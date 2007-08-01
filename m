Return-Path: <dgibson@ozlabs.org>
Date: Wed, 1 Aug 2007 12:12:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 4/6] PowerPC 440EPx: Sequoia bootwrapper
Message-ID: <20070801021249.GD31391@localhost.localdomain>
References: <20070730151445.GA5075@ru.mvista.com>
	<200707310754.56665.sr@denx.de> <46AF1ADA.10404@ru.mvista.com>
	<200707311342.46555.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200707311342.46555.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 31, 2007 at 01:42:46PM +0200, Stefan Roese wrote:
> On Tuesday 31 July 2007, Valentine Barshak wrote:
> > > Is treeboot-* really needed on Sequoia? From my understanding this is
> > > only needed for platforms using OpenBIOS as bootloader.
> >
> > Right, it's not used for u-boot. I've included it just in case.
> 
> I think we should drop it, when it's not used at all.
> 
> You didn't comment on my review down below in the code. Perhaps you didn't see 
> it. Here again the original review with 2 small comments.
> 
> Thanks for the good work.
> 
> > +++ linux/arch/powerpc/boot/sequoia.c 2007-07-27
> 20:59:09.000000000 +0400
[snip]
> > +static void ibm440epx_fixup_memsize(void)
> > +{
> > +     unsigned long val, max_cs, max_col, max_row;
> > +     unsigned long cs, col, row, bank, dpath;
> > +     unsigned long memsize;
> > +
> > +     mtdcr(DCRN_SDRAM0_CFGADDR, 2);
> > +     val = mfdcr(DCRN_SDRAM0_CFGDATA);
> 
> Again, mfsdram() functions would be handy here.

I concur, also add a #define for the value written to CFGADDR.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
