Return-Path: <linuxppc-dev+bounces-25586-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029FEC5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 13:52:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGlvw2yt2z3c4Y;
	Fri, 07 Aug 2026 23:52:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786110764;
	cv=none; b=f9M1RikQoY/1n/6vw4FZBloOf4AhydPh/RRs0c221SpeqN+4n9KsMA8z0WR1th2sf5rv4MmtElKNv5Lw7yZbUafXmIYto59Tm5gfZrqJiSzhzLkF5ZDVlkt6vdjAWk5GYV3JgxnWoNa8E1n42W/ku4iBi0rHg+QhDeafXa/9bNnBtk+ukSC/J/vb0ZzhJ9o4e6lInpYXx4wrWR8AX+6v20+b5gP3FaW6nCSJKgfuG+nlnjYZeq3/IcACfMvcVmc4BrjtgcwJ80E9owU29cc+Nwv1K2kkuScGLPGYI8OD6XFJI//ektnlPVIsp+UyRecxsSVgAlHM3o8kobrQL3g3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786110764; c=relaxed/relaxed;
	bh=m1S6oK7GBhrkizMAU9GvANAvxrNLBUwbzjQh2ALclu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7E/QC8uCjb3477xL0PXdbtbn5x0C52T5Y2nqdfbhcKMLdEk71q0MTSKTmzc+GmRdL2GqKR/sdi8Znl8BX3OFZogYma1JZ4Pd5GtuJ2bYaJ6vO6wFicfLovw/8ZyzJFDwDQp2du7iim4Xay0NZeFULsWXpuYMB/sjG1xxdMWEGKco2+NXX3TDrGh1cXZyg78mUj/cbTgDCRLYxPPTIPPYnBjv8x8/n/NQavP45fsKp2FlIETE1sLSMC/Nfw1ynUD7aA9x+wyhGsAAoqTAeTsa1w9spd1HIzxKyLfkQxy4mEn723EWESlWtg0N2+5feA9T4Vt2ronwoOEIAfwR6fB3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dv+UiOOu; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dv+UiOOu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGlvt673Kz3c4P
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 23:52:42 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3640D60A75;
	Fri,  7 Aug 2026 13:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB93C1F000E9;
	Fri,  7 Aug 2026 13:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786110759;
	bh=m1S6oK7GBhrkizMAU9GvANAvxrNLBUwbzjQh2ALclu4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dv+UiOOuH2RHoI13lU9hIbCRa0vwyhdr9SKTnDBkRb1CYKZze1N9eIE45t6FYDZsW
	 WA6+kQ+QtC8SmU7uyLdg0aMr2iGPeY1U1w4Flq1B9YUuquorInlfS8j+ZR5hU7ZndG
	 5odhSv6ANJFiU5josvfeYQ4RRGU4ln7KkVedX8jPM3yBXdCma0d3n6Tqexh0SAY6io
	 9jbRNTFT1zZU6aud+g63Vzi/fJDqu4sM3qVTLawerYKA3P2dPzg8k3+wanNl5Prz62
	 lNlb2O+Uma3qAyCVXcnEmm09IImuTomNjS/ZzplhurFnRNeS8O473jkcstp41tCrVy
	 0MAF94N7gqoYA==
Message-ID: <35d19b6e-5d0f-4725-89ab-2f9aaf153f1d@kernel.org>
Date: Fri, 7 Aug 2026 15:52:36 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linuxppc-dev] Patch notification: 1 patch updated
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Trevor Dickinson <rtd2@xtra.co.nz>, hypexed@yahoo.com.au
References: <178610760414.26045.11804778585802359017@legolas.ozlabs.org>
 <DB88E48F-F1CE-4A74-B7CD-A65ACE97EE53@xenosoft.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <DB88E48F-F1CE-4A74-B7CD-A65ACE97EE53@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian,

Le 07/08/2026 à 15:44, Christian Zigotzky a écrit :
> Hello,
> 
> I believe Patchwork did not fully associate the latest revision of my patch series with the previous one.

Not sure what you mean, in patchwork we have:

https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20260801043458.12500-1-chzigotzky@xenosoft.de/

So I marked following ones as been superseded by it:

https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20260701125941.906-2-chzigotzky@xenosoft.de/

https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20260701105501.2093-1-chzigotzky@xenosoft.de/

Did I miss something ?

Thanks
Christophe


> 
> Please use the following latest patch.
> 
> Thanks,
> Christian
> 
> —-
> The Nemo board requires the PCIe ports to be initialized before the
> SB600 ISA bridge can be accessed.
> 
> Since pas_pci_init() is now called later during boot, the i8259
> initialization in pas_init_IRQ() happens too early and accesses
> registers that are not yet mapped, preventing the board from booting.
> 
> Move the Nemo-specific i8259 initialization to pas_add_bridge(),
> after the ISA bridge has been discovered.
> 
> Suggested-by: Darren Stevens <darren at stevens-zone.net>
> Tested-by: Christian Zigotzky <chzigotzky at xenosoft.de>
> Signed-off-by: Christian Zigotzky <chzigotzky at xenosoft.de>
> ---
>   arch/powerpc/platforms/pasemi/pasemi.h |  6 ++++++
>   arch/powerpc/platforms/pasemi/pci.c    |  5 +++++
>   arch/powerpc/platforms/pasemi/setup.c  | 12 ++++--------
>   3 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platforms/pasemi/pasemi.h
> index 6f6743b8e48d..c37e5c684bb9 100644
> --- a/arch/powerpc/platforms/pasemi/pasemi.h
> +++ b/arch/powerpc/platforms/pasemi/pasemi.h
> @@ -7,6 +7,12 @@ extern void pas_pci_init(void);
>   struct pci_dev;
>   extern void pas_pci_dma_dev_setup(struct pci_dev *dev);
>   
> +#ifdef CONFIG_PPC_PASEMI_NEMO
> +extern void __init nemo_init_IRQ(void);
> +#else
> +static inline void __init nemo_init_IRQ(void) { }
> +#endif
> +
>   void __iomem *__init pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset);
>   
>   extern void __init pasemi_map_registers(void);
> diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
> index 2df955274652..fb53782da7ec 100644
> --- a/arch/powerpc/platforms/pasemi/pci.c
> +++ b/arch/powerpc/platforms/pasemi/pci.c
> @@ -265,6 +265,11 @@ static int __init pas_add_bridge(struct device_node *dev)
>   	 */
>   	isa_bridge_find_early(hose);
>   
> +	/*
> +	 * ISA bridge is now active, add the i8259 cascade (if needed)
> +	 */
> +	nemo_init_IRQ();
> +
>   	return 0;
>   }
>   
> diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
> index d03b41336901..c410e29414ee 100644
> --- a/arch/powerpc/platforms/pasemi/setup.c
> +++ b/arch/powerpc/platforms/pasemi/setup.c
> @@ -214,10 +214,12 @@ static void sb600_8259_cascade(struct irq_desc *desc)
>   	chip->irq_eoi(&desc->irq_data);
>   }
>   
> -static void __init nemo_init_IRQ(struct mpic *mpic)
> +void __init nemo_init_IRQ(void)
>   {
>   	struct device_node *np;
>   	int gpio_virq;
> +	struct mpic *mpic;
> +
>   	/* Connect the SB600's legacy i8259 controller */
>   	np = of_find_node_by_path("/pxp at 0,e0000000");
>   	i8259_init(np, 0);
> @@ -228,14 +230,10 @@ static void __init nemo_init_IRQ(struct mpic *mpic)
>   	irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
>   	mpic_unmask_irq(irq_get_irq_data(gpio_virq));
>   
> +	mpic = irq_get_chip_data(gpio_virq);
>   	irq_set_default_domain(mpic->irqhost);
>   }
>   
> -#else
> -
> -static inline void nemo_init_IRQ(struct mpic *mpic)
> -{
> -}
>   #endif
>   
>   static __init void pas_init_IRQ(void)
> @@ -298,8 +296,6 @@ static __init void pas_init_IRQ(void)
>   		mpic_unmask_irq(irq_get_irq_data(nmi_virq));
>   	}
>   
> -	nemo_init_IRQ(mpic);
> -
>   	of_node_put(mpic_node);
>   	of_node_put(root);
>   }


