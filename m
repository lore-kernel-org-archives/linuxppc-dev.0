Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3B64BDDFEE
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 22:22:21 +1000 (EST)
Date: Thu, 4 Sep 2008 16:22:18 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Li Yang-R58472 <LeoLi@freescale.com>
Subject: Re: [RFC PATCH 2/2 v2] powerpc/83xx: mpc836x_mds: add support for
	USBHost
Message-ID: <20080904122218.GA25935@oksana.dev.rtsoft.ru>
References: <20080825152736.GB25178@oksana.dev.rtsoft.ru>
	<20080901133442.GA32632@oksana.dev.rtsoft.ru>
	<0C69E0CDED15E4469A445DE244C1B9F708D19A@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <0C69E0CDED15E4469A445DE244C1B9F708D19A@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 04, 2008 at 02:45:05PM +0800, Li Yang-R58472 wrote:
> > -----Original Message-----
> > From: Anton Vorontsov [mailto:avorontsov@ru.mvista.com] 
> > Sent: Monday, September 01, 2008 9:35 PM
> > To: Kumar Gala
> > Cc: linuxppc-dev@ozlabs.org; Li Yang-R58472
> > Subject: [RFC PATCH 2/2 v2] powerpc/83xx: mpc836x_mds: add 
> > support for USBHost
> > 
> > Various changes to support QE USB Host on a MPC8360E-MDS board:
> > 
> > - Update the device tree per QE USB bindings;
> > - Configure QE Par IO;
> > - Set up BCSR for both USB Host and Peripheral modes;
> > - Add timer (GTM) node;
> > - Add gpio-controller node for BCSR13 bank;
> > - Select FSL_GTM, QE_GPIO and OF_SIMPLE_GPIO.
> > 
> > The work is loosely based on Li Yang's patch[1], which is 
> > used to support peripheral mode only.
> > 
> > [1] http://ozlabs.org/pipermail/linuxppc-dev/2008-August/061357.html
> > 
> > The s-o-b line of the original patch preserved here.
> > 
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> {snip}
> > @@ -297,11 +328,20 @@
> >  		};
> >  
> >  		usb@6c0 {
> > -			compatible = "qe_udc";
> > +			compatible = "fsl,mpc8360-qe-usb",
> > +				     "fsl,mpc8323-qe-usb";
> >  			reg = <0x6c0 0x40 0x8b00 0x100>;
> >  			interrupts = <11>;
> >  			interrupt-parent = <&qeic>;
> > -			mode = "slave";
> > +			fsl,fullspeed-clock = "clk21";
> > +			fsl,lowspeed-clock = "brg9";
> > +			gpios = <&qe_pio_b  2 0   /* USBOE */
> > +				 &qe_pio_b  3 0   /* USBTP */
> > +				 &qe_pio_b  8 0   /* USBTN */
> > +				 &qe_pio_b  9 0   /* USBRP */
> > +				 &qe_pio_b 11 0   /* USBRN */
> > +				 &bcsr13    5 0   /* SPEED */
> > +				 &bcsr13    4 1>; /* POWER */
> 
> 
> Nothing against this node.  But I don't think gpio nodes can
> replaces par_io nodes. 

Yes, they can't, and gpios = <> are not meant to be replacement
for par_io nodes. gpios are used by the host driver, the driver
really needs these "gpios = <>" as gpios.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
