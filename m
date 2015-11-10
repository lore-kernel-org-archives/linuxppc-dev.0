Return-Path: <dougmill@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C7DD1A0274
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2015 02:31:27 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dougmill@linux.vnet.ibm.com>;
 Tue, 10 Nov 2015 10:31:21 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 2C4CEC90052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2015 10:19:29 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAAFVI8I64618620
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2015 15:31:18 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAAFVHMn005571
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2015 10:31:17 -0500
Received: from oc5780617838.ibm.com ([9.80.96.161])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 tAAFVFt4005342
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2015 10:31:15 -0500
To: linuxppc-dev@lists.ozlabs.org
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
Subject: [xmon PATCH 1/1] RFC: Add xmon command to dump process/task similar
 to ps(1)
Message-ID: <56420DC2.3070500@linux.vnet.ibm.com>
Date: Tue, 10 Nov 2015 09:31:14 -0600
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080707020808010804020805"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080707020808010804020805
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

RFC: Not sure if I need locking when accessing task structs from xmon. 
Please comment.

I found this new xmon command indispensable while debugging a KDUMP 
problem. It dumps some task information similar to the ps(1) command, 
plus includes the kernel stack pointer for use with "t" traceback 
command. In the case of KDUMP on PKVM, it was running single-CPU so 
locking issues would likely not have shown up. Certainly if xmon runs in 
an environment where some CPUs are still running tasks, this information 
can be very fleeting.

Let me know what else needs to be done to make this patch ready.

Thanks,
Doug

--------------080707020808010804020805
Content-Type: text/x-patch;
 name="0001-Add-xmon-command-to-dump-process-task-similar-to-ps-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Add-xmon-command-to-dump-process-task-similar-to-ps-.pa";
 filename*1="tch"

>From 5f2dd7c955443332835de86cfde2097e298fc657 Mon Sep 17 00:00:00 2001
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
Date: Thu, 5 Nov 2015 07:55:33 -0600
Subject: [PATCH] Add xmon command to dump process/task similar to ps(1)

---
 arch/powerpc/xmon/xmon.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 13c6e20..745ecf5 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -149,6 +149,7 @@ static int  cpu_cmd(void);
 static void csum(void);
 static void bootcmds(void);
 static void proccall(void);
+static void proclist(void);
 void dump_segments(void);
 static void symbol_lookup(void);
 static void xmon_show_stack(unsigned long sp, unsigned long lr,
@@ -228,6 +229,7 @@ Commands:\n\
   mz	zero a block of memory\n\
   mi	show information about memory allocation\n\
   p 	call a procedure\n\
+  P 	list processes/tasks\n\
   r	print registers\n\
   s	single step\n"
 #ifdef CONFIG_SPU_BASE
@@ -947,6 +949,9 @@ cmds(struct pt_regs *excp)
 		case 'p':
 			proccall();
 			break;
+		case 'P':
+			proclist();
+			break;
 #ifdef CONFIG_PPC_STD_MMU
 		case 'u':
 			dump_segments();
@@ -2450,6 +2455,38 @@ memzcan(void)
 		printf("%.8x\n", a - mskip);
 }
 
+static void procshow(struct task_struct *tsk)
+{
+	char state;
+	state = (tsk->state == 0) ? 'R' : 
+		(tsk->state < 0) ? 'U' : 
+		(tsk->state & TASK_UNINTERRUPTIBLE) ? 'D' : 
+		(tsk->state & TASK_STOPPED) ? 'T' : 
+		(tsk->state & TASK_TRACED) ? 'C' : 
+		(tsk->exit_state & EXIT_ZOMBIE) ? 'Z' : 
+		(tsk->exit_state & EXIT_DEAD) ? 'E' : 
+		(tsk->state & TASK_INTERRUPTIBLE) ? 'S' : '?';
+
+	printf("%p %016lx %6d %6d %c %2d %s\n", tsk,
+		tsk->thread.ksp,
+		tsk->pid, tsk->parent->pid,
+		state, task_thread_info(tsk)->cpu,
+		tsk->comm);
+}
+
+static void proclist(void)
+{
+	struct task_struct *tsk;
+
+	if (scanhex(&tsk)) {
+		procshow(tsk);
+	} else {
+		for_each_process(tsk) {
+			procshow(tsk);
+		}
+	}
+}
+
 static void proccall(void)
 {
 	unsigned long args[8];
-- 
1.7.1


--------------080707020808010804020805--
