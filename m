Return-Path: <linuxppc-dev+bounces-21261-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A583CCD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 23:57:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLT4b2LkVz2yRC;
	Thu, 21 May 2026 09:57:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779321471;
	cv=none; b=BQiNlsPEMxxlRLuRqRcpRANgcUquqUpEdGh73YWDFhLzqfyPmEF1V1t2YOJmSueQh576qrTUtN3NnhK7uCO7RGqoDcpCiZ5mMIefdKWlpspewq9AmGiDAbkbueQAivSgN2TtgXJ5RQ0BHJiJJfmp1vc6USViwS9IkJrDR7YCkRPZDGW0gfVXIA3bxZfw2gHN2ySq8u7gj0JoFcp+QqroaAD1tv1kRgUVjFWYSLV4+g++XhsQoHL4yuJ98H9dDm/bc2YrZ+2KKfUkX5XE15W+aDM3x60Z7ldBaNsq2UDpz01u5UOVrQ1/Cui+TJaL10oHzqfj8Zi2nGAulczeytueag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779321471; c=relaxed/relaxed;
	bh=X6DI7mmqfvXQdfna5t6z3c+phyO48RHga9a4FKW2Iyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CiRGEMUGRTHAjPjGoBpYu+Qnmid82zDBsu08OhjJH9IKg846DV4eSQztGhDhWWa8HKW19F9CSkYqkIp3gif/N06BAXJ1PwJjdr/nvpVSALDWpF1ScBeMbHizdU6R/24f5IOM058DJi+gMcqjij2wxhKVEin+NDt3vFhEXqhEhYBCIA7XWD/DrR8EaJtF73GGeNBiRQuCt1dmk9r6D7VqN2aClifmFraAdP+i0qtZFaY9OXfsW9l8+UZ6+1ql3M+qyR/3FtZRCntVJIhlzwDp8jbRFU/wFY+NgXfGQkDdOgkVExcMuKZmsUJxYCye+/qP+lzoiocxC3ByUa8WqCzELg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=obytBnlW; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=obytBnlW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLT4Z33y3z2xHF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 09:57:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DEF2760098;
	Wed, 20 May 2026 23:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391BE1F000E9;
	Wed, 20 May 2026 23:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779321467;
	bh=X6DI7mmqfvXQdfna5t6z3c+phyO48RHga9a4FKW2Iyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=obytBnlWNgsZNdo2sqNmjUBgAKaVk2zKmsmXf/v38/izx3LAqiK+wrSXbbfzw2JPr
	 8nlQNOBRsV0RNxu5IzcMr+btHRta9VIM+x/As9ZpMVth6XXLO5wPcUSVVRvctovCmq
	 KgkH7/z/mqEHiLyNwxBpAeXaKs+gGVlTyppSvUGFTgPHnmzhrcwA+ZpmVd7Yfa2YQ8
	 yFi+hyec+6ZhZSgTV7566ve+EbcM357QM6PLMmUFQbn4b0WtyTOuth1xKd9YUsK+Ya
	 x4tqQ2TRpRWlCCj5k6SG9pyzMrYQ9XcekzLn55ijpN98zKffmj/lPNb0vq9QhIvY4F
	 mdQ/opjZ9JPvA==
Date: Wed, 20 May 2026 16:57:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linuxppc-dev@lists.ozlabs.org (open
 list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] net: ucc_geth: Batch RX packets before stack
 handoff
Message-ID: <20260520165746.7ed10c7b@kernel.org>
In-Reply-To: <20260517192856.3925-1-rosenp@gmail.com>
References: <20260517192856.3925-1-rosenp@gmail.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 12:28:56 -0700 Rosen Penev wrote:
> Collect received skbs on a local list during RX polling and pass the
> completed batch to netif_receive_skb_list(). This lets the networking
> stack process packets from a poll cycle in bulk instead of handing each
> skb up individually.

GRO should be even better.

> Speedup tested with bidirectional iperf3.

Please mention the platform / board as well.
-- 
pw-bot: cr

