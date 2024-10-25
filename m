Return-Path: <linuxppc-dev+bounces-2578-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCA5D0C608
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2024 12:57:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZjVL3bzRz2xGw;
	Fri, 25 Oct 2024 23:57:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729861034;
	cv=none; b=FPjXb5i96UfS6hA7YY8B9gteHfMQd8gpNz14+EDaBHJcHfiqnT5M63fRV/KxdU85gtgRJ1PrWosWRONqG9+0cImeftpEqMWEXstkgW3Y8xftabmUW1d61cpCUwd8Z44SbgkT4ksdW8NgTuMDSADPr51t3yUyuXlzxmKCoop+b3P9Mor5oGFHsVy6pgLATpwlSpOEY3djGOKS95/rwfeFX3XcrJ3T7neqsPBz4InxqiRCeghAB2lncQ1+CqlUB+NeXurfyr0yYwgm4Hs5ems/8bljlFkUnIyOMuJpE+CDaS/KnoSx8dKO+CYfU7wD1pAKYkCvQAQJeA/2Ciz0dOP+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729861034; c=relaxed/relaxed;
	bh=JfreyAPaxpHBTeYOYEZ8GaesVZPA+tiEfaK0VwVyFZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/vvbeuEOYXYjohV6onGaivQtJdLEIyuysqHAtBfpJHLVQIWE3jsnLLIOGq5P9vvCUGt45sIpgVb1Nyt/Tmhjbnp/5nJK35sgwxqPdl2qTMIIJK3yHv/sNsyw9+XCtBv6Dn3jg3EPVDBa0NFip7BDryjp5hR2BFXY1M21zgUF1DeLv4Au0w63tCOC70yorJ7GeU+Z89v7jTZmCDv+a+8xYzVPN6SmRghXhufTVD9CUd0j6qCWQsEYEmMhnzxPeBjk0To7M/QaBENO343/vkfZ9U0bqfpXs0TZzSjb0nNkQCxi8QeuMj6a3tV3ePLhDiDgPqIXLTR6feRduGRfBbT5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WMJA3zcc; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WMJA3zcc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZjVK21MYz2xGH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2024 23:57:13 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4E002A42E67;
	Fri, 25 Oct 2024 12:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E13C4CEC3;
	Fri, 25 Oct 2024 12:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729861029;
	bh=qQ9BGIBuydVEIbP3xQoTLisLWtMFfzR966v2FW0Zv48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMJA3zcceJ88lqN4DKbs7ZO4fBlHQyrFjCypZWJ9iWhNhkzeZSYxFOy7QzYtxMy+1
	 uw1n3p/aXsdzMMm4LzGfRgNxqIw+lj0Yb442PsUxMRYlzAwMbBV0mktdYvgfkfmSgJ
	 XkGQce4MGcTDn39Pa0jN01LQjjeKr7WiYoQTtM+io+TLErvVCE3q0tpRxh4TbA2Is7
	 pkHMFSIeruqUghKMZ7K7iHUzyLHnlenuVG7ITayAsjWs8yjE+FwjUUA2FlCcyj/l4O
	 4ObkMB1N/TiaHBzElKq5XTyir8nR7MqHedKXRjCMQXuZX97uKpuhBxWjYA5yMJxdrj
	 nK12D93ImIECA==
Date: Fri, 25 Oct 2024 13:57:04 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH net-next] net: freescale: use ethtool string helpers
Message-ID: <20241025125704.GT1202098@kernel.org>
References: <20241024205257.574836-1-rosenp@gmail.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024205257.574836-1-rosenp@gmail.com>

On Thu, Oct 24, 2024 at 01:52:57PM -0700, Rosen Penev wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer. Cleans up the code quite well.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

...

> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
> index b0060cf96090..10c5fa4d23d2 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
> @@ -243,38 +243,24 @@ static void dpaa_get_ethtool_stats(struct net_device *net_dev,
>  static void dpaa_get_strings(struct net_device *net_dev, u32 stringset,
>  			     u8 *data)
>  {
> -	unsigned int i, j, num_cpus, size;
> -	char string_cpu[ETH_GSTRING_LEN];
> -	u8 *strings;
> +	unsigned int i, j, num_cpus;
>  
> -	memset(string_cpu, 0, sizeof(string_cpu));
> -	strings   = data;
> -	num_cpus  = num_online_cpus();
> -	size      = DPAA_STATS_GLOBAL_LEN * ETH_GSTRING_LEN;
> +	num_cpus = num_online_cpus();
>  
>  	for (i = 0; i < DPAA_STATS_PERCPU_LEN; i++) {
> -		for (j = 0; j < num_cpus; j++) {
> -			snprintf(string_cpu, ETH_GSTRING_LEN, "%s [CPU %d]",
> -				 dpaa_stats_percpu[i], j);
> -			memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> -			strings += ETH_GSTRING_LEN;
> -		}
> -		snprintf(string_cpu, ETH_GSTRING_LEN, "%s [TOTAL]",
> -			 dpaa_stats_percpu[i]);
> -		memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> -		strings += ETH_GSTRING_LEN;
> -	}
> -	for (j = 0; j < num_cpus; j++) {
> -		snprintf(string_cpu, ETH_GSTRING_LEN,
> -			 "bpool [CPU %d]", j);
> -		memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> -		strings += ETH_GSTRING_LEN;
> +		for (j = 0; j < num_cpus; j++)
> +			ethtool_sprintf(&data, "%s [CPU %d]",
> +					dpaa_stats_percpu[i], j);
> +
> +		ethtool_sprintf(&data, "%s [TOTAL]", dpaa_stats_percpu[i]);
>  	}
> -	snprintf(string_cpu, ETH_GSTRING_LEN, "bpool [TOTAL]");
> -	memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> -	strings += ETH_GSTRING_LEN;
> +	for (i = 0; j < num_cpus; i++)

Perhaps this should consistently use i, rather than i and j:

	for (i = 0; i < num_cpus; i++)

Flagged by W=1 builds with clang-18.

> +		ethtool_sprintf(&data, "bpool [CPU %d]", i);
> +
> +	ethtool_puts(&data, "bpool [TOTAL]");
>  
> -	memcpy(strings, dpaa_stats_global, size);
> +	for (i = 0; i < DPAA_STATS_GLOBAL_LEN; i++)
> +		ethtool_puts(&data, dpaa_stats_global[i]);
>  }
>  
>  static int dpaa_get_hash_opts(struct net_device *dev,

...

