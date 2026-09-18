Return-Path: <linuxppc-dev+bounces-27689-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893D3C982DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 09:24:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmRyh5pncz2y7r;
	Fri, 18 Sep 2026 19:24:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789723452;
	cv=none; b=JUhIt+Ifs4R0+NeDWkYr5cYnK9ErYLWBu6cmNcWaCtGAR8nRQqZ+OoScO6wchnTM0dJBbkrRDKVHa6n3bfk+pN757i1VYF1tV76ppwly4SO/4Ny17hFEI4LFu7qIFBOYxMdQNYryRvmpQe/LeLXl2Q1VS8ZSL6ELExvhh4sRdr3ml+Y2VQ7UG6+qmxiHHzM2pybkENWeJaqR/Aw6IcPdCa9mJ6WBl7LcF/pI6whaWLshzArfX7r5lxdVCjKOlDDLM2G8Bbx3FV7V7Uiu/IrQnTyHbx91ZlApFW6UsMetE0ywHrjLp7XNYvQdiAw/rqm1nTy/xBP5dotmhoq1ongNRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789723452; c=relaxed/relaxed;
	bh=3AyPjWu4Gl0yX56nO/NLviif3j02J/T6027fVk46sWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mG1RimMVdOQeooOSESsod5oDaT78GSeKPMVl217EdeYNmDGNPfAYGwHDby0fSZYdUXR/Gg8E7orVPbcEU7zz9DOClP6GjnjDWlxUkct0cj2naEsLS7AM8Mt2r/HdapTsptMuttvJJ5LarF5XE56GdbtRI0iN8yLDwQaSmp2GA4Nv10fXvgb1AeRD/6AiMKY3XCI2e+6ouVeYcKmN+FcXiR+EObSsB7mNdnVedcV0KlbAwcHwxKHt6e3qKCTofhxGJtwOzEszwD27E0V0Hq1k9oCglgoEHKF1LiWxbuF7BUJi+/K+BN/dPnTOwpDBtckQa/gt9KNR8lBuTpzEWc/Ssg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y1fHzUmT; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y1fHzUmT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmRyg5Vtqz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 19:24:11 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id ED06743B57;
	Fri, 18 Sep 2026 09:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128661F000FF;
	Fri, 18 Sep 2026 09:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789723449;
	bh=3AyPjWu4Gl0yX56nO/NLviif3j02J/T6027fVk46sWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y1fHzUmTY6xJdh3xAeL1nIj/NFGevYq92scK49asLxP5JPN0jllIKza+b107haWAV
	 bw27IMYN7F/gnZcZgyp7zn08A0ykr9vXn00E/o8vXJ9EqLsWgkwLliyiudY1sDTVHs
	 l6rWlvybG1h803Uy1SSV4aND4nudjPaqFC5DO6zeNiLDsIoPPsB37G3Ni6kctBDDS4
	 QFWJS0DhSzKQ5hzVrKnkSM0PoSiUBr9KtDfqSfj/deBmPubm9WWMpclLYbVBc9LPrh
	 CYqkbKwSflAHkBhrQFJ4tJ9nbDuWiZgZp3R3H85x7Rqn7wfaGC6PUvo99yYVP0uN9F
	 gW4i/WcjxlZHg==
Date: Fri, 18 Sep 2026 10:24:04 +0100
From: Simon Horman <horms@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, Jeff Garzik <jeff@garzik.org>,
	Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: fs_enet: fix platform info memory leak on remove
Message-ID: <20260918092404.GF51261@horms.kernel.org>
References: <20260916031414.2875022-1-lgs201920130244@gmail.com>
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
In-Reply-To: <20260916031414.2875022-1-lgs201920130244@gmail.com>

On Wed, Sep 16, 2026 at 11:14:14AM +0800, Guangshuo Li wrote:
> fs_enet_probe() allocates the platform information structure with
> kzalloc_obj() and stores it in fep->fpi.
> 
> The probe failure paths release this allocation with kfree(). However,
> after a successful probe, fs_enet_remove() tears down the network
> device without freeing fep->fpi, leaving the platform information
> structure allocated after driver removal.
> 
> Free fep->fpi before releasing the network device.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 976de6a8c304 ("fs_enet: Be an of_platform device when CONFIG_PPC_CPM_NEW_BINDING is set.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> index d3c772ed5fc9..071e3f3de78c 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> @@ -1007,6 +1007,7 @@ static void fs_enet_remove(struct platform_device *ofdev)
>  	fep->ops->cleanup_data(ndev);
>  	dev_set_drvdata(fep->dev, NULL);
>  	phylink_destroy(fep->phylink);
> +	kfree(fep->fpi);
>  	free_netdev(ndev);

Reviewed-by: Simon Horman <horms@kernel.org>


