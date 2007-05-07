Return-Path: <mgreer@mvista.com>
Date: Mon, 7 May 2007 11:15:56 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/13] powerpc: Add bootwrapper support for Marvell/mv64x60
	hostbridge
Message-ID: <20070507181556.GB30132@mag.az.mvista.com>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070425235619.GE4046@mag.az.mvista.com>
	<17969.37331.228482.225919@cargo.ozlabs.ibm.com>
	<20070427220245.GC14490@mag.az.mvista.com>
	<17977.29234.367271.820951@cargo.ozlabs.ibm.com>
	<20070503184402.GA5600@mag.az.mvista.com>
	<17981.4843.4838.926329@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17981.4843.4838.926329@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 06, 2007 at 09:27:39AM +1000, Paul Mackerras wrote:
> Mark A. Greer writes:
> 
> > Actually, none of the config code should be needed by the bootwrapper
> > itself because the bootwrapper mpsc and i2c drivers use PIO (so accessing
> > memory isn't an issue).  The "get info" type routines are still needed.
> 
> Talking of i2c, why does the bootwrapper need an i2c driver at all?

The prpmc2800 needs it to get at some VPD that store in an i2c eeprom.
The VPD provide that type of board, amount of memory, etc. so the DT can
be updated.

> You don't tell me in the patch description for your patch 5/13...

Yes, I haven't provided much for descriptions :)
 
> > Its pretty much 1:1.  Whatever is in the bootwrapper (including
> > #define's) isn't needed in the kernel.
> 
> OK, good.
> 
> > I expect that the setup will be done the same for all of the boards
> > that need it.  Not all of the boards will need it, though.  It depends
> > on their firmware.  The config code is filling the gap between what the
> > firmware should have done and what the kernel drivers require (i.e.,
> > allowing the ctlrs to access system memory and pci mem/io space).
> 
> Is it possible that different kernels will want things set up
> differently?  Or is there really only one sensible setup?

Most of the boot/mv64x60 config code is "configurable" in that the
important info is passed in from platform-specific code so each platform
can configure the windows how it wants.

However, mv64x60_config_ctlr_windows() does assume that the cpu->mem
windows are set correctly and uses that info to configure the
enet/mpsc/idma->mem windows.  I can't think of any scenario where someone
would want to do it differently but if/when there is one, we can make
the necessary changes then.

There is another assumption where only one window each is used to configure
the cpu->pci mem, cpu->pci i/o, pci mem->system mem windows.  One window
can cover the entire address space, so I don't see why that would ever
ben an issue.

> > Paul, I'm a little perplexed by you wanting this code pushed back into
> > the kernel.  A while back there was a definite desire to push stuff like
> > this out of the kernel (mainly by Ben).  I tend to agree with Ben on
> > this.  Either way, it would good to have everyone pushing in the same
> > direction. :)
> 
> One of these days you guys will write me nice informative patch
> descriptions that explain the rationale and design decisions behind
> the changes you're proposing, without me nagging. :) I'm not so much
> pushing back as trying to get you to tell me why the code is here and
> not somewhere else, and what the obvious alternatives might be and why
> we aren't doing them.  Or better still, put that information into a
> new set of patch descriptions for me...
> 
> BTW, the descriptions on your string of 13 were completely empty for
> many of them, and for the remainder they just said what had been
> changed.  Please be more informative.  Yes, it does require thinking
> about things from the point of view of someone who doesn't have all
> the context in their head, as you do, which can take a bit of mental
> effort.  But in 2 or 3 years time it might be you that doesn't have
> the context in mind any more and will really appreciate a more verbose
> description. :)

Okay, point well taken.  The subject said enough for me but I wasn't
thinking of others or 2-3 years down the road.  I'll add some
descriptions and resubmit.  Sorry for the frustration.

Mark
