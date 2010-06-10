Return-Path: <paulmck@paulmck-laptop.linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 21B5EB7D4F
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jun 2010 13:13:43 +1000 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o5A0uMfS022213
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jun 2010 20:56:22 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5A18tVu101912
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jun 2010 21:08:55 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5A18t4J024693
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jun 2010 21:08:55 -0400
Date: Wed, 9 Jun 2010 18:08:54 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: BUG: scheduling while atomic: swapper/0/0x00000002
Message-ID: <20100610010854.GA11432@linux.vnet.ibm.com>
References: <20100609215229.GA12774@linux.vnet.ibm.com>
	<1276125608.1962.0.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1276125608.1962.0.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 10, 2010 at 09:20:08AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2010-06-09 at 14:52 -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > I get the following during boot on a 16 CPU Power box.  Thoughts?
> > (/proc/config attached)
> 
> Wow... looks like the preempt count of the idle task got busted or
> something ... how reproduceable ? Something like a record of previous
> interrupts might be useful..

I have seen it only once, but it did get my attention.  I will try running
it again this evening when/if kernel-ml8 is free again.  2.6.35-rc2,
I should have mentioned.

							Thanx, Paul

> Cheers,
> Ben.
> 
> > 							Thanx, Paul
> > 
> > UDP hash table entries: 2048 (order: 6, 262144 bytes)
> > UDP-Lite hash table entries: 2048 (order: 6, 262144 bytes)
> > NET: Registered protocol family 1
> > RPC: Registered udp transport module.
> > RPC: Registered tcp transport module.
> > RPC: Registered tcp NFSv4.1 backchannel transport module.
> > Trying to unpack rootfs image as initramfs...
> > Freeing initrd memory: 2455k freed
> > BUG: scheduling while atomic: swapper/0/0x00000002
> > no locks held by swapper/0.
> > Modules linked in:
> > Call Trace:
> > [c00000008e1afc20] [c000000000011990] .show_stack+0x70/0x184 (unreliable)
> > [c00000008e1afcd0] [c00000000005cb60] .__schedule_bug+0xac/0xd0
> > [c00000008e1afd70] [c0000000005f0c34] .schedule+0xc0/0x894
> > [c00000008e1afe40] [c0000000000142d0] .cpu_idle+0x1f8/0x20c
> > [c00000008e1afed0] [c000000000600b08] .start_secondary+0x3bc/0x3fc
> > [c00000008e1aff90] [c000000000008264] .start_secondary_prolog+0x10/0x14
> > BUG: scheduling while atomic: swapper/0/0x00000002
> > no locks held by swapper/0.
> > Modules linked in:
> > Call Trace:
> > [c00000008e1afc20] [c000000000011990] .show_stack+0x70/0x184 (unreliable)
> > [c00000008e1afcd0] [c00000000005cb60] .__schedule_bug+0xac/0xd0
> > [c00000008e1afd70] [c0000000005f0c34] .schedule+0xc0/0x894
> > [c00000008e1afe40] [c0000000000142d0] .cpu_idle+0x1f8/0x20c
> > [c00000008e1afed0] [c000000000600b08] .start_secondary+0x3bc/0x3fc
> > [c00000008e1aff90] [c000000000008264] .start_secondary_prolog+0x10/0x14
> > BUG: scheduling while atomic: swapper/0/0x00000002
> > no locks held by swapper/0.
> > Modules linked in:
> > Call Trace:
> > [c00000008e1afc20] [c000000000011990] .show_stack+0x70/0x184 (unreliable)
> > [c00000008e1afcd0] [c00000000005cb60] .__schedule_bug+0xac/0xd0
> > [c00000008e1afd70] [c0000000005f0c34] .schedule+0xc0/0x894
> > [c00000008e1afe40] [c0000000000142d0] .cpu_idle+0x1f8/0x20c
> > [c00000008e1afed0] [c000000000600b08] .start_secondary+0x3bc/0x3fc
> > [c00000008e1aff90] [c000000000008264] .start_secondary_prolog+0x10/0x14
> > BUG: scheduling while atomic: swapper/0/0x00000002
> > no locks held by swapper/0.
> > Modules linked in:
> > Call Trace:
> > [c00000008e1afc20] [c000000000011990] .show_stack+0x70/0x184 (unreliable)
> > [c00000008e1afcd0] [c00000000005cb60] .__schedule_bug+0xac/0xd0
> > [c00000008e1afd70] [c0000000005f0c34] .schedule+0xc0/0x894
> > [c00000008e1afe40] [c0000000000142d0] .cpu_idle+0x1f8/0x20c
> > [c00000008e1afed0] [c000000000600b08] .start_secondary+0x3bc/0x3fc
> > [c00000008e1aff90] [c000000000008264] .start_secondary_prolog+0x10/0x14
> > audit: initializing netlink socket (disabled)
> > type=2000 audit(1276043741.388:1): initialized
> > BUG: scheduling while atomic: swapper/0/0x00000002
> > no locks held by swapper/0.
> > Modules linked in:
> > Call Trace:
> > [c00000008e1afc20] [c000000000011990] .show_stack+0x70/0x184 (unreliable)
> > [c00000008e1afcd0] [c00000000005cb60] .__schedule_bug+0xac/0xd0
> > [c00000008e1afd70] [c0000000005f0c34] .schedule+0xc0/0x894
> > [c00000008e1afe40] [c0000000000142d0] .cpu_idle+0x1f8/0x20c
> > [c00000008e1afed0] [c000000000600b08] .start_secondary+0x3bc/0x3fc
> > [c00000008e1aff90] [c000000000008264] .start_secondary_prolog+0x10/0x14
> > BUG: scheduling while atomic: swapper/0/0x00000002
> > no locks held by swapper/0.
> > Modules linked in:
> 
> 
