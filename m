Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7CC5B1A054F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 07:12:50 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v1 1/2] mmc: host: arasan: Add addition of-arasan quirks
 and IOMMU support for arasan SDHCI driver.
Date: Tue, 27 Jan 2015 21:12:39 +0100
Message-ID: <2889598.XIWjCcRL7e@wuerfel>
In-Reply-To: <1422379260-10139-2-git-send-email-stripathi@apm.com>
References: <1422379260-10139-1-git-send-email-stripathi@apm.com>
 <1422379260-10139-2-git-send-email-stripathi@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: devicetree@vger.kernel.org, mlangsdo@redhat.com, jcm@redhat.com,
 anton@enomsg.org, linux-mmc@vger.kernel.org, chris@printf.net, patches@apm.com,
 ddutile@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 27 January 2015 22:50:59 Suman Tripathi wrote:
> @@ -174,6 +176,13 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         pltfm_host->priv = sdhci_arasan;
>         pltfm_host->clk = clk_xin;
> 
> +       ret = xgene_ahbc_iommu_attach_device(&pdev->dev);
> +       if (ret < 0 && IS_ENABLED(CONFIG_XGENE_AHBC_IOMMU)) {
> +               dev_err(&pdev->dev,
> +                       "unable to attach device to iommu %x\n", ret);
> +               goto clk_disable_all;
> +       }
> +
>         ret = sdhci_add_host(host);
>         if (ret) {
>                 dev_err(&pdev->dev, "platform register failed (%u)\n", ret);
> 

This looks wrong: the iommu should be automatically configured for devices
that need it, without any interaction from the driver.

	Arnd
