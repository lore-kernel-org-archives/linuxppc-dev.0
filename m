Return-Path: <laurent.pinchart@technotrade.biz>
Received: from mailrelay006.isp.belgacom.be (mailrelay006.isp.belgacom.be
	[195.238.6.172]) by ozlabs.org (Postfix) with ESMTP id 4B490DDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 17:11:24 +1000 (EST)
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: MPC82xx ADS SCC ports initialisation
Date: Wed, 11 Jul 2007 09:11:18 +0200
References: <200707101619.52438.laurent.pinchart@technotrade.biz>
	<20070710181133.GB14935@ld0162-tx32.am.freescale.net>
In-Reply-To: <20070710181133.GB14935@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707110911.19477.laurent.pinchart@technotrade.biz>
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

On Tuesday 10 July 2007 20:11, Scott Wood wrote:
> On Tue, Jul 10, 2007 at 04:19:51PM +0200, Laurent Pinchart wrote:
> > clrbits32(&immap->im_cpmux.cmx_scr, (0x00000007 << (4 - data->clk_tx)));
> > clrbits32(&immap->im_cpmux.cmx_scr, (0x00000038 << (4 - data->clk_rx)));
> > setbits32(&immap->im_cpmux.cmx_scr,
> >           ((data->clk_tx - 1) << (4 - data->clk_tx)));
> > setbits32(&immap->im_cpmux.cmx_scr,
> >           ((data->clk_rx - 1) << (4 - data->clk_rx)));
> >
> > The shift right-hand operand doesn't seem to be correct. Could anyone
> > confirm this ?
>
> You are correct; it's broken.

That code should be replaced with calls to cpm2_clk_setup 
(arch/powerpc/sysdev/cpm2_common.c). cpm2_clk_setup currently supports FCC 
clock setup only, but I've got a patch to add SCC clock setup support. Should 
I send it ?

> > If my assumption is right, could anyone tell me if the MPC82xx
> > processors are actually supported by the powerpc architecture, or if the
> > MPC82xx ADS code is just a non-functional work in progress.
>
> I have a bunch of 8xx/82xx changes pending; I hope to get them cleaned up
> before the merge window ends.

That would be nice. I'll wait for your changes to continue my ppc -> powerpc 
port.

> > I also noticed that U-Boot doesn't have flatten device tree support for
> > the MPC82xx family.
>
> No, but cuImage for 82xx is on its way.

Ok, nice to know. Adding FDT support to U-Boot for the MPC82xx family will be 
on my todo-list once I get Linux working with cuImage.

Laurent Pinchart
