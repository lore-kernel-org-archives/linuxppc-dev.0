Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615C6606C571
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdlyZ/Y6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJm7y6Nq8z2xMQ;
	Tue, 03 Nov 2026 22:10:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793704222;
	cv=none; b=ZbJpcFyEweAVGwN1AiuAKcZHckXvDk0msAsLok8/ZycG+5q33CRsTQ/ywp/COmiuUzE/vzvmtVO8AFS4H21HOi8Ri+ug+yncgpu2Kv2FpHK/t7piHeYLPSLAjXsCCFMr9U6co2bg05h3mtxINRC95bZT83HBR3oaaEkozb8hmzSgm6NkmNBAeZWKyCdrkBLJuTpLsChooqsPWgmxtehaspaZGGP3pD/lXyVPM+f0QEMEl3vVjpzbNn3PxiH2iJpQgbuDFFpRXtRK6n/Q3Jm/jn4WC/0bBL5lfVZFI1djXO0oYdUFvqvWGNs4wOjW7DebpbffJeFHPgdZ8/syPXFudA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793704222; c=relaxed/relaxed;
	bh=NcMf+ZVLmz04u/HN3Wxip9DQ9rG8PD3kxPva+jU7U8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2SiGIhpKvsij1Kt9Lt6VcwktNhTu8JnPotXn6yf7l/2eeg/Iv3dULo4ClUZ3iJHoc5ucG4j3V5CupPZzlGGpFR/xUBl+IJSqVw3USfJjbgok6+T3UqEFcawElauFqFssZ5t7njWH4JWeHImojlHDok+dzy8IjlbIplJoNMguBZwynLV810k3dNdAbEvYrzok+pplDmUmWsBhUbB9v44noJbqriJc80xHIf01hcx5r9auJaFtXczEV+2p0J49hgWisH3WDCMH4LxjfrT8Kj09O/7OmCfZrlHAt9hhjgTl4Am+rvY80FugPdzZ4cNDuzIfVtyhi6ntVVBfBga6RkYPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdlyZ/Y6; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdlyZ/Y6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJm7x58l5z2xK7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 22:10:21 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C18176022B;
	Tue,  3 Nov 2026 11:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B348E1F000C1;
	Tue,  3 Nov 2026 11:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704218;
	bh=NcMf+ZVLmz04u/HN3Wxip9DQ9rG8PD3kxPva+jU7U8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mdlyZ/Y6k0sbdKbPikMDKXgsUtOAz5HrJRPAoVFXjshi76nsuMvVkkNHl84B39eLt
	 mylrl8mWmKM2EClq6buoqHPVskn/HH+gGTbb4zYZkydPBBaG4OhhTvpUVrSChfZPQw
	 wc0nYOhZbdHjk5953sL3BwLrcZzaeN1Tzir+BqaLaTNmwvl3Y9FqA5jyIbdpZvU4z8
	 cyacM2376J6s3vZMEcviRg5GpWEPOQKC93qLHBlorrwsozfkQl/m00ZSnL4rzhAxjZ
	 dRxtNnkk/4oSqbMt4iEGK0fK9XmmAXGlgKl/iEQTZsK6oPvi2WIZzF4EMTBXD7JF6O
	 vK+JeO3lmMKKw==
Date: Tue, 3 Nov 2026 12:10:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	linuxppc-dev@lists.ozlabs.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Zhao Qiang <qiang.zhao@nxp.com>
Subject: Re: [PATCH] net: wan: fsl_ucc_hdlc: release the net device on remove
Message-ID: <20261103-psychedelic-malamute-of-health-ce7f30@quoll>
References: <20261103104237.1373675-1-vulab@iscas.ac.cn>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103104237.1373675-1-vulab@iscas.ac.cn>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Tue, 03 Nov 2026 10:42:37 +0000, Wentao Liang wrote:
> ucc_hdlc_probe() allocates the net device with alloc_hdlcdev() and
> registers it with register_hdlc_device(), but ucc_hdlc_remove() only
> tears down the QE resources and frees the private data.  The net device
> is never unregistered or freed, so after the platform device is removed
> or the module is unloaded it stays registered, keeps its reference to
> the module and is left pointing at the freed private data.
> 
> Unregister and free the net device in ucc_hdlc_remove(), before the
> private data is released, as fsl_qmc_hdlc does.
> 
> Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/wan/fsl_ucc_hdlc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
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
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof





