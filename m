Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id EA61BDDF9C
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 00:01:34 +1000 (EST)
Date: Wed, 23 Apr 2008 18:01:31 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [RFC POWERPC] booting-without-of: bindings for FHCI USB, GPIO
	LEDs, MCU, and NAND on UPM
Message-ID: <20080423140131.GA28303@polina.dev.rtsoft.ru>
References: <20080422194135.GA27822@polina.dev.rtsoft.ru>
	<200804231115.39126.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <200804231115.39126.laurentp@cse-semaphore.com>
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

On Wed, Apr 23, 2008 at 11:15:35AM +0200, Laurent Pinchart wrote:
> Hi Anton,
> 
> On Tuesday 22 April 2008 21:41, Anton Vorontsov wrote:
> > Hi all,
> > 
> > Here is purposed bindings draft for the new drivers that I would like to
> > send for this or next merge window, depending on results of this RFC. ;-)
> > (The new bindings needs to be in-tree or at least Acked before I could
> > send the drivers.)
> > 
> > Comments and suggestions are highly appreciated.
> > 
> > Thanks.
> > 
> > diff --git a/Documentation/powerpc/booting-without-of.txt 
> b/Documentation/powerpc/booting-without-of.txt
> > index c350623..38fe3e9 100644
> > --- a/Documentation/powerpc/booting-without-of.txt
> > +++ b/Documentation/powerpc/booting-without-of.txt
> > @@ -59,6 +59,11 @@ Table of Contents
> >        p) Freescale Synchronous Serial Interface
> >        q) USB EHCI controllers
> >        r) Freescale General-purpose Timers Module
> > +      s) Freescale USB Parameter RAM:
> > +      t) Freescale QUICC Engine USB Controller
> > +      u) LEDs on GPIOs
> > +      v) Freescale MCU with MPC8349E-mITX compatible firmware
> > +      w) NAND on UPM-driven Freescale Localbus
> >  
> >    VII - Marvell Discovery mv64[345]6x System Controller chips
> >      1) The /system-controller node
> > @@ -2866,6 +2871,139 @@ platforms are moved over to use the 
> flattened-device-tree model.
> >      	clock-frequency = <0>;
> >      };
> >  
> > +    s) Freescale USB Parameter RAM:
> > +
> > +    Required properties:
> > +      - compatible : should be "fsl,<chip>-qe-muram-usb-pram",
> > +        "fsl,qe-muram-usb-pram", "fsl,cpm-muram-usb-pram".
> > +      - reg : should contain USB PRAM location and length.
> > +
> > +    Example:
> > +
> > +	usb-pram@8b00 {
> > +		compatible = "fsl,mpc8360-qe-muram-usb-pram",
> > +			     "fsl,qe-muram-usb-pram",
> > +			     "fsl,cpm-muram-usb-pram";
> > +		reg = <0x8b00 0x100>;
> > +	};
> > +
> > +    t) Freescale QUICC Engine USB Controller
> > +
> > +    Required properties:
> > +      - compatible : should be "fsl,<chip>-qe-usb", "fsl,qe-usb",
> > +        "fsl,usb-fhci"
> > +      - reg : should contain gtm registers location and length.
> > +      - interrupts : should contain USB interrupt.
> > +      - interrupt-parent : interrupt source phandle.
> > +      - fsl,fullspeed-clock : specifies the full speed USB clock source.
> > +      - fsl,lowspeed-clock : specifies the low speed USB clock source.
> > +      - fsl,usb-mode : should be "host".
> > +      - linux,hub-power-budget : optional, USB power budget for the root 
> hub
> > +        in mA.
> > +      - gpios : should specify GPIOs in this order: USBOE, USBTP, USBTN, 
> USBRP,
> > +        USBRN, SPEED (optional), and SUSPEND (optional).
> 
> Suspend should in my opinion be renamed power (or bus power or anything 
> similar), as it controls the USB power and not USB PHY sleep mode.

Thanks, I'll rename it.

> > +    Example:
> > +
> > +	usb@6c0 {
> > +		compatible = "fsl,mpc8360-qe-usb", "fsl,qe-usb",
> > +			     "fsl,usb-fhci";
> > +		reg = <0x6c0 0x40>;
> > +		interrupts = <11>;
> > +		interrupt-parent = <&qeic>;
> > +		fsl,fullspeed-clock = "clk21";
> > +		fsl,usb-mode = "host";
> > +		gpios = <&qe_pio_b  2 0 /* USBOE */
> > +			 &qe_pio_b  3 0 /* USBTP */
> > +			 &qe_pio_b  8 0 /* USBTN */
> > +			 &qe_pio_b  9 0 /* USBRP */
> > +			 &qe_pio_b 11 0 /* USBRN */
> > +			 &qe_pio_e 20 0 /* SPEED */
> > +			 &qe_pio_e 21 0 /* SUSPN */>;
> > +	};
> > +
> > +    u) LEDs on GPIOs
> > +
> > +    Required properties:
> > +      - compatible : should be "linux,gpio-led".
> > +      - linux,name : LED name.
> > +      - linux,active-low : property should be present if LED wired as
> > +        active-low.
> 
> Just thinking out loud, wasn't the third GPIO cell supposed to be used to 
> encode such properties ?

Oh well, yes, origianally I wrote that it `may' encode this information.
Encoding this would be really useful if node is using many gpios that are
wired in some random inverted/not-inverted way...

gpios <&qe_pio 2 1   /* wired active-low */
       &qe_pio 3 0   /* wired active-high */
       &qe_pio 4 1   /* wired active-low */
       &qe_pio 5 0   /* wired active-high */
       &qe_pio 6 1>; /* wired active-low */


But we didn't see this setup yet, and I'm not sure if I want to implement
this support now just for the LEDs. Specifying this information via
gpios = <> property or separate one isn't going to conflict anyhow
and when we'll implement actual flags for GPIOs, we'll easily could
switch to it in backwards compatible way.

Thanks for brining it up though.

> > +      - linux,default-trigger : Linux default trigger for this LED.
> > +      - linux,brightness : default brightness.
> > +      - gpios : should specify LED GPIO.
> > +
> > +    Example:
> > +
> > +	led@0 {
> > +		compatible = "linux,gpio-led";
> > +		linux,name = "pwr";
> > +		linux,brightness = <1>;
> > +		linux,active-low;
> > +		gpios = <&mcu_pio 0>;
> > +	};
> > +
> > +	led@1 {
> > +	        compatible = "linux,gpio-led";
> > +	        linux,name = "hdd";
> > +	        linux,default-trigger = "ide-disk";
> > +		linux,active-low;
> > +		gpios = <&mcu_pio 1>;
> > +	};

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
