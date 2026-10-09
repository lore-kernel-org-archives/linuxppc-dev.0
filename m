Return-Path: <linuxppc-dev+bounces-29084-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308C1CA6015
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 06:10:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1GgH3GYYz30gC;
	Fri, 09 Oct 2026 17:10:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791526219;
	cv=none; b=Cu38vzxwlT92A1zgWhXbTD/2atrSudBJTuofwHPhOsQCYIOZWtpIumSOfY2aDDuFRny8SBpa5yzaBKSJhKJ5InF10oiLZgmMzBl3Z4KErt+WIYJ1FYHNhZewZZv92e32Sx79q8CcRpuRxEGdGQQLnNWdJgMTNfoJEmHuvR4ak2bpFpCdLL2weHUIJrnfVUS8RRhJZVa7Vd4dEwNlUSDc4GLZ6kba7xyxmS9v+sbwQmUlgDS3tGuQ4EfQwPP87+nxnSVr/T/QKRgO7tT2XKq5vKpnnjpy/Pr5FFiLfT4bE7aNnwfwjasKBbgTkzOjK4IUAT6Dcyks66fxVlDAxKml9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791526219; c=relaxed/relaxed;
	bh=1l5hIGSoizBJ4+ECoX3r7MfK+993Pnzr6WRToZvHfW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItXHH+GgLLDCm9ywTY0FdW6mtg+KdRVgXdNPqJiNFGUKQKdG81VFIyAQ8NCGQjsQgOurRkJXeRi9Sqo9yjxBgio43zEr4XjqpzqaOzyEs1wpbc64PPK5Mu5ow/QYk7wTDGJdngF50vW6px9bY6TkPNfb26JpcTVzgkESp5NNybf9Bz2C2HQp2TtAwuwRk7qnIlPcUOhabdEM8zflStjx6WtnKeWxGQgg2g+1WW9IkWqoQBHs3HuQy0OWlg28Zt/DadCVjlq0r6e65LLnTcl3Ehi4WYlw9ceG6prETcw1tMbHxboKDulW0gEA/NwIldBKtarBc7vBl2uOQm62j1RfLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cuPLDbsq; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cuPLDbsq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1GgG08nzz30DZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 17:10:18 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A7DA160A75;
	Fri,  9 Oct 2026 06:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9939F1F000FF;
	Fri,  9 Oct 2026 06:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791526215;
	bh=1l5hIGSoizBJ4+ECoX3r7MfK+993Pnzr6WRToZvHfW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cuPLDbsqxxrWPpjOtxYva0hqHGIOsTqPhuw0K3MrIPdTBtW2XYREqvc28E/7r4f25
	 AaCh3+hEo+OfBSjJNgMDBTojJxsHb36GvRaLW4ELkXyvJpitzZYupq3mw31apvOqVy
	 rXIplgrkBnVkZsilwzYtlPHxsu1046VN5hDZ7tvR2fdvTtbTTT5N9mTt4ZZrg8KJxY
	 afcE/AbFHac4MVldmoM77HxmY1v7yjpSkCU4RETytekKZVyasSJwSuASaPJJiE+OFb
	 n7R9LIum9vWm/b6yEKJdoOeCFmgpfsgz4pcQSPT38TC4ZMKcp5n1Nnnx5WtD+oMS31
	 +yy8/X2N9mBGA==
Date: Fri, 9 Oct 2026 08:10:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: fix device_node leak in drc-info lookup
 error paths
Message-ID: <20261009-proud-dog-of-stamina-476677@quoll>
References: <20261009035445.3079660-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261009035445.3079660-1-vulab@iscas.ac.cn>


On Fri, 09 Oct 2026 11:54:45 +0800, Haotian Zhang wrote:
> cpu_to_drc_index() and drc_index_to_cpu() acquire the /cpus device_node
> with of_find_node_by_path() and then walk the ibm,drc-info property. When
> an entry whose drc_type is not "CPU" is encountered, the code jumps to the
> err label, which is *after* the err_of_node_put label, so of_node_put() is
> skipped and the reference taken on the /cpus node is leaked on every such
> exit.
> 
> Jump to err_of_node_put instead so the device_node reference is always
> released.
> 
> Fixes: e83636ac3334 ("pseries/drc-info: Search DRC properties for CPU indexes")
> Assisted-by: DeepSeek-V4.1-Flash
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  arch/powerpc/platforms/pseries/pseries_energy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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





