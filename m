Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 19678DDF6B
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Sep 2008 01:00:04 +1000 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] powerpc/44x: Add hwmon support to Sequoia device tree
Date: Fri, 5 Sep 2008 16:58:38 +0200
References: <200809041155.02927.matthias.fuchs@esd-electronics.com>
	<200809041641.57614.matthias.fuchs@esd-electronics.com>
	<200809051219.43906.sr@denx.de>
In-Reply-To: <200809051219.43906.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809051658.39193.matthias.fuchs@esd-electronics.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I was inspired by some I2C RTC node (tqm5200.dts). Those nodes
are named rtc@... But to be in common I can change it. Also
the vendor is differnet in warp's dts file. adi (analog device inc.) against
"analog".

So I will update my patch to be compatible with warp.dts.

I keep your ack, Stefan.

Matthias

On Friday 05 September 2008 12:19, Stefan Roese wrote:
> > diff --git a/arch/powerpc/boot/dts/sequoia.dts
> > b/arch/powerpc/boot/dts/sequoia.dts index 72d15f0..9ba5def 100644
> > --- a/arch/powerpc/boot/dts/sequoia.dts
> > +++ b/arch/powerpc/boot/dts/sequoia.dts
> > @@ -246,13 +246,22 @@
> >  	   		};
> >
> >  			IIC0: i2c@ef600700 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> >  				compatible = "ibm,iic-440epx", "ibm,iic";
> >  				reg = <0xef600700 0x00000014>;
> >  				interrupt-parent = <&UIC0>;
> >  				interrupts = <0x2 0x4>;
> > +
> > +				hwmon@48 {
> 
> Not sure if we shouldn't use
> 
>                                 ad7414@48 {
> 
> here. This is the way it is already done in warp.dts.
