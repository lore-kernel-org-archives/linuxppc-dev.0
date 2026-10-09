Return-Path: <linuxppc-dev+bounces-29085-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93E0CA601A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 06:10:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1Ggk4jc2z30Ng;
	Fri, 09 Oct 2026 17:10:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791526242;
	cv=none; b=ELfi/E+IBq+xZ2rieCG0BdESYmL4ax60PsNYwFzYsVAmCUmObmLGr9Nt+OcPluGGd63NpT1TbMXM+LFmFnA7gYjAMImTX/ft5Hty+fOITk4m0Ob/0oZQ+Xa0G5fsjxi0HXUg5MbmGFk4RtmcFZekGA29ilJvNpS810EvURLolaOMnBej5QW7GzphOCpMZqDY0G6B0EsrLbL5V+2rxLvMi6NRJjO441mg39TjBV2oSx2GsLAbMnybn0fYuQ9TT+vAu2Lx+nIq/sKYMhCN/e5Ojy7u6tNu3Cw+Or9Gbeo0b1tZgQawGr9Alw5ouJbk87ZbhZqD42HWcZy4r5jHapMBrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791526242; c=relaxed/relaxed;
	bh=Bnt9ePZGN5hBqrnLAmtnR+vNRgS1zeRKnODE66mwB2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKvA/ZGtc72sJl+9u/475Lmu4WC/rwjgfMyDKm4egAreyp2RnWLeN53i6t4hSE5k3JFuSC4LImgWNNlSnxADN3ypq4aKlhVDU+bO+o3VR6vqXDpykfpgyrnxTOrKKXn+x5KgzjpdFaLjTVGipbhPSuAiKZ7efE9ltwpUnWzGSmqxVWiT6whwskjHO76LQ9mtQ5xT7dvWc9Qi8/FJ9z4YJR9AlclJ3lnByBqpquqrk9C71ON/tJUr84zB+phQB1bp3ISBkIvgNr9sxmSLkehSFpD4Rb84b8BUfiHm81rQWCsIgGlkjsFvYi514NFWlkoW0Fwk0E4eOYasocqVoQqYww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YYI0RK2f; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YYI0RK2f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1Ggj2Ywnz30DZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 17:10:41 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D65194078E;
	Fri,  9 Oct 2026 06:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE73E1F00898;
	Fri,  9 Oct 2026 06:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791526238;
	bh=Bnt9ePZGN5hBqrnLAmtnR+vNRgS1zeRKnODE66mwB2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YYI0RK2fKOWNLtf06iFFTM/c2Swa7r6ktaEWLBX37GtHtm+y8br8hoXW8SfoxMD6X
	 p9wwdbmSNnqM2lgVvUavLWls7JV8YBJnzcTAObR2B6/3NGPzfKRZlggneb/4qyzH/0
	 CoxZ6wIcuBTRLLWoKx6C7uL1/xm5WloPiQJaFIfcdO7BFq1wxH/Ct4E75Uiyt1NsGj
	 bbeJ0vC1Zjbg2mKFXXQ4mQgI1vsLFusKoul+oAph61wmotwXv4atCQF3uK4cJB1jZ2
	 GvypOvn8fWj2Dj8X/CjV6Or2ldbcBTQV9snCTrkkecd925NqZoZjp11i6AKUoOH5qf
	 L+0alVP96hUeA==
Date: Fri, 9 Oct 2026 08:10:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: Michael Ellerman <mpe@ellerman.id.au>, 
	Hari Bathini <hbathini@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/opalcore: fix device node leak on incompatible
 dump node
Message-ID: <20261009-lurking-curvy-piculet-ba68dc@quoll>
References: <20261008190549.2800467-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261008190549.2800467-1-vulab@iscas.ac.cn>


On Fri, 09 Oct 2026 03:05:49 +0800, Haotian Zhang wrote:
> opalcore_config_init() gets a reference on the "/ibm,opal/dump" device
> node with of_find_node_by_path(), but when the node is not compatible
> with "ibm,opal-dump" it warns and returns without dropping that
> reference, leaking the node. Every other exit path, including the
> adjacent of_get_property() failure, releases it.
> 
> Release the device node reference before returning from that error path.
> 
> Fixes: 6f713d18144c ("powerpc/opalcore: export /sys/firmware/opal/core for analysing opal crashes")
> Assisted-by: DeepSeek-V4.1-Flash
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  arch/powerpc/platforms/powernv/opal-core.c | 1 +
>  1 file changed, 1 insertion(+)
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





