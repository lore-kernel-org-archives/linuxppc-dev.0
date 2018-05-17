Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mpS60rWYzF1gW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 21:07:49 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4HB4D9v022961
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 07:07:47 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j187ph2sf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 07:07:47 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 17 May 2018 12:07:41 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, mhocko@kernel.org, peterz@infradead.org,
 kirill@shutemov.name, ak@linux.intel.com, dave@stgolabs.net,
 jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 sergey.senozhatsky.work@gmail.com, Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 David Rientjes <rientjes@google.com>, Jerome Glisse <jglisse@redhat.com>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>,
 Minchan Kim <minchan@kernel.org>, Punit Agrawal <punitagrawal@gmail.com>,
 vinayak menon <vinayakm.list@gmail.com>,
 Yang Shi <yang.shi@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com, paulmck@linux.vnet.ibm.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: [PATCH v11 24/26] x86/mm: add speculative pagefault handling
Date: Thu, 17 May 2018 13:06:31 +0200
In-Reply-To: <1526555193-7242-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1526555193-7242-1-git-send-email-ldufour@linux.vnet.ibm.com>
Message-Id: <1526555193-7242-25-git-send-email-ldufour@linux.vnet.ibm.com>
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
[Don't build SPF call if !CONFIG_SPECULATIVE_PAGE_FAULT]
[Handle memory protection key fault]
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/x86/mm/fault.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index fd84edf82252..11944bfc805a 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1224,7 +1224,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	struct mm_struct *mm;
 	int fault, major = 0;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
-	u32 pkey;
+	u32 pkey, *pt_pkey = &pkey;
 
 	tsk = current;
 	mm = tsk->mm;
@@ -1314,6 +1314,27 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 		flags |= FAULT_FLAG_INSTRUCTION;
 
 	/*
+	 * Do not try to do a speculative page fault if the fault was due to
+	 * protection keys since it can't be resolved.
+	 */
+	if (!(error_code & X86_PF_PK)) {
+		fault = handle_speculative_fault(mm, address, flags);
+		if (fault != VM_FAULT_RETRY) {
+			perf_sw_event(PERF_COUNT_SW_SPF, 1, regs, address);
+			/*
+			 * Do not advertise for the pkey value since we don't
+			 * know it.
+			 * This is not a matter as we checked for X86_PF_PK
+			 * earlier, so we should not handle pkey fault here,
+			 * but to be sure that mm_fault_error() callees will
+			 * not try to use it, we invalidate the pointer.
+			 */
+			pt_pkey = NULL;
+			goto done;
+		}
+	}
+
+	/*
 	 * When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in
 	 * the kernel and should generate an OOPS.  Unfortunately, in the
@@ -1427,8 +1448,10 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	}
 
 	up_read(&mm->mmap_sem);
+
+done:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
-		mm_fault_error(regs, error_code, address, &pkey, fault);
+		mm_fault_error(regs, error_code, address, pt_pkey, fault);
 		return;
 	}
 
-- 
2.7.4
