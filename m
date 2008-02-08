Return-Path: <simon.kagstrom@ericsson.com>
Received: from mailgw3.ericsson.se (mailgw3.ericsson.se [193.180.251.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5DD37DDE3C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Feb 2008 22:26:26 +1100 (EST)
Date: Fri, 8 Feb 2008 12:26:25 +0100
From: Simon Kagstrom <simon.kagstrom@ericsson.com>
To: Marco Stornelli <marco.stornelli@coritel.it>
Subject: Re: Leds
Message-ID: <20080208122625.7a1605fc@seasc0532.dyn.rnd.as.sw.ericsson.se>
In-Reply-To: <47AC324D.1050503@coritel.it>
References: <47AC28A8.5030609@coritel.it>
	<20080208112002.42a15c0d@seasc0532.dyn.rnd.as.sw.ericsson.se>
	<47AC324D.1050503@coritel.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 08 Feb 2008 11:43:25 +0100
Marco Stornelli <marco.stornelli@coritel.it> wrote:

> > Although I'm not sure if it's the "standard" way, we just added a
> > "home-made" node like this:
> > 
> > 	resetLED@c0018000 {
> > 		device_type = "leds";
> > 		compatible = "reset-leds";
> > 		reg = <c0018000 00008000>;
> > 	};
> > 
> Thanks. In this case where have you added the device registration? In
> the probe function? Have you registered the driver with
> of_register_platform_driver()?

We put it in the module init function and registered it as a platform
device:

static int __init led_init(void)
{
	int ret;

	ret = platform_driver_register(&led_driver);

	if (ret < 0)
		return -ENODEV;

	pdev = platform_device_register_simple(DRVNAME, -1, NULL, 0);
	if (IS_ERR(pdev)) {
		ret = PTR_ERR(pdev);
		platform_driver_unregister(&led_driver);
	}

	return ret;
}

And just use the device tree stuff to read out the device address. The
driver itself is quite similar to other led drivers found in the same
directory, so you can probably base your work on those.

This was for kernel 2.6.21, I'm not sure if these things have changed
for newer kernels (although I would guess most of it is the same).

// Simon
