Return-Path: <anton@samba.org>
Date: Sun, 16 Mar 2014 15:44:00 +1100
From: Anton Blanchard <anton@samba.org>
To: paulus@samba.org, benh@kernel.crashing.org, mikey@neuling.org,
 agraf@suse.de, aneesh.kumar@linux.vnet.ibm.com
Subject: kvmppc_wait_for_nap warnings and KVM host+guest hang on 3.14-rc6*
Message-ID: <20140316154400.406537e1@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

I was testing KVM on an upstream kernel (3.14.0-rc6-00145-ga4ecdf8)
with Gregory's emulated MMIO fixes.

I ran with 16 cores and 4 threads (matches the host):

qemu-system-ppc64 -enable-kvm -smp cores=16,threads=4 -m 32G -M pseries -cpu POWER7 -nographic -nodefaults -monitor stdio -serial pty -drive file=XXX -netdev bridge,br=br0,id=net0,helper=/usr/libexec/qemu-bridge-helper -device virtio-net-pci,netdev=net0

Note that in kernel XICS acceleration wasn't enabled (perhaps it should
be the default, it isn't right now):

qemu-system-ppc64: KVM and IRQ_XICS capability must be present for in-kernel XICS

During boot I see processors stuck in the guest:

[   16.145166] Processor 1 is stuck.

And thousands of:

kvmppc_wait_for_nap timeout 0 1
kvmppc_wait_for_nap timeout 0 1
kvmppc_wait_for_nap timeout 0 1
kvmppc_wait_for_nap timeout 0 1

And eventually:

INFO: rcu_sched self-detected stall on CPU { 52}  (t=10170 jiffies g=765 c=764 q=127)
CPU: 52 PID: 11833 Comm: qemu-system-ppc Not tainted 3.14.0-rc6-00145-ga4ecdf8-dirty #10
Call Trace:
[c000000765caad20] [c000000000015f3c] .show_stack+0x7c/0x1f0 (unreliable)
[c000000765caadf0] [c00000000082d83c] .dump_stack+0x88/0xb4
[c000000765caae70] [c0000000000f7cf0] .rcu_check_callbacks+0x5b0/0x950
[c000000765caafa0] [c00000000009c860] .update_process_times+0x50/0xa0
[c000000765cab030] [c000000000103c40] .tick_sched_handle.isra.16+0x20/0xa0
[c000000765cab0b0] [c000000000103d1c] .tick_sched_timer+0x5c/0xa0
[c000000765cab150] [c0000000000ba0f8] .__run_hrtimer+0x98/0x260
[c000000765cab1f0] [c0000000000baef8] .hrtimer_interrupt+0x138/0x320
[c000000765cab300] [c00000000001e430] .timer_interrupt+0x100/0x2f0
[c000000765cab3b0] [c00000000000a8d8] restore_check_irq_replay+0x40/0x5c
--- Exception: 901 at .__kvmppc_vcore_entry+0x140/0x1ac [kvm_hv]
    LR = kvmppc_call_hv_entry+0x8/0xe8
[c000000765cab6a0] [d000000006394f74] .__kvmppc_vcore_entry+0x140/0x1ac [kvm_hv] (unreliable)
[c000000765cab870] [d000000006394148] .kvmppc_vcpu_run_hv+0x8b8/0x1520 [kvm_hv]
[c000000765cab9f0] [d000000005e5c250] .kvmppc_vcpu_run+0x30/0x50 [kvm]
[c000000765caba60] [d000000005e599f4] .kvm_arch_vcpu_ioctl_run+0x54/0x1b0 [kvm]INFO: rcu_sched detected stalls on CPUs/tasks: { 52} (detected by 60, t=10170 jiffies, g=765, c=764, q=127)
Task dump for CPU 52:
qemu-system-ppc R  running task     9184 11833  11817 0x00000084
Call Trace:
[c000000765cab2f0] [c000000765cab3b0] 0xc000000765cab3b0 (unreliable)
[c000000765cab420] [c000000000d518e8] kexec_stack+0x18e8/0x10000
[c000000765cabaf0] [d000000005e54588] .kvm_vcpu_ioctl+0x478/0x740 [kvm]
[c000000765cabcb0] [c0000000001ffcd4] .do_vfs_ioctl+0x4a4/0x760
[c000000765cabd90] [c0000000001fffe8] .SyS_ioctl+0x58/0xb0
[c000000765cabe30] [c00000000000a158] syscall_exit+0x0/0x98

BUG: soft lockup - CPU#52 stuck for 97s! [qemu-system-ppc:11833]
Modules linked in: tun xt_conntrack ipt_MASQUERADE iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_filter ip_tables x_tables bridge stp llc kvm_hv powernv_rng rng_core kvm binfmt_misc nfsd exportfs autofs4
CPU: 52 PID: 11833 Comm: qemu-system-ppc Not tainted 3.14.0-rc6-00145-ga4ecdf8-dirty #10
task: c00000078f7af860 ti: c000000765ca8000 task.ti: c000000765ca8000
NIP: d000000006394f74 LR: c00000000007a1dc CTR: c00000000007a1a0
REGS: c000000765cab420 TRAP: 0901   Not tainted  (3.14.0-rc6-00145-ga4ecdf8-dirty)
MSR: 9000000000009032 <SF,HV,EE,ME,IR,DR,RI>  CR: 24002824  XER: 20000000
CFAR: c00000000007a2b4 SOFTE: 1 
GPR00: c00000000007a1dc c000000765cab6a0 c000000000d518e8 000000aae8fb0387 
GPR04: fffffff3dbd12408 0000000000000000 0000000000000007 9000000000009032 
GPR08: d000000006394f74 c00000078b880000 9000000000001032 c00000000007a1a0 
GPR12: 0000000000000500 c000000001e0d000 
NIP [d000000006394f74] .__kvmppc_vcore_entry+0x140/0x1ac [kvm_hv]
LR [c00000000007a1dc] kvmppc_call_hv_entry+0x8/0xe8
Call Trace:
[c000000765cab6a0] [d000000006394f74] .__kvmppc_vcore_entry+0x140/0x1ac [kvm_hv] (unreliable)
[c000000765cab870] [d000000006394148] .kvmppc_vcpu_run_hv+0x8b8/0x1520 [kvm_hv]
[c000000765cab9f0] [d000000005e5c250] .kvmppc_vcpu_run+0x30/0x50 [kvm]
[c000000765caba60] [d000000005e599f4] .kvm_arch_vcpu_ioctl_run+0x54/0x1b0 [kvm]
[c000000765cabaf0] [d000000005e54588] .kvm_vcpu_ioctl+0x478/0x740 [kvm]
[c000000765cabcb0] [c0000000001ffcd4] .do_vfs_ioctl+0x4a4/0x760
[c000000765cabd90] [c0000000001fffe8] .SyS_ioctl+0x58/0xb0
[c000000765cabe30] [c00000000000a158] syscall_exit+0x0/0x98
Instruction dump:
7d083a14 f90d03c0 60000000 60000000 60000000 60000000 60000000 60000000 
60000000 60000000 60000000 48003af1 <e8410028> e9c100e0 e9e100e8 ea0100f0 

Anton
