Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E842DDDF2D
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 23:23:13 +1000 (EST)
Date: Thu, 7 Aug 2008 17:23:11 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 5/6] powerpc: add USB peripheral support to MPC836xMDS
Message-ID: <20080807132311.GA6960@polina.dev.rtsoft.ru>
References: <1218006285-27138-1-git-send-email-leoli@freescale.com>
	<1218006285-27138-2-git-send-email-leoli@freescale.com>
	<1218006285-27138-3-git-send-email-leoli@freescale.com>
	<1218006285-27138-4-git-send-email-leoli@freescale.com>
	<1218006285-27138-5-git-send-email-leoli@freescale.com>
	<20080806120747.GA7717@polina.dev.rtsoft.ru>
	<1218101504.29628.32.camel@Gundam>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <1218101504.29628.32.camel@Gundam>
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

On Thu, Aug 07, 2008 at 05:31:44PM +0800, Li Yang wrote:
[...]
> > 
> > >  			reg = <0x6c0 0x40 0x8b00 0x100>;
> > >  			interrupts = <11>;
> > >  			interrupt-parent = <&qeic>;
> > >  			mode = "slave";
> > 
> > I'd suggest to rename this to "peripheral" as we use for fsl dual-role
> > usb controller.
> 
> As there will be two drivers chosen by compatible, I'm now inclined to
> put this information in compatible.

Please don't. I deliberately wrote bindings w/o specifing "udc" or
"host" in the compatible entry.

"udc"/"host" is the modes of an USB controller, but the controller
itself is the same: "fsl,mpc8323-qe-usb" (the first chip with QE USB).

So the driver should always match this device, but it can return
-ENODEV if mode is unspecified or !peripheral.

> > > +			usb-clock = <21>;
> > > +			pio-handle = <&pio_usb>;
> > 
> > Can we not introduce new pio maps? The pio setup should be done
> > by the firmware, or at least fixed up via the board file, as in
> > arch/powerpc/platforms/83xx/mpc832x_rdb.c.
> 
> Actually I am more apt to leaving full hardware access to kernel than
> firmware, especially for devices that are not used in firmware.  The
> reason why I made the pin-configuration flexible is that for development
> boards the role of pins are often changeable.
[...]
> Pio config is board and board configuration specific.  It's better to
> make it configurable by device tree.

Device tree isn't configuration file. The bad thing about pio-map is that
it is passing raw values instead of actually describing the hardware.

For example,

pio-map = <1  6  2  0  1  0>;

The thing describes bankB/pin6.. but you'll can't tell what exactly
this pin supposed to do. :-/

Basically "pio-map" is expanded version of this:

fsl,cpodr-reg = <0x...>;
fsl,cppar1-reg = <0x...>;
fsl,cppar2-reg = <0x...>;
...


Instead, it would be great to have something like this:

usb@... {
	/*
	 *      gpio/pinmux    pin
	 *      controller
	 */
	pio-map = <&pinmuxA     1 /* bindings says first pin is clk */
		   &pinmuxB    14 /* bindings says second pin is usboe */
		   ...>;
};

ucc@... {
	pio-map = <&pinmuxA     2 /* bindings says first pin is clk */
		   &pinmuxB    24 /* bindings says second pin is rxd0 */
		   &pinmuxB    21 /* bindings says second pin is rxd1 */
		   ...>;
};

Then drivers would call something like this in probe():

clk = qe_get_clock(node, "fsl,fullspeed-clock");
qe_set_pinmux(pin0, QE_PIN_FUNC_CLK(clk));
qe_set_pinmux(pin1, QE_PIN_FUNC_USB_OE);
...or ucc ethernet...
qe_set_pinmux(pin[rx_n], QE_PIN_FUNC_UCC_RXD(ucc_num, rx_n));

Obviously, this is quite hard to implement (and expensive, too), since
each SoC implementation has its own function<->pin<->regvalue mapping..

Thus nobody even think to bother with this.


Anyway, I'm not that opposed to the current pio-maps, but it
would be great if we could avoid them where possible.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
