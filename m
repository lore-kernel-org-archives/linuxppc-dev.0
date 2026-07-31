Return-Path: <linuxppc-dev+bounces-25183-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4929FC55167
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 16:33:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBWpV3kT7z2xwH;
	Sat, 01 Aug 2026 02:33:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785515602;
	cv=none; b=DOOHiTfhToOLiG5LmPFwzOAOATn6oB0rY3vhbJfnrkYvHNbrqxxB7y3AERnOb7TT0QHYDOqJZ3ffG1g0vUG+oyx049DqI0a6Rzk6WOQNbmoHD7q6yOlOpXxNVnFpVF1tFQ0PTib/9TkB2vRexZgm5wa+YwGy+God86dJUzf9PIWbXcZdsXpptl0Ei3MmF4GIB2essa02dEK4qsg73MevdSnvqiySxyLZSOgC1hZIaPuEC4dG/LjGEZI1EkHLUSdJw/PLn5svt5EVCoJWE22BmRjjGXxS2oGMKt4eKaTTi1QrEIMFRbTxcUdllmH8Ec+/kW1YRPvVrnVO+TgnnWCEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785515602; c=relaxed/relaxed;
	bh=/c2xE4Q1GHJ/mqVHkaThC+7dYDFsHbOzMkNSJtNffwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCB3QifwUlwEie+OsC6R/tzp62LiUMAaPXLwrkROWtSg5wULwGP6o+IZBNpRuAWgpp1O3P64yDCSZlKpx3vrJUyLKNo9Z+J4XGUnypGCzl+kMYE2BvlTHZHKC02bY3PtcdoWaYfDMdRfJrMiFKxEz7asMGTQ21fpeVgcnyLrdhn2MuAFC1B+P70I61n1v5eT09+yh7Rta1wVLFtcZnIwLY7Q1g2H5wveFovSUbQAc8K0z/NfgpSZZSRs29U+rU48+pDqL5ZhK+9ChH1Mi2OAi6ZHbAl1roXwGYkNIBaXCAq5hXM34j4iuoF1dBKz0XpsesCBOF9t6LnVv4v9YCtZNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kg0a8RDD; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kg0a8RDD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBWpT3kS0z2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Aug 2026 02:33:21 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 255BE6004E;
	Fri, 31 Jul 2026 16:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9501F00ADE;
	Fri, 31 Jul 2026 16:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785515597;
	bh=/c2xE4Q1GHJ/mqVHkaThC+7dYDFsHbOzMkNSJtNffwA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Kg0a8RDD7QfMtew/PR4BdIHIDRZGAzCtHMIATEiiGxTA5E2k/gTNJN1MY+evfPqbp
	 YdQKX0ioNHBk5WY6n2vSo9ajrzKXbgjd1vkBnAJAaNVH6sSRr7nCpxNtorDamvn3ut
	 eIFa6Vp6hR3eBUMSvyqsKEDarD/3rUUkuewYKBAlcodItXgYdbeLIF3vKtw5fLkiAQ
	 lKtfauTNg1lKtN4Ir8toqOh3T8Qcs9cnIdCHwXCNBFTa1ZRDPsSWFI5NaOIQa7Srth
	 pQQigad18myCthmgRlII3SytOSo+OGux0VgAtKhG4r1Z4rVJfsL/IX4i/o9KOel9wh
	 pn+FsaN+OPrWQ==
Message-ID: <53f0b244-9461-4402-a5e7-b54d7ec3e09d@kernel.org>
Date: Fri, 31 Jul 2026 18:33:11 +0200
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
Subject: Re: [PATCH] Connecting the SB600's i8259 controller rather in
 pasemi's pci.c than in pasemi's setup.c.
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Cc: "R.T.Dickinson" <rtd2@xtra.co.nz>, mad skateman <madskateman@gmail.com>,
 Damien Stewart <hypexed@yahoo.com.au>,
 Darren Stevens <darren@stevens-zone.net>,
 Christian Zigotzky <info@xenosoft.de>
References: <20260701125941.906-2-chzigotzky@xenosoft.de>
 <656742f7-ff8f-43f5-829d-5b5f0f6c8c95@kernel.org>
 <f5ed5a79-4235-31b6-5bd9-c68d1a6b50cf@xenosoft.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <f5ed5a79-4235-31b6-5bd9-c68d1a6b50cf@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 28/07/2026 à 14:50, Christian Zigotzky a écrit :
> On 27/07/26 15:43, Christophe Leroy (CS GROUP) wrote:
>  >
>  > Should be better in arch/powerpc/platforms/pasemi/pasemi.h
>  >
> 
> Hello Christophe,
> 
> Thank you for your answer. I modified the patch today. The Nemo board 
> boots without any problems if I compile the RC5 of kernel 7.2 with this 
> patch.
> 
> Could you please check the following modified patch?

b4 doesn't see it as a patch. Can you resend as a regular patch ?

$ b4 shazam --single-message 
f5ed5a79-4235-31b6-5bd9-c68d1a6b50cf@xenosoft.de
Single-message mode, ignoring any follow-ups
Grabbing thread from 
lore.kernel.org/all/f5ed5a79-4235-31b6-5bd9-c68d1a6b50cf@xenosoft.de/t.mbox.gz
Analyzing 1 messages in the thread
No patches found.

Thanks
Christophe

> 
> Thanks,
> Christian
> 
> ---
> 
> powerpc/pasemi: Move Nemo i8259 initialization to pci.c
> 
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
> Suggested-by: Darren Stevens <darren@stevens-zone.net>
> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> 
> ---
> v2:
> - Move Nemo i8259 initialization out of pas_init_IRQ() and into
>    pas_add_bridge() after the ISA bridge has been discovered.
> - Change nemo_init_IRQ() to no longer depend on the MPIC instance passed
>    from the IRQ setup path.
> - Move the nemo_init_IRQ() declaration to pasemi.h and add a no-op stub
>    for non-Nemo builds.
> - Fix missing prototype warning reported by Christophe Leroy.
> - Fix indentation and clean up the commit message.
> 
> diff -rupN a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/ 
> platforms/pasemi/pasemi.h
> --- a/arch/powerpc/platforms/pasemi/pasemi.h    2026-07-26 
> 23:45:48.000000000 +0200
> +++ b/arch/powerpc/platforms/pasemi/pasemi.h    2026-07-28 
> 07:44:31.924168227 +0200
> @@ -7,6 +7,12 @@ extern void pas_pci_init(void);
>   struct pci_dev;
>   extern void pas_pci_dma_dev_setup(struct pci_dev *dev);
> 
> +#ifdef CONFIG_PPC_PASEMI_NEMO
> +extern void __init nemo_init_IRQ(void);
> +#else
> +static inline void __init nemo_init_IRQ(void) { }
> +#endif
> +
>   void __iomem *__init pasemi_pci_getcfgaddr(struct pci_dev *dev, int 
> offset);
> 
>   extern void __init pasemi_map_registers(void);
> diff -rupN a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/ 
> platforms/pasemi/pci.c
> --- a/arch/powerpc/platforms/pasemi/pci.c    2026-07-26 
> 23:45:48.000000000 +0200
> +++ b/arch/powerpc/platforms/pasemi/pci.c    2026-07-28 
> 07:34:37.036634023 +0200
> @@ -265,6 +265,11 @@ static int __init pas_add_bridge(struct
>        */
>       isa_bridge_find_early(hose);
> 
> +    /*
> +     * ISA bridge is now active, add the i8259 cascade (if needed)
> +     */
> +    nemo_init_IRQ();
> +
>       return 0;
>   }
> 
> diff -rupN a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/ 
> platforms/pasemi/setup.c
> --- a/arch/powerpc/platforms/pasemi/setup.c    2026-07-26 
> 23:45:48.000000000 +0200
> +++ b/arch/powerpc/platforms/pasemi/setup.c    2026-07-28 
> 07:54:54.147863161 +0200
> @@ -214,10 +214,12 @@ static void sb600_8259_cascade(struct ir
>       chip->irq_eoi(&desc->irq_data);
>   }
> 
> -static void __init nemo_init_IRQ(struct mpic *mpic)
> +void __init nemo_init_IRQ(void)
>   {
>       struct device_node *np;
>       int gpio_virq;
> +    struct mpic *mpic;
> +
>       /* Connect the SB600's legacy i8259 controller */
>       np = of_find_node_by_path("/pxp@0,e0000000");
>       i8259_init(np, 0);
> @@ -228,14 +230,10 @@ static void __init nemo_init_IRQ(struct
>       irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
>       mpic_unmask_irq(irq_get_irq_data(gpio_virq));
> 
> +    mpic = irq_get_chip_data(gpio_virq);
>       irq_set_default_domain(mpic->irqhost);
>   }
> 
> -#else
> -
> -static inline void nemo_init_IRQ(struct mpic *mpic)
> -{
> -}
>   #endif
> 
>   static __init void pas_init_IRQ(void)
> @@ -297,9 +295,7 @@ static __init void pas_init_IRQ(void)
>           irq_set_irq_type(nmi_virq, IRQ_TYPE_EDGE_RISING);
>           mpic_unmask_irq(irq_get_irq_data(nmi_virq));
>       }
> -
> -    nemo_init_IRQ(mpic);
> -
> +
>       of_node_put(mpic_node);
>       of_node_put(root);
>   }
> 
> 
> 


