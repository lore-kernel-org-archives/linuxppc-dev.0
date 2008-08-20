Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6C01ADDF92
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 03:08:08 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7KH83m3011847
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 13:08:03 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7KH83Y4230048
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 13:08:03 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7KH82b4030025
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 13:08:03 -0400
Date: Wed, 20 Aug 2008 13:08:02 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 0/9] Rework PowerPC 44x board support
Message-ID: <20080820130802.59a16b06@zod.rchland.ibm.com>
In-Reply-To: <48AC4B86.8010902@ru.mvista.com>
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
	<48AC4B86.8010902@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 20 Aug 2008 20:51:18 +0400
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> Josh Boyer wrote:
> > The following patch series reworks the board support code for PowerPC 44x
> > platforms.  It eliminates a number of redundant <board>.c files and add a
> > ppc44x_simple.c file that has an explicit list of boards that are supported
> > by it.  This is the same mechanism that Grant Likely has used for MPC 5200
> > boards.
> > 
> > It also adds some more explicit support for Glacier and Yosemite boards, as
> > those boards were using a board level compatible property in their DTS files
> > that was a bit confusing.
> > 
> > Review would be appreciated.  Tested on Sequoia, and I plan on testing on as
> > many boards as I can before committing to my tree.
> > 
> > josh
> 
> Sorry if I miss anything, but
> what happens if I build an uImage just for Rainier (not enabling other 
> platforms in the kernel config) and then start it on Canyonlands for 
> example?

Why would you do that?  If you want that, use ppc44x_defconfig as it
has all the boards enabled.  Also, if you're talking about the default
make targets in the kernel, that would build a cuImage for Rainier, and
I'd expect that to blow up spectacularly on a Canoynlands because the
device tree would be in no way correct.

> They both use PowerPC_44x_simple stuff and looks like now we claim that 
> all these "simple" boards are compatible. So, board check always passes, 

No, we don't claim they are compatible at all.  We simply claim that
they can all be supported by the ppc44x_simple.c platform file.  The
compatible stuff is done through the device tree, and if you look at
the patch series you'll see that I actually removed all the cross-board
compatible statements from the boards that had more than one in the DTS
file.

> although Canyonlands support is actually disabled (CONFIG_460EX = n; 
> CONFIG_PPC4xx_PCI_EXPRESS = n). It's not critical, but I just thought we 
> might also remove the platform-specific options from 
> arch/powerpc/platforms/44x/Kconfig for these boards at all. Just enable 

I left them in there on purpose.  People want to be able to say "I have
a Rainier board.  I only want a kernel for that."  They're also used
for the wrapper stuff to build the right images.

> all board-specific stuff under "config PPC44x_SIMPLE".
> Otherwise we probably should have a configurable char *board[] array.

We could do that if it's _really_ necessary, but I'm not sure it is.

josh
