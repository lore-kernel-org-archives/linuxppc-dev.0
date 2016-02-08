Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B9C41A0018
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 22:13:22 +1100 (AEDT)
Message-ID: <1454929996.1562.3.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Fix incorrect PPC32 PAMU dependency
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andy Fleming <afleming@gmail.com>, joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 08 Feb 2016 22:13:16 +1100
In-Reply-To: <1454638566-1953-1-git-send-email-afleming@gmail.com>
References: <1454638566-1953-1-git-send-email-afleming@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-02-04 at 20:16 -0600, Andy Fleming wrote:

> The Freescale PAMU can also be enabled on 64-bit power
> chips. Commit 477ab7a19cec8409e4e2dd10e7348e4cac3c06e5
> (iommu: Make more drivers depend on COMPILE_TEST)
> added this false dependency. Fixed it by allowing PPC64, too.
>
> Signed-off-by: Andy Fleming <afleming@gmail.com>
> ---
>  drivers/iommu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index a1e75cb..63ec7ae 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -57,7 +57,7 @@ config IOMMU_DMA
>
>  config FSL_PAMU
>  	bool "Freescale IOMMU support"
> -	depends on PPC32
> +	depends on PPC32 || PPC64

That's == PPC.

>  	depends on PPC_E500MC || COMPILE_TEST

But then you have that ^

Multiple depends are joined with &&, so you get:

	depends on PPC && (PPC_E500MC || COMPILE_TEST)

PPC_E500MC depends (indirectly) on PPC, so I think it would be clearer as:

	depends on PPC_E500MC || (COMPILE_TEST && PPC)

Which I /think/ matches the original intention?

cheers
