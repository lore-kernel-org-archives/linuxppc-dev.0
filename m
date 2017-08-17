Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYL0N2rflzDrMj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 08:06:44 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7HM5ZaK051380
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 18:06:42 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cdkkpr59g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 18:06:42 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 17 Aug 2017 23:06:39 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: [PATCH v2 19/20] x86/mm: Add speculative pagefault handling
Date: Fri, 18 Aug 2017 00:05:18 +0200
In-Reply-To: <1503007519-26777-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1503007519-26777-1-git-send-email-ldufour@linux.vnet.ibm.com>
Message-Id: <1503007519-26777-20-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Peter Zijlstra <peterz@infradead.org>

Try a speculative fault before acquiring mmap_sem, if it returns with
VM_FAULT_RETRY continue with the mmap_sem acquisition and do the
traditional fault.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

[Clearing of FAULT_FLAG_ALLOW_RETRY is now done in
 handle_speculative_fault()]
[Retry with usual fault path in the case VM_ERROR is returned by
 handle_speculative_fault(). This allows signal to be delivered]
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/x86/include/asm/pgtable_types.h |  7 +++++++
 arch/x86/mm/fault.c                  | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index bf9638e1ee42..4fd2693a037e 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -234,6 +234,13 @@ enum page_cache_mode {
 #define PGD_IDENT_ATTR	 0x001		/* PRESENT (no other attributes) */
 #endif
 
+/*
+ * Advertise that we call the Speculative Page Fault handler.
+ */
+#ifdef CONFIG_X86_64
+#define __HAVE_ARCH_CALL_SPF
+#endif
+
 #ifdef CONFIG_X86_32
 # include <asm/pgtable_32_types.h>
 #else
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 2a1fa10c6a98..4c070b9a4362 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1365,6 +1365,24 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	if (error_code & PF_INSTR)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
+#ifdef __HAVE_ARCH_CALL_SPF
+	if (error_code & PF_USER) {
+		fault = handle_speculative_fault(mm, address, flags);
+
+		/*
+		 * We also check against VM_FAULT_ERROR because we have to
+		 * raise a signal by calling later mm_fault_error() which
+		 * requires the vma pointer to be set. So in that case,
+		 * we fall through the normal path.
+		 */
+		if (!(fault & VM_FAULT_RETRY || fault & VM_FAULT_ERROR)) {
+			perf_sw_event(PERF_COUNT_SW_SPF_DONE, 1,
+				      regs, address);
+			goto done;
+		}
+	}
+#endif /* __HAVE_ARCH_CALL_SPF */
+
 	/*
 	 * When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in
@@ -1474,6 +1492,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 		return;
 	}
 
+done:
 	/*
 	 * Major/minor page fault accounting. If any of the events
 	 * returned VM_FAULT_MAJOR, we account it as a major fault.
-- 
2.7.4
