Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E59F7DDEB7
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 00:10:17 +1000 (EST)
Date: Wed, 29 Aug 2007 09:02:39 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/3] Add early debug console for CPM serial ports.
Message-ID: <20070829140239.GC30184@ld0162-tx32.am.freescale.net>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201621.GC24210@ld0162-tx32.am.freescale.net>
	<20070829054540.GD3206@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070829054540.GD3206@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 29, 2007 at 03:45:40PM +1000, David Gibson wrote:
> > diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> > index 22acece..d471154 100644
> > --- a/arch/powerpc/Kconfig.debug
> > +++ b/arch/powerpc/Kconfig.debug
> > @@ -211,6 +211,15 @@ config PPC_EARLY_DEBUG_44x
> >  	  Select this to enable early debugging for IBM 44x chips via the
> >  	  inbuilt serial port.
> >  
> > +config PPC_EARLY_DEBUG_CPM
> > +	bool "Early serial debugging for Freescale CPM-based serial ports"
> > +	depends on SERIAL_CPM
> > +	select PIN_TLB if PPC_8xx
> 
> I see this Kconfig line, but I don't see any code below that would set
> up a suitable TLB on 8xx for the CPM...?

There's existing code that pins the IMMR when that option is enabled.
It's a bit broken, but there's a patch in the 8xx series that fixes it.

> >  # Temporary hack until we have migrated to asm-powerpc
> >  ifeq ($(ARCH),powerpc)
> > +obj-$(CONFIG_CPM1)$(CONFIG_CPM2) += cpm_common.o
> 
> Uh.. I don't think this will work properly.  If CONFIG_CPM1 and
> CONFIG_CPM2 are both enabled, it will set obj-yy rather than obj-y.

The assumption was that CPM1 and CPM2 are never going to both be enabled,
as CPM1 only exists on hardware with a unique MMU.

I could add an obj-y += $(obj-yy) if you like, though.

> Since this is all udbg related, it could go (within an ifdef) into
> udbg.c rather than creating a new file for it.

Well, I was hoping that more consolidation between cpm1 and cpm2 (and
qe/cpm3, for that matter) would happen in the future, and this would be a
place to put it.

> Urg... this is ugly, because it looks like it can be muti-platform,
> but actually isn't.  I think a better approach is to set the magic
> address as a Kconfig variable, as we do on 44x.  This approach can
> also be useful for hacking up early debug for new chips during the
> process of creating platform code for them.

OK.

-Scott
