Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A9ADDDDDF3
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jul 2007 18:21:22 +1000 (EST)
Date: Sat, 28 Jul 2007 03:35:30 -0500
From: Olof Johansson <olof@lixom.net>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [patch 07/35] pasemi_mac: stop using the pci config space
	accessors for register read/writes
Message-ID: <20070728083530.GA4580@lixom.net>
References: <20070705170233.258351000@lixom.net>
	<20070705170235.314700000@lixom.net>
	<46A91130.8000907@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46A91130.8000907@semihalf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Thu, Jul 26, 2007 at 11:25:04PM +0200, Marian Balakowicz wrote:
> 
> Olof,
> 
> Olof Johansson wrote:
> > Move away from using the pci config access functions for simple register
> > access.  Our device has all of the registers in the config space (hey,
> > from the hardware point of view it looks reasonable :-), so we need to
> > somehow get to it. Newer firmwares have it in the device tree such that
> > we can just get it and ioremap it there (in case it ever moves in future
> > products). For now, provide a hardcoded fallback for older firmwares.
> 
> I have recently tried to apply a group of your MAC patches that
> includes the one from this email. Strangely, I got a pretty random
> kernel panics (or kernel freezes) when this patch is included. Panics
> happen in a random, places and have random causes. What I observed is
> that replacing newly introduced mac->iob_regs with the corresponding
> offset from (already ioremapped) hose->cfg_data removed the problem. So,
> it seems that dereferencing pointers based on a second ioremap on a
> subset of 0xe000_0000 addresses is problematic.

The problem is that the IOB register range is 8K, not 4K. I have since
fixed that bug but I didn't repost the patch series. It does cause weird
and strange errors to happen since register writes into the second 4K
would really go to another mapping somewhere else.

So, the quick fix is to always map 0x2000 in map_one_reg, the slightly better
one is to check the PCI dev and only map 2K for the IOB.

> Here are the questions that come to my mind:
> 
> - I am testing on a A2 hw, what what your testing setup, anything
> newer than this (something closer B0 maybe), did you have a chance to
> try that on a A2 board?

I'm doing all of my work on A2 hardware at the moment.

> - Is there any particular patch or set of patches/updates that this
> patch may depend on?

There's a fix, but with the description above you should be able to handle it on your
own as well. I'm currently travelling on vacation, but I'll try to post something within
a few days.

> Switching from pci accessors to direct in_* out_* calls drops the
> guard pci spinlock. Initially, I thought that this may be the reason,
> but it's not, adding the spinlock is not solving the problem. But anyway,
> shouldn't we be using it to coordinate access?

The very point of this patch is to avoid doing the spinlock. There's no need
for one in this case, it's pure overhead.


-Olof
