Return-Path: <scottwood@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 16A552C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 09:10:38 +1100 (EST)
Message-ID: <1384467025.1403.210.camel@snotra.buserror.net>
Subject: Re: [PATCH] iommu/fsl_pamu: use physical cpu index to find the
 matched cpu nodes
From: Scott Wood <scottwood@freescale.com>
To: Haiying Wang <Haiying.Wang@freescale.com>
Date: Thu, 14 Nov 2013 16:10:25 -0600
In-Reply-To: <1384457440.2144.15.camel@haiying-laptop>
References: <1384457440.2144.15.camel@haiying-laptop>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Varun Sethi <Varun.Sethi@freescale.com>, joro@8bytes.org,
 linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-11-14 at 14:30 -0500, Haiying Wang wrote:
> In the case we miss to bring up some cpus, we need to make sure we can
> find the correct cpu nodes in the device tree based on the given logical
> cpu index from the caller.
> 
> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
> ---
>  drivers/iommu/fsl_pamu.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
> index cba0498..a9ab57b 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -539,6 +539,7 @@ u32 get_stash_id(u32 stash_dest_hint, u32 vcpu)

Should probably also s/vcpu/cpu/g as vcpu makes no sense outside of
virtualization code.

>  	u32 cache_level;
>  	int len, found = 0;
>  	int i;
> +	u32 cpuid = get_hard_smp_processor_id(vcpu);

s/cpuid/phys_cpu/ or similar

-Scott
