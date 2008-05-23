Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BE4B2DDF2E
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 08:11:15 +1000 (EST)
In-Reply-To: <20080523163903.GF16137@polina.dev.rtsoft.ru>
References: <20080523163811.GA12181@polina.dev.rtsoft.ru>
	<20080523163903.GF16137@polina.dev.rtsoft.ru>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <25787c450a6a7e79435877a358ab819a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 6/7] [POWERPC] booting-without-of: add FHCI USB, FSL MCU,
	FSL UPM and GPIO LEDs bindings
Date: Sat, 24 May 2008 00:10:56 +0200
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +      - fsl,fullspeed-clock : specifies the full speed USB clock 
> source in
> +        "clk<num>" or "brg<num>" format.
> +      - fsl,lowspeed-clock : specifies the low speed USB clock source 
> in
> +        "clk<num>" or "brg<num>" format.

What format is "<num>" in?

> +      - fsl,usb-mode : should be "host".

If that's the only possible value, this property is unnecessary,
no?  It probably would make sense to make this optional (and default
to "host") anyway.

> +      - linux,hub-power-budget : optional, USB power budget for the 
> root hub
> +        in mA.

Why is this linux-specific?

> +    w) Freescale MCU with MPC8349E-mITX compatible firmware
> +
> +    Required properties:
> +      - compatible : "fsl,<mcu-chip>-<board>", "fsl,mcu-mpc8349emitx";
> +      - reg : should specify I2C address (0x0a).
> +      - #address-cells : should be 0.
> +      - #size-cells : should be 0.

> +    x) Freescale Localbus UPM programmed to work with NAND flash

Similar here, except this one is never a GPIO controller.

If the point to have #a = #s = 0 is to not have a unit-address
in the child nodes: you should do that simply by not specifying
a "reg" in the child nodes.

> +    y) LEDs on GPIOs

This one is so full of "linux," stuff that I won't review it --
I wouldn't know where to start, sorry.


Segher
