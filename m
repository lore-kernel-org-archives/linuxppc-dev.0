Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1214C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 06:08:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE4820830
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 06:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="Q7ulQUDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE4820830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PKHM6h6kzDqMV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 17:08:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="Q7ulQUDS"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PK8818YZzDqCD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 17:02:32 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id q206so967847pgq.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 23:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IGxg7qPTH1XRndaxGBBC9B5LWSDIxp+rcCH50HMqYLg=;
 b=Q7ulQUDSeB/ZNeFewMQg34C3C8wJj6SJF5wfRslYtcYjjAG7hoMexpnOP1E9YRtC1d
 Spd3psAtz+hCYMgu4TeKA1Iz/h7gBnmSAzBpoCQBESQf1Qqd3kpy4wHTnm6Fuqn3dLJO
 c0yI2IdzxKX9UQnps8gznhx/DfJANPLNL8yb8nM9W9Kj3nCsAW5e9JzR3dQk4OdWij89
 Qa7zMD0SCgQmV9W8X0jIv+G8lFzRQrL1KfSgZejRILAL3WWzzjmBW51X24azIolI9VQp
 gccc/sqi+F0NZcTNydtg27mavQcVLwyBpXaGmg06YwdT5ysu3B8I0GRCT59K94JyW2b1
 zFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=IGxg7qPTH1XRndaxGBBC9B5LWSDIxp+rcCH50HMqYLg=;
 b=J9Z1PY32UGGuG1HQQE/h595kakbmVS4wyiogJxY0NKbuA3bJGwFSWd7zWyXqZcA5ye
 q81NtS+6TsHS/DRaIxnYGzEntnaP26p24wFskDo7/CFMqcJ2TOk4iPpb/kplNfPu4Fl3
 Dv+LPq/dpUbq4TdKMVs2o3dqkF7LfUgW9XVQoo6VSv9OidPEg3sVC9EIjv9PJbteKKNf
 ZHklfs67pSoeAW6j8mRUszkfWXUQkLqLaOC2uxVD9upefZShrRYOMs80TclC/i85df9D
 lNNk2AXwH6+UXlckcdxFlfSfRlfxVWHxN1tWYCeLRI5tDqWBejMNDq+NZobzX3UdXqIS
 2/UQ==
X-Gm-Message-State: APjAAAUrUYeGOuMofIyp9leh2QLLXmZUOVWm8WuGMWv3mHJgpQ1ttm9y
 pxyFrYi2iJ/pNTALidne404qciyLo+s=
X-Google-Smtp-Source: APXvYqwhoe3HLqYygWNmSjeKBhjbOa3k3XWEcklHIy15NEHUMGigO0DCo8CJ8PJzI0Vi3wjz40OIvw==
X-Received: by 2002:a63:cd03:: with SMTP id i3mr27160620pgg.172.1553061750336; 
 Tue, 19 Mar 2019 23:02:30 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id l84sm1901146pfb.113.2019.03.19.23.02.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Mar 2019 23:02:29 -0700 (PDT)
Subject: Re: [PATCH 4/8] powerpc/eeh: Improve debug messages around device
 addition
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <cover.1553050609.git.sbobroff@linux.ibm.com>
 <7ae025867a92715bb6fe253834211e2745f53787.1553050609.git.sbobroff@linux.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <aeb1be46-2846-7e26-1585-dc32159a1aee@ozlabs.ru>
Date: Wed, 20 Mar 2019 17:02:26 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <7ae025867a92715bb6fe253834211e2745f53787.1553050609.git.sbobroff@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 20/03/2019 13:58, Sam Bobroff wrote:
> Also remove useless comment.

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

> 
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> ---
>  arch/powerpc/kernel/eeh.c                    |  2 +-
>  arch/powerpc/platforms/powernv/eeh-powernv.c | 14 ++++++++----
>  arch/powerpc/platforms/pseries/eeh_pseries.c | 23 +++++++++++++++-----
>  3 files changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 8d3c36a1f194..b14d89547895 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -1291,7 +1291,7 @@ void eeh_add_device_late(struct pci_dev *dev)
>  	pdn = pci_get_pdn_by_devfn(dev->bus, dev->devfn);
>  	edev = pdn_to_eeh_dev(pdn);
>  	if (edev->pdev == dev) {
> -		pr_debug("EEH: Already referenced !\n");
> +		pr_debug("EEH: Device %s already referenced!\n", pci_name(dev));
>  		return;
>  	}
>  
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index f0a95f663810..51c5b6bb9b0e 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -50,10 +50,7 @@ void pnv_pcibios_bus_add_device(struct pci_dev *pdev)
>  	if (!pdev->is_virtfn)
>  		return;
>  
> -	/*
> -	 * The following operations will fail if VF's sysfs files
> -	 * aren't created or its resources aren't finalized.
> -	 */
> +	pr_debug("%s: EEH: Setting up device %s.\n", __func__, pci_name(pdev));
>  	eeh_add_device_early(pdn);
>  	eeh_add_device_late(pdev);
>  	eeh_sysfs_add_device(pdev);
> @@ -389,6 +386,10 @@ static void *pnv_eeh_probe(struct pci_dn *pdn, void *data)
>  	int ret;
>  	int config_addr = (pdn->busno << 8) | (pdn->devfn);
>  
> +	pr_debug("%s: probing %04x:%02x:%02x.%01x\n",
> +		__func__, hose->global_number, pdn->busno,
> +		PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
> +
>  	/*
>  	 * When probing the root bridge, which doesn't have any
>  	 * subordinate PCI devices. We don't have OF node for
> @@ -483,6 +484,11 @@ static void *pnv_eeh_probe(struct pci_dn *pdn, void *data)
>  	/* Save memory bars */
>  	eeh_save_bars(edev);
>  
> +	pr_debug("%s: EEH enabled on %02x:%02x.%01x PHB#%x-PE#%x\n",
> +		__func__, pdn->busno, PCI_SLOT(pdn->devfn),
> +		PCI_FUNC(pdn->devfn), edev->pe->phb->global_number,
> +		edev->pe->addr);
> +
>  	return NULL;
>  }
>  
> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> index 7aa50258dd42..ae06878fbdea 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> @@ -65,6 +65,8 @@ void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
>  	if (!pdev->is_virtfn)
>  		return;
>  
> +	pr_debug("%s: EEH: Setting up device %s.\n", __func__, pci_name(pdev));
> +
>  	pdn->device_id  =  pdev->device;
>  	pdn->vendor_id  =  pdev->vendor;
>  	pdn->class_code =  pdev->class;
> @@ -251,6 +253,10 @@ static void *pseries_eeh_probe(struct pci_dn *pdn, void *data)
>  	int enable = 0;
>  	int ret;
>  
> +	pr_debug("%s: probing %04x:%02x:%02x.%01x\n",
> +		__func__, pdn->phb->global_number, pdn->busno,
> +		PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
> +
>  	/* Retrieve OF node and eeh device */
>  	edev = pdn_to_eeh_dev(pdn);
>  	if (!edev || edev->pe)
> @@ -294,7 +300,12 @@ static void *pseries_eeh_probe(struct pci_dn *pdn, void *data)
>  
>  	/* Enable EEH on the device */
>  	ret = eeh_ops->set_option(&pe, EEH_OPT_ENABLE);
> -	if (!ret) {
> +	if (ret) {
> +		pr_debug("%s: EEH failed to enable on %02x:%02x.%01x PHB#%x-PE#%x (code %d)\n",
> +			__func__, pdn->busno, PCI_SLOT(pdn->devfn),
> +			PCI_FUNC(pdn->devfn), pe.phb->global_number,
> +			pe.addr, ret);
> +	} else {
>  		/* Retrieve PE address */
>  		edev->pe_config_addr = eeh_ops->get_pe_addr(&pe);
>  		pe.addr = edev->pe_config_addr;
> @@ -310,11 +321,6 @@ static void *pseries_eeh_probe(struct pci_dn *pdn, void *data)
>  		if (enable) {
>  			eeh_add_flag(EEH_ENABLED);
>  			eeh_add_to_parent_pe(edev);
> -
> -			pr_debug("%s: EEH enabled on %02x:%02x.%01x PHB#%x-PE#%x\n",
> -				__func__, pdn->busno, PCI_SLOT(pdn->devfn),
> -				PCI_FUNC(pdn->devfn), pe.phb->global_number,
> -				pe.addr);
>  		} else if (pdn->parent && pdn_to_eeh_dev(pdn->parent) &&
>  			   (pdn_to_eeh_dev(pdn->parent))->pe) {
>  			/* This device doesn't support EEH, but it may have an
> @@ -323,6 +329,11 @@ static void *pseries_eeh_probe(struct pci_dn *pdn, void *data)
>  			edev->pe_config_addr = pdn_to_eeh_dev(pdn->parent)->pe_config_addr;
>  			eeh_add_to_parent_pe(edev);
>  		}
> +		pr_debug("%s: EEH %s on %02x:%02x.%01x PHB#%x-PE#%x (code %d)\n",
> +			__func__, (enable ? "enabled" : "unsupported"),
> +			pdn->busno, PCI_SLOT(pdn->devfn),
> +			PCI_FUNC(pdn->devfn), pe.phb->global_number,
> +			pe.addr, ret);
>  	}
>  
>  	/* Save memory bars */
> 

-- 
Alexey
