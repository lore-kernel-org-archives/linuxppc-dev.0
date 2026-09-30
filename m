Return-Path: <linuxppc-dev+bounces-28598-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9787ECA5FC4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 18:00:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hw2s10tGlz2y8d;
	Thu, 01 Oct 2026 04:00:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790791237;
	cv=none; b=XDEivlWY1tuwl6tn7C2UqIjkmqeEkEgJIZu+/SyEQX4SUS7piG0ZAb3nHrzx2svfTt2coLvEEAoDKnAibpVOsFyNPIBc7Kuefh6CpKSMvqr6tiIjB8chfgLjjGdJHdevjh4+lC5bT4nLAig6ZXRdW3y2s25aMYW2+8sbEW9pAXqYFvji6CbLA2vs2eRd9pipT0XBrrUsi5j0vc7rFC3OdhojhnkhVCLN2lcefF3LQ6zAuy9VWTa6zZRZ53VEL+ak8zphk8u75Maop9xBRvrS+8l+c26OHmteZsMfYOqokui1B3gGdyOgj8CRNRF+WtMNNnXNsU8KZsza3tIGJFoZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790791237; c=relaxed/relaxed;
	bh=m/yksmZi4/8K5CoXfwsmRihQ5Y6+rvb/E2mBihR25ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NPsBohkPOg2JaAjuiE4uQqIYGBz9CH5lwOIbV8OYZHwqPeLqygY1ps+yKhXzYBIXOO7u3cdmh/5JTniTwntZeWFUUKUF/mU5EngEEEDFHwG0hrkvmfKUfU6gJfR67jMYGCRAJBl8X38AefEG+ZKdmRU3AKvWF+0B7dU2rLrWp9/oKm4YCeFLnTGytH/G8K6Jqupo9cdGrU4P5Jm3FmU5lQJccyNUwmY7BFgBRWRTSzkkgK41aodfW3Allw+Mxmz4RCRYJIpsXFPSd+Vk05QFjUdfbmmALGnly8CfOXEu6f2UClbqwRg0fTLj8u61jkDGnFbGwwC87QR/W/IE+phUHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a0lQ69ZA; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a0lQ69ZA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hw2rz1yXlz2y24
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 04:00:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E463D41331;
	Wed, 30 Sep 2026 18:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399611F000FF;
	Wed, 30 Sep 2026 18:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790791232;
	bh=m/yksmZi4/8K5CoXfwsmRihQ5Y6+rvb/E2mBihR25ec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a0lQ69ZA3EF3oZrA8FJp6gvLHNcjv7sa0CYpXDRp5NCIpQAKZINSlmZePxs0Bu/GG
	 ZL+K2zBU5VYOUipLGoPXy7oqxQneSnadQ1rQHA8NOucWYetyMEsqX5Z/4SkamW4nc5
	 1CdVHa1J6L6kTXif3yRviHjfmpYWpcQTuApygeBSOtr/mbYM4/DrinXULausYGEql8
	 7VYFIfty06grTZp9bcWuMRm+v7INjdNAwKWqGrnz2ZsA7i8lRMoOaaqJylR1vEkrSm
	 U0STDXgARwrHn6dT0i++Q62rSNwcyw3yoJ7TPi/rAekH7TvRRK7D6GrcYSdaKfLCnS
	 2PR9tiwtCURkQ==
Message-ID: <36a39658-1345-40dc-8c25-44c3ec5c9750@kernel.org>
Date: Wed, 30 Sep 2026 22:00:06 +0200
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
Subject: Re: [PATCH] bus: fsl-mc: drop the fwnode links of the dpmacs nodes
To: vjardin@free.fr, Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260928-for-upstream-fsl-mc-dpmac-fwnode-links-v1-1-b8976244b38b@free.fr>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260928-for-upstream-fsl-mc-dpmac-fwnode-links-v1-1-b8976244b38b@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 28/09/2026 à 15:52, Vincent Jardin via B4 Relay a écrit :
> From: Vincent Jardin <vjardin@free.fr>
> 
> A DPMAC node under dpmacs/ is never the fwnode of any device:
>    the fsl-mc bus creates dpmac.N objects without one,
>    then dpaa2-mac finds its node in dpmacs/ at connect time.
> 
> fw_devlink therefore attaches the supplier links of those nodes (phys, ...)
> to the nearest ancestor device, the fsl-mc bus, as SYNC_STATE_ONLY proxies.
> 
> device_link_add() refuses such a link once the consumer has probed, and
> fw_devlink logs the refusal as an error.
> 
> On an LX2160A board with 4x25G DPMACs for which phys = <&serdes_1 N>,
> the Serdes PHY binds after the bus and then at every boot it shows:
> 
>    fsl_mc_bus 80c000000.fsl-mc: Failed to create device link (0x180) with supplier 1ea0000.phy for /soc/fsl-mc@80c000000/dpmacs/ethernet@3
> 
> once per port!

If I understand correctly this explains the problem but it doesn't 
explain what this patch does to fix it, allthough the patch subject 
might be the explanation.

I have taken this patch as is to give it a go into linux-next, but 
please feel free to send a new version with a more obvious explanation 
before begining of next week.

Another question below.

> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>   drivers/bus/fsl-mc/fsl-mc-bus.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 5878eafd8d44..0c37b6780c84 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -11,6 +11,7 @@
>   #define pr_fmt(fmt) "fsl-mc: " fmt
>   
>   #include <linux/module.h>
> +#include <linux/fwnode.h>
>   #include <linux/of_device.h>
>   #include <linux/of_address.h>
>   #include <linux/ioport.h>
> @@ -1033,6 +1034,20 @@ static int fsl_mc_firmware_check(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static void fsl_mc_purge_dpmac_fwnode_links(struct device *dev)
> +{
> +	struct device_node *dpmacs, *child;
> +
> +	dpmacs = of_get_child_by_name(dev->of_node, "dpmacs");

Is this name a valid API documented in Documentation/devicetree/bindings/ ?

I'm asking because I have already been challenged by devicetree 
reviewers on a use of undocumentated name.

Christophe

> +	if (!dpmacs)
> +		return;
> +
> +	for_each_child_of_node(dpmacs, child)
> +		fwnode_links_purge(of_fwnode_handle(child));
> +
> +	of_node_put(dpmacs);
> +}
> +
>   /*
>    * fsl_mc_bus_probe - callback invoked when the root MC bus is being
>    * added
> @@ -1134,6 +1149,8 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
>   						&mc->num_translation_ranges);
>   		if (error < 0)
>   			goto error_cleanup_mc_io;
> +
> +		fsl_mc_purge_dpmac_fwnode_links(&pdev->dev);
>   	}
>   
>   	error = dprc_get_container_id(mc_io, 0, &container_id);
> 
> ---
> base-commit: 7b3b0598c00e67f2df85d0b4cd99eaa3be6c9bfd
> change-id: 20260928-for-upstream-fsl-mc-dpmac-fwnode-links-622b8eadb98a
> 
> Best regards,


