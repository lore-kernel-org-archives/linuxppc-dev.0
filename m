Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id BE5E8DDDEF
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 05:34:44 +1100 (EST)
Date: Mon, 27 Oct 2008 21:34:21 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
Message-ID: <20081027183421.GA1009@oksana.dev.rtsoft.ru>
References: <4900ED81.3040202@genesi-usa.com> <4900F90B.80703@firmworks.com>
	<4901032F.3090805@genesi-usa.com> <49011C42.2020101@firmworks.com>
	<20081024032944.GE4267@yookeroo.seuss>
	<49014C69.8020408@firmworks.com>
	<20081024044511.GI4267@yookeroo.seuss>
	<490248C2.9020104@genesi-usa.com>
	<20081026234747.GD22339@yookeroo.seuss>
	<4905E0DC.104@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <4905E0DC.104@genesi-usa.com>
Cc: Mitch Bradley <wmb@firmworks.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 27, 2008 at 10:40:12AM -0500, Matt Sealey wrote:
>
>
> David Gibson wrote:
>
>> Um.. I can't actually follow what you're getting at there, sorry.
>
> Imagine in your head that you have a GPIO controller that has a
> 32-bit register potentially controlling 32 pins on the chip.
>
> Imagine that rather than being able to allocate 6 GPIO pins
> *right next to each other* in the register and saying that
> you start at "pin" 15 and use the next 6 "pins", you have to
> spread it around and use pin 1, pin 8, pin 9, pin 11, pin 15,
> pin 30, to make up this peripheral.

Isn't this some implementation detail of a gpio controller?

gpio: gpio-controller@... {
	#gpio-cells = <2>;
	compatible = "gpio-bank-with-funny-mapping"; <- notice this
	reg = <123 4>;
	gpio-controller;
}

device {
	gpios = <&gpio 0 0 &gpio 1 0 &gpio 2 0>;
}

^^ Three gpios, 0, 1, 2. Based on a compatible entry Linux can
   translate them in any way.

   For example GPIO0 - bit 15, GPIO1 - bit 20, GPIO2 - bit 1.

> As far as I can tell there is no way at all to specify a set of
> GPIO pins which are NOT consecutive because the current GPIO
> spec stops after specifying a controller bank (the 32-bit
> register).

The GPIO spec doesn't specify a controller bank. It says

- - - -
gpio-specifier may encode: bank, pin position inside the bank,
whether pin is open-drain and whether pin is logically inverted.
- - - -

May encode. Or may not encode. FYI, for most (all) SOC GPIO
controllers we don't use "bank" encoding in the gpio-specifier.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
