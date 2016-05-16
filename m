Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r7xnZ2Z6mzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 09:41:54 +1000 (AEST)
Date: Mon, 16 May 2016 18:41:47 -0500
From: Scott Wood <oss@buserror.net>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Cc: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-ID: <20160516234147.GA22832@home.buserror.net>
References: <1461746125-8055-1-git-send-email-alessio.bogani@elettra.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461746125-8055-1-git-send-email-alessio.bogani@elettra.eu>
Subject: Re: [v4,1/1] powerpc/86xx: Add support for Emerson/Artesyn MVME7100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 27, 2016 at 10:35:25AM +0200, Alessio Igor Bogani wrote:
> +		bcsr@4,0 {
> +			compatible = "artesyn,mvme7100-bcsr";
> +			reg = <4 0 0x10000>;
> +		};
> +
> +	       serial@5,1000 {
> +			cell-index = <2>;
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <5 0x1000 0x100>;
> +			clock-frequency = <1843200>;
> +			interrupts = <11 1 0 0>;
> +		};

The "serial@5,1000" line has spaces where there should be tabs.  There
are several other instances of this in the patch.

Where did these cell-index values come from?  Why are they needed?

> +	};
> +
> +};

No blank line here.

> +	platform_ops.fixups = mvme7100_fixups;
> +
> +}

No blank line here.

> diff --git a/arch/powerpc/boot/ppcboot.h b/arch/powerpc/boot/ppcboot.h
> index 6ae6f90..7b758be 100644
> --- a/arch/powerpc/boot/ppcboot.h
> +++ b/arch/powerpc/boot/ppcboot.h
> @@ -43,7 +43,7 @@ typedef struct bd_info {
>  	unsigned long	bi_sramstart;	/* start of SRAM memory */
>  	unsigned long	bi_sramsize;	/* size	 of SRAM memory */
>  #if defined(TARGET_8xx) || defined(TARGET_CPM2) || defined(TARGET_85xx) ||\
> -	defined(TARGET_83xx)
> +	defined(TARGET_83xx) || defined(TARGET_MVME7100)
>  	unsigned long	bi_immr_base;	/* base of IMMR register */
>  #endif

Again, please use TARGET_86xx here rather than TARGET_MVME7100.

> @@ -69,7 +74,7 @@ config MPC8641
>  	select FSL_PCI if PCI
>  	select PPC_UDBG_16550
>  	select MPIC
> -	default y if MPC8641_HPCN || SBC8641D || GEF_SBC610 || GEF_SBC310 || GEF_PPC9A
> +	default y if MPC8641_HPCN || SBC8641D || GEF_SBC610 || GEF_SBC310 || GEF_PPC9A || MVME7100

Please wrap this long line.

-Scott
