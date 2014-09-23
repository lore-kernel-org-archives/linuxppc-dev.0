Return-Path: <rostedt@goodmis.org>
Received: from cdptpa-oedge-vip.email.rr.com
 (cdptpa-outbound-snat.email.rr.com [107.14.166.229])
 by lists.ozlabs.org (Postfix) with ESMTP id 24CCF1A0440
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 09:20:23 +1000 (EST)
Date: Tue, 23 Sep 2014 19:20:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 2/3] powerpc/ftrace: Remove mod_return_to_handler
Message-ID: <20140923192021.57f335e0@gandalf.local.home>
In-Reply-To: <1410937624-25140-2-git-send-email-anton@samba.org>
References: <1410937624-25140-1-git-send-email-anton@samba.org>
 <1410937624-25140-2-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 17 Sep 2014 17:07:03 +1000
Anton Blanchard <anton@samba.org> wrote:

> mod_return_to_handler is the same as return_to_handler, except
> it handles the change of the TOC (r2). Add this into
> return_to_handler and remove mod_return_to_handler.

Adding this patch actually gave me some more output. Funny that?

electra login: INFO: rcu_sched self-detected stall on CPU { 1}  (t=5250 jiffies g=3579 c=3578 q=7)
Task dump for CPU 1:
trace-cmd       R  running task        0  3553   3550 0x00008014
Call Trace:
[c0000000054a6ce0] [c000000000012b34] .show_stack+0x104/0x260 (unreliable)
[c0000000054a6dc0] [c0000000000c2270] .sched_show_task+0xd0/0x150
[c0000000054a6e40] [c0000000000eedb0] .rcu_dump_cpu_stacks+0xe0/0x150
[c0000000054a6ee0] [c0000000000f2a48] .rcu_check_callbacks+0x4f8/0x8d0
[c0000000054a7020] [c0000000000f8118] .update_process_times+0x48/0xa0
[c0000000054a70b0] [c00000000010cfe8] .tick_sched_timer+0x88/0xd0
[c0000000054a7150] [c0000000000f8b1c] .__run_hrtimer+0xcc/0x2c0
[c0000000054a7200] [c0000000000f9a98] .hrtimer_interrupt+0x158/0x330
[c0000000054a7310] [c00000000001a6b8] .__timer_interrupt+0xa8/0x280
[c0000000054a73c0] [c00000000001a920] .timer_interrupt+0x90/0x100
[c0000000054a7440] [c000000000002260] decrementer_common+0x160/0x180
--- interrupt: 901 at .trace_buffer_lock_reserve+0x2c/0x90
    LR = .trace_function+0x54/0xe0
[c0000000054a77c0] [c0000000001449cc] .function_trace_call+0x7c/0x120
[c0000000054a7840] [c00000000012d750] .ftrace_ops_no_ops+0xf0/0x170
[c0000000054a78e0] [c000000000009d8c] ftrace_call+0x4/0x8
[c0000000054a7950] [c00000000072e128] .mutex_unlock+0x18/0x70
[c0000000054a79d0] [c000000000137534] .tracing_buffers_splice_read+0x424/0x4c0
[c0000000054a7c80] [c00000000021bfe8] .do_splice_to+0xa8/0xe0
[c0000000054a7d20] [c00000000021eae4] .SyS_splice+0x694/0x6b0
[c0000000054a7e30] [c000000000009224] syscall_exit+0x0/0x98


Note, the stress test is basically this:

perf record -o perf-test.dat -a -- trace-cmd record -e all -p function hackbench 2

It actually dies as it finishes the hackbench run and starts stopping
the tracing.

-- Steve
