Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0D63B2C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 17:17:14 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 5 Sep 2013 17:03:15 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id BAE7B2CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 17:17:11 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8570lYW61538506
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Sep 2013 17:00:47 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r857HAYH011386
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Sep 2013 17:17:11 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Fix possible deadlock on page fault
Date: Thu,  5 Sep 2013 12:47:02 +0530
Message-Id: <1378365422-25203-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/mm/fault.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 8726779..dc2902a 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -206,7 +206,7 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 	int trap = TRAP(regs);
  	int is_exec = trap == 0x400;
 	int fault;
-	int rc = 0;
+	int rc = 0, store_update;
 
 #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 	/*
@@ -280,6 +280,13 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
+	/*
+	 * We want to do this outside mmap_sem, because reading code around nip
+	 * can result in fault, which will cause a deadlock when called with
+	 * mmap_sem held
+	 */
+	store_update = store_updates_sp(regs);
+
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunately, in the case of an
@@ -346,7 +353,7 @@ retry:
 		 * expand the stack rather than segfaulting.
 		 */
 		if (address + 2048 < uregs->gpr[1]
-		    && (!user_mode(regs) || !store_updates_sp(regs)))
+		    && (!user_mode(regs) || !store_update))
 			goto bad_area;
 	}
 	if (expand_stack(vma, address))
-- 
1.8.1.2
