Return-Path: <linuxppc-dev+bounces-29083-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE76CA6015
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 06:07:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1Gbg4LQtz30DZ;
	Fri, 09 Oct 2026 17:07:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791526031;
	cv=none; b=UCVRzoK3HdJAikE6Yk0U/zkBvFACasPA0ON3BhyZqBgyP99NPxTDgw1ZG5CZ7YHNnVAJa+bMmJBg6zsdLCZajEHf1+AJvQJyKx8CG+k6p29a1F98k5qbpAO9nKKwtm1vx2lGmnRGT9STSumafcpAISA+zRHHlN03HC3HEPkDGTOywbs92gH/KVETf8blYDMgIAbg3KIbYlUHy8qiKoJiTU9PLggwL6LPReEuPcYXNmYMXDamN5ytJrQG4+FWZvcPkPCVHVVLM46Pyn78xhO40PQabBg6B+ocQTrfGY0whuzHh1475mCQ73frTNEOupmuaiE/beAwxt49IX3j3qHQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791526031; c=relaxed/relaxed;
	bh=/du9wEuofXf+8NbTewi6KKBVFh5WF8XdhjIfsLZhNPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/QjVXnIbnaEkPzCSubtUy6qWuDIzqTCvufmdLdFa0NXLN8tBBtCUy7W+/didOL/Ap4BbttrJscC1cNf8PKFxvCBt2bJC3JnCBwE3LAWO9NsZrJlHdO1RiAGGF4cA0F4/eYEvw+qBMhKO7Mzz90I0kjjogB1sLxOdeY0jNcfCUhKIL27USetyn/7KxWr9ky3yOmeBGEUZJ+U5K8KtDbbPqJXPAj5toArgpl/8wyNgAyCjNsHWUuqFOPFEpOZxx6MLhBy5VnOl0Vr1nBf9lQrxMSvMtcM5AsHpD8iVFd6O9NrngosAChmk5a8vkbIn5cC/2cIr+ilVkUbT/SkYubIng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJn2rdhh; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJn2rdhh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1Gbf5yk9z30Cj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 17:07:10 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AF45943EF6;
	Fri,  9 Oct 2026 06:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9951F000FF;
	Fri,  9 Oct 2026 06:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791526027;
	bh=/du9wEuofXf+8NbTewi6KKBVFh5WF8XdhjIfsLZhNPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZJn2rdhhDpXpLRyXCcGSYUFO/xWY5xiZdafVQU1xOzhsoWwUAkE7qApwY0rbkTBQo
	 7vNmfT4A8ISrIKc7VP5ODQFkITYw2+h61ovVyxopBilrL0H+rbDIvOZoD3jNjoI1t3
	 AFcNV0RCk81mpQcDL/Mex9farBXuY5MHc7tA/gOZ1v813oGm3pOSTsqduCMD25YPZj
	 2tEzVXH/3tygzuSFHZnvzo/o1s/VU/EyEKHe7lKokp9hFxK+rFam01Z3rqP6TnyLWK
	 K+bIYmQ/yyHq7F4oXZuAGpqo4oESvdE6t85AgcEYs+LtPPaQzMwjaMHnYgT5SbGmyV
	 iAUfzwcY6PAQQ==
Date: Fri, 9 Oct 2026 08:07:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	Qiang Zhao <qiang.zhao@nxp.com>, Herve Codina <herve.codina@bootlin.com>, 
	linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: fsl: cpm1: tsa: fix wrong clocks released on cleanup
Message-ID: <20261009-serious-jasmine-bumblebee-10ae3d@quoll>
References: <20261009053720.3146117-1-vulab@iscas.ac.cn>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261009053720.3146117-1-vulab@iscas.ac.cn>


On Fri, 09 Oct 2026 13:37:20 +0800, Haotian Zhang wrote:
> tsa_of_parse_tdms() gets and enables tdm->l1tsync_clk and
> tdm->l1tclk_clk in addition to l1rsync_clk and l1rclk_clk, but the
> error cleanup path releases l1rsync_clk/l1rclk_clk again in the
> l1tsync_clk/l1tclk_clk branches. The tsync/tclk clocks are leaked --
> never disabled nor clk_put() -- while rsync/rclk are clk_put() twice,
> underflowing their reference counts. tsa_remove() has the same
> copy-paste bug.
> 
> Release the clock actually held in each cleanup branch.
> 
> Fixes: 1d4ba0b81c1c ("soc: fsl: cpm1: Add support for TSA")
> Assisted-by: DeepSeek-V4.1-Flash
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/soc/fsl/qe/tsa.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 



Multiple things here:
1. Your team ignored completely previous feedback.

2. You use multiple identities with this email, thus I actually doubt we speak
   with actual person.

3. Finally, same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document usage of LLM and how what you should not do
if this was posted in a good faith.

Best regards,
Krzysztof





