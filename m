Return-Path: <linuxppc-dev+bounces-27511-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9415FC982C9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 22:50:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlYyH02B4z2yGT;
	Thu, 17 Sep 2026 08:50:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789599046;
	cv=none; b=JbCpfUtBePJrz+0IONOJgC8wnzheQPyqd8dyrJeBJZT6874xVw2jRRWoAfHEsRnfSEEO6Y1PG2l74qAVtTK5YLfDi9PxGmLDHssSmdDj63p8xlZTzeQ6f9/XPI1uatLfmscOdoGQQVOEscgOD6WnHPifjKUIaYysCmEi1PbTvaOMAXcDPlCCp+K+F+qgwmCxgiLB9EY2eH12ipxO3h1UrbZiw2SUnhIWGTzJ8rwgH1SD/k3J7iyElBgkIdlbqTZhrdCZ6t7as9kno/Gt7fqYKLgx3gDE4EM5qoB6bqlMqlIRkt83u5tqcmx2ZyREykUrlusG3IjlavrhIY3YsE3wxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789599046; c=relaxed/relaxed;
	bh=UPrxWso2jS9frylLdy0Jy0Nxd5S7abxn3XuSWz2Dy0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiAgE4pCLQ3px7G+YKlmWgFQ2q3xIy3jFRBbm3RP3ZzsaZD5qnrVd2yelLbgqh9feCszhjnvKS7Xp1mpOZkWYKoa2GnBeGE4jJn1rvHb484G3BgHz4cvxuSknCu/axPFSWUBXKUxp8HQOR+LIztD0txHfKgfmuxcxvcBNhdZ2GzvhuJR/IBHw91hDj0BROjzF2qCFN8CX34cSvA92sK/nok5ZUHvn+XUanRF0ULpJDpfgpH3gielCail0Ld+eTPTft1ilmWfmmzWbiWt5Zy09sHYsoBBc/iEgqVT3stF+Dy/vVNPMWJi8nc1rkiG1F8qFbznYWRHiIg2j9ND2GQlQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f73SiSnZ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f73SiSnZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlYyG2XvTz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 08:50:46 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 08DB3600CB;
	Wed, 16 Sep 2026 21:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CC31F000FF;
	Wed, 16 Sep 2026 21:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789594375;
	bh=UPrxWso2jS9frylLdy0Jy0Nxd5S7abxn3XuSWz2Dy0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f73SiSnZRvVZuvo0fToEh5hdb+xgrmJGCGftS9N89GzwsCH8RnZjAmDsHqQlVIn7+
	 E/sMajFArESRXECSJnosiIgeAZ7aKIRKrx635U9PFfrCAz8yTPic9zjkiNSsNHANhi
	 JZCbZTSSFb2Inze5+aJWbe3eoUO7qJ+fYHh2aFGSYabUwgi6N2hfpHarPp/Jkno6bm
	 TCsI8nkiTEhdNpLZt+U4GRmD4cL9312J2O7L+EG3HSa6wDJdl+DlodxfNBdAmBQzya
	 s0VeHVCjyGpPg4Wc0o43jnGuXdKqxE86BMF6mkLYxp5syhuFFgkl3QA2x45wk0l1lM
	 lF7cso8ylVBmw==
Date: Wed, 16 Sep 2026 23:32:50 +0200
From: Thorsten Blum <blum@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Kees Cook <kees@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: fsl_rio: Use snprintf() in fsl_rio_setup()
Message-ID: <aqsLAuX8mHUe5ls2@kernel.org>
References: <20260630144951.692473-2-thorsten.blum@linux.dev>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630144951.692473-2-thorsten.blum@linux.dev>

On Tue, Jun 30, 2026 at 04:49:50PM +0200, Thorsten Blum wrote:
> While the current code works correctly, replace the unbounded sprintf()
> with the safer snprintf() in fsl_rio_setup() to follow secure coding
> best practices.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/powerpc/sysdev/fsl_rio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Gentle ping?

> diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
> index eb55dabb4748..077c03cd93e4 100644
> --- a/arch/powerpc/sysdev/fsl_rio.c
> +++ b/arch/powerpc/sysdev/fsl_rio.c
> @@ -612,7 +612,7 @@ static int fsl_rio_setup(struct platform_device *dev)
>  				kfree(port);
>  				continue;
>  		}
> -		sprintf(port->name, "RIO mport %d", i);
> +		snprintf(port->name, sizeof(port->name), "RIO mport %d", i);
>  
>  		priv->dev = &dev->dev;
>  		port->dev.parent = &dev->dev;

