Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D7F41A0627
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 11:33:08 +1100 (AEDT)
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0113.outbound.protection.outlook.com [65.55.169.113])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9B5CF1400E7
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2014 11:33:07 +1100 (AEDT)
Message-ID: <1417566777.15957.227.camel@freescale.com>
Subject: Re: [PATCH v3 3/4] powerpc/mpc85xx: Add FSL QorIQ DPAA BMan support
 to device tree(s)
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Tue, 2 Dec 2014 18:32:57 -0600
In-Reply-To: <1417428135-12895-4-git-send-email-Emilian.Medve@Freescale.com>
References: <1417428135-12895-1-git-send-email-Emilian.Medve@Freescale.com>
 <1417428135-12895-4-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Poonam Aggrwal <poonam.aggrwal@Freescale.com>,
 Geoff Thorpe <Geoff.Thorpe@Freescale.com>, linuxppc-dev@ozlabs.org,
 Chunhe Lan <Chunhe.Lan@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-12-01 at 04:02 -0600, Emil Medve wrote:
> diff --git a/arch/powerpc/boot/dts/t4240rdb.dts b/arch/powerpc/boot/dts/t4240rdb.dts
> index 53761d4..431bf4e 100644
> --- a/arch/powerpc/boot/dts/t4240rdb.dts
> +++ b/arch/powerpc/boot/dts/t4240rdb.dts
> @@ -69,10 +69,27 @@
>  		device_type = "memory";
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		bman_fbpr: bman-fbpr {
> +			compatible = "fsl,bman-fbpr";
> +			alloc-ranges = <0 0 0xffff 0xffffffff>;
> +			size = <0 0x1000000>;
> +			alignment = <0 0x1000000>;
> +		};
> +	};

Can't this be done at the SoC level rather than board level?

-Scott
