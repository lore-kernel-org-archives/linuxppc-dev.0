Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4E931DDDF2
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 05:58:46 +1000 (EST)
Date: Wed, 29 Aug 2007 14:58:37 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/3] Add early debug console for CPM serial ports.
Message-ID: <20070829195837.GA6818@ld0162-tx32.am.freescale.net>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201621.GC24210@ld0162-tx32.am.freescale.net>
	<20070829054540.GD3206@localhost.localdomain>
	<20070829140239.GC30184@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070829140239.GC30184@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 29, 2007 at 09:02:39AM -0500, Scott Wood wrote:
> > >  # Temporary hack until we have migrated to asm-powerpc
> > >  ifeq ($(ARCH),powerpc)
> > > +obj-$(CONFIG_CPM1)$(CONFIG_CPM2) += cpm_common.o
> > 
> > Uh.. I don't think this will work properly.  If CONFIG_CPM1 and
> > CONFIG_CPM2 are both enabled, it will set obj-yy rather than obj-y.
> 
> The assumption was that CPM1 and CPM2 are never going to both be enabled,
> as CPM1 only exists on hardware with a unique MMU.
> 
> I could add an obj-y += $(obj-yy) if you like, though.

On second thought, I'll just add a CONFIG_CPM that CPM1 and CPM2 select;
that'll make things easier for further consolidation.

-Scott
