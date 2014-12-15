Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2DCC1A0198
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 08:33:56 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] mmc: host: arasan: Add addition of-arasan quirks and
 add IOMMU support.
Date: Mon, 15 Dec 2014 22:27:33 +0100
Message-ID: <3866536.C6OiUcuGCr@wuerfel>
In-Reply-To: <1418662867-9210-2-git-send-email-stripathi@apm.com>
References: <1418662867-9210-1-git-send-email-stripathi@apm.com>
 <1418662867-9210-2-git-send-email-stripathi@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: devicetree@vger.kernel.org, Suman Tripathi <stripathi@apm.com>,
 jcm@redhat.com, anton@enomsg.org, linux-mmc@vger.kernel.org, chris@printf.net,
 patches@apm.com, ddutile@redhat.com, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 15 December 2014 22:31:06 Suman Tripathi wrote:
> @@ -162,6 +206,16 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>                 goto clk_dis_ahb;
>         }
> 
> +#if defined(CONFIG_IOMMU_SUPPORT)
> +       sdhci_arasan->domain = iommu_domain_alloc(&amba_bustype);
> +       if (!sdhci_arasan->domain) {
> +               dev_err(&pdev->dev, "Unable to allocate iommu domain\n");
> +               return PTR_ERR(sdhci_arasan->domain);
> +       }
> +
> +       iommu_attach_device(sdhci_arasan->domain, &pdev->dev);
> +#endif
> +
> 

Device drivers should never care about the implementation details
of the iommu. Please change the code to use the regular dma_map_*
interfaces that will work both with and without IOMMU.

	Arnd
