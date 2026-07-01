Return-Path: <linuxppc-dev+bounces-23321-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995CCC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 20:55:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grC370Tb2z2yfs;
	Thu, 02 Jul 2026 06:55:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782939346;
	cv=none; b=JiqDj9vOGtufoVXkFAfHmcZzWA7u5EwJOP+wYuUrtgXPISkjF5Gx+Yr5lGZ6OIoDunRJuW+srmI2Td/ryguOqXrsyPQDBhrn2jTzXQwjUnC4C1JW8WfVLPZgXBUT8WWkkyxar/iEYYIdfxsGZVEcDC/N2FuGlMyHtkxWiSxOK3sLCQwDqfy4bqevSqOtodZMKOjP5U2Pj/vEJ5NV0yvb0luag7PmdvklLYgcgC8WKnDScw1WNwSPZSGx0zJLd3PrGJBGQBter+9oKGGYgoJCSwKGpd1TSZwelcmFOwQ9bX4hVH1RgLjxnGmzo+yKZFK4RHc/SyyUbMF051B4orkwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782939346; c=relaxed/relaxed;
	bh=HzyayHOctkQ2V84W5loiQdWT8uv8bQ5hqh0s1FE+kT8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K95nUDsbdmlf59sb8Yjd5TQGEIxRUWvpVnT0Mx8yXRRDlloplT+W2kMBJqOH1RT9CjxvCl1HxCNAjaa3GM8Hz4QbRkwjfTJ9xA9rf9gOvcxXNQeSyH9xDogmSQK6X8bDKxwVEzvISsqrD9VCrC7Z37RVzBJ4I69BLnWoNcsDEhQgkIdcpBJFCUOfdHKKud4XuhZWEUuNUHD01/8E7uIE+27VOOM3Jcwam1KuyLlfSkD9hjk8IQgLZGSePfC0uhULJya+xiYGO/DaRxTJT5y16bAE3Z3IcQ/L9LW9eU2zqQGP9CQIqEWIst7lh5u5Brd/Woq9J3cbur51UZwijptJeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D6qugY66; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D6qugY66;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grC3548srz2yfH
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 06:55:44 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-c9aea40d799so483692a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 13:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782939342; x=1783544142; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HzyayHOctkQ2V84W5loiQdWT8uv8bQ5hqh0s1FE+kT8=;
        b=D6qugY66JMlKZRvy0fpdllPZXWOAbAIw8rKNhwbnGa7eVhMVorqM5IvIIEhEmXfAsl
         aWMjpXcd+HuYIUSlq6H3TbRSsNAf58HFV6XYJWqYG+lYfRMx4KRMMdZxNJGnHZe2MXJ7
         Jgm2Yre5kNxSgvfjDOrQ23AWY+OErJeJlXRKhOV41V8ZxaSUHYNzYdmz20lyKQkmiIi5
         vXxi+/mBoPisRMalBhViFrr2QxrInwr4JQZuc0A1DD9Pg1r1aUrO79xraFrTBBtZ46L/
         gqa9ivoy7tEt7pnAT/2rMsurbzBb49RKULBaf2KD5rhPOaXK+5vAAnJogvNP4n0aj2Y0
         26kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782939342; x=1783544142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzyayHOctkQ2V84W5loiQdWT8uv8bQ5hqh0s1FE+kT8=;
        b=M61kQVcvSec0IM3jcC/oUfhkDubYenLr852e+qPsXS0ZRYSgFvMgDsIy2/LI/7Mtlh
         iE6As58NWbkcz8/PKWg06aN1B4u+CqiIbS88McMViO8vvw8j/5w3N5j8ox3lbeSeb11j
         d2+MaId8c7ggtOUZgW1ayKpgp5/OxbevRAmmmFa8mk/lk5KJXfFQAGrNNNYe623p6Tr4
         IOALZD72dhLwTCscf4Ql7Y7TqUdDuU143+xaLfO6Tsscy+9u4qoBpPia1ycREzuCTQ8a
         w3b9V87DCSqhV/ST54eKjlBAtoqYoBwpjNdo+6MIA4FProGz8cXiGpKP4z4x/O5xQkfT
         di2A==
X-Forwarded-Encrypted: i=1; AFNElJ8reJp4VAzpWdlFu4elzHcXbg5Kx24fpftOUUsBnVAyh/pZDFVpCNuCr665L2SG0dVUHXThLpk8FcqgvAw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyOCFnl9Dv4D6GdXZAqFTkuTqMr5PcWpw/KM4eEkx1HeIgK0bQI
	NFE3At4iFW6ZuunsSpIV7BwazpJTsvi3dJ48EgS9Kwd3p2zKY7UsqllD
X-Gm-Gg: AfdE7cnWenxBfwtuq4q71kqLb2cEhFyoYvN/CpzacPvk959xc3j1ODuvFVozNfcgE1D
	xhXEsDmSh1R85lVu8mJC+XBF0YtKwH/T1Su7QIM5rM/Y9/8NmK2uaiBS5GaNtq5PKKw2INUgDdL
	bcRx0Kx2Esema2i1oIu88I9tdvodqsbxVpEgY5KUlw6fAdWREEpLYB5Ywf8U60G9KV6h+uglEF0
	yc2DXKTpQy5GcAPiphOmOgouCaPaKhHg9SIqnW4O/cbs8iLfwz73qe9rlxmbv1PTnuaYoTb0izK
	sx8y6Xw9VFcueP7HjgZA7hz/f/8rRqg1lhq2CMM8jUp5d3qO9uSL+SS2byy5U6O80cBX22tY3d2
	4zcrGM2uTJoM7W1PyLfd7ZEuOCI/5VbO/i0SBaWqJB/HM3kNS31caG8/7fwntBCek8/ga8oaeEx
	HOBXeD97VL
X-Received: by 2002:a05:6a21:390:b0:3bf:c126:baf2 with SMTP id adf61e73a8af0-3bff42e3e34mr2607570637.47.1782939341671;
        Wed, 01 Jul 2026 13:55:41 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7b8e3dsm1350231eec.6.2026.07.01.13.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 13:55:41 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Wed, 1 Jul 2026 16:55:39 -0400
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: akpm@linux-foundation.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org,
	Andreas Larsson <andreas@gaisler.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Nicholas Piggin <npiggin@gmail.com>, Rich Felker <dalias@libc.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 3/4] powerpc/numa: set node_possible_map from
 node_online_map
Message-ID: <akV-xN18Xtt1rmTL@yury>
References: <20260701171851.2447626-1-ekffu200098@gmail.com>
 <20260701171851.2447626-4-ekffu200098@gmail.com>
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
In-Reply-To: <20260701171851.2447626-4-ekffu200098@gmail.com>

On Thu, Jul 02, 2026 at 02:18:50AM +0900, Sang-Heon Jeon wrote:
> mem_topology_setup() intersects node_possible_map with node_online_map.
> Nothing sets node_possible_map before this, so it is NODE_MASK_ALL and
> the result is just node_online_map.
> 
> In preparation for changing node_possible_map's initial value,
> mem_topology_setup() no longer depends on it.
> 
> No functional change.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  arch/powerpc/mm/numa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index f4cf3ae036de..2fdecae90a01 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1179,7 +1179,7 @@ void __init mem_topology_setup(void)
>  	 * that we expect to make use of for this platform's affinity
>  	 * calculations.
>  	 */
> -	nodes_and(node_possible_map, node_possible_map, node_online_map);
> +	node_possible_map = node_online_map;
>  
>  	find_possible_nodes();

And in find_possible_nodes():

         for (i = 0; i < max_nodes; i++) {
                 if (!node_possible(i))
                         node_set(i, node_possible_map);
         }

So, assuming the code reaches to that point, you unconditionally
online all the offlined nodes.

This doesn't look correct at the first glance, and definitely it's not
a "No functional change" type of things.

