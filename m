Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0128.outbound.protection.outlook.com [65.55.169.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6DDAF1A03A4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 04:13:44 +1000 (AEST)
Message-ID: <1431627194.3868.182.camel@freescale.com>
Subject: Re: [PATCH] iommu/fsl: Fix the dependency check for PAMU driver.
From: Scott Wood <scottwood@freescale.com>
To: Varun Sethi <Varun.Sethi@freescale.com>
Date: Thu, 14 May 2015 13:13:14 -0500
In-Reply-To: <1431625272-17869-1-git-send-email-Varun.Sethi@freescale.com>
References: <1431625272-17869-1-git-send-email-Varun.Sethi@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: joro@8bytes.org, jroedel@suse.de, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-05-14 at 23:11 +0530, Varun Sethi wrote:
> Fix the build dependency for the PAMU driver. PPC32 build dependecy is incorrect.
> Add the CORENET_GENERIC build dependency for PAMU driver.
> 
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
>  drivers/iommu/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 1ae4e54..4ace8db 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -50,7 +50,7 @@ config OF_IOMMU
>  
>  config FSL_PAMU
>  	bool "Freescale IOMMU support"
> -	depends on PPC32
> +	depends on CORENET_GENERIC
>  	depends on PPC_E500MC || COMPILE_TEST
>  	select IOMMU_API
>  	select GENERIC_ALLOCATOR

CORENET_GENERIC is for board support.  There is no guarantee that all
corenet boards will use it.  You already depend on PPC_E500MC; why do
you need anything else (besides probably getting rid of "||
COMPILE_TEST" which is useless if you do add CORENET_GENERIC, because
CORENET_GENERIC implies PPC_E500MC)?

-Scott
