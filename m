Return-Path: <joro@8bytes.org>
Received: from mail.8bytes.org (8bytes.org
 [IPv6:2a01:238:4242:f000:64f:6c43:3523:e535])
 by lists.ozlabs.org (Postfix) with ESMTP id 71D821A00D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 20:54:34 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 5169D12B0A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 12:54:32 +0200 (CEST)
Date: Fri, 4 Jul 2014 12:54:31 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Varun Sethi <Varun.Sethi@freescale.com>
Subject: Re: [PATCH 2/3] iommu/fsl: Fix the device domain attach condition.
Message-ID: <20140704105430.GE13434@8bytes.org>
References: <1403618237-26248-1-git-send-email-Varun.Sethi@freescale.com>
 <1403618237-26248-3-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403618237-26248-3-git-send-email-Varun.Sethi@freescale.com>
Cc: alex.williamson@redhat.com, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hmm,

On Tue, Jun 24, 2014 at 07:27:16PM +0530, Varun Sethi wrote:
> -	old_domain_info = find_domain(dev);
> +	old_domain_info = dev->archdata.iommu_domain;
>  	if (old_domain_info && old_domain_info->domain != dma_domain) {
>  		spin_unlock_irqrestore(&device_domain_lock, flags);
>  		detach_device(dev, old_domain_info->domain);

Wouldn't this set dev->archdata.iommu_domain to NULL anyway, so that ...

> @@ -399,7 +394,7 @@ static void attach_device(struct fsl_dma_domain *dma_domain, int liodn, struct d
>  	 * the info for the first LIODN as all
>  	 * LIODNs share the same domain
>  	 */
> -	if (!old_domain_info)
> +	if (!dev->archdata.iommu_domain)
>  		dev->archdata.iommu_domain = info;

We already know that it _must_ be NULL here?

>  	spin_unlock_irqrestore(&device_domain_lock, flags);

This would shrink down the patch to:

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 93072ba..d21b554 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -399,8 +399,7 @@ static void attach_device(struct fsl_dma_domain *dma_domain, int liodn, struct d
 	 * the info for the first LIODN as all
 	 * LIODNs share the same domain
 	 */
-	if (!old_domain_info)
-		dev->archdata.iommu_domain = info;
+	dev->archdata.iommu_domain = info;
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 }
