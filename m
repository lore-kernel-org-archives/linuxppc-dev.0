Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D49F7DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2009 04:32:01 +1100 (EST)
Message-ID: <499EE8DD.2030709@freescale.com>
Date: Fri, 20 Feb 2009 11:31:09 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] powerpc/83xx: Add power management support for MPC837x
	boards
References: <20090220171258.GA3050@oksana.dev.rtsoft.ru>
In-Reply-To: <20090220171258.GA3050@oksana.dev.rtsoft.ru>
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

Anton Vorontsov wrote:
> diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
> index 3e3ec8f..c54b90d 100644
> --- a/arch/powerpc/boot/dts/mpc8377_mds.dts
> +++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
> @@ -137,6 +137,7 @@
>  			reg = <0x3000 0x100>;
>  			interrupts = <14 0x8>;
>  			interrupt-parent = <&ipic>;
> +			sleep = <&pmc 0x0c000000>;
>  			dfsrr;

[snip]

> @@ -318,6 +325,7 @@
>  			reg = <0x2e000 0x1000>;
>  			interrupts = <42 0x8>;
>  			interrupt-parent = <&ipic>;
> +			sleep = <&pmc 0x0c000000>;

You have two different nodes with the same bits referenced.  These nodes 
cannot be put to sleep independently, and as such need to be under a 
common sleep-nexus node.

-Scott
