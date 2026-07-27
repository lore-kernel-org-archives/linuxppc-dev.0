Return-Path: <linuxppc-dev+bounces-24899-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16210C53209
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 13:43:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h80DC3yJBz2yhD;
	Mon, 27 Jul 2026 23:43:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785159803;
	cv=none; b=Vz3wIcxomGHQB0Ste7awCQ+pADK5Kf3YCuhuuH6ZqU4+cVczrkPlMl4AGuBmOm/4+Yd4oXiVRLGKS+43r+UcsTVCwyRabBckVS6bMzfFZK6Msr8ZT/vfZg89oFmkEUjDMGvcOlokaE3NF4Y8UAQtTl0MuVyMM2Xh2ZNbtuEzhmh21/jzYJsr4hWBsXanNNxJGmgrotg3dPXKhSp7x50/3KQP+XNQUVJaA/rZjd2W/9LtuhR9eXIlL44efMcodh8rzw1vklye0QV4odTLxpoM9Vguh7Qiemlgqjc4pL1/e8ONoHelNm8LnOtGyzx+wjERAOcvVJE453rMZQWsB119mA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785159803; c=relaxed/relaxed;
	bh=XqTzIB28UyZ9XktoS/dXmviQH4du7TagFHFSIWMHFIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d7l+UXT3phlUOY7e7JFalRYVifBAiK3wZ2qfLU+qHv6z6yX+nAI+cQLmz9vhwBTLn5vxmDf4lC6izqAwNMtN47+VUXTeUo8D9Pz6BsMiIpUVZViURkLqHwrZixNTPfjDvsC/1xXm8Lryop2CGc6y/JHqmpKxKd3yJWZ3GerVmh0dPcoCrosIKYAimkBYe6RtVUboomS+KpLl0yD2+bJO9Qx18GYOaQ8V0pwwm6ikzl0bl/g5WNL66JliZz193M/oF7vWVF3zaEkMKurVj+JES9UdKN2ATOmnwsOMefH6jzG99GnRsp0apEyNHxG/kH/4BQcwCNFZlofKo7wEbL6sjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=itBGQXrX; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=itBGQXrX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h80DB2tQjz2ygn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 23:43:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4929D600AA;
	Mon, 27 Jul 2026 13:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1951F000E9;
	Mon, 27 Jul 2026 13:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785159799;
	bh=XqTzIB28UyZ9XktoS/dXmviQH4du7TagFHFSIWMHFIw=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=itBGQXrXR2C9tJccpAbDWMBmiTkYEZLX9blV4pjDfunPCPov1cdlqFO96d2kfpTKO
	 4TiHUy9RtgdQTcP16zrznZjxJ4YILkeisEiTMMPdIdPIeGAMfXvlmV2895SUnJe3Rx
	 ySb8EJe3kY+Iv43/KWSbnCcD6GlsAt2VHyVM6EnOZiSRoCpT/khiMGxCUi2ItjY0yd
	 mf0ocYI2NOCfzbbyqL4xsHLk/hwXJnXwFGcfae4o9MBlG3/1obZeBqjOVCIbxKGPoM
	 aES9DO0NQVQApj2MnfM6oGBlRAn6H33+8AwQzdgtfeyouiea/h2zU7lUvJWDyZRium
	 zd0/qFqFhpEDw==
Message-ID: <656742f7-ff8f-43f5-829d-5b5f0f6c8c95@kernel.org>
Date: Mon, 27 Jul 2026 15:43:16 +0200
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
References: <20260701125941.906-2-chzigotzky@xenosoft.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260701125941.906-2-chzigotzky@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 01/07/2026 à 14:59, Christian Zigotzky a écrit :
> Hello,
> 
> Here is the email without HTML (Sorry):
> 
> The Nemo board [1] doesn’t boot without this patch. Darren explained it really well:
> 
> Originally we initialised the PCI-e ports in setup arch, this is quite early, and it seems uses some kernel functions that were not recommended (They changed a whole lot of different platforms at the same time for the same reason)
> 
> After this we added the ISA bridge, then the kernel would init the IRQ contollers.
> 
> The patch that broke booting on the X1000 moved the pas_pci_init to a node in the machine description, where it called later in the boot sequence. Unfortunately this is after we've tried to add the i8259 contoller from the pas_init_IRQ. Since our ISA bridge can't be found until we've connected the PCI-e ports the system tries to write to registers that aren't yet mapped - result a kernel panic, but before console I/O has been initialised so it appears to be a hang. We had a similar problem when they were introducing Radix support.
> 
> My patch changes our code so that it works with the new kernel code in place. Basically I moved the code that adds the i8259 cascade to after we've scanned for the ISA bridge where I know it will work.
> 
> Hopefully this makes sense, shout out if it doesn't.
> 
> Regards
> Darren
> 
> [1] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FAmigaOne_X1000&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cb415e9e7a26c4d8e3c6b08ded770c1b7%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639185077045605675%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C60000%7C%7C%7C&sdata=EgGtT9Kj7aqkWWcIIxfPpYRulro8rUA%2F%2Bsp9bhy%2Bjqo%3D&reserved=0
> 
> Signed-off-by: Christian Zigotzky <chzigotzky@xenosoft.de>


The commit message will look strange when picking-up this email, you 
should resend with a cleaned commit message.

> ---
>   arch/powerpc/platforms/pasemi/pci.c   | 7 +++++++
>   arch/powerpc/platforms/pasemi/setup.c | 7 ++++---
>   2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
> index 2df955274652..7208c325bfc5 100644
> --- a/arch/powerpc/platforms/pasemi/pci.c
> +++ b/arch/powerpc/platforms/pasemi/pci.c
> @@ -25,6 +25,8 @@
>   
>   #define PA_PXP_CFA(bus, devfn, off) (((bus) << 20) | ((devfn) << 12) | (off))
>   
> +extern void nemo_init_IRQ(void);
> +

Should be better in arch/powerpc/platforms/pasemi/pasemi.h

>   static inline int pa_pxp_offset_valid(u8 bus, u8 devfn, int offset)
>   {
>   	/* Device 0 Function 0 is special: It's config space spans function 1 as
> @@ -265,6 +267,11 @@ static int __init pas_add_bridge(struct device_node *dev)
>   	 */
>   	isa_bridge_find_early(hose);
>   
> +	/*
> +	 * ISA brigde is now active, add the i8259 cascade (if needed)
> +	 */
> +	nemo_init_IRQ();
> +
>   	return 0;
>   }
>   
> diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
> index d03b41336901..eec74611be46 100644
> --- a/arch/powerpc/platforms/pasemi/setup.c
> +++ b/arch/powerpc/platforms/pasemi/setup.c
> @@ -214,10 +214,12 @@ static void sb600_8259_cascade(struct irq_desc *desc)
>   	chip->irq_eoi(&desc->irq_data);
>   }
>   
> -static void __init nemo_init_IRQ(struct mpic *mpic)
> +void nemo_init_IRQ(void)
>   {
>   	struct device_node *np;
>   	int gpio_virq;
> +        struct mpic *mpic;
> +
>   	/* Connect the SB600's legacy i8259 controller */
>   	np = of_find_node_by_path("/pxp@0,e0000000");
>   	i8259_init(np, 0);
> @@ -228,6 +230,7 @@ static void __init nemo_init_IRQ(struct mpic *mpic)
>   	irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
>   	mpic_unmask_irq(irq_get_irq_data(gpio_virq));
>   
> +	mpic = irq_get_chip_data(gpio_virq);
>   	irq_set_default_domain(mpic->irqhost);
>   }
>   
> @@ -298,8 +301,6 @@ static __init void pas_init_IRQ(void)
>   		mpic_unmask_irq(irq_get_irq_data(nmi_virq));
>   	}
>   
> -	nemo_init_IRQ(mpic);
> -
>   	of_node_put(mpic_node);
>   	of_node_put(root);
>   }

Build fails:

   CC      arch/powerpc/platforms/pasemi/setup.o
arch/powerpc/platforms/pasemi/setup.c:217:6: error: no previous 
prototype for 'nemo_init_IRQ' [-Werror=missing-prototypes]
   217 | void nemo_init_IRQ(void)
       |      ^~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[5]: *** [scripts/Makefile.build:289: 
arch/powerpc/platforms/pasemi/setup.o] Error 1
make[4]: *** [scripts/Makefile.build:549: arch/powerpc/platforms/pasemi] 
Error 2
make[3]: *** [scripts/Makefile.build:549: arch/powerpc/platforms] Error 2
make[2]: *** [scripts/Makefile.build:549: arch/powerpc] Error 2
make[1]: *** [/home/chleroy/linux-powerpc/Makefile:2184: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2


