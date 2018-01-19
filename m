Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zN3jz5rm8zF0ww
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 12:52:39 +1100 (AEDT)
Received: by mail-qt0-x243.google.com with SMTP id i1so433077qtj.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 17:52:39 -0800 (PST)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 corbet@lwn.net, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Subject: [PATCH v10 19/27] powerpc: Handle exceptions caused by pkey violation
Date: Thu, 18 Jan 2018 17:50:40 -0800
Message-Id: <1516326648-22775-20-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
References: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Handle Data and  Instruction exceptions caused by memory
protection-key.

The CPU will detect the key fault if the HPTE is already
programmed with the key.

However if the HPTE is not  hashed, a key fault will not
be detected by the hardware. The software will detect
pkey violation in such a case.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/reg.h       |    1 -
 arch/powerpc/kernel/exceptions-64s.S |    2 +-
 arch/powerpc/mm/fault.c              |   22 ++++++++++++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index b779f3c..ffc9990 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -312,7 +312,6 @@
 				 DSISR_BAD_EXT_CTRL)
 #define	  DSISR_BAD_FAULT_64S	(DSISR_BAD_FAULT_32S	| \
 				 DSISR_ATTR_CONFLICT	| \
-				 DSISR_KEYFAULT		| \
 				 DSISR_UNSUPP_MMU	| \
 				 DSISR_PRTABLE_FAULT	| \
 				 DSISR_ICSWX_NO_CT	| \
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index e441b46..804e804 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1521,7 +1521,7 @@ USE_TEXT_SECTION()
 	.balign	IFETCH_ALIGN_BYTES
 do_hash_page:
 #ifdef CONFIG_PPC_BOOK3S_64
-	lis	r0,(DSISR_BAD_FAULT_64S|DSISR_DABRMATCH)@h
+	lis	r0,(DSISR_BAD_FAULT_64S | DSISR_DABRMATCH | DSISR_KEYFAULT)@h
 	ori	r0,r0,DSISR_BAD_FAULT_64S@l
 	and.	r0,r4,r0		/* weird error? */
 	bne-	handle_page_fault	/* if not, try to insert a HPTE */
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 4797d08..943a91e 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -427,6 +427,11 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
+	if (error_code & DSISR_KEYFAULT) {
+		_exception(SIGSEGV, regs, SEGV_PKUERR, address);
+		return 0;
+	}
+
 	/*
 	 * We want to do this outside mmap_sem, because reading code around nip
 	 * can result in fault, which will cause a deadlock when called with
@@ -498,6 +503,23 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * the fault.
 	 */
 	fault = handle_mm_fault(vma, address, flags);
+
+#ifdef CONFIG_PPC_MEM_KEYS
+	/*
+	 * if the HPTE is not hashed, hardware will not detect
+	 * a key fault. Lets check if we failed because of a
+	 * software detected key fault.
+	 */
+	if (unlikely(fault & VM_FAULT_SIGSEGV) &&
+		!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
+			is_exec, 0)) {
+		int pkey = vma_pkey(vma);
+
+		if (likely(pkey))
+			return __bad_area(regs, address, SEGV_PKUERR);
+	}
+#endif /* CONFIG_PPC_MEM_KEYS */
+
 	major |= fault & VM_FAULT_MAJOR;
 
 	/*
-- 
1.7.1
