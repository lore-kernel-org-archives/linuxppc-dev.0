Return-Path: <dgibson@ozlabs.org>
Date: Mon, 7 May 2007 14:02:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 5/6] Support for the Ebony 440GP reference board in
	arch/powerpc
Message-ID: <20070507040224.GD21287@localhost.localdomain>
References: <20070504055455.GA25922@localhost.localdomain>
	<20070504055733.8FB7EDDFFD@ozlabs.org>
	<20070504143645.GA10645@lixom.net>
	<20070507032206.GB21287@localhost.localdomain>
	<20070507034526.GA5352@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070507034526.GA5352@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 06, 2007 at 10:45:26PM -0500, Olof Johansson wrote:
> Hi,
> 
> On Mon, May 07, 2007 at 01:22:06PM +1000, David Gibson wrote:
> > On Fri, May 04, 2007 at 09:36:45AM -0500, Olof Johansson wrote:
> > > Hi,
> > > 
> > > Not much actual board support code in here, nice and clean. :-) Seems
> > > like most of this was boot wrapper enhancements.
> > 
> > Mostly, yes.  There will be more in-kernel support code coming
> > eventually, when we get PCI, the RTC and various other peripherals
> > going.
> 
> Makes sense.
> 
> > > > Index: working-2.6/arch/powerpc/kernel/head_44x.S
> > > > ===================================================================
> > > > --- working-2.6.orig/arch/powerpc/kernel/head_44x.S	2007-05-03 10:19:32.000000000 +1000
> > > > +++ working-2.6/arch/powerpc/kernel/head_44x.S	2007-05-04 13:46:51.000000000 +1000
> > > > @@ -709,16 +709,6 @@ _GLOBAL(giveup_fpu)
> > > >  	blr
> > > >  #endif
> > > >  
> > > > -/*
> > > > - * extern void abort(void)
> > > > - *
> > > > - * At present, this routine just applies a system reset.
> > > > - */
> > > > -_GLOBAL(abort)
> > > > -        mfspr   r13,SPRN_DBCR0
> > > > -        oris    r13,r13,DBCR0_RST_SYSTEM@h
> > > > -        mtspr   SPRN_DBCR0,r13
> > > > -
> > > 
> > > Looks like this rename is really separate from the platform support. Maybe
> > > post it as such in a patch before this one?
> > 
> > Hrm, I suppose I could.  Is it really worth it?
> 
> Personally I prefer to see new code separate from just
> renames/moves/cleanups, it makes the new code easier to spot during
> review. My first reaction when reading this patch was "why does he remove
> this?" since it wasn't added until X chunks later down in the file.

Oh, ok, I'll split it out again.

> > > > Index: working-2.6/arch/powerpc/platforms/Makefile
> > > > ===================================================================
> > > > --- working-2.6.orig/arch/powerpc/platforms/Makefile	2007-02-14 10:58:22.000000000 +1100
> > > > +++ working-2.6/arch/powerpc/platforms/Makefile	2007-05-04 13:46:51.000000000 +1000
> > > > @@ -6,7 +6,8 @@ obj-$(CONFIG_PPC_PMAC)		+= powermac/
> > > >  endif
> > > >  endif
> > > >  obj-$(CONFIG_PPC_CHRP)		+= chrp/
> > > > -obj-$(CONFIG_4xx)		+= 4xx/
> > > > +#obj-$(CONFIG_4xx)		+= 4xx/
> > > 
> > > Hmm?
> > 
> > Contrary to the comment in arch/powerpc/platforms/4xx/Makefile, an
> > empty Makefile does *not* compile correctly within Kbuild.  It's
> > commented out so we build again, obviously it will need to go back in
> > once there's any code that actually works in
> > arch/powerpc/platforms/4xx.
> 
> I'm not sure I follow you here. This patch also adds the makefile, and
> it's not empty (if you-ve got CONFIG_4xx enabled, it will build at least
> one file in there)?

Not quite.  The patch adds the platforms/44x/Makefile, it comments out
4xx so that the (empty) platforms/4xx/Makefile is not invoked.
Possibly we should rename 44x to ibm_booke everywhere to avoid this
kind of confusion.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
