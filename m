Return-Path: <simon.kagstrom@ericsson.com>
Received: from mailgw4.ericsson.se (mailgw4.ericsson.se [193.180.251.62])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A2B4CDDEDE
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Feb 2008 21:44:27 +1100 (EST)
Date: Fri, 8 Feb 2008 11:20:02 +0100
From: Simon Kagstrom <simon.kagstrom@ericsson.com>
To: Marco Stornelli <marco.stornelli@coritel.it>
Subject: Re: Leds
Message-ID: <20080208112002.42a15c0d@seasc0532.dyn.rnd.as.sw.ericsson.se>
In-Reply-To: <47AC28A8.5030609@coritel.it>
References: <47AC28A8.5030609@coritel.it>
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

Hi Marco,

On Fri, 08 Feb 2008 11:02:16 +0100
Marco Stornelli <marco.stornelli@coritel.it> wrote:

> how can specify a led device in a dts file? These leds are connected
> with gpio to the microprocessor. I can't find anything like a led node
> in the dts files of the other boards. Have you got any suggestions?

Although I'm not sure if it's the "standard" way, we just added a
"home-made" node like this:

	resetLED@c0018000 {
		device_type = "leds";
		compatible = "reset-leds";
		reg = <c0018000 00008000>;
	};

and then just get the info in the probe function for the led driver
we placed in drivers/leds/:

	/* Get device info from OF tree */
	np = of_find_compatible_node(NULL, "leds", "reset-leds");
	if (!np) {
		dev_err(&pdev->dev, "Could not find device tree node for reset-leds\n");
		goto error_classdev;
	}

	if (of_address_to_resource(np, 0, &res)) {
		dev_err(&pdev->dev, "Could not convert reset-leds device tree address\n");
		of_node_put(np);
		goto error_classdev;
	}
	...

At least this was all the information we needed from the device tree.

// Simon
