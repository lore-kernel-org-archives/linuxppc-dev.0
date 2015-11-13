Return-Path: <dougmill@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C1A941A09A7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2015 02:58:27 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dougmill@linux.vnet.ibm.com>;
 Fri, 13 Nov 2015 08:58:25 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 598E03E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 08:58:21 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tADFsqoW9568628
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 08:54:52 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tADFwKUl030813
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 08:58:21 -0700
Subject: Re: [xmon PATCH 1/1] RFC: Add xmon command to dump process/task
 similar to ps(1)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
References: <56420DC2.3070500@linux.vnet.ibm.com>
 <56422051.8030505@linux.vnet.ibm.com>
 <1447229393.31884.152.camel@kernel.crashing.org>
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
Message-ID: <5646089B.6090408@linux.vnet.ibm.com>
Date: Fri, 13 Nov 2015 09:58:19 -0600
MIME-Version: 1.0
In-Reply-To: <1447229393.31884.152.camel@kernel.crashing.org>
Content-Type: multipart/mixed; boundary="------------010909050307000501010903"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010909050307000501010903
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks, Ben, for the feedback.

Here is an updated patch. I added a macro XMON_PROTECT() to wrap a 
statement in what I think is the correct setjmp/protection code. Each 
place seems to do it slightly differently, so I wasn't sure what the 
right way was and didn't want to change all other places until we were 
certain. If you have a better way to implement this, please let me know. 
It may be difficult to make a macro that fits all use cases, too.

I checked using a task point of NULL and it errored out safely, and also 
tried a pointer to valid memory but not a valid task_struct and it also 
errored out cleanly. Of course, random memory might not always cause a 
fault but rather just print garbage.

Thanks,
Doug

On 11/11/2015 02:09 AM, Benjamin Herrenschmidt wrote:
> On Tue, 2015-11-10 at 10:50 -0600, Douglas Miller wrote:
>> +{
>> +	unsigned long tskv;
>> +	struct task_struct *tsk;
>> +
>> +	if (scanhex(&tskv)) {
>> +		procshow((struct task_struct *)tskv);
>> +	} else {
>> +		for_each_process(tsk) {
>> +			procshow(tsk);
>> +		}
>> +	}
>> +}
>> +
> The main thing is wrap it with the setjump magic that xmon uses for
> other things that allows it to recover if you hit a bad pointer
> along the way:
>
> 	if (setjmp(bus_error_jmp) == 0) {
> 		catch_memory_errors = 1;
> 		sync();
> 		... do your stuff...
> 		sync();
> 	}
> 	catch_memory_errors = 0;
>
> We could make some kind of helper or macro to factor that out
> while it it ;-) (For bonus points !)
>
> Cheers,
> Ben.
>
>


--------------010909050307000501010903
Content-Type: text/x-patch;
 name="0001-Add-xmon-command-to-dump-process-task-similar-to-ps-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Add-xmon-command-to-dump-process-task-similar-to-ps-.pa";
 filename*1="tch"

>From a0e7eeef8c51ecedad131aa4c04541f37fc083c4 Mon Sep 17 00:00:00 2001
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
Date: Thu, 5 Nov 2015 07:55:33 -0600
Subject: [PATCH] Add xmon command to dump process/task similar to ps(1)

---
 arch/powerpc/xmon/xmon.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 13c6e20..5c24f55 100644
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
@@ -191,6 +192,24 @@ extern void xmon_leave(void);
 			 || ('A' <= (c) && (c) <= 'Z'))
 #define isspace(c)	(c == ' ' || c == '\t' || c == 10 || c == 13 || c == 0)
 
+/*
+ * Wrap a statement (typically function call) in setjmp to
+ * protect it from memory access errors. msg... are printf
+ * fmt+args used if error is trapped.
+ */
+#define XMON_PROTECT(stmt, msg...) 		\
+	if (setjmp(bus_error_jmp) != 0) {	\
+		catch_memory_errors = 0;	\
+		printf(msg);			\
+	} else {				\
+		catch_memory_errors = 1;	\
+		sync();				\
+		stmt;				\
+		sync();				\
+		__delay(200);			\
+		catch_memory_errors = 0;	\
+	}
+
 static char *help_string = "\
 Commands:\n\
   b	show breakpoints\n\
@@ -228,6 +247,7 @@ Commands:\n\
   mz	zero a block of memory\n\
   mi	show information about memory allocation\n\
   p 	call a procedure\n\
+  P 	list processes/tasks\n\
   r	print registers\n\
   s	single step\n"
 #ifdef CONFIG_SPU_BASE
@@ -947,6 +967,9 @@ cmds(struct pt_regs *excp)
 		case 'p':
 			proccall();
 			break;
+		case 'P':
+			proclist();
+			break;
 #ifdef CONFIG_PPC_STD_MMU
 		case 'u':
 			dump_segments();
@@ -2450,6 +2473,41 @@ memzcan(void)
 		printf("%.8x\n", a - mskip);
 }
 
+static void procshow(struct task_struct *tsk)
+{
+	char state;
+
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
+	unsigned long tskv;
+	struct task_struct *tsk;
+
+	if (scanhex(&tskv)) {
+		tsk = (struct task_struct *)tskv;
+		XMON_PROTECT(procshow(tsk), "*** Error dumping task %p\n", tsk);
+	} else {
+		for_each_process(tsk) {
+			XMON_PROTECT(procshow(tsk), "*** Error dumping task %p\n", tsk);
+		}
+	}
+}
+
 static void proccall(void)
 {
 	unsigned long args[8];
-- 
1.7.1


--------------010909050307000501010903--
