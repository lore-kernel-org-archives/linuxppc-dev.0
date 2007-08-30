Return-Path: <dgibson@ozlabs.org>
Date: Thu, 30 Aug 2007 10:57:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] Add early debug console for CPM serial ports.
Message-ID: <20070830005741.GC22844@localhost.localdomain>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201621.GC24210@ld0162-tx32.am.freescale.net>
	<20070829054540.GD3206@localhost.localdomain>
	<20070829140239.GC30184@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070829140239.GC30184@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 29, 2007 at 09:02:39AM -0500, Scott Wood wrote:
> On Wed, Aug 29, 2007 at 03:45:40PM +1000, David Gibson wrote:
> > > diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> > > index 22acece..d471154 100644
> > > --- a/arch/powerpc/Kconfig.debug
> > > +++ b/arch/powerpc/Kconfig.debug
> > > @@ -211,6 +211,15 @@ config PPC_EARLY_DEBUG_44x
> > >  	  Select this to enable early debugging for IBM 44x chips via the
> > >  	  inbuilt serial port.
> > >  
> > > +config PPC_EARLY_DEBUG_CPM
> > > +	bool "Early serial debugging for Freescale CPM-based serial ports"
> > > +	depends on SERIAL_CPM
> > > +	select PIN_TLB if PPC_8xx
> > 
> > I see this Kconfig line, but I don't see any code below that would set
> > up a suitable TLB on 8xx for the CPM...?
> 
> There's existing code that pins the IMMR when that option is enabled.
> It's a bit broken, but there's a patch in the 8xx series that fixes it.
> 
> > >  # Temporary hack until we have migrated to asm-powerpc
> > >  ifeq ($(ARCH),powerpc)
> > > +obj-$(CONFIG_CPM1)$(CONFIG_CPM2) += cpm_common.o
> > 
> > Uh.. I don't think this will work properly.  If CONFIG_CPM1 and
> > CONFIG_CPM2 are both enabled, it will set obj-yy rather than obj-y.
> 
> The assumption was that CPM1 and CPM2 are never going to both be enabled,
> as CPM1 only exists on hardware with a unique MMU.

Hrm.  I guess it's ok in that case, although it's a non-obvious
constraint.

> I could add an obj-y += $(obj-yy) if you like, though.

Ouch, no, that would be even uglier.

> > Since this is all udbg related, it could go (within an ifdef) into
> > udbg.c rather than creating a new file for it.
> 
> Well, I was hoping that more consolidation between cpm1 and cpm2 (and
> qe/cpm3, for that matter) would happen in the future, and this would be a
> place to put it.
> 
> > Urg... this is ugly, because it looks like it can be muti-platform,
> > but actually isn't.  I think a better approach is to set the magic
> > address as a Kconfig variable, as we do on 44x.  This approach can
> > also be useful for hacking up early debug for new chips during the
> > process of creating platform code for them.
> 
> OK.
> 
> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
