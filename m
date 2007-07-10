Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EE4F7DDEDC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 04:11:41 +1000 (EST)
Date: Tue, 10 Jul 2007 13:11:33 -0500
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurent.pinchart@technotrade.biz>
Subject: Re: MPC82xx ADS SCC ports initialisation
Message-ID: <20070710181133.GB14935@ld0162-tx32.am.freescale.net>
References: <200707101619.52438.laurent.pinchart@technotrade.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200707101619.52438.laurent.pinchart@technotrade.biz>
Cc: vbordug@ru.mvista.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Jul 10, 2007 at 04:19:51PM +0200, Laurent Pinchart wrote:
> clrbits32(&immap->im_cpmux.cmx_scr, (0x00000007 << (4 - data->clk_tx)));
> clrbits32(&immap->im_cpmux.cmx_scr, (0x00000038 << (4 - data->clk_rx)));
> setbits32(&immap->im_cpmux.cmx_scr, 
>           ((data->clk_tx - 1) << (4 - data->clk_tx)));
> setbits32(&immap->im_cpmux.cmx_scr,
>           ((data->clk_rx - 1) << (4 - data->clk_rx)));
> 
> The shift right-hand operand doesn't seem to be correct. Could anyone confirm 
> this ?

You are correct; it's broken.

> If my assumption is right, could anyone tell me if the MPC82xx 
> processors are actually supported by the powerpc architecture, or if the 
> MPC82xx ADS code is just a non-functional work in progress.

I have a bunch of 8xx/82xx changes pending; I hope to get them cleaned up
before the merge window ends.

> I also noticed that U-Boot doesn't have flatten device tree support for the 
> MPC82xx family.

No, but cuImage for 82xx is on its way.

-Scott
