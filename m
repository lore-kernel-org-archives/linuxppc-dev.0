Return-Path: <linuxppc-dev+bounces-16968-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DCEC531F4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Feb 2026 00:35:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fHB9X2yvxz2yrn;
	Fri, 20 Feb 2026 11:35:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::ab"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771545072;
	cv=none; b=HWoWPe+Vlr3jwc9dmESpnucQteroLiwxFeQC5jnS+5NxKt4Fhn/liGE/VKZfuWXRI/FGA4a8EJKy3IXRwKQCafErQml8eSejWoWwS0EEwSObK4PRQRIIZhDFV45pdkUC3FxCcF2DV7KI40r83F6DYR+QRDB1lITUPyvD5MnHycsoWBChqFNiMHKaTpg72L1Zopy24Ng6sJD0CFc5FEXpfL/SoA1lt2UYXYWeTeKULbb7oQQbl51ww2vU9jB84j86ZSHMfDUNpGwdQwgSfqb2Qdq7fF8/01LoUtKHFZOc0sicwkp2edvCVdleHszyRr+YwBehVorNSfT6xbyiBtqwJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771545072; c=relaxed/relaxed;
	bh=CRO5rWml1QK70tgKl06x/aVYyKWj/aRzqe+fxQOhkKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TP2iwuD3ihCNT1Skh7NwOusHDjdG4PRynpk/5AJBCEck9j/HJ/J9rAY1o6MZXR0yxe7xxMYxdI11Hl6wpbwKHLT+2Ud53nLtHnT9ilKjFHRB/WpAsPeLB+Oe1J+2AEM6V44/5kB7vU7NYWRskcZwCgPAeLVFcnEIuZQtxMPa7MmC51+gxXawPWx41jSjUhm074X6z2jpwgLHlGuw2EMZVnGaVx1GKYJaiNrTr7Usj+7wxx2rDYTE3ocuZO1bVmUKtQVXiV3oMvuE2iKlcuU3JF1KqyRzj4c90LdmRkAxROd56dQYDKIkgnU6XhKVMUQcz51yAo5dfC+FghDbKCnviQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fhQrXZgH; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::ab; helo=out-171.mta1.migadu.com; envelope-from=russ.weight@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fhQrXZgH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::ab; helo=out-171.mta1.migadu.com; envelope-from=russ.weight@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 391 seconds by postgrey-1.37 at boromir; Fri, 20 Feb 2026 10:51:07 AEDT
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [IPv6:2001:41d0:203:375::ab])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fH9BM46Mjz2xls
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2026 10:51:07 +1100 (AEDT)
Date: Thu, 19 Feb 2026 16:43:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771544647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CRO5rWml1QK70tgKl06x/aVYyKWj/aRzqe+fxQOhkKU=;
	b=fhQrXZgHJkvalaKby2C9z8kNEAxoIH1m4n89qWYP4oV4FrEttt7O/TFwSqck5NetZ+5GDD
	r85/jEND3KIXN+QZQViJ5D6/7XLpG0063G/hobulPpZrlBoCjyKRIHgQ8/tmHR3cbJhttp
	PROJqJgnuOXtp4Pi0UJPkEoNJ3l8aaM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Russ Weight <russ.weight@linux.dev>
To: Yury Norov <ynorov@nvidia.com>
Cc: linux-kernel@vger.kernel.org, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Andrew Morton <akpm@linux-foundation.org>, Antoine Tenart <atenart@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Eric Dumazet <edumazet@google.com>, Geetha sowjanya <gakula@marvell.com>, 
	Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	James Clark <james.clark@linaro.org>, Jerin Jacob <jerinj@marvell.com>, 
	Linu Cherian <lcherian@marvell.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Mike Leach <mike.leach@linaro.org>, Moritz Fischer <mdf@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	Sunil Goutham <sgoutham@marvell.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Tom Rix <trix@redhat.com>, Xu Yilun <yilun.xu@intel.com>, Yajun Deng <yajun.deng@linux.dev>, 
	Yury Norov <yury.norov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, hariprasad <hkelam@marvell.com>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
Subject: Re: [PATCH 09/12] fpga: m10bmc-sec: switch show_canceled_csk() to
 using scnprintf()
Message-ID: <nsymcnuakoxcuq55csc5dsyevuftlp4vahz7yljziwnbbe7vhr@6n3kddtcuwh7>
References: <20260219181407.290201-1-ynorov@nvidia.com>
 <20260219181407.290201-10-ynorov@nvidia.com>
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
In-Reply-To: <20260219181407.290201-10-ynorov@nvidia.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 19, 2026 at 01:14:01PM -0500, Yury Norov wrote:
> Switch show_canceled_csk() to use a more common scnprintf("%*pbl").
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Reviewed-by: Russ Weight <russ.weight@linux.dev>

> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index 10f678b9ed36..5ae76b8ece18 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -10,6 +10,7 @@
>  #include <linux/firmware.h>
>  #include <linux/mfd/intel-m10-bmc.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> @@ -183,7 +184,7 @@ show_canceled_csk(struct device *dev, u32 addr, char *buf)
>  
>  	bitmap_from_arr32(csk_map, csk32, CSK_BIT_LEN);
>  	bitmap_complement(csk_map, csk_map, CSK_BIT_LEN);
> -	return bitmap_print_to_pagebuf(1, buf, csk_map, CSK_BIT_LEN);
> +	return scnprintf(buf, rest_of_page(buf), "%*pbl\n", CSK_BIT_LEN, csk_map);
>  }
>  
>  #define DEVICE_ATTR_SEC_CSK_RO(_name)						\
> -- 
> 2.43.0
> 

