Return-Path: <consul.kautuk@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
 [209.85.161.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9A14EB6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 01:12:24 +1100 (EST)
Received: by ggni2 with SMTP id i2so78109ggn.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2012 07:12:20 -0700 (PDT)
From: Kautuk Consul <consul.kautuk@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jimi Xenidis <jimix@pobox.com>,
 Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Christian Dietrich <christian.dietrich@informatik.uni-erlangen.de>
Subject: [PATCH 04/20 v2] powerpc/mm/fault.c: Port OOM changes to do_page_fault
Date: Tue, 20 Mar 2012 10:12:02 -0400
Message-Id: <1332252722-3794-1-git-send-email-consul.kautuk@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Mohd. Faris" <mohdfarisq2010@gmail.com>,
 Kautuk Consul <consul.kautuk@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit d065bd810b6deb67d4897a14bfe21f8eb526ba99
(mm: retry page fault when blocking on disk transfer) and
commit 37b23e0525d393d48a7d59f870b3bc061a30ccdb
(x86,mm: make pagefault killable)

The above commits introduced changes into the x86 pagefault handler
for making the page fault handler retryable as well as killable.

These changes reduce the mmap_sem hold time, which is crucial
during OOM killer invocation.

Port these changes to powerpc.

Signed-off-by: Mohd. Faris <mohdfarisq2010@gmail.com>
Signed-off-by: Kautuk Consul <consul.kautuk@gmail.com>
---
 arch/powerpc/mm/fault.c |   51 +++++++++++++++++++++++++++++++++-------------
 1 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 2f0d1b0..a3b1176 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -129,6 +129,7 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 	int is_write = 0, ret;
 	int trap = TRAP(regs);
  	int is_exec = trap == 0x400;
+	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
 #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 	/*
@@ -212,6 +213,7 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 		if (!user_mode(regs) && !search_exception_tables(regs->nip))
 			goto bad_area_nosemaphore;
 
+retry:
 		down_read(&mm->mmap_sem);
 	}
 
@@ -313,6 +315,7 @@ good_area:
 	} else if (is_write) {
 		if (!(vma->vm_flags & VM_WRITE))
 			goto bad_area;
+		flags |= FAULT_FLAG_WRITE;
 	/* a read */
 	} else {
 		/* protection fault */
@@ -327,7 +330,11 @@ good_area:
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	ret = handle_mm_fault(mm, vma, address, is_write ? FAULT_FLAG_WRITE : 0);
+	ret = handle_mm_fault(mm, vma, address, flags);
+
+	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+		return;
+
 	if (unlikely(ret & VM_FAULT_ERROR)) {
 		if (ret & VM_FAULT_OOM)
 			goto out_of_memory;
@@ -335,22 +342,36 @@ good_area:
 			goto do_sigbus;
 		BUG();
 	}
-	if (ret & VM_FAULT_MAJOR) {
-		current->maj_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-				     regs, address);
-#ifdef CONFIG_PPC_SMLPAR
-		if (firmware_has_feature(FW_FEATURE_CMO)) {
-			preempt_disable();
-			get_lppaca()->page_ins += (1 << PAGE_FACTOR);
-			preempt_enable();
+	if (flags & FAULT_FLAG_ALLOW_RETRY) {
+		if (ret & VM_FAULT_MAJOR) {
+			current->maj_flt++;
+			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
+					     regs, address);
+#ifdef CONFIG_PPC_SMLPAR
+			if (firmware_has_feature(FW_FEATURE_CMO)) {
+				preempt_disable();
+				get_lppaca()->page_ins += (1 << PAGE_FACTOR);
+				preempt_enable();
+			}
+#endif
+		} else {
+			current->min_flt++;
+			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
+					     regs, address);
+		}
+		if (fault & VM_FAULT_RETRY) {
+			flags &= ~FAULT_FLAG_ALLOW_RETRY;
+
+			/*
+			 * No need to up_read(&mm->mmap_sem) as we would
+			 * have already released it in __lock_page_or_retry
+			 * in mm/filemap.c.
+			 */
+
+			goto retry;
 		}
-#endif
-	} else {
-		current->min_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-				     regs, address);
 	}
+
 	up_read(&mm->mmap_sem);
 	return 0;
 
-- 
1.7.5.4
