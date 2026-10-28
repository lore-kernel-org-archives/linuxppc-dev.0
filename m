Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18995606A327
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 00:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgI+KYN9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFPmJ0DjMz2xg9;
	Thu, 29 Oct 2026 11:11:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793232703;
	cv=none; b=ABeR0JMeD8i3b7w6kqvo0tHA+Jb/0azO/H6sgGG1En0G5YV9G+YaGWR9SsJcQ9Gh6ujv3RS2ZmX1lUIaY7vsygzbldEcN7lNHBsZkuikpbN4FXWfvLGK3w/EdzixwAE/4yU1HqEZR4YNnJtbtbOuovIWltVQubn9kwP5+Jb9FGiVfib/Aw+sarTA7wP7ctgyQyc/mDfG4lIhjK/vlbQZRHk3QAuIHI3uziNCXk9Cge/qqlEWwciN6BvhyO5ecbQzR2KlNO02qguzXMc4kRKtz9Eq7qjh6PbgQcAO+QetzWc6Co/0kZKMGOQ1LewoAcTF2lvfP/KBCnRGHHwLHDABNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793232703; c=relaxed/relaxed;
	bh=3P0Hp+F33aoisJ9L2IvNEQy8ShY87tikSrvoj3cvgQI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GeGvWTB3d6AgI5Gv4hlVUJnJN445EdvYdLtFklORMvDPTOumMJcXXKLLBk4qKe6mpJ4vL3m/1sxT+4Q0kIlInjsReNlyCvQ5r+THpqbU3Mm7MSHgTjOwOtwn3+T2Day8Ayi5N1GsTiauPGyVrB8yGOfGK5PtLlfHYLBQNM5Am80r9nN3noycoX5wLif0TBaXpRWXw59ufUGYOLXy1o4y8fDYx0Wf2WcNqWVBGbJBK1Sd+KIZOltDch6Sn7xWBS8t+qZu1A71iXDdbHHOwrlRQvbVHo/mE73EqfNEClsouYXfOeLJSJTCutGqZmCm5ym0Vrv1jAbnYH9QMcH4+X3JrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgI+KYN9; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgI+KYN9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFPmH0JYGz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 11:11:42 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D990243A18;
	Thu, 29 Oct 2026 00:11:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A51E1F01825;
	Thu, 29 Oct 2026 00:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793232699;
	bh=3P0Hp+F33aoisJ9L2IvNEQy8ShY87tikSrvoj3cvgQI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HgI+KYN9iy6ql6cjO0JaTmBBW+Thv5+iKbbY0zHUoPcqV6I3SuII1pdW0RtYKloWK
	 4oc4sU7VsBlzi8jB9IOuqvHTL2/9rkzk7m0PEcYMPQ6XSlg5OpDPleO+Jq/29cxGbO
	 bIK1EYtRU1UuVGraVFnjRvEpyP+EHmQRsPEpLOjhR24zryHHC0tkbQbMaV0R/whhO4
	 ZbnsFGULcyuzOYX3NHJTZd2aTfA2Izt3YlIACx1OqFY9uvczKlxz1C7SOtROzYr8Tg
	 uuMpMKF/OHnn5anRSup36kkbnkWJWT3wySJkwlc8Oo1Fj5vs1txmShEBB+/ed0wlIP
	 sqvk2khLg4m8A==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id AB5372062ABC;
	Thu, 29 Oct 2026 00:11:36 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Chancel Liu <chancel.liu@oss.nxp.com>
Cc: linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20261019-b4-imx-pcm-rpmsg-concurrent-v1-1-c1fb8c33f4db@nxp.com>
References: <20261019-b4-imx-pcm-rpmsg-concurrent-v1-1-c1fb8c33f4db@nxp.com>
Subject: Re: [PATCH] ASoC: imx-pcm-rpmsg: Flush pending work in hw_free
Message-Id: <179320705881.1308637.1526280484324452440.b4-ty@b4>
Date: Wed, 28 Oct 2026 17:04:18 +0000
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CEWA5BCsM2m+RdihV34Cj2j9qYJA3lhTL7Qhy7yDHcY=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIe9VsYLVC7F5gwL1zUeM1SO6+iiIBTpgxL2U2+ZzSxq
 pvn/dzdUcrCIMbFICumyBKXxf2yvuT1Gr6DC9tg5rAygQxh4OIUgImY5zAyHHzWJGxVY3Jjq/C9
 1X9vJa1b9je5/F30yTuTPlXPnu50goGRoUXzkv2buKs13sHxd+w+f2V1s42NYxQ0Tm248PHbc/f
 TXAA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 15:58:20 +0900, Chancel Liu wrote:
> ASoC: imx-pcm-rpmsg: Flush pending work in hw_free

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: imx-pcm-rpmsg: Flush pending work in hw_free
      https://git.kernel.org/broonie/sound/c/bbe41586cdfa

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


