Return-Path: <oohall@gmail.com>
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JfFm6H0zzF116
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 19:35:40 +1000 (AEST)
Received: by mail-it1-x143.google.com with SMTP id p129-v6so9611254ite.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 02:35:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1537779408.26347.9.camel@abdul.in.ibm.com>
References: <1537779408.26347.9.camel@abdul.in.ibm.com>
From: Oliver <oohall@gmail.com>
Date: Mon, 24 Sep 2018 19:35:37 +1000
Message-ID: <CAOSf1CHX0PnVQSrW+t=4vA2ZyVDpU_5B_OUg_arwsuDbcDTzOw@mail.gmail.com>
Subject: Re: [mainline][ppc][bnx2x] watchdog: CPU 80 self-detected hard LOCKUP
 @ opal_interrupt+0x28/0x70 when module load/unload
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 maurosr <maurosr@linux.vnet.ibm.com>,
 sim <sim@linux.vnet.ibm.com>, manvanth <manvanth@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 24, 2018 at 6:56 PM, Abdul Haleem
<abdhalee@linux.vnet.ibm.com> wrote:
> Greeting's
>
> bnx2x module load/unload test results in continuous hard LOCKUP trace on
> my powerpc bare-metal running mainline 4.19.0-rc4 kernel
>
> the instruction address points to:
>
> 0xc00000000009d048 is in opal_interrupt
> (arch/powerpc/platforms/powernv/opal-irqchip.c:133).
> 128
> 129     static irqreturn_t opal_interrupt(int irq, void *data)
> 130     {
> 131             __be64 events;
> 132
> 133             opal_handle_interrupt(virq_to_hw(irq), &events);
> 134             last_outstanding_events = be64_to_cpu(events);
> 135             if (opal_have_pending_events())
> 136                     opal_wake_poller();
> 137
>
> trace:
> bnx2x 0008:01:00.3 enP8p1s0f3: renamed from eth0
> bnx2x 0008:01:00.3 enP8p1s0f3: using MSI-X  IRQs: sp 297  fp[0] 299 ... fp[7] 306
> bnx2x 0008:01:00.2 enP8p1s0f2: NIC Link is Up, 1000 Mbps full duplex, Flow control: none
> bnx2x 0008:01:00.3 enP8p1s0f3: NIC Link is Up, 1000 Mbps full duplex, Flow control: none
> bnx2x: QLogic 5771x/578xx 10/20-Gigabit Ethernet Driver bnx2x 1.712.30-0 (2014/02/10)
> bnx2x 0008:01:00.0: msix capability found
> bnx2x 0008:01:00.0: Using 64-bit DMA iommu bypass
> bnx2x 0008:01:00.0: part number 0-0-0-0
> bnx2x 0008:01:00.0: 32.000 Gb/s available PCIe bandwidth (5 GT/s x8 link)
> bnx2x 0008:01:00.0 enP8p1s0f0: renamed from eth0
> bnx2x 0008:01:00.1: msix capability found
> bnx2x 0008:01:00.1: Using 64-bit DMA iommu bypass
> bnx2x 0008:01:00.1: part number 0-0-0-0
> bnx2x 0008:01:00.0 enP8p1s0f0: using MSI-X  IRQs: sp 267  fp[0] 269 ... fp[7] 276
> bnx2x 0008:01:00.0 enP8p1s0f0: NIC Link is Up, 10000 Mbps full duplex, Flow control: ON - receive & transmit
> bnx2x 0008:01:00.1: 32.000 Gb/s available PCIe bandwidth (5 GT/s x8 link)
> bnx2x 0008:01:00.1 enP8p1s0f1: renamed from eth0
> bnx2x 0008:01:00.2: msix capability found
> bnx2x 0008:01:00.2: Using 64-bit DMA iommu bypass
> bnx2x 0008:01:00.2: part number 0-0-0-0
> bnx2x 0008:01:00.1 enP8p1s0f1: using MSI-X  IRQs: sp 277  fp[0] 279 ... fp[7] 286
> bnx2x 0008:01:00.1 enP8p1s0f1: NIC Link is Up, 10000 Mbps full duplex, Flow control: ON - receive & transmit


> watchdog: CPU 80 self-detected hard LOCKUP @ opal_interrupt+0x28/0x70
> watchdog: CPU 80 TB:980794111093, last heartbeat TB:973959617200 (13348ms ago)

Ouch, 13 seconds in OPAL. Looks like we trip the hard lockup detector
once the thread comes back into the kernel so we're not completely
stuck. At a guess there's some contention on a lock in OPAL due to the
bind/unbind loop, but i'm not sure why that would be happening.

Can you give us a copy of the OPAL log? /sys/firmware/opal/msglog)

> Modules linked in: bnx2x(+) iptable_mangle ipt_MASQUERADE iptable_nat
> nf_nat_ipv4 nf_nat xt_conntrack nf_conntrack nf_defrag_ipv4 ipt_REJECT
> nf_reject_ipv4 xt_tcpudp tun bridge stp llc iptable_filter dm_mirror
> dm_region_hash dm_log dm_service_time vmx_crypto powernv_rng rng_core
> dm_multipath kvm_hv kvm binfmt_misc nfsd ip_tables x_tables autofs4 xfs
> lpfc crc_t10dif crct10dif_generic nvme_fc nvme_fabrics mdio libcrc32c
> nvme_core crct10dif_common [last unloaded: bnx2x]
> CPU: 80 PID: 0 Comm: swapper/80 Not tainted 4.19.0-rc4-autotest-autotest #1
> NIP:  c00000000009d048 LR: c000000000092fd0 CTR: 0000000030032a00
> REGS: c000003fff493d80 TRAP: 0900   Not tainted  (4.19.0-rc4-autotest-autotest)
> MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 48004042  XER: 00000000
> CFAR: c000000000092fbc IRQMASK: 1
> GPR00: 0000000030005128 c000003fff70f220 c0000000010ae500 0000000000000000
> GPR04: 0000000048004042 c00000000009d048 9000000000009033 0000000000000090
> GPR08: 0000000000000000 0000000000000000 c000000000092fe4 9000000000001003
> GPR12: c000000000092fbc c000003fff7ff300 c000003c96c80c00 0000000000010000
> GPR16: 0000000000000000 000000000000003c c000003c96c80800 c000003c96d00700
> GPR20: 0000000000000001 0000000000000001 0000000000000002 0000000000000014
> GPR24: c000001fe8741000 c000003fff70f330 0000000000000000 c000003ca947fb40
> GPR28: 00000000092f47d0 0000000000000014 c000001fe8741000 c000001fe9860200
> NIP [c00000000009d048] opal_interrupt+0x28/0x70
> LR [c000000000092fd0] opal_return+0x14/0x48
> Call Trace:
> [c000003fff70f220] [c00000000009d048] opal_interrupt+0x28/0x70 (unreliable)
> [c000003fff70f250] [c00000000016d890] __handle_irq_event_percpu+0x90/0x2d0
> [c000003fff70f310] [c00000000016db00] handle_irq_event_percpu+0x30/0x90
> [c000003fff70f350] [c00000000016dbc0] handle_irq_event+0x60/0xc0
> [c000003fff70f380] [c000000000172d2c] handle_fasteoi_irq+0xbc/0x1f0
> [c000003fff70f3b0] [c00000000016c084] generic_handle_irq+0x44/0x70
> [c000003fff70f3d0] [c0000000000193cc] __do_irq+0x8c/0x200
> [c000003fff70f440] [c000000000019640] do_IRQ+0x100/0x110
> [c000003fff70f490] [c000000000008db8] hardware_interrupt_common+0x158/0x160
> --- interrupt: 501 at fib_table_lookup+0xfc/0x600
>     LR = fib_validate_source+0x148/0x370
> [c000003fff70f780] [0000000000000000]           (null) (unreliable)
> [c000003fff70f7e0] [c000000000959af8] fib_validate_source+0x148/0x370
> [c000003fff70f8a0] [c0000000008fd664] ip_route_input_rcu+0x214/0x970
> [c000003fff70f990] [c0000000008fdde0] ip_route_input_noref+0x20/0x30
> [c000003fff70f9e0] [c000000000945e28] arp_process.constprop.14+0x3d8/0x8a0
> [c000003fff70faf0] [c00000000089eb20] __netif_receive_skb_one_core+0x60/0x80
> [c000003fff70fb30] [c0000000008a7d00] netif_receive_skb_internal+0x30/0x110
> [c000003fff70fb70] [c0000000008a888c] napi_gro_receive+0x11c/0x1c0
> [c000003fff70fbb0] [c000000000702afc] tg3_poll_work+0x5fc/0x1060
> [c000003fff70fcb0] [c0000000007035b4] tg3_poll_msix+0x54/0x210
> [c000003fff70fd00] [c0000000008a922c] net_rx_action+0x31c/0x470
> [c000003fff70fe10] [c0000000009f5afc] __do_softirq+0x15c/0x3b4
> [c000003fff70ff00] [c0000000000fddf0] irq_exit+0x100/0x120
> [c000003fff70ff20] [c0000000000193d8] __do_irq+0x98/0x200
> [c000003fff70ff90] [c00000000002af24] call_do_irq+0x14/0x24
> [c000003ca947fa80] [c0000000000195d4] do_IRQ+0x94/0x110
> [c000003ca947fad0] [c000000000008db8] hardware_interrupt_common+0x158/0x160
> --- interrupt: 501 at replay_interrupt_return+0x0/0x4
>     LR = arch_local_irq_restore+0x84/0x90
> [c000003ca947fdc0] [0000000000080000] 0x80000 (unreliable)
> [c000003ca947fde0] [c000000000181f60] rcu_idle_exit+0xa0/0xd0
> [c000003ca947fe30] [c000000000136d08] do_idle+0x1c8/0x3a0
> [c000003ca947fec0] [c0000000001370b4] cpu_startup_entry+0x34/0x40
> [c000003ca947fef0] [c0000000000467f4] start_secondary+0x4d4/0x520
> [c000003ca947ff90] [c00000000000b270] start_secondary_prolog+0x10/0x14
> Instruction dump:
> 60000000 60420000 3c4c0101 384214e0 7c0802a6 78630020 f8010010 f821ffd1
> 4bf7b901 60000000 38810020 4bff657d <60000000> 39010020 3d42ffed e94a5d28
> watchdog: CPU 80 became unstuck TB:980802789270
> CPU: 80 PID: 412 Comm: ksoftirqd/80 Not tainted 4.19.0-rc4-autotest-autotest #1
> Call Trace:
> [c000003ca96f7910] [c0000000009d4cec] dump_stack+0xb0/0xf4 (unreliable)
> [c000003ca96f7950] [c00000000002f278] wd_smp_clear_cpu_pending+0x368/0x3f0
> [c000003ca96f7a10] [c00000000002fa48] wd_timer_fn+0x78/0x3a0
> [c000003ca96f7ad0] [c00000000018a3c0] call_timer_fn+0x50/0x1b0
> [c000003ca96f7b50] [c00000000018a658] expire_timers+0x138/0x1e0
> [c000003ca96f7bc0] [c00000000018a7c8] run_timer_softirq+0xc8/0x220
> [c000003ca96f7c50] [c0000000009f5afc] __do_softirq+0x15c/0x3b4
> [c000003ca96f7d40] [c0000000000fdab4] run_ksoftirqd+0x54/0x80
> [c000003ca96f7d60] [c000000000126f10] smpboot_thread_fn+0x290/0x2a0
> [c000003ca96f7dc0] [c0000000001215ac] kthread+0x15c/0x1a0
> [c000003ca96f7e30] [c00000000000bdd4] ret_from_kernel_thread+0x5c/0x68
> bnx2x 0008:01:00.2: 32.000 Gb/s available PCIe bandwidth (5 GT/s x8 link)
> bnx2x 0008:01:00.2 enP8p1s0f2: renamed from eth0
> bnx2x 0008:01:00.3: msix capability found
> bnx2x 0008:01:00.3: Using 64-bit DMA iommu bypass
> bnx2x 0008:01:00.3: part number 0-0-0-0
> bnx2x 0008:01:00.3: 32.000 Gb/s available PCIe bandwidth (5 GT/s x8 link)
> bnx2x 0008:01:00.3 enP8p1s0f3: renamed from eth0
>
> --
> Regard's
>
> Abdul Haleem
> IBM Linux Technology Centre
>
>
>
