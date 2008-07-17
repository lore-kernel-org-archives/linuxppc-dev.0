Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 50617DDF22
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 15:59:23 +1000 (EST)
In-Reply-To: <20080714164114.GA18784@polina.dev.rtsoft.ru>
References: <20080714164114.GA18784@polina.dev.rtsoft.ru>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dc452eaab83710e7d6f86dcc5d77bdda@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] leds: implement OpenFirmare GPIO LED driver
Date: Thu, 17 Jul 2008 07:59:03 +0200
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> diff --git a/Documentation/powerpc/dts-bindings/gpio/led.txt 
> b/Documentation/powerpc/dts-bindings/gpio/led.txt
> new file mode 100644
> index 0000000..7e9ce81
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/gpio/led.txt
> @@ -0,0 +1,15 @@
> +LED connected to GPIO
> +
> +Required properties:
> +- compatible : should be "gpio-led".

This "compatible" name is a bit too generic.  No, I don't know a
better name :-(

> +- label : (optional) the label for this LED. If omitted, the label is
> +  taken from the node name (excluding the unit address).

What is a label?  It should be described here.  Also, its encoding
should be described ("a string" I guess).

> +- gpios : should specify LED GPIO.
> +
> +Example:
> +
> +led@0 {
> +	compatible = "gpio-led";
> +	label = "hdd";
> +	gpios = <&mcu_pio 0 0>;
> +};

You show a unit address but have no "reg" value.  This is
incorrect.

What would be the parent node of this, btw?


Segher
