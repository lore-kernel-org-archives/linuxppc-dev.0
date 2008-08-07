Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CAED6DDEE7
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 19:16:56 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m779GnbC005918
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Aug 2008 02:16:49 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m779GklZ001324
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Aug 2008 04:16:47 -0500 (CDT)
Subject: Re: [PATCH 5/6] powerpc: add USB peripheral support to MPC836xMDS
From: Li Yang <leoli@freescale.com>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080806120747.GA7717@polina.dev.rtsoft.ru>
References: <1218006285-27138-1-git-send-email-leoli@freescale.com>
	<1218006285-27138-2-git-send-email-leoli@freescale.com>
	<1218006285-27138-3-git-send-email-leoli@freescale.com>
	<1218006285-27138-4-git-send-email-leoli@freescale.com>
	<1218006285-27138-5-git-send-email-leoli@freescale.com>
	<20080806120747.GA7717@polina.dev.rtsoft.ru>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 17:31:44 +0800
Message-Id: <1218101504.29628.32.camel@Gundam>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: leoli@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Anton,

On Wed, 2008-08-06 at 16:07 +0400, Anton Vorontsov wrote:
> Hello Li,
> 
> On Wed, Aug 06, 2008 at 03:04:44PM +0800, Li Yang wrote:
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> >  arch/powerpc/boot/dts/mpc836x_mds.dts     |   15 ++++++-
> >  arch/powerpc/platforms/83xx/mpc836x_mds.c |   19 ++++++++-
> >  arch/powerpc/platforms/83xx/mpc83xx.h     |    1 +
> >  arch/powerpc/platforms/83xx/usb.c         |   67 +++++++++++++++++++++++++++++
> >  4 files changed, 100 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
> > index a3b76a7..596377b 100644
> > --- a/arch/powerpc/boot/dts/mpc836x_mds.dts
> > +++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
> > @@ -235,6 +235,17 @@
> >  					0  2  1  0  1  0>; /* MDC */
> >  			};
> >  
> > +			pio_usb: usb_pin@01 {
> > +				pio-map = <
> > +			/* port  pin  dir  open_drain  assignment  has_irq */
> > +					1  2  1  0  3  0        /* USBOE  */
> > +					1  3  1  0  3  0        /* USBTP  */
> > +					1  8  1  0  1  0        /* USBTN  */
> > +					1 10  2  0  3  0        /* USBRXD */
> > +					1  9  2  1  3  0        /* USBRP  */
> > +					1 11  2  1  3  0>;      /* USBRN  */
> > +			};
> > +
> >  		};
> >  	};
> >  
> > @@ -280,11 +291,13 @@
> >  		};
> >  
> >  		usb@6c0 {
> > -			compatible = "qe_udc";
> > +			compatible = "fsl,qe_udc";
> 
> You might want to reuse existing bindings as described in
> Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/usb.txt.

Ok.  I didn't notice your addition to the binding.  I will try to update
it for device mode.

> 
> >  			reg = <0x6c0 0x40 0x8b00 0x100>;
> >  			interrupts = <11>;
> >  			interrupt-parent = <&qeic>;
> >  			mode = "slave";
> 
> I'd suggest to rename this to "peripheral" as we use for fsl dual-role
> usb controller.

As there will be two drivers chosen by compatible, I'm now inclined to
put this information in compatible.

> 
> > +			usb-clock = <21>;
> > +			pio-handle = <&pio_usb>;
> 
> Can we not introduce new pio maps? The pio setup should be done
> by the firmware, or at least fixed up via the board file, as in
> arch/powerpc/platforms/83xx/mpc832x_rdb.c.

Actually I am more apt to leaving full hardware access to kernel than
firmware, especially for devices that are not used in firmware.  The
reason why I made the pin-configuration flexible is that for development
boards the role of pins are often changeable.

> 
> [...]
> > +#ifdef CONFIG_QUICC_ENGINE
> > +/* QE USB_CLOCK configure functions */
> > +int qe_usb_clock_set(struct device_node *np)
> 
> We already have this function, in arch/powerpc/sysdev/qe_lib/usb.c

I just saw this.  Will try to reuse it.

> 
> It does not parse any of properties though, driver should do this.
> 
> > +{
> > +	u32 tmpreg = 0;
> > +	struct qe_mux *qemux = NULL;
> > +	const int *clock;
> > +
> > +	qemux = &qe_immr->qmx;
> > +
> > +	clock = of_get_property(np, "usb-clock", NULL);
> > +	if (!clock)
> > +		return -EINVAL;
> > +
> > +	/* CLK21 -> USBCLK on MPC8360-PB*/
> > +	tmpreg = in_be32(&qemux->cmxgcr) & ~QE_CMXGCR_USBCS;
> > +	switch (*clock) {
> > +	case 21:
> > +		tmpreg |= 0x8;
> > +		out_be32(&qemux->cmxgcr, tmpreg);
> > +		par_io_config_pin(2, 20, 2, 0, 1, 0);  /* PC20 for CLK21 */
> 
> No, pio config is very board-specific. This should be done by the
> firmware (ideally) or by the board file.

Pio config is board and board configuration specific.  It's better to
make it configurable by device tree.

- Leo
