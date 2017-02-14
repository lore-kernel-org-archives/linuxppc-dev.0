Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN7Zb1N03zDqJV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 03:45:27 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1EGiUxW001396
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 11:45:25 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28kk8p4h0y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 11:45:25 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 16:45:22 -0000
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] powerpc/mm: move mmap_sem unlocking in do_page_fault()
Date: Tue, 14 Feb 2017 17:45:12 +0100
In-Reply-To: <cover.1487090656.git.ldufour@linux.vnet.ibm.com>
References: <cover.1487090656.git.ldufour@linux.vnet.ibm.com>
In-Reply-To: <cover.1487090656.git.ldufour@linux.vnet.ibm.com>
References: <cover.1487090656.git.ldufour@linux.vnet.ibm.com>
Message-Id: <6515aebdbd7adad576f1c97753809547b273504a.1487090656.git.ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since the fault retry is now handled earlier, we can release the
mmap_sem lock earlier too and remove later unlocking previously done in
mm_fault_error().

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/mm/fault.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 2a6bc7e6e69a..21e06cce8984 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -151,13 +151,6 @@ static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
 	 * continue the pagefault.
 	 */
 	if (fatal_signal_pending(current)) {
-		/*
-		 * If we have retry set, the mmap semaphore will have
-		 * alrady been released in __lock_page_or_retry(). Else
-		 * we release it now.
-		 */
-		if (!(fault & VM_FAULT_RETRY))
-			up_read(&current->mm->mmap_sem);
 		/* Coming from kernel, we need to deal with uaccess fixups */
 		if (user_mode(regs))
 			return MM_FAULT_RETURN;
@@ -170,8 +163,6 @@ static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
 
 	/* Out of memory */
 	if (fault & VM_FAULT_OOM) {
-		up_read(&current->mm->mmap_sem);
-
 		/*
 		 * We ran out of memory, or some other thing happened to us that
 		 * made us unable to handle the page fault gracefully.
@@ -182,10 +173,8 @@ static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
 		return MM_FAULT_RETURN;
 	}
 
-	if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
-		up_read(&current->mm->mmap_sem);
+	if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE))
 		return do_sigbus(regs, addr, fault);
-	}
 
 	/* We don't understand the fault code, this is fatal */
 	BUG();
@@ -452,11 +441,12 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 				goto retry;
 		}
 		/* We will enter mm_fault_error() below */
-	}
+	} else
+		up_read(&current->mm->mmap_sem);
 
 	if (unlikely(fault & (VM_FAULT_RETRY|VM_FAULT_ERROR))) {
 		if (fault & VM_FAULT_SIGSEGV)
-			goto bad_area;
+			goto bad_area_nosemaphore;
 		rc = mm_fault_error(regs, address, fault);
 		if (rc >= MM_FAULT_RETURN)
 			goto bail;
@@ -488,7 +478,6 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 			      regs, address);
 	}
 
-	up_read(&mm->mmap_sem);
 	goto bail;
 
 bad_area:
-- 
2.7.4
