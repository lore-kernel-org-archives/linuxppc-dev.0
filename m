Return-Path: <dougmill@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3C141A027F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2015 03:50:35 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dougmill@linux.vnet.ibm.com>;
 Tue, 10 Nov 2015 09:50:31 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B2E541FF0046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2015 09:38:39 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAAGnFfK10420670
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2015 09:49:17 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAAGoQTR023921
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2015 09:50:26 -0700
Received: from oc5780617838.ibm.com ([9.80.96.161])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 tAAGoP5l023758
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2015 09:50:25 -0700
Subject: Re: [xmon PATCH 1/1] RFC: Add xmon command to dump process/task
 similar to ps(1)
To: linuxppc-dev@lists.ozlabs.org
References: <56420DC2.3070500@linux.vnet.ibm.com>
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
Message-ID: <56422051.8030505@linux.vnet.ibm.com>
Date: Tue, 10 Nov 2015 10:50:25 -0600
MIME-Version: 1.0
In-Reply-To: <56420DC2.3070500@linux.vnet.ibm.com>
Content-Type: multipart/mixed; boundary="------------050901010002040605070808"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050901010002040605070808
Content-Type: multipart/alternative;
 boundary="------------010906020105040900090802"


--------------010906020105040900090802
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry, rookie mistake: last minute changes without checking compile.

Here's is the corrected patch.



On 11/10/2015 09:31 AM, Douglas Miller wrote:
> RFC: Not sure if I need locking when accessing task structs from xmon. 
> Please comment.
>
> I found this new xmon command indispensable while debugging a KDUMP 
> problem. It dumps some task information similar to the ps(1) command, 
> plus includes the kernel stack pointer for use with "t" traceback 
> command. In the case of KDUMP on PKVM, it was running single-CPU so 
> locking issues would likely not have shown up. Certainly if xmon runs 
> in an environment where some CPUs are still running tasks, this 
> information can be very fleeting.
>
> Let me know what else needs to be done to make this patch ready.
>
> Thanks,
> Doug
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


--------------010906020105040900090802
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Sorry, rookie mistake: last minute changes without checking compile.<br>
    <br>
    Here's is the corrected patch.<br>
    <br>
    <br>
    <br>
    <div class="moz-cite-prefix">On 11/10/2015 09:31 AM, Douglas Miller
      wrote:<br>
    </div>
    <blockquote cite="mid:56420DC2.3070500@linux.vnet.ibm.com"
      type="cite">RFC: Not sure if I need locking when accessing task
      structs from xmon. Please comment.
      <br>
      <br>
      I found this new xmon command indispensable while debugging a
      KDUMP problem. It dumps some task information similar to the ps(1)
      command, plus includes the kernel stack pointer for use with "t"
      traceback command. In the case of KDUMP on PKVM, it was running
      single-CPU so locking issues would likely not have shown up.
      Certainly if xmon runs in an environment where some CPUs are still
      running tasks, this information can be very fleeting.
      <br>
      <br>
      Let me know what else needs to be done to make this patch ready.
      <br>
      <br>
      Thanks,
      <br>
      Doug
      <br>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Linuxppc-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------010906020105040900090802--

--------------050901010002040605070808
Content-Type: text/x-patch;
 name="0001-Add-xmon-command-to-dump-process-task-similar-to-ps-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Add-xmon-command-to-dump-process-task-similar-to-ps-.pa";
 filename*1="tch"

>From 18a3fff40f84973639ddf1e519a5976b90cec33f Mon Sep 17 00:00:00 2001
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
Date: Thu, 5 Nov 2015 07:55:33 -0600
Subject: [PATCH] Add xmon command to dump process/task similar to ps(1)

---
 arch/powerpc/xmon/xmon.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 13c6e20..72f0404 100644
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
@@ -2450,6 +2455,39 @@ memzcan(void)
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
+	unsigned long tskv;
+	struct task_struct *tsk;
+
+	if (scanhex(&tskv)) {
+		procshow((struct task_struct *)tskv);
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


--------------050901010002040605070808--
