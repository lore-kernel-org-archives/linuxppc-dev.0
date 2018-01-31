Return-Path: <paubert@iram.es>
Received: from cica-lavadora-l1mail1v.puc.rediris.es
 (ci-l1mail1v-out04a.puc.rediris.es [IPv6:2001:720:418:ca02::14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zWfV23mR6zDr0j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jan 2018 21:23:36 +1100 (AEDT)
Date: Wed, 31 Jan 2018 11:22:39 +0100
From: Gabriel Paubert <paubert@iram.es>
To: James Hogan <james.hogan@mips.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: Wifi (B43) broken on G4 PowerBooks with kernel v4.15
Message-ID: <20180131102239.ifzorzhepepgs67k@lt-gp.iram.es>
References: <20180131093730.ikmoawgh3mh2pxoy@lt-gp.iram.es>
 <20180131100345.GD21356@jhogan-linux.mipstec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180131100345.GD21356@jhogan-linux.mipstec.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 31, 2018 at 10:03:46AM +0000, James Hogan wrote:
> On Wed, Jan 31, 2018 at 10:37:30AM +0100, Gabriel Paubert wrote:
> > 	Hi,
> > 
> > yesterday I recompiled the kernel on my late 2005 G4 PowerBook, and the
> > Wifi stopped working. After comparing the configuration is turns out
> > that a change to a Kconfig condition disabled SSB support which is
> > necessary for these chips.
> > 
> > The graph of configuration options is quite messy, and I'm not sure that
> > I fully understand it.
> > 
> > Nevertheless the following patch fixes the regression, but there might
> > be a better way to solve the problem.
> > 
> > If you pick up this trivial patch as is, you may add:
> > 
> > Signed-off-by: Gabriel Paubert <paubert@iram.es>
> > 
> > diff --git a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
> > index 71c7376..d189db6 100644
> > --- a/drivers/ssb/Kconfig
> > +++ b/drivers/ssb/Kconfig
> > @@ -32,7 +32,7 @@ config SSB_BLOCKIO
> >  
> >  config SSB_PCIHOST_POSSIBLE
> >  	bool
> > -	depends on SSB && (PCI = y || PCI = SSB) && PCI_DRIVERS_LEGACY
> > +	depends on SSB && (PCI = y || PCI = SSB) && (PCI_DRIVERS_LEGACY || B43_SSB)
> >  	default y
> >  
> >  config SSB_PCIHOST
> > 
> 
> Yes, really sorry about that. There is a patch here:
> https://patchwork.kernel.org/patch/10185397/

Ok, thanks, it's even better than my patch. I was not aware of that
patch: AFAIK it was not posted to one of the mailing I track, and it had
not percolated to Linus'tree which I pulled just before posting.

Sorry for the noise.

	Cheers,
	Gabriel
