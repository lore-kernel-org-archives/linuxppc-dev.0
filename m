Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9FCD41007D9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 05:01:02 +1100 (EST)
Message-ID: <49443.84.105.60.153.1259172058.squirrel@gate.crashing.org>
In-Reply-To: <1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
Date: Wed, 25 Nov 2009 19:00:58 +0100 (CET)
Subject: Re: [RFC PATCH 02/19] powerpc: gamecube: device tree
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: "Albert Herranz" <albert_herranz@yahoo.es>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +	memory {
> +		device_type = "memory";
> +		/* 24M minus framebuffer memory area (640*576*2*2) */
> +		reg = <0x00000000 0x01698000>;

Put the whole 24MB here, probe the framebuffer address and size
in the platform code?

> +	soc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		#interrupt-cells = <1>;

This isn't an interrupt controller, don't put #interrupt-cells
here.

> +		video@0c002000 {
> +			compatible = "nintendo,flipper-video";
> +			reg = <0x0c002000 0x100>;
> +			interrupts = <8>;
> +			interrupt-parent = <&pic>;
> +			/* XFB is the eXternal FrameBuffer */
> +			xfb-start = <0x01698000>; /* end-of-ram - xfb-size */
> +			xfb-size = <0x168000>;

XFB address isn't fixed on the hardware, and the kernel might
want to move it, and you can easily probe for it anyway.  Remove
these last two properties please.


> +		auxram@0c005000 {
> +			compatible = "nintendo,flipper-auxram";
> +			reg = <0x0c005000 0x200>;	/* DSP */
> +			interrupts = <6>;
> +			interrupt-parent = <&pic>;
> +		};
> +
> +		audio@0c005000 {
> +			compatible = "nintendo,flipper-audio";
> +			reg = <0x0c005000 0x200		/* DSP */
> +			       0x0c006c00 0x20>;	/* AI */
> +			interrupts = <6>;
> +			interrupt-parent = <&pic>;
> +		};

These two have the same address, not good.  Just remove the
auxram node?

> +		disk@0c006000 {
> +			compatible = "nintendo,flipper-disk";

I always thought optical discs are spelled with a "c", but
people disagree a lot on this :-)

...and all the applicable things I mentioned in my Wii dev tree
reply, of course.

Wow, it wasn't as bad as I expected actually.  But you cheated,
you omitted most devices from the device trees :-)


Segher
