Return-Path: <tpiepho@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B2B29DE50E
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 09:19:53 +1000 (EST)
Date: Wed, 16 Jul 2008 16:18:52 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v3] leds: implement OpenFirmare GPIO LED driver
In-Reply-To: <20080715151917.GA30607@polina.dev.rtsoft.ru>
Message-ID: <Pine.LNX.4.64.0807161546010.12709@t2.domain.actdsltmp>
References: <1216133032.5345.73.camel@dax.rpnet.com>
	<20080715151917.GA30607@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Richard Purdie <rpurdie@rpsys.net>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 15 Jul 2008, Anton Vorontsov wrote:
> Despite leds-gpio and leds-openfirmware-gpio similar purposes, there
> is not much code can be shared between the two drivers (both are mostly
> driver bindings anyway).

Why can't this driver use the existing gpio-led driver?  Basically, do
something like this:

of_gpio_leds_probe(...)
{
 	gpio = of_get_gpio(np, 0);
 	label = of_get_property(np, "label", NULL);

 	struct gpio_led led = {
 		.name = label,
 		.gpio = gpio,
 	};

 	pdev = platform_device_register_simple("leds-gpio", 0, NULL, 0);
 	platform_device_add_data(pdev, &led, sizeof(led));
}
