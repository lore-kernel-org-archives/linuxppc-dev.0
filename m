Return-Path: <linuxppc-dev+bounces-16648-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61225EB28D6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 07:25:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6lwX0ZBKz2xqk;
	Fri, 06 Feb 2026 18:25:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770362699;
	cv=none; b=G5g2I0quvlqGaySFB5si2vErSNZHpSLrAMQccxFehUzFS4bDCuXkKKrgzl9R2H1voPcqWR9W4WM/JT6tG7lBKbLyvy32+bm2PC8AuoBkJvquEwToXrh3V5oGn5fE0P1IphEoAd0E6Qa3UESGXfl45ljgneyB1MJV6V8BPHgNWuEQ6kv7vj6WX6poAjmfLFWkFPY75UPB57nsjRZk6mncCGj2YNx4XfjbCOcrY9esIqM7tHUR/iuOui/ia76hnG7LGUvBklWy9ZlzeymplK5LIAcgxiWvKglYk4juec+Cc47IBfEWkMi15aBoM3YTHyheUjEy0EKKEbD/NsyYLrWTXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770362699; c=relaxed/relaxed;
	bh=1No5ZvlsgoJE+yC1Nqoigxav4jf77WH/f2pLm5U7tZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HB3NgtcmQUsZZxe5FY83a5u1IdrucF/1BHiI7aHwex7myIPPPFzxV8r31rqoRWRuo1/xljxXOM3TwLKV5aHjDICc4GQI/kM0Nu2xD/72F90L99pmV6S3IE5N52IlF+Bv6WMKf57ud78F9h/dEzDO74NJfcRgbjK6Q+NGcQhaUCeLXRlBE4F7GtRjvsOaG4/JNGLfwzN4H7CGUKcGPhEiPbTg4DZdJiWlXKNrz+GgDjez75HXHVqTaf06jE1Ufrs4nj0mpYdFeWS8lX6KJoxWPFRaB7BMXoZsdadxZvxu091TRYW2Ml+dXiu2ELgKwxXWV9IV2OffKjOYZL59V8DRQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sbREU9Fb; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sbREU9Fb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6lwW1tZ2z2xWJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Feb 2026 18:24:59 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A1468600AD;
	Fri,  6 Feb 2026 07:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EE4C116C6;
	Fri,  6 Feb 2026 07:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770362696;
	bh=P0NhoGMuk6PH5jP7ZeN3aTohFrPPtEmPqpM83aqZXaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sbREU9FbWU9quRswUeOLIUKRE/bDm8Dd898bYIyaKd6lRBhYQJrYLNlmiR48w5HJ4
	 jX2mqq8d3PeteEFqF774P+9ph6+X/ttO5jVW3/leuQnp2Jkb0k+apFaCiR1vmuBbHv
	 wdSXX/rzHb3FF+wJzpgK9mwJBFG0hcpwtPoS32pMdOAuAJBAgg8vP5Y36F4MhMdjS4
	 GK/WQ6rbmR5Nhf/5eHsddDblCy+bEzTIDoiQWnWkGcB7Ji873P2pFFlVovIO9gQxAH
	 8Y1UacvCmVaf0inBJTc5/wMA3qGIO6P7gYyKMPCVvA2vsQmNsrxMw0uAUTbiZoYT4Z
	 3z9sYGgzA7RNg==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: CHAMPSEIX Thomas <thomas.champseix@alstomgroup.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Kees Cook <kees@kernel.org>,
	Roy Pledge <roy.pledge@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Scott Wood <oss@buserror.net>,
	Richard Genoud <richard.genoud@bootlin.com>
Cc: Christophe Leroy <chleroy@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: fsl: qbman: fix race condition in qman_destroy_fq
Date: Fri,  6 Feb 2026 08:24:38 +0100
Message-ID: <177036249397.3323736.12618812589949729211.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251223072549.397625-1-richard.genoud@bootlin.com>
References: <20251223072549.397625-1-richard.genoud@bootlin.com>
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
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=chleroy@kernel.org; h=from:subject:message-id; bh=s/9qncZXkiRO4FXncL0CjHqdtLNJ8JipcvT2jBzGz1A=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWS2Tre68l9pplRo+duDR+4UMDO8TeRLrLGK//YjganWS DFS53JRRykLgxgXg6yYIsvx/9y7ZnR9Sc2fuksfZg4rE8gQBi5OAZjIbz5GhuNlWybsF21xr89T cmaMu/Z3Y0n5hGaNlvP13jG8coZ8pQx/ZS5NcztynVX7xYaddo7idenxPOsU3yycyzuvWt4kNSe REwA=
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Tue, 23 Dec 2025 08:25:49 +0100, Richard Genoud wrote:
> When QMAN_FQ_FLAG_DYNAMIC_FQID is set, there's a race condition between
> fq_table[fq->idx] state and freeing/allocating from the pool and
> WARN_ON(fq_table[fq->idx]) in qman_create_fq() gets triggered.
> 
> Indeed, we can have:
>          Thread A                             Thread B
>     qman_destroy_fq()                    qman_create_fq()
>       qman_release_fqid()
>         qman_shutdown_fq()
>         gen_pool_free()
>            -- At this point, the fqid is available again --
>                                            qman_alloc_fqid()
>            -- so, we can get the just-freed fqid in thread B --
>                                            fq->fqid = fqid;
>                                            fq->idx = fqid * 2;
>                                            WARN_ON(fq_table[fq->idx]);
>                                            fq_table[fq->idx] = fq;
>      fq_table[fq->idx] = NULL;
> 
> [...]

Applied, thanks!

[1/1] soc: fsl: qbman: fix race condition in qman_destroy_fq
      (no commit info)

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

