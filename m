Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpsQr6SHfzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 14:26:28 +1000 (AEST)
Message-ID: <1461039981.32510.201.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>, Kumar Gala
 <galak@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Date: Mon, 18 Apr 2016 23:26:21 -0500
In-Reply-To: <1460966279-29188-1-git-send-email-alessio.bogani@elettra.eu>
References: <460384482-21320-1-git-send-email-alessio.bogani@elettra.eu>
 <1460966279-29188-1-git-send-email-alessio.bogani@elettra.eu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v2 1/1] powerpc/86xx: Add support for Emerson/Artesyn
 MVME7100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-04-18 at 09:57 +0200, Alessio Igor Bogani wrote:
> +	pci0: pcie@f1008000 {
> +		reg = <0xf1008000 0x1000>;
> +		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0
> 0x50000000
> +			  0x01000000 0x0 0x00000000 0xf0000000 0x0
> 0x00800000>;
> +		pcie@0 {
> +			ranges = <0x02000000 0x0 0x80000000
> +				  0x02000000 0x0 0x80000000
> +				  0x0 0x50000000
> +
> +				  0x01000000 0x0 0x00000000
> +				  0x01000000 0x0 0x00000000
> +				  0x0 0x00800000>;
> +		};
> +	};
> +
> +	pci1: pcie@f1009000 {
> +		compatible = "fsl,mpc8641-pcie";
> +		device_type = "pci";
> +		#size-cells = <2>;
> +		#address-cells = <3>;
> +		reg = <0xf1009000 0x1000>;
> +		bus-range = <0 0xff>;

Why are pci0 and pci1 so different?  Why does mpc8641si-post.dtsi not have
pci1?

> +asm("	.globl _zimage_start\n\
> +	_zimage_start:\n\
> +		mfmsr   10\n\
> +		rlwinm  10,10,0,~(1<<15)        /* Clear MSR_EE */\n\
> +		sync\n\
> +		mtmsr   10\n\
> +		isync\n\
> +		b _zimage_start_lib\n\
> +");

Please put this in an asm file.

Is U-Boot really not clearing MSR[EE]?  How old is this U-Boot?

> diff --git a/arch/powerpc/boot/ppcboot.h b/arch/powerpc/boot/ppcboot.h
> index 6ae6f90..7b758be 100644
> --- a/arch/powerpc/boot/ppcboot.h
> +++ b/arch/powerpc/boot/ppcboot.h
> @@ -43,7 +43,7 @@ typedef struct bd_info {
>  	unsigned long	bi_sramstart;	/* start of SRAM memory
> */
>  	unsigned long	bi_sramsize;	/* size	 of SRAM
> memory */
>  #if defined(TARGET_8xx) || defined(TARGET_CPM2) || defined(TARGET_85xx) ||\
> -	defined(TARGET_83xx)
> +	defined(TARGET_83xx) || defined(TARGET_MVME7100)
>  	unsigned long	bi_immr_base;	/* base of IMMR register
> */
>  #endif

TARGET_86xx would match the U-Boot definition better.

> +/*
> + * Called very early, device-tree isn't unflattened
> + */
> +static int __init mvme7100_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +
> +	if (!of_flat_dt_is_compatible(root, "artesyn,MVME7100"))
> +		return 0;
> +
> +	_set_L2CR(_get_L2CR() | L2CR_L2E);
> +	return 1;
> +}

U-Boot doesn't enable L2 cache?

-Scott
