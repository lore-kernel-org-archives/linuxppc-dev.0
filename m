Return-Path: <linuxppc-dev+bounces-17107-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB45E9B24E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Feb 2026 10:19:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKty32HnJz3cLR;
	Tue, 24 Feb 2026 21:19:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771928395;
	cv=none; b=YVhLAZAqNenwfLnvB4ETMlDYGRntacvEPdhZSNRBpgEx41G2/BJW86gwNWHlOXmdjMLgwuV0/t2J9qdtM3qp9GNf5GqJP3kB9fcaSCZ8tZvAni2CoHU1xqaey2RMXXlREE0+LuejHnZbQHfY60z8QLE13QTKeiyp+73LJwC1ys9VlyM3wL8u6lMjTWTlFrDByXYutV14zHeZOaT1qyHUYzKUOmq1vOY+TjiBknKTGwPfjs7srsvYoas4PQncWdVi1IjvBzne0fDYC6XuwVU4a9TE+99kk+QNDtfj9TU2c0sa8uuE9bODNtJPli6FmZhG8BJNFRUzEGU/3NUCWKYUxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771928395; c=relaxed/relaxed;
	bh=5EzL+ErhkAAWQ3kvmzsoscVzRGE4s0aOH9obyVOoulk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihkMhw7Jcj2ZljeBI/BZ7jjm5ltVLCntVo4ym1g1/eQc3RFcsS9inkqN2xkJxInP4mUnJZW5IkzXTmUR4yF+MVMpwWsANUeCdzBGKSwa/H5+51PVQwsc8RkE/B0YDOPEztlQh7Lj72BgSK8oobmAzms4mS4BmatS73ahU13L9zNeyxJRBGBTXuDts/a97r8QhbjLi8r90LJJXvtqJ/UjyDA0kCsPx+ZSHM/KmiH9mOuI09UN/5e/F3C4YZpLVynEzGpNDoOc80urwKKivMoPXFBqR8IlmcKy0fwj8w7XHTr7CTsgOMkoEK8hg65M/7xmdsouQKQY6JVPrBIl4nxQTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rwzDOA93; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rwzDOA93;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKty24FBKz3cLN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2026 21:19:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5AA066132D;
	Tue, 24 Feb 2026 10:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098FBC19422;
	Tue, 24 Feb 2026 10:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771928392;
	bh=fIXh4FVUt5VEHxFr0HBf8S2hQ8DjDCocxqimR0QodIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rwzDOA934TyaoEDSurzQdMfNuTutWxevhF52tTtyKATwwWsPwYOngo+IUI8i5wfMx
	 cFsjR4SrD0K5taMJWgNrueqt67wfqGv4uAcl4yAPxDGt8Wb2Fh/Gx4SHHjP4f1t7jf
	 a+aO3hdLgqEkhWWQwAdlBIukb38sRZEltUS4P8zis2ddpUtcOwevElo63PoNB3wJRV
	 DjoBygu4Yes4HjImpBwhQ+iG/yL+z3PpeMqZ0tnOz/YWATtrxp06E/kky98Tv2aMzz
	 jmtfU8BghutsHYbEd0mbpVhusRE+HQhFyvZQ8k3Tw5lLdMYlE/Z+3m1Q18BrP+CM/0
	 xWRc12XvI88gQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vupWA-0000000DIo0-0XT2;
	Tue, 24 Feb 2026 10:19:50 +0000
Date: Tue, 24 Feb 2026 10:19:49 +0000
Message-ID: <86ikbma1fe.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/6] fsl-mc: Move fsl_over to device MSI
In-Reply-To: <d289cacf-043d-46f9-9337-b6249b294c24@kernel.org>
References: <20260218135203.2267907-1-maz@kernel.org>
	<kukzdg7cym2cwytx3zgbu5ik2cw7c2zq7irwp6q6o4jzupjzla@qgkrv7emus6f>
	<86ms0za8e0.wl-maz@kernel.org>
	<d289cacf-043d-46f9-9337-b6249b294c24@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
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
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: chleroy@kernel.org, ioana.ciornei@nxp.com, tglx@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Hi Christophe,

On Mon, 23 Feb 2026 13:54:10 +0000,
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:
> 
> Don't know what is your merge plan. I wanted to push it to soc fsl
> tree but it doesn't apply on top of v7.0-rc1:

Not completely unexpected, as -rc1 wasn't released when I posted this,
hence being based on the latest tag from Linus' tree at the point of
posting (v6.19 in this case).

[...]

> Let me know how you want to proceed.

I've since reposted the series at [1], based on -rc1, and Thomas has
indicated he was OK with you merging it directly -- works for me.

Thanks,

	M.

[1] https://lore.kernel.org/r/20260224100936.3752303-1-maz@kernel.org

-- 
Without deviation from the norm, progress is not possible.

