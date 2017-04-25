Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBlqc1LN7zDqCC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 11:24:28 +1000 (AEST)
Date: Mon, 24 Apr 2017 20:24:13 -0500
From: Scott Wood <oss@buserror.net>
To: Liu Hailong <liu.hailong6@zte.com.cn>
Cc: benh@kernel.crashing.org, zhong.weidong@zte.com.cn,
 linux-kernel@vger.kernel.org, liu.song11@zte.com.cn,
 huang.jian@zte.com.cn, jiang.xuexin@zte.com.cn,
 jiang.biao2@zte.com.cn, linuxppc-dev@lists.ozlabs.org
Message-ID: <20170425012413.gaobi3atq7noa5v7@home.buserror.net>
References: <1486434952-2093-1-git-send-email-liu.hailong6@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486434952-2093-1-git-send-email-liu.hailong6@zte.com.cn>
Subject: Re: Powerpc64: Fixup oops when debug programs with
 CONFIG_RELOCATABLE=y
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 07, 2017 at 10:35:52AM +0800, Liu Hailong wrote:
> From: LiuHailong <liu.hailong6@zte.com.cn>
> 
> Debug interrupts can be taken during regular program or a standard
> interrupt, the EA of the instruction causing the interrupt will be
> kept in DSRR0.
> Kernel will check if this value is between [interrupt_base_book3e,
> __end_interrupts].
> However, when the kernel build with CONFIG_RELOCATABLE, it can't get
> EA of those lables by LOAD_REG_IMMEDIATE(r14,interrupt_base_book3e)
> and LOAD_REG_IMMEDIATE(r15,__end_interrupts),then it cases problems
> later.
> At the same time, r2(toc) are not usable here, so LOAD_REG_ADDR()
> dosen't work neither. So we use the *name@got* to get the EV of two
> lables directly.
> This patch can fix the problem and remove the oops when we gdb a
> program with single-step.
> 
> Test programs test.c shows as follows:
> #include <fcntl.h>
> #include <stdio.h>
> int main(int argc, char *argv[])
> {
> 	if (access("/proc/sys/kernel/perf_event_paranoid", F_OK) == -1)
> 		printf("Kernel doesn't have perf_event support\n");
> }
> 
> Steps to reproduce the bug, for example:
>  1) ./gdb ./test
>  2) (gdb) b access
>  3) (gdb) r
>  4) (gdb) s
> 
> Then will trigger the oops, it looks like:
> (gdb) s
> Single stepping Oops: Exception in kernel mode, sig: 5 [#2]
> PREEMPT CoreNet Generic
> Modules linked in:
> CPU: 0 PID: 1135 Comm: test Tainted: G    D    Linux (none) 4.9.5 #79
> task: c000000079199580 ti: c00000007ffc4000 task.ti: c000000074064000
> NIP: c00000000001a1e4 LR: 000000001000103c CTR: 000000001000100c
> REGS: c00000007ffc7cf0 TRAP: 0d08   Tainted: G   D  (Linux (none) 4.9.5)
> MSR: 0000000080021000 <CE,ME>  CR: 24000442  XER: 00000000
> SOFTE: 1

I apologize for not getting to this earlier...

Does it really produce an oops, rather than a hang?  It looks like
without this fix, flow would go to kernel_dbg_exc which is a
branch-to-self.  Do you have other changes in your tree that affected
this?

If so, have you tested the patch on an unmodified top-of-tree kernel?  I
can't test this at the moment as I don't currently have hardware and QEMU
doesn't emulate the booke debug registers.

That said, the patch looks correct, and the bug is even worse if it's a
hang rather than merely noisily killing the debugged process.  It should
go to stable for 4.4+ (when support for relocatable e500 was added) and
probably to Linus this week (though I'd feel more comfortable knowing it
got testing on the current tree).  OTOH, I believe this bug will only
trigger if a relocation actually happened, which on e500 is an unusual
case outside of a kdump crash kernel, since the kernel is normally loaded
at zero.  But maybe you've got a different use case for relocatable?

-Scott
