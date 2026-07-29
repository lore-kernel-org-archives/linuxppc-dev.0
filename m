Return-Path: <linuxppc-dev+bounces-25023-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2ED2C54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 15:29:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9GTN38jgz2yDr;
	Thu, 30 Jul 2026 01:29:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785338952;
	cv=none; b=gWB7xtR3tvUfxFZlmJ8Qc3vEOi3qJ1ClDfXDhWdztmj/CYjCYcx1cAk0XQlBfd5nHe7atnruFfshFWdPVrDEMVxbdF/YEFA9ZtCnOj7EEhmIt7hv0o6Kh8L92o5RxVrGETWuUvsVeHOUkq4nZ4JE8eXpMQTdvlWg61ebbua69yTDgS1N0383sJjLhNkpXz/VbZT5ppnmFSylSS1vQNbatsmao9N7xigyfsdyKXDRQVddUQXaeghK/oNT7AEyNaP5flDj2MMpAmCtqLvPlje6ohjx/AfS/HoLveWKEYd4+m1NiF8NOYjF3tss+8Y6nuzK3czgMeQNehqmWBBSHcMNcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785338952; c=relaxed/relaxed;
	bh=pm2Nrp7Imh72FuDU5pPppeehnA/Ha/4A3yBMluiIZH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlYjtaNZx0j3btVmKFjNFVLzXlYrS2YCR0CRzf8K0r1tZshVwkScCj54nQcYxXdpwHtHUhH0mehR9rIUqwGSKEP3PeZCpW5OyxAzubTumbcyVUD4ohgI0hIz2jAH1SgkG396ClD7hI/9FJaXrkp6duJKp1WZAFFHSQ2U1Alt7kq7/LRYInzTHlsc53ua2TTDIY/nlxNa6CeHnFDdizKsAGrZfxk3wdr+iNQdBYZ0+X2tYtHCwBz1lVcHhhQPeUgfTvJt3sxU6qiZ29rVzb+HEjFS3fqk0+kDBSnjCD3zYZ2qOTh0VlOFq5GnXTZIOpADuPSmKUmLaYLYfjN2nWvVcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=yg11ygwC; dkim-atps=neutral; spf=pass (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=herve.codina@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=yg11ygwC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=herve.codina@bootlin.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 421 seconds by postgrey-1.37 at boromir; Thu, 30 Jul 2026 01:29:09 AEST
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9GTK4grYz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 01:29:08 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 413CB1A1300;
	Wed, 29 Jul 2026 15:22:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 078DB6039A;
	Wed, 29 Jul 2026 15:22:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1212C11C14FF4;
	Wed, 29 Jul 2026 17:21:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785338520; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pm2Nrp7Imh72FuDU5pPppeehnA/Ha/4A3yBMluiIZH4=;
	b=yg11ygwCPHXsInhwI2RvhudDxTtt6qLEl1eKqq9BFv4JKYR0cyKCFjigq48ct3Cm251irR
	AIinH5hNkagJFmmCnnj5ykP11y4MQFLygGr8WXWO49BZlPwhBfmxP0MNRxnT4h54t76tFd
	8Xn7hU2aNZzpEqFI3QDkrCeZzaXP4w6qIfw+2cNcm2T6Id04b0473lpx+EzBApfUV9arl8
	EmIQtWlbDs61ttvU6o19hvFVah0bxq71brHeWtFqJK7neRDSQsatDsQ2II+tD1giep4F6Y
	rODJ5gsyDSsLadzjDEWpeTRSr1cB+MGY/SbKEkeYFb1JaupdTnvIR5exOhx0EA==
Date: Wed, 29 Jul 2026 17:21:56 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>, Paul
 Louvel <paul.louvel@bootlin.com>
Subject: Re: [PATCH] soc: fsl: qe: properly scan GPIO nodes at startup
Message-ID: <20260729172156.4371a8bc@bootlin.com>
In-Reply-To: <04dc047f8958a78a920f0a88ca3bd8bf70c56187.1785333986.git.chleroy@kernel.org>
References: <04dc047f8958a78a920f0a88ca3bd8bf70c56187.1785333986.git.chleroy@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Christophe,

On Wed, 29 Jul 2026 16:10:36 +0200
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> Before commit 156460811def ("soc: fsl: qe: Change GPIO driver to a
> proper platform driver") qe_add_gpiochips() was walking the device
> tree to find all nodes with compatible "fsl,mpc8323-qe-pario-bank".
> 
> After that commit the discovery is handled by the platform core,
> therefore it is necessary to call of_platform_default_populate() on
> the par_io node.
> 
> Fixes: 156460811def ("soc: fsl: qe: Change GPIO driver to a proper platform driver")
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> ---
>  drivers/soc/fsl/qe/qe_io.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/soc/fsl/qe/qe_io.c b/drivers/soc/fsl/qe/qe_io.c
> index a5e2d0e5ab51..02ca556c8db0 100644
> --- a/drivers/soc/fsl/qe/qe_io.c
> +++ b/drivers/soc/fsl/qe/qe_io.c
> @@ -15,6 +15,7 @@
>  #include <linux/errno.h>
>  #include <linux/module.h>
>  #include <linux/ioport.h>
> +#include <linux/of_platform.h>
>  
>  #include <asm/io.h>
>  #include <soc/fsl/qe/qe.h>
> @@ -184,3 +185,17 @@ int par_io_of_config(struct device_node *np)
>  	return 0;
>  }
>  EXPORT_SYMBOL(par_io_of_config);
> +
> +static int __init par_io_populate(void)
> +{
> +	struct device_node *np = of_find_node_by_name(NULL, "par_io");
> +
> +	if (!np)
> +		return 0;
> +
> +	of_platform_default_populate(np, NULL, NULL);
> +	of_node_put(np);
> +
> +	return 0;
> +}
> +arch_initcall(par_io_populate);


The par_io node is a sub-node of the soc@xxx node.
The soc@xxx node is simple-bus compatible. This child node should be
populated.

Why do we need this additional of_platform_default_populate?

Also par_io node has a compatible. Maybe the related driver should call
of_platform_populate() to populate children of par_io if needed. If this
driver is missing, maybe it should be created.

Do I miss something?

Best regards,
Hervé

