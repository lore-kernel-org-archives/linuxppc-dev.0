Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C2597B7D1A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 May 2010 14:48:27 +1000 (EST)
Subject: Re: Spinlock lockup lockup in switch_mmu_context and task_rq_lock
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Li, Jianlin (Jianlin)" <jianlin.li@alcatel-lucent.com>
In-Reply-To: <38A3C77CC1D12D4DB6632EFEE8128BFE1367A668FA@USNAVSXCHMBSA1.ndc.alcatel-lucent.com>
References: <38A3C77CC1D12D4DB6632EFEE8128BFE1367A668FA@USNAVSXCHMBSA1.ndc.alcatel-lucent.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 26 May 2010 14:48:16 +1000
Message-ID: <1274849296.1931.301.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-05-25 at 09:15 -0500, Li, Jianlin (Jianlin) wrote:
> Hi,
> 
> I am running 2.6.29.1 on MPC8572 dual core with SMP enabled on our customized board.
> 
> I have two applications running. One is to access CPLD registers via PCI bus and then sleep in an endless loop, the other is to send (and of course receive data) via TSEC port in an endless loop.
> 
> Sooner or later, I will encounter spinlock lockup in both cores.
> 
> I examined the call traces and found out that it is always the case that one got stuck in switch_mmu_context and the other in task_rq_lock when switching from interrupt context to a waiting process.

This has been fixed since then. I suggest you look at the git changes to
mmu_context_nohash.c after 2.6.29 and you'll find the fix quickly.

Cheers,
Ben.

> BUG: spinlock lockup on CPU#0, diag/31023, c0478f64
> BUG: spinlock lockup on CPU#1, diag/31016, c18123c0
> Call Trace:
> [edb4d980] [c0007a78] show_stack+0x48/0x16c (unreliable)
> [edb4d9b0] [c01c1a48] _raw_spin_lock+0x1b0/0x1c4
> [edb4d9f0] [c0348e7c] _spin_lock+0x10/0x20
> [edb4da00] [c002f0c8] task_rq_lock+0x50/0x94
> [edb4da30] [c0035430] try_to_wake_up+0xb0/0x214
> [edb4da60] [c00b99ec] pollwake+0x64/0x74
> [edb4dab0] [c0037970] __wake_up_common+0x5c/0xa0
> [edb4dae0] [c0037a6c] __wake_up_sync+0x48/0x68
> [edb4db10] [c0272aa8] sock_def_write_space+0xac/0xbc
> [edb4db30] [c0271e48] sock_wfree+0x98/0x9c
> [edb4db50] [c0274bd0] skb_release_head_state+0x8c/0xa8
> [edb4db70] [c0274c04] skb_release_all+0x18/0x30
> [edb4db90] [c0274c34] __kfree_skb+0x18/0xec
> [edb4dbb0] [f106c6fc] csmencaps_rcv+0x474/0x57c [csmencaps]
> [edb4dbe0] [c027f2c0] netif_receive_skb+0x2ec/0x32c
> [edb4dc10] [c02167dc] gfar_clean_rx_ring+0x180/0x3dc
> [edb4dc60] [c0216aa0] gfar_poll+0x68/0x354
> [edb4dcc0] [c027fd34] net_rx_action+0x12c/0x1a8
> [edb4dcf0] [c00435b0] __do_softirq+0xa8/0x15c
> [edb4dd40] [c0004348] do_softirq+0x60/0x68
> [edb4dd60] [c0043768] irq_exit+0x8c/0x90
> [edb4dd80] [c00041e4] do_IRQ+0xd8/0x110
> [edb4ddb0] [c00102f4] ret_from_except+0x0/0x18
> [edb4de70] [c0014a84] destroy_context+0x3c/0xac
> [edb4de90] [c003b3fc] __mmdrop+0x3c/0x60
> [edb4deb0] [c0035880] finish_task_switch+0xd0/0xd4
> [edb4ded0] [c03467b0] __sched_text_start+0x200/0x6b4
> [edb4df40] [c00107a8] recheck+0x0/0x24
> Call Trace:
> [e92e9e10] [c0007a78] show_stack+0x48/0x16c (unreliable)
> [e92e9e40] [c01c1a48] _raw_spin_lock+0x1b0/0x1c4
> [e92e9e80] [c0348e7c] _spin_lock+0x10/0x20
> [e92e9e90] [c0014700] switch_mmu_context+0x2c/0x35c
> [e92e9ed0] [c0346778] __sched_text_start+0x1c8/0x6b4
> [e92e9f40] [c00107a8] recheck+0x0/0x24
> 
> Does anyone have some clue on this?
> 
> Thanks,
> 
> Jane
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
