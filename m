Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 44DCF2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Dec 2013 04:44:51 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset=us-ascii
Subject: 3.13 Oops on ppc64_cpu --smt=off
Date: Sat, 30 Nov 2013 18:45:40 +0100
Message-Id: <9C236EE3-BB04-4BF9-ACE0-870A9E97EA0F@suse.de>
To: Ben Herrenschmidt <benh@kernel.crashing.org>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1812\))
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

With current linus master (3.13-rc2+) I'm facing an interesting issue =
with SMT disabling on p7. When I trigger the cpu offlining it works as =
expected, but after a few seconds the machine goes into an oops as you =
can see below.

It looks like a null pointer dereference.


Alex

($ ppc64_cpu --smt=3Doff)
kvm: disabling virtualization on CPU1
kvm: disabling virtualization on CPU2
kvm: disabling virtualization on CPU3
kvm: disabling virtualization on CPU5
kvm: disabling virtualization on CPU6
kvm: disabling virtualization on CPU7
kvm: disabling virtualization on CPU9
kvm: disabling virtualization on CPU10
kvm: disabling virtualization on CPU11
kvm: disabling virtualization on CPU13
kvm: disabling virtualization on CPU14
kvm: disabling virtualization on CPU15
kvm: disabling virtualization on CPU17
kvm: disabling virtualization on CPU18
kvm: disabling virtualization on CPU19
kvm: disabling virtualization on CPU21
kvm: disabling virtualization on CPU22
kvm: disabling virtualization on CPU23
kvm: disabling virtualization on CPU25
kvm: disabling virtualization on CPU26
kvm: disabling virtualization on CPU27
kvm: disabling virtualization on CPU29
kvm: disabling virtualization on CPU30
kvm: disabling virtualization on CPU31
kvm: disabling virtualization on CPU33
kvm: disabling virtualization on CPU34
kvm: disabling virtualization on CPU35
kvm: disabling virtualization on CPU37
kvm: disabling virtualization on CPU38
kvm: disabling virtualization on CPU39
kvm: disabling virtualization on CPU41
kvm: disabling virtualization on CPU42
kvm: disabling virtualization on CPU43
kvm: disabling virtualization on CPU45
kvm: disabling virtualization on CPU46
kvm: disabling virtualization on CPU47
kvm: disabling virtualization on CPU49
kvm: disabling virtualization on CPU50
kvm: disabling virtualization on CPU51
kvm: disabling virtualization on CPU53
kvm: disabling virtualization on CPU54
kvm: disabling virtualization on CPU55
kvm: disabling virtualization on CPU57
kvm: disabling virtualization on CPU58
kvm: disabling virtualization on CPU59
kvm: disabling virtualization on CPU61
kvm: disabling virtualization on CPU62
kvm: disabling virtualization on CPU63
Unable to handle kernel paging request for data at address 0x00000010
Faulting instruction address: 0xc000000000124188
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=3D1024 NUMA PowerNV
Modules linked in: iptable_filter ip_tables x_tables nfsv3 nfs_acl nfs =
fscache lockd sunrpc autofs4 binfmt_misc af_packet fuse loop dm_mod =
ohci_pci ohci_hcd ehci_pci ehci_hcd e1000e usbcore sr_mod cdrom ses =
enclosure rtc_generic usb_common ptp sg pps_core sd_mod crc_t10dif =
crct10dif_common scsi_dh_hp_sw scsi_dh_alua scsi_dh_emc scsi_dh_rdac =
scsi_dh virtio_pci virtio_console virtio_blk virtio virtio_ring ipr =
libata scsi_mod
CPU: 56 PID: 0 Comm: swapper/56 Not tainted =
3.13.0-rc2-0.g01695c8-default+ #1
task: c0000007f28b5180 ti: c0000007f28c8000 task.ti: c0000007f28c8000
NIP: c000000000124188 LR: c000000000124144 CTR: c00000000011e650
REGS: c0000007f28cb1e0 TRAP: 0300   Not tainted  =
(3.13.0-rc2-0.g01695c8-default+)
MSR: 9000000000009032 <SF,HV,EE,ME,IR,DR,RI>  CR: 24000028  XER: =
00000000
CFAR: c00000000000908c DAR: 0000000000000010 DSISR: 40000000 SOFTE: 0
GPR00: 00000000ef4546c9 c0000007f28cb460 c0000000013c7690 =
0000000000000000
GPR04: 0000000000000038 0000000000000010 c000000003314ea0 =
c000000000c72878
GPR08: c000000000c83448 c0000007ef454600 0000000002690000 =
0000000000000000
GPR12: 000000000000c345 c00000000ff0e000 c0000007f28cb8b0 =
0000000000000001
GPR16: 7fffffffffffffff c0000007f28cb8c0 0000000002690000 =
000000219729878b
GPR20: 0000000000000000 c000000000c72698 c0000000033027d0 =
c00000000142ca58
GPR24: c000000000c84e80 c000000003314e80 c00000000142ca58 =
00000000ffffc32c
GPR28: 0000000000000038 c0000007f28b5180 c0000000012f8cd0 =
c000000001422180
NIP [c000000000124188] .trigger_load_balance+0xc8/0x2e0
LR [c000000000124144] .trigger_load_balance+0x84/0x2e0
Call Trace:
[c0000007f28cb460] [c000000000124134] .trigger_load_balance+0x74/0x2e0 =
(unreliable)
[c0000007f28cb510] [c00000000011ca50] .scheduler_tick+0x100/0x160
[c0000007f28cb5d0] [c0000000000e9074] .update_process_times+0x64/0x90
[c0000007f28cb660] [c0000000001628f4] .tick_sched_handle+0x34/0xc0
[c0000007f28cb6f0] [c000000000162c60] .tick_sched_timer+0x70/0xc0
[c0000007f28cb790] [c000000000109000] .__run_hrtimer+0x180/0x280
[c0000007f28cb840] [c000000000109738] .hrtimer_interrupt+0x158/0x340
[c0000007f28cb960] [c00000000001ec74] .timer_interrupt+0x174/0x2d0
[c0000007f28cba10] [c000000000002824] decrementer_common+0x124/0x180
--- Exception: 901 at .arch_local_irq_restore+0x84/0xa0
    LR =3D .arch_local_irq_restore+0x84/0xa0
[c0000007f28cbd00] [c000000000010c34] .arch_local_irq_restore+0x54/0xa0 =
(unreliable)
[c0000007f28cbd70] [c0000000000174f8] .arch_cpu_idle+0xc8/0x170
[c0000007f28cbe00] [c00000000014597c] .cpu_idle_loop+0x9c/0x2c0
[c0000007f28cbed0] [c00000000003f800] .start_secondary+0x2a0/0x2d0
[c0000007f28cbf90] [c0000000000097fc] .start_secondary_prolog+0x10/0x14
Instruction dump:
78001f24 e8fe8040 7d7a002a 7ce93b78 7d29582a 2fa90000 419e0030 8009004c
2f800000 419e0024 9069004c e9690010 <e92b0010> 3929001c 7c004828 =
30000001
---[ end trace 5d5f06c369432fa1 ]---

Kernel panic - not syncing: Fatal exception in interrupt
Rebooting in 100 seconds..=
