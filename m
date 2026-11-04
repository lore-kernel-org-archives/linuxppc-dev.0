Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204DA606D83A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hu3PpFEq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKWKc0yLmz2xdb;
	Thu, 05 Nov 2026 03:36:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793810180;
	cv=none; b=CUkfPLzJRy9bUNbAFJH3RewS23rDRW05xsbqVWqwzASBJ6pW9gnSDvnSvMuM8ZqJLFT6CkLrRSB0wciZ/NQzJvcWNimGghjgqNtDdg2tDoENaklytlGL+Fcj0+wjg72fdM+C8OqSo1RnAaOkn947C8An6t9hjIWyoQg7yaP0bhACXhhzGkEGBspu7P4PYniMrx5Rx43QjYAYn0mAOlMZOBTIL9F8snrgS8jAWea4ne2AGKUjoM8d1o7nTrmRccTRbHD5lHtCwLTCsmq4FRaLBGZD7bPgFGi5TOGfda11LGh5l57kEc1F93rd/6gnQwcQev5p3l8KUiwuszWbPQAxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793810180; c=relaxed/relaxed;
	bh=cDbBGbbkWjMCN3YoXpVfQqChD+m0tIhfsBNrMkEf1Ck=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iCW+g+SdaV+tFr3nkM59JH54ds143L1IoERlgFtX89MwhHQWla04f7hRBNlUkv09A7TPqaOqC5U8lmsAHuhnZv/tP3pNAWlDNNMucFF8QIXV6AWJMlajcDs6GZn37IGG6DN7hZh8athGoBxYYoMbuRE+q9C226qmC76lDDirIv7nVN+cXlxb0srjvUwhcs9tuzx/mA9CMiqaFNL5nfa8JZtpTn3OBhZB5eh9Kwj+D7njcI+R4HoKbhTqB+o5dm4yIxN5kGR8Ww9mfJfpPksSxvg03KMykhozlRTS7NXQpWrq24SVvgeAp+FOR2nsaeeJ3h9eoRVwx0uYAaXivtXuMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hu3PpFEq; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hu3PpFEq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKWKb2Xjbz2xcB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 03:36:19 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CE68343F2F;
	Wed,  4 Nov 2026 16:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967F41F00A02;
	Wed,  4 Nov 2026 16:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793810176;
	bh=cDbBGbbkWjMCN3YoXpVfQqChD+m0tIhfsBNrMkEf1Ck=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Hu3PpFEqr5f779u7yB2Z2s79tJ3zFLorX9Y4hhr+SkKLNq2sKtf1PSghB0x/z8gZJ
	 /WJz4jwnkGENzOnAdLCYLhFftYtiiomx8t8DqHDuwe6uRgNkqc9DOwjcSNFbOX2+D/
	 IQazj6sG9NMRHo105Z0V/HGDB21RF9HwA7HXjESdOsOb3RQjOaKZP9IHrR6ireXCFT
	 F/d70+DjAQgv1/EzGlZRpYA548lQWy1AgEaQ6tXm7HCYUoJ9dOjhcuUo7yRZnH06Ox
	 OuaFnh0SWN0gBSA/5GCeQ5RS1DdOPY8nGAeblKHaF85vCCZ6dDaq0MmtlxLoNtJgZ0
	 6CDZO40IAms6A==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 5E8AC260FD69;
	Wed, 04 Nov 2026 16:36:14 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, Yige Jiang <yigejiang86@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <rc-review-20261103-07-1337c123a4ea@gmail.com>
References: <rc-review-20261103-07-1337c123a4ea@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: pcm030: release the platform node reference
Message-Id: <179379246392.2456854.10933132535673763460.b4-ty@b4>
Date: Wed, 04 Nov 2026 11:41:03 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1124; i=broonie@kernel.org;
 h=from:subject:message-id; bh=UkkLwJ+LYkDLbS5A4697Il7nAUQhqXO6ao/iZgou5vM=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJex/27fUIrlN1hdf6VDfVtNZxLbxXIGUsp/Xrp+v79g
 9KLN15ZdpSyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAiZ38w/BVKbNjzn78iOlOO
 94p2Z8q93azt0cIi2lcF6y7ZZZd3+DP8010ZzsbJvzlEP3sLW8cp33mlJ7+/jIyST9MxP7FgX48
 HDwA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 01:43:33 +0800, Yige Jiang wrote:
> ASoC: fsl: pcm030: release the platform node reference

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: fsl: pcm030: release the platform node reference
      https://git.kernel.org/broonie/sound/c/c526eaad1ada

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


