Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9099BDDDE5
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 00:02:00 +1100 (EST)
Date: Tue, 06 Feb 2007 22:01:46 +0900 (JST)
Message-Id: <200702061301.l16D1lxf009347@toshiba.co.jp>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 0/11] Patches for Toshiba Cell reference set
In-Reply-To: <1170633321.2620.56.camel@localhost.localdomain>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben-san,

> On Fri, 2007-02-02 at 16:34 +0900, Ishizaki Kou wrote:
> > Paul-san,
> > 
> > This is a revised version of the patch set for Toshiba Cell reference
> > set (aka Celleb). It is against powerpc.git. Please apply.
> > 
> > 
> > Changes from our previous patch set:
> > 
> > [PATCH 5/11] Celleb: htab routines
> > * use spin_lock_irqsave() instead of spin_lock()
> 
> In which circumstances was that a problem ? iSeries uses spin_lock() ...
> the caller should have disable IRQs before calling any of the low level
> htab routines. If not, then there is a bug that needs to be fixed.

It can be.

We found that following phenomenon:
 - An application calls "munmap"
 - do_munmap flushes TLB (so HTAB is invalidated)
 - when exiting spin_unlock(), DEC exception occurs. (!)
 - One of DEC handler causes data storage interrupt
 - Then, the kernel reenters HTAB handler and spin_lock().


BUG: spinlock recursion on CPU#0, modprobe/1752
 lock: c000000000460578, .magic: dead4ead, .owner: modprobe/1752,
.owner_cpu: 0
Call Trace:
[C000000007FF3640] [C00000000000FB00] .show_stack+0x68/0x1b0
(unreliable)
[C000000007FF36E0] [C0000000001AEB8C] .spin_bug+0xb0/0xd4
[C000000007FF3770] [C0000000001AECE8] ._raw_spin_lock+0x60/0x17c
[C000000007FF3810] [C00000000036287C] ._spin_lock+0x10/0x24
[C000000007FF3890] [C00000000003BA70]
.beat_lpar_hpte_updatepp+0x60/0x104
[C000000007FF3940] [C0000000000299E4] .htab_call_hpte_updatepp+0x4/0x18
[C000000007FF3A40] [C00000000002980C] .hash_page+0x1b0/0x1cc
[C000000007FF3AB0] [C0000000000049C0] .do_hash_page+0x40/0x5c
--- Exception: 401 at .add_grec+0x0/0x4e4 [ipv6]
    LR = .mld_ifc_timer_expire+0x1b8/0x2ac [ipv6]
[C000000007FF3DA0] [D000000000115DF8] .mld_ifc_timer_expire+0x188/0x2ac
[ipv6] (unreliable)
[C000000007FF3E40] [C00000000005C0AC] .run_timer_softirq+0x168/0x214
[C000000007FF3EF0] [C0000000000565A8] .__do_softirq+0xa8/0x164
[C000000007FF3F90] [C00000000002116C] .call_do_softirq+0x14/0x24
[C000000004E33430] [C00000000000C114] .do_softirq+0x68/0xac
[C000000004E334C0] [C0000000000566B8] .irq_exit+0x54/0x6c
[C000000004E33540] [C00000000001E508] .timer_interrupt+0x3e8/0x424
[C000000004E33620] [C000000000003578] decrementer_common+0xf8/0x100
--- Exception: 901 at .beat_hcall5+0x30/0x54
    LR = .beat_lpar_hpte_getword0+0x28/0x58
[C000000004E33910] [C000000000362794] ._spin_unlock_irqrestore+0x18/0x3c
(unreliable)
[C000000004E339D0] [C00000000003B624]
.beat_lpar_hpte_invalidate+0x64/0xe8
[C000000004E33A70] [C0000000000290F0] .flush_hash_page+0x74/0x88
[C000000004E33AE0] [C000000000029188] .flush_hash_range+0x84/0xb8
[C000000004E33B80] [C000000000029B18] .__flush_tlb_pending+0x78/0x9c
[C000000004E33C00] [C0000000000A6CBC] .unmap_region+0x160/0x1c0
[C000000004E33CD0] [C0000000000A7E80] .do_munmap+0x21c/0x2d4
[C000000004E33D90] [C0000000000A7F8C] .sys_munmap+0x54/0x88
[C000000004E33E30] [C000000000008634] syscall_exit+0x0/0x40
BUG: spinlock lockup on CPU#0, modprobe/1752, c000000000460578
Call Trace:
[C000000007FF36D0] [C00000000000FB00] .show_stack+0x68/0x1b0
(unreliable)
[C000000007FF3770] [C0000000001AEDC8] ._raw_spin_lock+0x140/0x17c
[C000000007FF3810] [C00000000036287C] ._spin_lock+0x10/0x24
[C000000007FF3890] [C00000000003BA70]
.beat_lpar_hpte_updatepp+0x60/0x104
[C000000007FF3940] [C0000000000299E4] .htab_call_hpte_updatepp+0x4/0x18
[C000000007FF3A40] [C00000000002980C] .hash_page+0x1b0/0x1cc
[C000000007FF3AB0] [C0000000000049C0] .do_hash_page+0x40/0x5c
--- Exception: 401 at .add_grec+0x0/0x4e4 [ipv6]
    LR = .mld_ifc_timer_expire+0x1b8/0x2ac [ipv6]
[C000000007FF3DA0] [D000000000115DF8] .mld_ifc_timer_expire+0x188/0x2ac
[ipv6] (unreliable)
[C000000007FF3E40] [C00000000005C0AC] .run_timer_softirq+0x168/0x214
[C000000007FF3EF0] [C0000000000565A8] .__do_softirq+0xa8/0x164
[C000000007FF3F90] [C00000000002116C] .call_do_softirq+0x14/0x24
[C000000004E33430] [C00000000000C114] .do_softirq+0x68/0xac
[C000000004E334C0] [C0000000000566B8] .irq_exit+0x54/0x6c
[C000000004E33540] [C00000000001E508] .timer_interrupt+0x3e8/0x424
[C000000004E33620] [C000000000003578] decrementer_common+0xf8/0x100
--- Exception: 901 at .beat_hcall5+0x30/0x54
    LR = .beat_lpar_hpte_getword0+0x28/0x58
[C000000004E33910] [C000000000362794] ._spin_unlock_irqrestore+0x18/0x3c
(unreliable)
[C000000004E339D0] [C00000000003B624]
.beat_lpar_hpte_invalidate+0x64/0xe8
[C000000004E33A70] [C0000000000290F0] .flush_hash_page+0x74/0x88
[C000000004E33AE0] [C000000000029188] .flush_hash_range+0x84/0xb8
[C000000004E33B80] [C000000000029B18] .__flush_tlb_pending+0x78/0x9c
[C000000004E33C00] [C0000000000A6CBC] .unmap_region+0x160/0x1c0
[C000000004E33CD0] [C0000000000A7E80] .do_munmap+0x21c/0x2d4
[C000000004E33D90] [C0000000000A7F8C] .sys_munmap+0x54/0x88
[C000000004E33E30] [C000000000008634] syscall_exit+0x0/0x40

Best regards,
Kou Ishizaki
