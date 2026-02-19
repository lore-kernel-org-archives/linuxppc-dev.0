Return-Path: <linuxppc-dev+bounces-16952-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C522E9A057
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Feb 2026 18:42:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fH2Kt3Q6Mz2yFY;
	Fri, 20 Feb 2026 05:42:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771526530;
	cv=none; b=g0gVeMjHtodOBh6KMFFDsDS7SFPmH3WqN8WshFEdHG9OjzM1SnSC1s42TmEz7U3cLhMHh5ma0M7dsqt6N+JApCvjrlOsZk0M8cL/rTDN6PkNFSh/uaq6rYZ7yG3i3v9ZkQe7+mqjUkTGfSNz8Sk3CNoivwORYRxezjGH7Os1dgpGfs+Sx4U3DLWTnkKj6aNT+LrbiZj9pRl8XLkczdDftAJlwOxvvInFP0EhTmn10XNctmbj+G9hclEVvJexjJLGtPtaInJxqXlWJAuPaK2CuiBn/3mf37Hq89ajXQlhi7oz9YX09Sh7iFS4rgA/medJJmAeXeArVxWq7n/KQA9HZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771526530; c=relaxed/relaxed;
	bh=XMZYMKCfRO1P00AFy8aKMQ+jjXDkHAdCnmx8W4egAKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eU1EvSnTkRuufVIIgmQS/kS6EZDhrW7h+zP/4VEz6fCTPov90D9fvgzwszTizNfBwxI00CVfZFOjHicKeJszrO8aHPEX7tjYcnF2rjOhwxXmss7JS6kWiXw8RFrs+0RgpsOHKKS+17BF60ghs11nXuuKX+ByWyJIrBsThZkgXbZ7dXX+WIKDuTHlynBu7oZKvIH1K4+hQR5cnysRPdvplw+wgUYbiS8NHsbbipnRG4uD2YpDNxjN6G2IoOrHnR0rVnUXu1m6t047Gjp2deCva44GQ1SCWXMh7a98UiThKBPfvSGhDgRSB/RL5hS+/ac+DXtNEUAQPFvA3p0zERtPTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=rR28TUEv; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=rR28TUEv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fH2Kr5b3bz2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2026 05:42:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1771526522;
	bh=6/iezbvx6MIXp+pbGoZW7PKtUMMWOusSDApm2rJKtYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rR28TUEv4Jls8PLGjd1MVfZpFs8m0ZVg+yghXO1Rb+SpBWCLpUKYvE6iUmsZPZmMr
	 RU4I4s1JnrZpD6F/GMsuVkSkQz+gB+4bLd02mur96IEHpmd2AG0aJsOIbygBFi4dFU
	 h98LqnIXxT6lINGuoHzN59SzLiZJlRy69D2g17cM=
Date: Thu, 19 Feb 2026 19:42:01 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
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
Subject: Re: [PATCH 08/12] coresight: don't use bitmap_print_to_pagebuf()
Message-ID: <68f8d4b0-6df2-4743-bb71-f44671219931@t-8ch.de>
References: <20260219181407.290201-1-ynorov@nvidia.com>
 <20260219181407.290201-9-ynorov@nvidia.com>
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
In-Reply-To: <20260219181407.290201-9-ynorov@nvidia.com>

Hi Yury,

On 2026-02-19 13:14:00-0500, Yury Norov wrote:
> Switch to a more common scnprintf("%*pbl") where appropriate.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  .../hwtracing/coresight/coresight-cti-sysfs.c | 33 +++++++++----------
>  1 file changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> index 572b80ee96fb..182c8db52a04 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> @@ -606,14 +606,11 @@ static ssize_t chan_gate_enable_show(struct device *dev,
>  	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
>  	struct cti_config *cfg = &drvdata->config;
>  	unsigned long ctigate_bitmask = cfg->ctigate;
> -	int size = 0;
>  
>  	if (cfg->ctigate == 0)
> -		size = sprintf(buf, "\n");
> -	else
> -		size = bitmap_print_to_pagebuf(true, buf, &ctigate_bitmask,
> -					       cfg->nr_ctm_channels);
> -	return size;
> +		return sprintf(buf, "\n");
> +
> +	return scnprintf(buf, rest_of_page(buf), "%*pbl\n", cfg->nr_ctm_channels, &ctigate_bitmask);

For sysfs show handlers the correct formatting function is sysfs_emit()
rather than raw scnprintf(). It validates that buf is page-aligned
(which is always true for sysfs show handlers) and that the output does
not exceed PAGE_SIZE.

(...)


Thomas

