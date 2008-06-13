Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A6E90DE20B
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 01:51:33 +1000 (EST)
Message-ID: <4852977B.8030800@freescale.com>
Date: Fri, 13 Jun 2008 10:51:23 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: hs@denx.de
Subject: Re: [PATCH] [8xx] powerpc: Add support for the MPC852 based mgsuvd
	board from keymile.
References: <20080612152838.GA2756@loki.buserror.net> <4852A09B.100@denx.de>
In-Reply-To: <4852A09B.100@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Heiko Schocher wrote:
> +	localbus@fff00100 {
> +		compatible = "fsl,pq1-localbus";

"fsl,mpc852-localbus", "fsl,pq1-localbus", "simple-bus";

> +	soc@fff00000 {
> +		compatible = "fsl,mpc852", "simple-bus", "fsl,pq1-soc";

simple-bus should come last, since it's the most generic.

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		ranges = <0 0xfff00000 0x00004000>;
> +
> +		PIC: interrupt-controller@0 {
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			reg = <0 24>;
> +			compatible = "fsl,pq1-pic";

"fsl,mpc852-pic", "fsl,pq1-pic";

In general, a chip-specific name should be listed first, so the driver 
can easily apply workarounds if needed.  See the existing 8xx device 
trees for examples.

-Scott
