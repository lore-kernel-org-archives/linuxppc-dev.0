Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2BDABDDEE8
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 00:19:17 +1000 (EST)
Date: Tue, 11 Sep 2007 09:19:07 -0500
From: Scott Wood <scottwood@freescale.com>
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
Subject: Re: [PATCH 1/5] Add Freescale DMA and DMA channel to
	Documentation/powerpc/booting-without-of.txt file.
Message-ID: <20070911141907.GF1932@ld0162-tx32.am.freescale.net>
References: <11891624353752-git-send-email-wei.zhang@freescale.com>
	<1189162437484-git-send-email-wei.zhang@freescale.com>
	<3b29878a7d3d1b14f84b5d3b182cdb98@kernel.crashing.org>
	<20070910032529.GA27828@localhost.localdomain>
	<46B96294322F7D458F9648B60E15112C85D61B@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46B96294322F7D458F9648B60E15112C85D61B@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 11, 2007 at 06:01:39PM +0800, Zhang Wei-r63237 wrote:
> 
>  
> > 
> > On Fri, Sep 07, 2007 at 04:43:35PM +0200, Segher Boessenkool wrote:
> > > > +   l) Freescale DMA
> > > 
> > > > +    - compatible : Should be "fsl,dma".
> > > 
> > > Please choose some more specific name.  "fsl,mpc8540-dma" would
> > > be a reasonable choice perhaps.
> > 
> > More precisely, the compatible property should always have an specific
> > entry based on the exact chip the DMA engine resides in, as well as a
> > more general entry for any fsl dma engine of this type.
> > 
> There is only difference in DMA channel and not in DMA node now. Does it
> need add the precise compatible property name?

Yes.  First of all, there most likely is a difference -- the endianness
of the shared status summary register.  Secondly, the device tree should
not make assumptions as far as whether the user is going to bind to
individual channels or the whole controller.

-Scott
