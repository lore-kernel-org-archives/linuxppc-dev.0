Return-Path: <mgreer@mvista.com>
Date: Thu, 3 May 2007 11:44:02 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/13] powerpc: Add bootwrapper support for Marvell/mv64x60
	hostbridge
Message-ID: <20070503184402.GA5600@mag.az.mvista.com>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070425235619.GE4046@mag.az.mvista.com>
	<17969.37331.228482.225919@cargo.ozlabs.ibm.com>
	<20070427220245.GC14490@mag.az.mvista.com>
	<17977.29234.367271.820951@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17977.29234.367271.820951@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 03, 2007 at 03:25:06PM +1000, Paul Mackerras wrote:
> Mark A. Greer writes:
> 
> > Well, the firmware just doesn't do all the init that's required.  And,
> > some of the init that it does do is wrong.  For example, the window for
> > the MPSC (serial ctlr) to access main memory isn't set up so the kernel
> > mpsc driver can't dma.  There are several other examles.
> > 
> > All of this init should be in the firmware but its Motorola/ECC's
> > firmware and I/we have no control over it.  Given that, I/we have to do
> > the init somewhere.  Either in the kernel or the bootwrapper.
> > I vote for the bootwrapper but then your vote is the only one that actually
> > counts.  :)
> 
> How much of the setup is actually necessary for the bootwrapper to
> run, and how much could be deferred to setup_arch() time in the
> kernel?

Actually, none of the config code should be needed by the bootwrapper
itself because the bootwrapper mpsc and i2c drivers use PIO (so accessing
memory isn't an issue).  The "get info" type routines are still needed.

> If nothing else, doing it in the kernel means that the code
> and data for it exist in compressed form in the zImage rather than
> uncompressed form. :)

mv64x60.o is 4804 bytes, .text is 2188 bytes, .data 64 bytes, .bss 0
bytes.  So we're probably only saving ~1-2KB by compressing.

> Also, how many lines of code (including definitions) would we avoid
> having in the kernel by having this stuff in the bootwrapper?

Its pretty much 1:1.  Whatever is in the bootwrapper (including
#define's) isn't needed in the kernel.

> Another question - is this setup something that will need to be done
> differently for different boards using the mv64x60, or is the same
> setup needed for all applications of the mv64x60?

I expect that the setup will be done the same for all of the boards
that need it.  Not all of the boards will need it, though.  It depends
on their firmware.  The config code is filling the gap between what the
firmware should have done and what the kernel drivers require (i.e.,
allowing the ctlrs to access system memory and pci mem/io space).

Paul, I'm a little perplexed by you wanting this code pushed back into
the kernel.  A while back there was a definite desire to push stuff like
this out of the kernel (mainly by Ben).  I tend to agree with Ben on
this.  Either way, it would good to have everyone pushing in the same
direction. :)

Mark
