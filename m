Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 281D0DE5C8
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 01:32:19 +1000 (EST)
Date: Thu, 12 Jun 2008 10:32:15 -0500
From: Scott Wood <scottwood@freescale.com>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH] [82xx] powerpc: Add support for mpc8247 based board
	MGCOGE from keymile.
Message-ID: <20080612153215.GB2756@loki.buserror.net>
References: <20080612003052.12592.84896.stgit@vitb-lp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080612003052.12592.84896.stgit@vitb-lp>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 12, 2008 at 04:30:53AM +0400, Vitaly Bordug wrote:
> +			muram {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0 0x10000>;
> +
> +				data@0 {
> +					compatible = "fsl,cpm-muram-data";
> +					reg = <0x80 0x1f80 0x9800 0x800>;
> +				};
> +			};

"fsl,cpm-muram" compatible on the muram node.

> +			/* Monitor port/SMC2 */
> +			smc2: serial@11a90 {
> +				device_type = "serial";
> +				compatible = "fsl,mpc8247-smc-uart",
> +				             "fsl,cpm2-smc-uart";
> +				reg = <0x11a90 0x20 0x88fc 0x02>;
> +				interrupts = <5 8>;
> +				interrupt-parent = <&PIC>;
> +				fsl,cpm-brg = <2>;
> +				fsl,cpm-command = <0x21200000>;
> +				current-speed = <115200>;
> +			};

Shouldn't u-boot fill in the current speed?

-Scott
