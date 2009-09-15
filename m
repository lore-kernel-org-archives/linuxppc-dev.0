Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 49758B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 05:32:12 +1000 (EST)
Date: Tue, 15 Sep 2009 15:32:05 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: RFC: delete UART current-speed from 4xx DTS?
Message-ID: <20090915193205.GA8115@windriver.com>
References: <20090915143135.GA7015@windriver.com>
	<20090915153220.GG12372@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090915153220.GG12372@zod.rchland.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Re: RFC: delete UART current-speed from 4xx DTS?] On 15/09/2009 (Tue 11:32) Josh Boyer wrote:

> On Tue, Sep 15, 2009 at 10:31:36AM -0400, Paul Gortmaker wrote:
> >One of the guys here was getting a messed up console on a bamboo board

I meant to say Yosemite board (and hence u-boot), sorry for that.  It
gives garbage up until the udbg -> ttyS0 handover, at which point the
console=ttyS0,115200 fixes things.

> >(on linux boot), which he traced to the fact that the default dts has a
> >9600 baudrate coded into it (board was running 115k2, not 9600).  Either
> >deleting the line, or replacing the 9600 with zero fixed the problem.
> 
> Once booted, was there a valid current-speed property in /proc/device-tree
> for the serial node?  I'm curious if U-Boot created it, or if the kernel
> just used whatever baud was present already.

Had to go back to get this info; it turns out there is a valid prop in
all the serial nodes (2.6.31-rc7), and hexdumping it gives 0x2580 (9600).

> 
> When I did the bamboo port a while ago, I recall having issues with either
> a missing clock-frequency or current-speed (or both perhaps) and the bootloader
> on the board was the original PIBS.  It might have been an issue with PIBS
> but I'm guessing the rest of the 4xx boards copied from either Ebony or
> Bamboo in their ports and hence contain that property.

Right - so there could still perhaps be the same issue with PIBS/bamboo
present that you saw earlier (given my inability to keep board names
straight)

> 
> >Looking at the Fsl boards, it seems that 99% of them don't list any
> >current-speed at all.  I'm willing to whip up a patch to delete them
> 
> I think 99% of them use U-Boot, which should fix things up either way.

This is the interesting part -- being a yosemite (u-boot), I would have
thought so as well.  I've not looked at the u-boot code, but it may only
add a current-speed if there isn't one yet.  At least that is what the
behaviour tends to indicate.  Board is running u-boot 1.3.3 so what we
are seeing here may not reflect what current u-boot code is doing
anyway...

> 
> >from the various boards, but I thought I'd check 1st to see if there was
> >some other reasoning/input.  I suppose one could argue that u-boot
> >should be replacing the 9600 with 115k2 on the fly, but if the explicit
> >specification isn't helping anyone, then it probably just makes sense to
> >delete them anyway, I figured.
> 
> Yeah, that's probably valid.  I'd be happy to test on the set of boards I
> have.
> 
> >Here is the subset of boards I was considering deleting the lines from:
> >
> >   bamboo.dts ebony.dts hcu4.dts holly.dts katmai.dts sam440ep.dts
> >   sequoia.dts taishan.dts walnut.dts yosemite.dts
> 
> I can test bamboo with PIBS, ebony, holly (which isn't 4xx even though it's
> a tree name) with PIBS, sequoia, taishan, yosemite, and walnut.  Perhaps a few
> of the 405 boards I have as well.
> 
> It's easy enough for me to whip up a patch, and since I'll be testing either
> way I'd be happy to do that if you'd like.

Sure -- the testing effort will be greater than the time to make the
patch, so you doing coverage on all those would be great.  I think I've
probably only got easy immediate access to a PIBS/bamboo at the moment.
We already know the yosemite is OK with the change, so that is one less
to test.

Thanks,
Paul.

> 
> josh
