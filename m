Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 76BF72C01E5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2013 23:14:59 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 10 Sep 2013 18:38:32 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 96488125805A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2013 18:44:49 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8ADEjWb48038092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2013 18:44:45 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8ADEk4q017759
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2013 18:44:47 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V3] powerpc: Fix possible deadlock on page fault
Date: Tue, 10 Sep 2013 18:44:42 +0530
Message-Id: <1378818882-10898-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

 stack_grow_into/14082 is trying to acquire lock:
  (&mm->mmap_sem){++++++}, at: [<c000000000206d28>] .might_fault+0x78/0xe0

 but task is already holding lock:
  (&mm->mmap_sem){++++++}, at: [<c0000000007ffd8c>] .do_page_fault+0x24c/0x910

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&mm->mmap_sem);
   lock(&mm->mmap_sem);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 1 lock held by stack_grow_into/14082:
  #0:  (&mm->mmap_sem){++++++}, at: [<c0000000007ffd8c>] .do_page_fault+0x24c/0x910

 stack backtrace:
 CPU: 21 PID: 14082 Comm: stack_grow_into Not tainted 3.10.0-10.el7.ppc64.debug #1
 Call Trace:
 [c0000003d396b850] [c000000000016e7c] .show_stack+0x7c/0x1f0 (unreliable)
 [c0000003d396b920] [c000000000813fc8] .dump_stack+0x28/0x3c
 [c0000003d396b990] [c000000000124b90] .__lock_acquire+0x1640/0x1800
 [c0000003d396bab0] [c00000000012570c] .lock_acquire+0xac/0x250
 [c0000003d396bb80] [c000000000206d54] .might_fault+0xa4/0xe0
 [c0000003d396bbf0] [c0000000007ffe2c] .do_page_fault+0x2ec/0x910
 [c0000003d396be30] [c0000000000092e8] handle_page_fault+0x10/0x30

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/fault.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 8726779..1d1f2ec 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -206,7 +206,7 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 	int trap = TRAP(regs);
  	int is_exec = trap == 0x400;
 	int fault;
-	int rc = 0;
+	int rc = 0, store_update_sp = 0;
 
 #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 	/*
@@ -280,6 +280,14 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
+	/*
+	 * We want to do this outside mmap_sem, because reading code around nip
+	 * can result in fault, which will cause a deadlock when called with
+	 * mmap_sem held
+	 */
+	if (user_mode(regs))
+		store_update_sp = store_updates_sp(regs);
+
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunately, in the case of an
@@ -345,8 +353,7 @@ retry:
 		 * between the last mapped region and the stack will
 		 * expand the stack rather than segfaulting.
 		 */
-		if (address + 2048 < uregs->gpr[1]
-		    && (!user_mode(regs) || !store_updates_sp(regs)))
+		if (address + 2048 < uregs->gpr[1] && !store_update_sp)
 			goto bad_area;
 	}
 	if (expand_stack(vma, address))
-- 
1.8.1.2
