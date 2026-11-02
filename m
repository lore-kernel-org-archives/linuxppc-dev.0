Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18074606A324
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 03:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ha3W1NZf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHyBC3ZFkz2y8Z;
	Mon, 02 Nov 2026 14:39:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793590771;
	cv=none; b=oUJ18yvtOPCLaPcAWDmHgOBrLwNQkWglWGscBXCPFEqrTFN9bdqJAq7yBEJwXyNUdSUyx1BsthunzHhTCE/XWVevzYpdIk8pjGG5j5P25lb8NgA+16ZLNSt5MOvRcqzfrl1FdH4pg9+9raBXJzXijoY0/faP+paSYaqS3GOG0FqyyNHkc6zVfYb90n/5i0CrxdDgyUbxsUOSPk5rfI78UGL6EOqveOaXJI2EPAM6blYaFC+NVOKI0eEF2Mgwebf0VPpxx27qvUAGM+s0oMmRjl76db3gW/N0AIPfOiZem+8J4/DEYPa9/vPZTlvIupn073lSEa3/wbe9NJM0nnaiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793590771; c=relaxed/relaxed;
	bh=ip0P9/T6/Rg8PD1u8QGcPkjDOKojP0U7oGZdcSPG1BA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=C+7h/1dv1fqo5ZRB7nX/2AZjEp7tgkR+SFQBBB+Bhc+zqmZmWL/dWgjG4uuhSXhKv5fQHpHsfzQWhSEXBA5RXZlIS5wmvlAAfHci2+PWctG5YjUzrHY482KzSuLiqVhg9714btJySf5V6XyMxeTg9Rakm7imOmeC1wqVHavxj99UZ1dulAIokKZwQwA3WlJ1SvQLJO3HqZH8xgPh9hMD88JkNWB9bicuus0VFO64X+45bm4gM6ZrjdPWQ6IktM9mssHIBgVGeiBk4fpZiwL9d4ap28kUVaw9zG+OmU96Ph999G36wS3UKN73p+I2HHjEd3jjafjY/95mf8omLL3BkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ha3W1NZf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ha3W1NZf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122a.google.com (mail-dl1-x122a.google.com [IPv6:2607:f8b0:4864:20::122a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHyBB0jNjz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 14:39:29 +1100 (AEDT)
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-14fc585291cso1944838c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 19:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793590767; x=1794195567; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ip0P9/T6/Rg8PD1u8QGcPkjDOKojP0U7oGZdcSPG1BA=;
        b=ha3W1NZfedN4YIdYZvNZwJ7k/ycoTQwHK7+71nkQYn7dhv30A8xSF9NtVfKjpNjBlZ
         oJL1SKMaLo7BFs8SXolYTJmQubv+VOO0Sk0s8wnQ9qvg0ZxlHuRHgSwMhpS2Z514fvWy
         MpWPqYcN3EXaiIg/eXvC0w8NBpNIm2/uIGElHorye89oC+Jvg2wgHJ669lBuluetVMZz
         cHQHmhl48sPxQQcl+lKcdEqb8lJ5h+lNCJSx/ZU32HyAJTmum27BVapKWUzXpuZifLeA
         XpN+E0xGbpNVDP4YYdopFX0mLdmC3F5sLQ+gMkNsRMj5KTsROGz3CStnZkP8yJD/tjFj
         sEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793590767; x=1794195567;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ip0P9/T6/Rg8PD1u8QGcPkjDOKojP0U7oGZdcSPG1BA=;
        b=FwA5/AWK7oSal5w9O+QK3pi+T0r37tUEikh+ZM9LGj02+DBiNORI9LFVUXVvzJDNsY
         aFn0heb9n3tZY02TXjBreCbLEbgQeSUiElre6M8KYbtJRInvj74UcvUpSftEzp/IfuIc
         YcAb5jRP4cZ3NzDP50dN3IJUheUbnN9vw1nU5EdMLO7yxO4YoYPSrRwTpBZKBMocBmdN
         zwrMc/EBBS1/F45ZbRfdm2No4bdUkBNbfxoEc4G5au+FazEFZGUGgjNgQuXr+fxA8SgB
         MP0MSI5SZpavUo75Y+ihGkz5VBO5bnJ8kMQUxz2CobIn5tmvdqZIZYtS+W6Wrcai2CGw
         MisQ==
X-Forwarded-Encrypted: i=1; AKwUvBwyLdRgnyJo/bI8S5sn+BbmphAB1cSouNnNksyrrqJVXUZ4V1oMYefA2zBrkJqa04S5X+4cXvXLdZcfnvw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIINh/cHBjuwbNfzvOXrfb/wBgTlSBdjiR8KzEQT0szkPgFQLID
	/Q1bj4hn4eOpTZEXbNT7QEZJp8/da7/+YBNQb5F/HHv14i+YrbBmt1qF
X-Gm-Gg: AYBFou10qjjYkMcn0/0Lmua6SfyQEUWsPe2jb9uJXCCarovS+JSaHmbCjSF+HAnZeMI
	GAIDDtEFHyJiZeJvt+cM0NsQc4OWaFtizNWzan3XM2v/5yqj3PGyxlcCS4CcBRoT59pANag9Wvv
	/DoxIFFO4gsQGJwGWeIvGEeMRXoaxE+bR3xg4eAPA0D/UljAvB8kkvExbvW0tV86UPj9OBBDOmb
	WlGIms4nFq9VmsCRdB+qkt/rQ7ScjztiXZBdkNYQ3N6yWauMcfk3ssMN0Pd1LYM7MrrpnwQidBA
	9XeB59/vG0FyY/ohOmRjjSuD+hh0J0grhwiSFQg1FHaeHq0BebPhOCZSE7/RarczJEYxs/lDED6
	VwApkMqGygWKrST02kmTHoekQ/Ig0uqOS4PvSY/LntvrtWbaLdk/lsPbrX2kaDxgr1EK6jrk/YX
	qansGXDh0Blq3mcM9LtxZyWkIKSOtP6Pi6VPrjktkFJb/SvLWwoKDZQh9c2h4ikcYfAOLBvRoQz
	PbaC3lfbW3CisXj5NEpOLl51RXR52RurhPnkqS/5Dtppwbo3zsgh7dRZ7O92NzglpCo1RZ3B3U9
	vVHA53HRKstfkTN9m2RjIpBFapg=
X-Received: by 2002:a05:7022:38b:b0:1aa:47e7:97e3 with SMTP id a92af1059eb24-1ac5c45fd1dmr16055742c88.15.1793590767425;
        Sun, 01 Nov 2026 19:39:27 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac192c27cdsm50365621c88.10.2026.11.01.19.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 19:39:26 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: chzigotzky@xenosoft.de, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, Christian Zigotzky A-EON Open Source <info@xenosoft.de>, Darren Stevens <darren@stevens-zone.net>, Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: [PATCH] powerpc/pasemi: Defer Nemo IRQ initialization
In-Reply-To: <20261024075519.18877-1-chzigotzky@xenosoft.de>
Date: Mon, 02 Nov 2026 09:04:49 +0530
Message-ID: <zevr6h46.ritesh.list@gmail.com>
References: <20261024075519.18877-1-chzigotzky@xenosoft.de>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>

chzigotzky@xenosoft.de writes:

> From: Christian Zigotzky A-EON Open Source <info@xenosoft.de>
>
> Since pas_pci_init() is now called later during boot, the i8259
> initialization in pas_init_IRQ() happens too early and accesses
> registers that are not yet mapped, preventing the board from booting.
>
> Move the Nemo-specific i8259 initialization to pas_add_bridge(),
> after the ISA bridge has been discovered.


That make sense to me. The patch looks good. However, shouldn't we also
add Fixes tag and Cc: stable tag - so that this gets backported to older
stable kernels.


Fixes: c144bc719234 ("powerpc/pasemi: Move PHB discovery")
Cc: stable@vger.kernel.org

I think the fixes tag should be above - but feel free to correct that.

Otherwise looks good to me. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


>
> Suggested-by: Darren Stevens <darren@stevens-zone.net>
> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Christian Zigotzky A-EON Open Source <info@xenosoft.de>
> ---
>  arch/powerpc/platforms/pasemi/pasemi.h |  6 ++++++
>  arch/powerpc/platforms/pasemi/pci.c    |  5 +++++
>  arch/powerpc/platforms/pasemi/setup.c  | 12 ++++--------
>  3 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platforms/pasemi/pasemi.h
> index 6f6743b8e48d..01bcfa258625 100644
> --- a/arch/powerpc/platforms/pasemi/pasemi.h
> +++ b/arch/powerpc/platforms/pasemi/pasemi.h
> @@ -7,6 +7,12 @@ extern void pas_pci_init(void);
>  struct pci_dev;
>  extern void pas_pci_dma_dev_setup(struct pci_dev *dev);
>  
> +#ifdef CONFIG_PPC_PASEMI_NEMO
> +void __init nemo_init_IRQ(void);
> +#else
> +static inline void __init nemo_init_IRQ(void) { }
> +#endif
> +
>  void __iomem *__init pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset);
>  
>  extern void __init pasemi_map_registers(void);
> diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
> index 2df955274652..fb53782da7ec 100644
> --- a/arch/powerpc/platforms/pasemi/pci.c
> +++ b/arch/powerpc/platforms/pasemi/pci.c
> @@ -265,6 +265,11 @@ static int __init pas_add_bridge(struct device_node *dev)
>  	 */
>  	isa_bridge_find_early(hose);
>  
> +	/*
> +	 * ISA bridge is now active, add the i8259 cascade (if needed)
> +	 */
> +	nemo_init_IRQ();
> +
>  	return 0;
>  }
>  
> diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
> index 45792ecd5dfd..7a961f2a228f 100644
> --- a/arch/powerpc/platforms/pasemi/setup.c
> +++ b/arch/powerpc/platforms/pasemi/setup.c
> @@ -216,10 +216,12 @@ static void sb600_8259_cascade(struct irq_desc *desc)
>  	chip->irq_eoi(&desc->irq_data);
>  }
>  
> -static void __init nemo_init_IRQ(struct mpic *mpic)
> +void __init nemo_init_IRQ(void)
>  {
>  	struct device_node *np;
>  	int gpio_virq;
> +	struct mpic *mpic;
> +
>  	/* Connect the SB600's legacy i8259 controller */
>  	np = of_find_node_by_path("/pxp@0,e0000000");
>  	i8259_init(np, 0);
> @@ -230,14 +232,10 @@ static void __init nemo_init_IRQ(struct mpic *mpic)
>  	irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
>  	mpic_unmask_irq(irq_get_irq_data(gpio_virq));
>  
> +	mpic = irq_get_chip_data(gpio_virq);
>  	irq_set_default_domain(mpic->irqhost);
>  }
>  
> -#else
> -
> -static inline void nemo_init_IRQ(struct mpic *mpic)
> -{
> -}
>  #endif
>  
>  static __init void pas_init_IRQ(void)
> @@ -300,8 +298,6 @@ static __init void pas_init_IRQ(void)
>  		mpic_unmask_irq(irq_get_irq_data(nmi_virq));
>  	}
>  
> -	nemo_init_IRQ(mpic);
> -
>  	of_node_put(mpic_node);
>  	of_node_put(root);
>  }
> -- 
> 2.43.0

