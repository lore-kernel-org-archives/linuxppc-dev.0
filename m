Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29487C04A6A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Aug 2023 14:41:01 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iH/uNjKq;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RLXmW5khVz3c62
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Aug 2023 00:40:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iH/uNjKq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RLXlT2V4mz2xqq
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2023 00:40:05 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5E9ED63C4D;
	Wed,  9 Aug 2023 14:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEFDC433C8;
	Wed,  9 Aug 2023 14:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691592001;
	bh=t6FjFc3AES2KACSvBk65Vzki7TTeide32e508stIQPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iH/uNjKqst+lY51K1kZDshSOoR+reeILLpdtz8Ao14jstCiZMIKIepAR1KjxSIByQ
	 ThlyHk8zjv/VdlVDLzyVj/Mf0RCbuGjc74ES7OxcffFuCl8I+9syQYqTiqzP//7wm7
	 MTd9Urzs7nOpKPM+sJiInjD/0DW8xmVSL9WmIo+m/n0Kx6AvklgRwe9zaxKSUutARI
	 2YmSzN9UCyK4Yc/tU9gdaCOYk7EvaXf5dh2grULVHSCxSCU8wU6ZRa3QDo1eWrdOAt
	 ugZD+2wHve4uJSQCiRbgglp69eq/DxdvctVWuZWEeH4AqVQ1x+e33sUMz2vWZJwJbW
	 nyxrmenqljSAA==
Date: Wed, 9 Aug 2023 16:39:57 +0200
From: Simon Horman <horms@kernel.org>
To: Li Zetao <lizetao1@huawei.com>
Subject: Re: [PATCH -next] net/ps3_gelic_net: Use ether_addr_to_u64() to
 convert ethernet address
Message-ID: <ZNOlPdxAPzIcB0Ij@vergenet.net>
References: <20230808114050.4034547-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808114050.4034547-1-lizetao1@huawei.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: geoff@infradead.org, npiggin@gmail.com, edumazet@google.com, netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Aug 08, 2023 at 07:40:50PM +0800, Li Zetao wrote:
> Use ether_addr_to_u64() to convert an Ethernet address into a u64 value,
> instead of directly calculating, as this is exactly what
> this function does.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/net/ethernet/toshiba/ps3_gelic_net.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> index 9d535ae59626..77a02819e412 100644
> --- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> +++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> @@ -596,7 +596,6 @@ void gelic_net_set_multi(struct net_device *netdev)
>  	struct gelic_card *card = netdev_card(netdev);
>  	struct netdev_hw_addr *ha;
>  	unsigned int i;

Hi Li Zetao,

It looks like i is now unused in this function and should be removed.

> -	uint8_t *p;
>  	u64 addr;
>  	int status;
>  
> @@ -629,12 +628,7 @@ void gelic_net_set_multi(struct net_device *netdev)
>  
>  	/* set multicast addresses */
>  	netdev_for_each_mc_addr(ha, netdev) {
> -		addr = 0;
> -		p = ha->addr;
> -		for (i = 0; i < ETH_ALEN; i++) {
> -			addr <<= 8;
> -			addr |= *p++;
> -		}
> +		addr = ether_addr_to_u64(ha->addr);
>  		status = lv1_net_add_multicast_address(bus_id(card),
>  						       dev_id(card),
>  						       addr, 0);
> -- 
> 2.34.1

-- 
pw-bot: changes-requested
