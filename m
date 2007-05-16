Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 25EA3DDED9
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 02:37:16 +1000 (EST)
Subject: Re: [PATCH 2/5] Add legacy devices to mpc8641_hpcn.dts
From: Jon Loeliger <jdl@freescale.com>
To: Wade Farnsworth <wfarnsworth@mvista.com>
In-Reply-To: <1179246470.8132.112.camel@rhino>
References: <1179245829.8132.100.camel@rhino> <1179246470.8132.112.camel@rhino>
Content-Type: text/plain
Message-Id: <1179333421.7018.17.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 16 May 2007 11:37:01 -0500
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-15 at 11:27, Wade Farnsworth wrote:
> This adds device nodes for the ISA devices on the MPC8641 HPCN to the
> dts.  Additionally, it moves the node for the i8259 to the isa bus,
> since the i8259 is actually on that bus.

This is good.  Couple of quick comments below.


> Index: linux-2.6-8641/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> ===================================================================
> --- linux-2.6-8641.orig/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> +++ linux-2.6-8641/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> @@ -285,17 +285,45 @@


> +			isa@f0 {
> +				device_type = "isa";
>  				#interrupt-cells = <2>;

Yea, thanks.  BTW, will this be sufficient to now identify the
primary controller and not doink with the legacy IO ports now?
Or is that being handled differently somehow?

> +				#size-cells = <1>;
> +				#address-cells = <2>;
> +				reg = <f000 0 0 0 0>;
> +				ranges = <1 0 01000000 0 0 00001000>;
> +				interrupt-parent = <4d0>;

That 4d0 should likely be &i8259.

> +				8042@60 {
> +					device_type = "8042";
> +					reg = <1 60 1 1 64 1>;
> +					interrupts = <1 3 c 3>;
> +					interrupt-parent = <4d0>;
> +				};

Ditto.

> +				rtc@70 {
> +					device_type = "rtc";
> +					reg = <1 70 2>;
> +				};

Is "rtc" a standard OF device, or are we making up a
new thing that should be documented in booting-with-OF.txt ?
And is the plan to somehow use this entry in the future?

Thanks,
jdl
