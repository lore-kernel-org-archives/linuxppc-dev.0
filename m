Return-Path: <kato.takeharu@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id E30CD67A6E
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Mar 2005 17:21:08 +1100 (EST)
Message-ID: <4231387D.6030204@jp.fujitsu.com>
Date: Fri, 11 Mar 2005 15:19:41 +0900
From: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
MIME-Version: 1.0
To: Takeharu KATO <takeharu1219@ybb.ne.jp>
References: <20050303124435.GA24233@Redstar.dorchain.net>	<4227153C.3030201@gmx.net>	<20050303141832.GU25080@Redstar.dorchain.net>	<20050304075703.GA15637@Redstar.dorchain.net>	<422FD24F.4070108@jp.fujitsu.com>
	<20050310072803.GR4017@Redstar.dorchain.net>
	<423073A9.70404@ybb.ne.jp>
In-Reply-To: <423073A9.70404@ybb.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: boot time scheduling hile atomic
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Joerg:

First of all, I am sorry to making mistake on my stack analysis.
After all, I found what is wrong.

The syscall_exit_work is called(jumped) by fork, strictly speaking,
this is caused by kernel_thead for init process.
At this point, kernel set a need_resched flag in thread_info struct
(flags member).
So, the system executes syscall_exit_work when
the swapper thread exited from syscall.

However, the syscall_exit_work routine does not check
preempt counts when it calls schedule function.

FYI, I post the patch which fix this problem.
I've confirmed the problem has been removed by this patch,
but I can not figure out whether it is truely
correct or not.

Please review this.

Signed-off-by: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
--- linux-2.6.11/arch/ppc/kernel/entry.S        2005-03-09 12:57:32.000000000 +0900
+++ linux-2.6.11-wdt/arch/ppc/kernel/entry.S    2005-03-11 14:39:16.345490784 +0900
@@ -314,10 +314,16 @@ syscall_exit_work:
         SYNC
         MTMSRD(r10)             /* disable interrupts again */
         rlwinm  r12,r1,0,0,18   /* current_thread_info() */
-       lwz     r9,TI_FLAGS(r12)
  5:
+#ifdef CONFIG_PREEMPT
+       lwz     r0,TI_PREEMPT(r12)
+       cmpwi   0,r0,0          /* if non-zero, we can not reschedule here */
+       bne     6f
+#endif
+       lwz     r9,TI_FLAGS(r12)
         andi.   r0,r9,_TIF_NEED_RESCHED
         bne     1f
+6:
         lwz     r5,_MSR(r1)
         andi.   r5,r5,MSR_PR
         beq     syscall_exit_cont

-- 
Takeharu KATO
Fujitsu Limited
Email:kato.takeharu at jp.fujitsu.com
