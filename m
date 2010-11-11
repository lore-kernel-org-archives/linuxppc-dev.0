Return-Path: <xzhao28@gmail.com>
Received: from mail-pw0-f67.google.com (mail-pw0-f67.google.com
	[209.85.160.67]) by ozlabs.org (Postfix) with ESMTP id 13AD8B7148
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Nov 2010 06:54:32 +1100 (EST)
Received: by pwi3 with SMTP id 3so242167pwi.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Nov 2010 11:54:31 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 11 Nov 2010 11:54:29 -0800
Message-ID: <AANLkTi=0_7x35wuaKQE6o32JDkPsGzJ6HAFP6Smte6OW@mail.gmail.com>
Subject: setuid() libc function hang on Freescale P1020 RDB
From: xuan zhao <xzhao28@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi GURUs

I am working on application based on Freescale P1020 SDK.  But for
some reasons, my application hangs in setuid(0).


The Freescale P1020 SDK is using this toolchain:
                  gcc-4.3.74-eglibc-2.8.74-dp-2
and the kernel is also from SDK:
                  linux-2.6.31.


The threads in my application are like:

main() thread -  SCHED_NORMAL
      |
      |-------        thread #a,  implement a timer using SIGALRM   -  SCHE=
D_RR
      |
      |--------       thread #b  =96 SCHED_NORMAL            -  this is
who hangs at setuid(0).
                             |
                             |--------   thread #c -  SCHED_RR,
waitting on a netlink FD for  incomming event


I added some code in kernel, I found that my thread #b returns from
sys_setuid() successfully, with its "task_struct->state" as
TASK_RUNNING. but for some reason, it doesn't return to my user-level
application code. it seems that it stays in setuid() libc function and
another system call sys_futex(), and its kernel mode stack calltrace
is like:

[cdc25c80] [c007e5ac] __rcu_process_callbacks+0x2c4/0x3a0 (unreliable)
[cdc25d40] [c0007ef8] __switch_to+0x5c/0xcc
[cdc25d50] [c0488ab8] schedule+0x2dc/0x4c4
[cdc25db0] [c00699e0] futex_wait_queue_me+0xfc/0x134
[cdc25de0] [c0069b54] futex_wait+0x13c/0x2cc
[cdc25ec0] [c006c560] do_futex+0x58/0x1e8
[cdc25ee0] [c006c784] sys_futex+0x94/0x1e4
[cdc25f40] [c0010254] ret_from_syscall+0x0/0x3c


I notice that there was  some discussion about RT thread setuid() hang,

http://linux.derkeiler.com/Mailing-Lists/Kernel/2009-02/msg09870.html
but that fix is already in kernel.2.6.31, and my thread is
SCHED_NORMAL, not RT. so I guess it is not like my case.

And this is some kernel configurations:

CONFIG_TREE_RCU=3Dy
# CONFIG_TREE_PREEMPT_RCU is not set
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_FANOUT=3D32
# CONFIG_RCU_FANOUT_EXACT is not set
# CONFIG_TREE_RCU_TRACE is not set
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
CONFIG_LOG_BUF_SHIFT=3D14
CONFIG_GROUP_SCHED=3Dy
# CONFIG_FAIR_GROUP_SCHED is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_USER_SCHED=3Dy
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUPS is not set


CONFIG_PREEMPT_NONE=3Dy
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set

         CONFIG_PREEMPT is not set, but setuid() hangs no matter
whether or not it is set.



Any way, I am completely out of ideas.

Is this caused by the toolchain of Freescale P1020 SDK?  Do you have
any ideas about what I should do to debug this issue?

I would appreciate it a lot if you GURUs could give me some idea. If
you need me to provide more information, please let me know.


thanks
