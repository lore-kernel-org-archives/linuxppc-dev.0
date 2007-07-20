Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6EF2DDDED5
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 05:13:36 +1000 (EST)
Message-ID: <46A10931.4090208@freescale.com>
Date: Fri, 20 Jul 2007 14:12:49 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Randy Vinson <rvinson@mvista.com>
Subject: Re: [PATCH 6/6] 85xxCDS: MPC8548 DTS cleanup.
References: <46A10582.7020709@mvista.com>
In-Reply-To: <46A10582.7020709@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Randy Vinson wrote:
> diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
> index c241e4f..2c6fd63 100644
> --- a/arch/powerpc/boot/dts/mpc8548cds.dts
> +++ b/arch/powerpc/boot/dts/mpc8548cds.dts
> @@ -44,8 +44,14 @@
>  		#size-cells = <1>;
>  		#interrupt-cells = <2>;
>  		device_type = "soc";
> -		ranges = <0 e0000000 00100000>;
> -		reg = <e0000000 00100000>;	// CCSRBAR 1M
> +		ranges = <00001000 e0001000 000ff000
> +			  80000000 80000000 10000000
> +			  e2000000 e2000000 00800000
> +			  90000000 90000000 10000000
> +			  e2800000 e2800000 00800000
> +			  a0000000 a0000000 20000000
> +		          e3000000 e3000000 01000000>;
> +		reg = <e0000000 00001000>;	// CCSRBAR
>  		bus-frequency = <0>;

Instead of duplicating all of these ranges, might we want to move the 
PCI node out of the SOC node, and include a phandle a PCI control node 
under the SOC (similar to the PQ2 /chipselect node in my patchset)?

-Scott
