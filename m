Return-Path: <linuxppc-dev+bounces-27912-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC01EC982F1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 10:28:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpxBq1Xrkz2ygK;
	Tue, 22 Sep 2026 20:28:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790072899;
	cv=none; b=WujjglDSVYjZq2JIrR018nEPSLHqmDNxKuHIA2qEQRYJkE6j3OpurNZkkYbzBs8+kmiP6Wb6s5at+Nmvc95IKOz7eJJNljdZ/l0DGKViB7LqOyCLocQWN6/kULKlM4MJaTNe6xrjXaKAbkemJawBTsNxR0KnqpyCKydNmTQ/tQPuHlCKz4jfBcdjSt5GWQCcLwqiC/k/Q1ccbl+VRnc8GnmqOVhmgQhn4zUlqBjRYfJYezxfd+LCFYJROfVy7GVBx64ueNzMyNyWe6Imhkq+AXg82Hfxh5fzbfgwOMbGGeBSQXKkGlYbvYXA3E7EKKZmgFa19Evt68HPGWHmRD0Cng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790072899; c=relaxed/relaxed;
	bh=LOJp4blY5phc9Vv5SsCAuVuk6WuoBNzFXQ+AbRV2dCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=indFTS7Zj5TwZzkNyeAbUteU3BRnduqNRtgNuwSBAzd5tADDbogyiGkZyj3W55rQKfvU/ipkmcEfyr9VpvBcctFtRpOgGYAdNYw/2Ee7FrDUzr/mM3750pyg2jf2OWBqTm1D6Hy32CEsUdR4SJc8a6QajPcRqcrXIawZ4OCAtg+brhFQcTSEU67vK95my58t4lUI28p1AzJ0wPY7LsxfLxWCp7YAzGM8I2qze0nbTSKnBr0cFYcdv80ojmhvkNMBI6F3KLEGmgFy/awrJ119X7DsFYzJCU5dx/D7vZatexzn+pSNAnyVI4qQaZ7Jr4172G/CZnUpD72SECTd7iXFDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnYBUmgR; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnYBUmgR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpxBp1DKXz2yQJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 20:28:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 87568601F7;
	Tue, 22 Sep 2026 10:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6371F000FF;
	Tue, 22 Sep 2026 10:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790072895;
	bh=LOJp4blY5phc9Vv5SsCAuVuk6WuoBNzFXQ+AbRV2dCA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fnYBUmgRgs+DrsVZ4E7rNjAcBrnd55YcN/xtuScQWsatNfiAK8CaVLVsalX3VbpUU
	 eNkioZbKquxGIoNHlQ7nqM0jpOUdzZH0J+duAdiQESUtuvBz/gRJVJju43DDfkdx0c
	 gZzSSLz63VkeapKrh7dhYaDqtES+j9Avm5vKFp9sITBwDo2tVuZCqh99EQfBo6szyV
	 qCRg19zxrNl9cSUSFHHdaN1c7FR3ysLbmT0alDo2qHpi5LIuANCwx6XPf+Kr2GU1R1
	 NfnYw5z5if634DwpeVaRGRJoOiBF2kD9dDlQYp1JLCqMUBW7iuBvt8l54XN1v6Mmmr
	 kQ2acyT8DnXww==
Message-ID: <0a35cf00-32ba-4a21-b05c-edd44d3ca219@kernel.org>
Date: Tue, 22 Sep 2026 12:28:12 +0200
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
Subject: Re: [PATCH] soc: fsl: qbman: order the probed flags with
 release/acquire
To: jaidevshastri@vt.edu
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260921-mb-qbman-v1-1-35f3321aa330@vt.edu>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260921-mb-qbman-v1-1-35f3321aa330@vt.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Le 22/09/2026 à 02:47, Jaidev Shastri via B4 Relay a écrit :
> [Vous ne recevez pas souvent de courriers de devnull+jaidevshastri.vt.edu@kernel.org. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Jaidev Shastri <jaidevshastri@vt.edu>
> 
> dpaa_eth, caam and the portal drivers poll qman_is_probed(),
> bman_is_probed(), qman_portals_probed() and bman_portals_probed() before
> they touch the state the probe functions set up: qman_ip_rev, the CCSR
> and portal register maps, the FQD and PFDR bases, affine_portals and the
> pool allocators.
> 
> Each flag is set with a plain store at the end of its probe function and
> read with a plain load in the exported accessor. The stores that build
> the state are not ordered before the store to the flag, and the
> consumer's load of the flag is not ordered before its loads of the
> state. A consumer probing on another CPU can see the flag set and then
> read state that is still stale or zeroed, and program the hardware with
> it.
> 
> Set the flags with smp_store_release() and read them with
> smp_load_acquire(). The error paths storing -1 keep their plain stores:
> a consumer that sees -1 fails its own probe without touching the state.
> 
> Found with MBCheck, a static herd7-based memory consistency checker.

Sashiko made comments, can you have a look ?

https://sashiko.dev/#/patchset/20260921-mb-qbman-v1-1-35f3321aa330@vt.edu

Christophe

> 
> Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
> ---
>   drivers/soc/fsl/qbman/bman_ccsr.c   |  6 ++++--
>   drivers/soc/fsl/qbman/bman_portal.c |  6 ++++--
>   drivers/soc/fsl/qbman/qman_ccsr.c   | 11 +++++++++--
>   drivers/soc/fsl/qbman/qman_portal.c |  6 ++++--
>   4 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c b/drivers/soc/fsl/qbman/bman_ccsr.c
> index b0f26f6f7..c5be35aba 100644
> --- a/drivers/soc/fsl/qbman/bman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/bman_ccsr.c
> @@ -180,7 +180,8 @@ static irqreturn_t bman_isr(int irq, void *ptr)
> 
>   int bman_is_probed(void)
>   {
> -       return __bman_probed;
> +       /* Pairs with smp_store_release() in fsl_bman_probe(). */
> +       return smp_load_acquire(&__bman_probed);
>   }
>   EXPORT_SYMBOL_GPL(bman_is_probed);
> 
> @@ -279,7 +280,8 @@ static int fsl_bman_probe(struct platform_device *pdev)
>                  return ret;
>          }
> 
> -       __bman_probed = 1;
> +       /* Order bm_ccsr_start, bman_ip_rev and the pool allocator before the flag. */
> +       smp_store_release(&__bman_probed, 1);
> 
>          return 0;
>   };
> diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
> index 4d7b9caee..056fe3fbb 100644
> --- a/drivers/soc/fsl/qbman/bman_portal.c
> +++ b/drivers/soc/fsl/qbman/bman_portal.c
> @@ -90,7 +90,8 @@ static int bman_online_cpu(unsigned int cpu)
> 
>   int bman_portals_probed(void)
>   {
> -       return __bman_portals_probed;
> +       /* Pairs with smp_store_release() in bman_portal_probe(). */
> +       return smp_load_acquire(&__bman_portals_probed);
>   }
>   EXPORT_SYMBOL_GPL(bman_portals_probed);
> 
> @@ -157,7 +158,8 @@ static int bman_portal_probe(struct platform_device *pdev)
>          spin_lock(&bman_lock);
>          cpu = cpumask_first_zero(&portal_cpus);
>          if (cpu >= nr_cpu_ids) {
> -               __bman_portals_probed = 1;
> +               /* All CPU-bound portals are initialised and in affine_bportals. */
> +               smp_store_release(&__bman_portals_probed, 1);
>                  /* unassigned portal, skip init */
>                  spin_unlock(&bman_lock);
>                  goto check_cleanup;
> diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
> index aa5348f49..b46cfb964 100644
> --- a/drivers/soc/fsl/qbman/qman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/qman_ccsr.c
> @@ -711,7 +711,8 @@ static int qman_resource_init(struct device *dev)
> 
>   int qman_is_probed(void)
>   {
> -       return __qman_probed;
> +       /* Pairs with smp_store_release() in fsl_qman_probe(). */
> +       return smp_load_acquire(&__qman_probed);
>   }
>   EXPORT_SYMBOL_GPL(qman_is_probed);
> 
> @@ -864,7 +865,13 @@ static int fsl_qman_probe(struct platform_device *pdev)
>          if (ret)
>                  return ret;
> 
> -       __qman_probed = 1;
> +       /*
> +        * Publish the flag only after every store made above (qman_ip_rev,
> +        * qm_ccsr_start, the FQD/PFDR bases, the work queue) is visible to
> +        * the consumers that poll qman_is_probed() and then call into
> +        * qman_set_sdest(), qman_liodn_fixup(), qman_alloc_*().
> +        */
> +       smp_store_release(&__qman_probed, 1);
> 
>          return 0;
>   }
> diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> index 456ef5d5c..181c0f373 100644
> --- a/drivers/soc/fsl/qbman/qman_portal.c
> +++ b/drivers/soc/fsl/qbman/qman_portal.c
> @@ -175,7 +175,8 @@ static int qman_online_cpu(unsigned int cpu)
> 
>   int qman_portals_probed(void)
>   {
> -       return __qman_portals_probed;
> +       /* Pairs with smp_store_release() in qman_portal_probe(). */
> +       return smp_load_acquire(&__qman_portals_probed);
>   }
>   EXPORT_SYMBOL_GPL(qman_portals_probed);
> 
> @@ -251,7 +252,8 @@ static int qman_portal_probe(struct platform_device *pdev)
>          spin_lock(&qman_lock);
>          cpu = cpumask_first_zero(&portal_cpus);
>          if (cpu >= nr_cpu_ids) {
> -               __qman_portals_probed = 1;
> +               /* All CPU-bound portals are initialised and in affine_portals. */
> +               smp_store_release(&__qman_portals_probed, 1);
>                  /* unassigned portal, skip init */
>                  spin_unlock(&qman_lock);
>                  goto check_cleanup;
> 
> ---
> base-commit: 93f51579e7df248780214094418f205253383cc5
> change-id: 20260921-mb-qbman-84f56ef0f84c
> 
> Best regards,
> --
> Jaidev Shastri <jaidevshastri@vt.edu>
> 
> 


