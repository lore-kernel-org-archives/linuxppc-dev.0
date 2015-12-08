Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0206.hostedemail.com
 [216.40.44.206])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D01C51A05F4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 05:59:23 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave05.hostedemail.com (Postfix) with ESMTP id C2502183DC6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 18:51:04 +0000 (UTC)
Date: Tue, 8 Dec 2015 13:50:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, chuhu@redhat.com
Subject: [RFC][PATCH] ppc: Implement save_stack_trace_regs()
Message-ID: <20151208135056.718b7668@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It has come to my attention that kprobe event stack tracing does not
work on powerpc. You can see with the following:

 # cd /sys/kernel/debug/tracing
 # echo stacktrace > trace_options
 # echo 'p kfree' > kprobe_events
 # echo 'r exit_mmap' >> kprobe_events
 # echo 1 > events/kprobes/enable

Gives the following splat:

save_stack_trace_regs() not implemented yet.
------------[ cut here ]------------
WARNING: at kernel/stacktrace.c:74
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.3.0-test #89
task: c000000000a98660 ti: c00000003efe8000 task.ti: c000000000b98000
NIP: c0000000000fa72c LR: c0000000000fa728 CTR: c0000000004a8b80
REGS: c00000003efeaf40 TRAP: 0700   Not tainted  (4.3.0-test)
MSR: 9000000000021032 <SF,HV,ME,IR,DR,RI>  CR: 28002042  XER: 20000000
SOFTE: 0 
GPR00: c0000000000fa728 c00000003efeb1c0 c000000000b9e400 000000000000002c 
GPR04: 0000000000000000 000000000000013b c000000000b5e790 6e6f7420696d706c 
GPR08: 656d656e00000000 c000000000aad148 c000000000ba3878 00000000000001ef 
GPR12: 0000000022002044 c00000000ffff000 0000000000000100 0000000000000000 
GPR16: c00000003800f01c c00000003800f02c 000000010000a849 c000000038008100 
GPR20: c00000003800f010 c00000003efe8000 0000000000000000 0000000000000000 
GPR24: 0000000000000100 c0000000389ad120 c0000000389ad1b0 0000000000000000 
GPR28: 0000000000000100 c00000003efeb920 c000000000a1d88c c000000000a93529 
NIP [c0000000000fa72c] .save_stack_trace_regs+0x3c/0x70
LR [c0000000000fa728] .save_stack_trace_regs+0x38/0x70
Call Trace:
[c00000003efeb1c0] [c0000000000fa728] .save_stack_trace_regs+0x38/0x70 (unreliable)
[c00000003efeb240] [c000000000145b2c] .__ftrace_trace_stack+0x15c/0x210
[c00000003efeb310] [c000000000145cc4] .ftrace_trace_stack_regs+0x24/0x40
[c00000003efeb380] [c0000000001467c4] .trace_buffer_unlock_commit_regs+0x44/0x70
[c00000003efeb420] [c000000000165b38] .kprobe_trace_func+0x278/0x400
[c00000003efeb530] [c000000000165d38] .kprobe_dispatcher+0x78/0xa0
[c00000003efeb5c0] [c0000000007b0ca0] .kprobe_exceptions_notify+0x2e0/0x520
[c00000003efeb670] [c0000000000b4934] .notifier_call_chain+0x94/0xf0
[c00000003efeb710] [c0000000000b4a2c] .atomic_notifier_call_chain+0x3c/0x50
[c00000003efeb7a0] [c0000000000b4c48] .notify_die+0x38/0x50
[c00000003efeb830] [c0000000007aff90] .program_check_exception+0x1a0/0x260
[c00000003efeb8b0] [c00000000000621c] program_check_common+0x11c/0x180
--- interrupt: 700 at .kfree+0x0/0x220
    LR = .skb_release_data+0xe8/0x160
[c00000003efebba0] [c00000003efebc30] 0xc00000003efebc30 (unreliable)
[c00000003efebc30] [c000000000678bd8] .__kfree_skb+0x38/0xe0
[c00000003efebcb0] [c000000000686a20] .net_tx_action+0xe0/0x330
[c00000003efebd70] [c000000000090e94] .__do_softirq+0x194/0x3d0
[c00000003efebe90] [c000000000091428] .irq_exit+0xb8/0x100
[c00000003efebf00] [c00000000000f2dc] .__do_irq+0xac/0x1b0
[c00000003efebf90] [c00000000001f1b8] .call_do_irq+0x14/0x24
[c000000000b9b870] [c00000000000f478] .do_IRQ+0x98/0x110
[c000000000b9b920] [c0000000000020b8] hardware_interrupt_common+0x138/0x180
--- interrupt: 501 at .arch_local_irq_restore+0x64/0x90
    LR = .arch_local_irq_restore+0x64/0x90
[c000000000b9bc10] [c000000000b98000] 0xc000000000b98000 (unreliable)
[c000000000b9bc80] [c0000000000133e8] .arch_cpu_idle+0xe8/0x160
[c000000000b9bd00] [c0000000000d9204] .default_idle_call+0x44/0x70
[c000000000b9bd70] [c0000000000d95f4] .cpu_startup_entry+0x2f4/0x460
[c000000000b9be80] [c00000000000ab4c] .rest_init+0x9c/0xb0
[c000000000b9bef0] [c00000000097742c] .start_kernel+0x520/0x540
[c000000000b9bf90] [c000000000008cf0] start_here_common+0x20/0x3b0
Instruction dump:
f821ff81 3fe2ffef 60000000 60000000 3bff5129 881f0001 2f800001 41be0028 
3c62ffd0 38636b38 486bb975 60000000 <0fe00000> 38000001 981f0001 60000000 
---[ end trace e224cc02c4ea7f78 ]---


Although save_stack_trace() (which normal event stack traces use) is
implemented, save_stack_trace_regs() which kprobe events use is not.
This is a cheap attempt to implement that function.

Note, This may have issues if a task tries to get a stack trace from
another task with its regs, because it just passes in "current" to
save_context_stack(). But this does solve the issue with stack tracing
kprobe events.

Reported-by: Chunyu Hu <chuhu@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index ea43a347a104..0142c86801ba 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -61,3 +61,10 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 	save_context_stack(trace, tsk->thread.ksp, tsk, 0);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
+
+void
+save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
+{
+	save_context_stack(trace, regs->gpr[PT_R1], current, 0);
+}
+EXPORT_SYMBOL_GPL(save_stack_trace_regs);
