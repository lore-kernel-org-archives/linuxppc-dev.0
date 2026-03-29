Return-Path: <linuxppc-dev+bounces-18983-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7204FC97EE
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Mar 2026 21:30:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkSGT0dCDz2xQD;
	Mon, 30 Mar 2026 08:30:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774819824;
	cv=none; b=m1ufMXSU6qvJvN8ToACYPKCVcHfaZTxbHsD22cxivTQ9+soIFF09x/NM6/fSf+mhLniXN0vIMWogNSSogRErNKkk++UpaKvOGJ9m3H43EYujOv2uewvtYTv30YgUowbA9wS2L76KDpP5X/7IWc9xkeNJdJSfYN6SEenapaGiU6Nb6uSDp7CGLN7Cy3TkS0U/wV+eqriuNNnI9UACCOIZeN6AdZ8hehdZ5OkUALC230lW7c7eH5ypyFBVJSKYygJb5yN/W/Ver6qldLGaJiw2ULawbtam3UvQYhDFu26Ym3Fab/EAJeZPB8xoc0feMgp0qlZl1k/xyMTT77TfFZSj5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774819824; c=relaxed/relaxed;
	bh=Jg/wbahLIEudwcuob6ggpIAEpGEySqByemdIn1HZxTY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LaQtO4FNilphmueN23HsZThnP6u8wCMDA4Tpj9gIgB2vEfq3X5qTMDUG5aQ9K2uHBzu6FqY0v230Aqd/oHcW/mQs2QQA8tVQcqHib1LhFawA6Q1xz9Fu6YxT1HhO3hJwdIbhdbLLA8Rz8NOKLt1axZvqsP8fTSBjqPRWN90xcw7hQ94ZRqVrxxiueWM0i/WiQlJV211SDYgrAU5V/nEkmmlxQE4Uh1+p/I4EzglBvSn9rd85CM/bh5Wsf1orW2GFGuPkhJN0tzV4uHCQKvXeL32NvLKEREXrjAhH5fm146oogQzEouzVX1uG5zAnTflDgzz36lnOeE6vKQ6IemM3wg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rnGXHvHy; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rnGXHvHy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkSGR73fvz2xQB
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 08:30:23 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CDE1340249;
	Sun, 29 Mar 2026 21:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3CEC116C6;
	Sun, 29 Mar 2026 21:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774819820;
	bh=dT4RSInZIwtU5J3JPKDfHXxdBaPFiyi61n/u9jP9OUc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rnGXHvHyfdSMSf5XEHBkiT5fa60BTyY0HnEakPLPy9HOHQwTjXIuDQ6DAJznQ4iPh
	 4XUop4odcE//Os+yoiIdlQPrOchqaCgjzO4+h6tNtxZjomSGc805uGp3oAlq1NPL23
	 iVaSdk4E1GkqiehI3E8Jl9C5U61ce0AFt8osC6j6Sv4ngDSkj4BEwJZlKfsh3lMAwh
	 OH1hfl84INXaw7gJdsPbR7cUdt08aBzi3/1OiO776LWya9KuiC4fiRW0UMTxnIvjkW
	 BoIg11hIsoIVe8SgR9AZaLVcql8IvY/VB1faiEcsVkKyxygUZESJ6Skh2ZsIViEggG
	 oXR/XPJaJnQmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE463930012;
	Sun, 29 Mar 2026 21:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
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
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: wan/fsl_ucc_hdlc: cleanup ucc_hdlc_poll
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177481980529.469895.8262496906167852994.git-patchwork-notify@kernel.org>
Date: Sun, 29 Mar 2026 21:30:05 +0000
References: <20260326100232.904289-1-tomas.alvarez-vanoli@hitachienergy.com>
In-Reply-To: <20260326100232.904289-1-tomas.alvarez-vanoli@hitachienergy.com>
To: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, qiang.zhao@nxp.com,
 andrew+netdev@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Mar 2026 11:02:32 +0100 you wrote:
> Immediately after setting to 0 we are adding to it, and subtracting 0
> from budget. Replace with just assignment and no subtraction.
> 
> Signed-off-by: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
> ---
>  drivers/net/wan/fsl_ucc_hdlc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - net: wan/fsl_ucc_hdlc: cleanup ucc_hdlc_poll
    https://git.kernel.org/netdev/net-next/c/57ec1622b62a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



