Return-Path: <laurent.pinchart@technotrade.biz>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 2597FDDDFE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 23:14:04 +1000 (EST)
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: MPC82xx ADS SCC ports initialisation
Date: Wed, 11 Jul 2007 15:13:59 +0200
References: <200707101619.52438.laurent.pinchart@technotrade.biz>
	<200707110911.19477.laurent.pinchart@technotrade.biz>
	<20070711143422.6b00620e@localhost.localdomain>
In-Reply-To: <20070711143422.6b00620e@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200707111514.00910.laurent.pinchart@technotrade.biz>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Vitaly,

On Wednesday 11 July 2007 12:34, Vitaly Bordug wrote:
> On Wed, 11 Jul 2007 09:11:18 +0200
>
> Laurent Pinchart wrote:
> > On Tuesday 10 July 2007 20:11, Scott Wood wrote:
> > > On Tue, Jul 10, 2007 at 04:19:51PM +0200, Laurent Pinchart wrote:
> > > > clrbits32(&immap->im_cpmux.cmx_scr, (0x00000007 << (4 -
> > > > data->clk_tx))); clrbits32(&immap->im_cpmux.cmx_scr, (0x00000038
> > > > << (4 - data->clk_rx))); setbits32(&immap->im_cpmux.cmx_scr,
> > > >           ((data->clk_tx - 1) << (4 - data->clk_tx)));
> > > > setbits32(&immap->im_cpmux.cmx_scr,
> > > >           ((data->clk_rx - 1) << (4 - data->clk_rx)));
> > > >
> > > > The shift right-hand operand doesn't seem to be correct. Could
> > > > anyone confirm this ?
> > >
> > > You are correct; it's broken.
> >
> > That code should be replaced with calls to cpm2_clk_setup
> > (arch/powerpc/sysdev/cpm2_common.c). cpm2_clk_setup currently
> > supports FCC clock setup only, but I've got a patch to add SCC clock
> > setup support. Should I send it ?
>
> If you have functional approach, please feel free to send it...

I haven't been able to test the patch, as I have no ADS hardware to test it 
on. My MPC82xx board is far from being ported to the powerpc architecture. 
I'll send the patch anyway. Could you evaluate it ?

> > > > If my assumption is right, could anyone tell me if the MPC82xx
> > > > processors are actually supported by the powerpc architecture, or
> > > > if the MPC82xx ADS code is just a non-functional work in progress.
>
> once my last changes were committed, 82xx was supported and worked fine.
> Pretty long time I had no access to the hardware, hence some minor things
> might require catch-up.

The above code might have been worked by sheer luck though.

> > > I have a bunch of 8xx/82xx changes pending; I hope to get them
> > > cleaned up before the merge window ends.
>
> Since I'm the only person covering 8xx/82xx for a while, I definitely want
> to look at those changes...
>
> > That would be nice. I'll wait for your changes to continue my ppc ->
> > powerpc port.
> >
> > > > I also noticed that U-Boot doesn't have flatten device tree
> > > > support for the MPC82xx family.
>
> At the moment, I have a patch to add such a thing, but no ability to
> validate it still works. If you guys will assist a little, I'll go ahead
> and submit it to the u-boot list.

I'm ready to help, but I'd like to port my board to the powerpc architecture 
first. FDT support in U-Boot is pretty useless with the ppc architecture.

> > > No, but cuImage for 82xx is on its way.
> >
> > Ok, nice to know. Adding FDT support to U-Boot for the MPC82xx family
> > will be on my todo-list once I get Linux working with cuImage.

Laurent Pinchart
