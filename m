Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C34E1B7D47
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jun 2010 09:20:16 +1000 (EST)
Subject: Re: BUG: scheduling while atomic: swapper/0/0x00000002
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: paulmck@linux.vnet.ibm.com
In-Reply-To: <20100609215229.GA12774@linux.vnet.ibm.com>
References: <20100609215229.GA12774@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Jun 2010 09:20:08 +1000
Message-ID: <1276125608.1962.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-06-09 at 14:52 -0700, Paul E. McKenney wrote:
> Hello!
> 
> I get the following during boot on a 16 CPU Power box.  Thoughts?
> (/proc/config attached)

Wow... looks like the preempt count of the idle task got busted or
something ... how reproduceable ? Something like a record of previous
interrupts might be useful..

Cheers,
Ben.

> 							Thanx, Paul
> 
> UDP hash table entries: 2048 (order: 6, 262144 bytes)
> UDP-Lite hash table entries: 2048 (order: 6, 262144 bytes)
> NET: Registered protocol family 1
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> RPC: Registered tcp NFSv4.1 backchannel transport module.
> Trying to unpack rootfs image as initramfs...
> Freeing initrd memory: 2455k freed
> BUG: scheduling while atomic: swapper/0/0x00000002
> no locks held by swapper/0.
> Modules linked in:
> Call Trace:
> [c00000008e1afc20] [c000000000011990] .show_stack+0x70/0x184 (unreliable)
> [c00000008e1afcd0] [c00000000005cb60] .__schedule_bug+0xac/0xd0
> [c00000008e1afd70] [c0000000005f0c34] .schedule+0xc0/0x894
> [c00000008e1afe40] [c0000000000142d0] .cpu_idle+0x1f8/0x20c
> [c00000008e1afed0] [c000000000600b08] .start_secondary+0x3bc/0x3fc
> [c00000008e1aff90] [c000000000008264] .start_secondary_prolog+0x10/0x14
> BUG: scheduling while atomic: swapper/0/0x00000002
> no locks held by swapper/0.
> Modules linked in:
> Call Trace:
> [c00000008e1afc20] [c000000000011990] .show_stack+0x70/0x184 (unreliable)
> [c00000008e1afcd0] [c00000000005cb60] .__schedule_bug+0xac/0xd0
> [c00000008e1afd70] [c0000000005f0c34] .schedule+0xc0/0x894
> [c00000008e1afe40] [c0000000000142d0] .cpu_idle+0x1f8/0x20c
> [c00000008e1afed0] [c000000000600b08] .start_secondary+0x3bc/0x3fc
> [c00000008e1aff90] [c000000000008264] .start_secondary_prolog+0x10/0x14
> BUG: scheduling while atomic: swapper/0/0x00000002
> no locks held by swapper/0.
> Modules linked in:
> Call Trace:
> [c00000008e1afc20] [c000000000011990] .show_stack+0x70/0x184 (unreliable)
> [c00000008e1afcd0] [c00000000005cb60] .__schedule_bug+0xac/0xd0
> [c00000008e1afd70] [c0000000005f0c34] .schedule+0xc0/0x894
> [c00000008e1afe40] [c0000000000142d0] .cpu_idle+0x1f8/0x20c
> [c00000008e1afed0] [c000000000600b08] .start_secondary+0x3bc/0x3fc
> [c00000008e1aff90] [c000000000008264] .start_secondary_prolog+0x10/0x14
> BUG: scheduling while atomic: swapper/0/0x00000002
> no locks held by swapper/0.
> Modules linked in:
> Call Trace:
> [c00000008e1afc20] [c000000000011990] .show_stack+0x70/0x184 (unreliable)
> [c00000008e1afcd0] [c00000000005cb60] .__schedule_bug+0xac/0xd0
> [c00000008e1afd70] [c0000000005f0c34] .schedule+0xc0/0x894
> [c00000008e1afe40] [c0000000000142d0] .cpu_idle+0x1f8/0x20c
> [c00000008e1afed0] [c000000000600b08] .start_secondary+0x3bc/0x3fc
> [c00000008e1aff90] [c000000000008264] .start_secondary_prolog+0x10/0x14
> audit: initializing netlink socket (disabled)
> type=2000 audit(1276043741.388:1): initialized
> BUG: scheduling while atomic: swapper/0/0x00000002
> no locks held by swapper/0.
> Modules linked in:
> Call Trace:
> [c00000008e1afc20] [c000000000011990] .show_stack+0x70/0x184 (unreliable)
> [c00000008e1afcd0] [c00000000005cb60] .__schedule_bug+0xac/0xd0
> [c00000008e1afd70] [c0000000005f0c34] .schedule+0xc0/0x894
> [c00000008e1afe40] [c0000000000142d0] .cpu_idle+0x1f8/0x20c
> [c00000008e1afed0] [c000000000600b08] .start_secondary+0x3bc/0x3fc
> [c00000008e1aff90] [c000000000008264] .start_secondary_prolog+0x10/0x14
> BUG: scheduling while atomic: swapper/0/0x00000002
> no locks held by swapper/0.
> Modules linked in:
