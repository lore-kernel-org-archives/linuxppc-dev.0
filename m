Return-Path: <linuxppc-dev+bounces-20494-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE14CD342F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 01:22:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9Hg46dVKz2xfB;
	Wed, 06 May 2026 11:22:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778030544;
	cv=none; b=SL6AurUCKGsAMJl/EsFXV0y2G2NWRu4sQFMEntc6eO7xE2hrhW7n3gOxqffUV0R0Tp7Iwf2x0Lm8aI25FilWSaxRFTjklPDDu5fKRgxGW1FWdRMe3Q6QBWuE906QJHDl8yxaKXVG7aAGRg0PTdpdLLX7hR1tITl2FwQ4GlyrosmOifr0GO3zfUI/Bdg3c1wgieyWpKIC2EXkx6uM5SgCkNruxc0MlKFrmz8BZPh6AL3rqW9pFQ7a7kFRiyx02h780aAEoBnmf/tZ/7xPtBKD9pv+RExxKVvH8C3utSEsJ1pfAiDvewT2U0tsyhnTfZvLOjIpjaPaZOIAersyqm4HaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778030544; c=relaxed/relaxed;
	bh=SyEWqpKmHzDffdAGHxKLrmsP+/EjpXeNigKcpw7v28U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVwLO8Y5VAczj/CccC4Jr8HA39jGrzp17fciSgEk6cIbxoTOLux/REZ+BDL9kLC876e1yNXWLs+kNzYe1Zs/lcI96QTBx7cj3BGx19UPauMZs8as7liKf8AHc8v96OBZGvZA1ig4EdP95Q8LCbo3UU7nAM834Nbfwi7g9aQBRB4Doitz7A8nV0BtJsMaXAKjz5Js54dUVimDT9J8Ee+exMbbNEsXfydfN8KujIRFkWMLfuCIJRUe5ShKaPyxzn8RGBRiQAqlul+oBrfEpt4iR4Pt7R78CoPp8cO4gDsLLjxyVxS84SBJ/SQlElMyiGZxiiSkyV5ZK28/D5H1sM8U7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=D7Aqt45n; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=D7Aqt45n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9Hg35lRTz2xdR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 11:22:23 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6E53E440BE;
	Wed,  6 May 2026 01:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EE0C2BCB4;
	Wed,  6 May 2026 01:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778030541;
	bh=tBZznMZhe/z/vc4OOIqsH+actGAsU1Pg7notBrzzcdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D7Aqt45nWyh18DTHzQ7+alG28Pi7knAAMEh8vClY7mWFq30Onz9PnX/RK9415DXnc
	 fjqdkDgJlRSEH/D7HB+1x1zfK7iBaCgwduNvYmy5tIxX/p+yRNyw8Eji+2aRqnKxzt
	 MeVpcmFbUnBEOdIftVAZQRM90UDGLqwPZ54BqIGSe8Sysv+HR3x4lb81eh1zny8ROZ
	 3Vueo9mt8xzEjzfiHLYLiy2oYY8B52xm74O0/KEnxCM99L1vhfdqWveNGq5/wEmpI3
	 HkwGycho9d9miJXd9+y8HPU/rs3SlDB72MEu2GsvNjRndNcC5VwFQMeip+xTf2WsUq
	 0DFb5UNoHK94g==
Date: Tue, 5 May 2026 18:22:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 andrew+netdev@lunn.ch, chleroy@kernel.org, qiang.zhao@nxp.com,
 horms@kernel.org
Subject: Re: [PATCH net] net: wan: fsl_ucc_hdlc: return NETDEV_TX_OK if skb
 was freed
Message-ID: <20260505182220.29e5f34e@kernel.org>
In-Reply-To: <20260504174406.2229693-1-holger.brunck@hitachienergy.com>
References: <20260504174406.2229693-1-holger.brunck@hitachienergy.com>
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

On Mon,  4 May 2026 19:44:06 +0200 Holger Brunck wrote:
> If the skb was freed in the ucc_hdlc_tx function and the packet marked
> as dropped we need to return NETDEV_TX_OK. Otherwise the above layer
> will try to requeue an already freed skb.

Is this really true? I thought negative returns mean drop.

