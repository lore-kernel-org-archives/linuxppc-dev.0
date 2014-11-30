Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47F381A0868
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Nov 2014 21:39:51 +1100 (AEDT)
Date: Sun, 30 Nov 2014 21:39:48 +1100
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>, Paul Mackerras
 <paulus@au1.ibm.com>, Alexey Kardashevskiy <aik@au1.ibm.com>, Alexander
 Graf <agraf@suse.de>
Subject: KVM XICS bug
Message-ID: <20141130213948.572e2579@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I've been seeing intermittent hangs when booting a KVM guest on a busy box.
Both host and guest are mainline (3.18-rc6). The backtrace looks like:

INFO: rcu_sched self-detected stall on CPU { 7}  (t=8404 jiffies g=-299 c=-300 q=79)
Task dump for CPU 7:
swapper/7       R  running task    11840     0      1 0x00000804
Call Trace:
[c0000007fa5434a0] [c0000000000cd684] sched_show_task+0xe4/0x160 (unreliable)
[c0000007fa543510] [c0000000000fa568] rcu_dump_cpu_stacks+0xe8/0x160
[c0000007fa543560] [c0000000000fe75c] rcu_check_callbacks+0x59c/0x8b0
[c0000007fa543680] [c000000000104a68] update_process_times+0x58/0xb0
[c0000007fa5436c0] [c000000000114e14] tick_periodic+0x44/0x110
[c0000007fa5436f0] [c000000000115208] tick_handle_periodic+0x38/0xc0
[c0000007fa543730] [c00000000001c7cc] __timer_interrupt+0x8c/0x240
[c0000007fa543780] [c00000000001ce90] timer_interrupt+0xa0/0xe0
[c0000007fa5437b0] [c0000000000099f4] restore_check_irq_replay+0x54/0x70
--- interrupt: 901 at arch_local_irq_restore+0x74/0x90
    LR = arch_local_irq_restore+0x74/0x90
[c0000007fa543aa0] [c0000000000d1874] vtime_common_account_irq_enter+0x54/0x70 (unreliable)
[c0000007fa543ac0] [c00000000009c3d8] __do_softirq+0xd8/0x3a0
[c0000007fa543bb0] [c00000000009c9f8] irq_exit+0xc8/0x110
[c0000007fa543be0] [c00000000001ce94] timer_interrupt+0xa4/0xe0
[c0000007fa543c10] [c0000000000099f4] restore_check_irq_replay+0x54/0x70
--- interrupt: 901 at arch_local_irq_restore+0x5c/0x90
    LR = arch_local_irq_restore+0x40/0x90
[c0000007fa543f00] [c000000000097864] cpu_notify+0x34/0x80 (unreliable)
[c0000007fa543f20] [c00000000003afa0] start_secondary+0x330/0x360
[c0000007fa543f90] [c000000000008b6c] start_secondary_prolog+0x10/0x14

XICS in kernel emulation is disabled (I really need to update the defconfig).

It looks like we are looping in restore_check_irq_replay, replaying 0x500
exceptions. When we call H_XIRR to ask for the IRQ, QEMU tells us it's a
spurious IRQ.

Thinking up other ways to create similar stress, I ran a big SMP guest
on one core (with taskset). With no root filesystem this will just
panic and reboot until it hits the bug:

taskset -c 0 ~/qemu/ppc64-softmmu/qemu-system-ppc64 -enable-kvm -smp cores=16,threads=8 -m 4G -M pseries -nographic -vga none -kernel vmlinux

It usually hits in under 5 minutes.

I took a QEMU trace (I added a tracepoint to power7_set_irq) and we can
see QEMU is trying to cancel the exception:

xics_icp_accept 0.322 pid=71614 old_xirr=0xff000000 new_xirr=0xff000000
power7_set_irq 2.232 pid=71614 pin=0x0 level=0x0
xics_icp_accept 0.285 pid=71614 old_xirr=0xff000000 new_xirr=0xff000000
power7_set_irq 21.809 pid=71614 pin=0x0 level=0x0
xics_icp_accept 0.311 pid=71614 old_xirr=0xff000000 new_xirr=0xff000000
power7_set_irq 2.230 pid=71614 pin=0x0 level=0x0

To me it looks like the KVM and the QEMU view of the 0x500 exception
state has got out of sync. The patch below fixes the issue for me, but
we might want to dig further to understand why the state has got out of
sync. Any ideas?

Anton
--

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index bec82cd..cb0911f 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -60,7 +60,6 @@ void ppc_set_irq(PowerPCCPU *cpu, int n_IRQ, int level)
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
-    unsigned int old_pending = env->pending_interrupts;
 
     if (level) {
         env->pending_interrupts |= 1 << n_IRQ;
@@ -72,11 +71,9 @@ void ppc_set_irq(PowerPCCPU *cpu, int n_IRQ, int level)
         }
     }
 
-    if (old_pending != env->pending_interrupts) {
 #ifdef CONFIG_KVM
-        kvmppc_set_interrupt(cpu, n_IRQ, level);
+    kvmppc_set_interrupt(cpu, n_IRQ, level);
 #endif
-    }
 
     LOG_IRQ("%s: %p n_IRQ %d level %d => pending %08" PRIx32
                 "req %08x\n", __func__, env, n_IRQ, level,
