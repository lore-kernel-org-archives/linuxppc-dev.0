Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C5F606D81A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAW1KUUe
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL0vj6jZdz2xqh;
	Thu, 05 Nov 2026 22:49:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793879345;
	cv=none; b=ExODS9+l/yRa4qKpmDCYaoh/nLPyizMC/BVvkw6JfazH70nlZZVMSuKQevEyCrySUBq/luqtmmkOPXxZoTsoC3CMl6nA2AXLn79Ll7czdlqO/u8BUx8e/3Pz7tEhhIeDV3mMxJwh78RaULwSswXgYWhLqsc1vOZLU/cn8NYLz1kc1kHYQnxtaxiYgFLDv7SAATrYGaflQ8RP+r+QVJ+m0FmoNez2YjR+ZIcvXhPMMbW1TZn93apQhzVs2o5egDSreQTqE2DYDelw+wy1c3GzQxnqnDJPtu98eLS7HQ23xMI46co2eG8jXfLEk6Po/uk+9Q33q6vZrshX3Vf1pQd3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793879345; c=relaxed/relaxed;
	bh=/jC5d0rS+q4cmxCF0m5PTk+OxcNoBs/3lqvduRzrOxM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ko76mwzesyHvNAUs5eZ3U9h/+I7b+gezUWcusbX9N6kAeMhhzmVi1Ohbue/GBBr6Z4mog6d2orrRS0AbsQO40cVKkrnFXRX+M35ry+8G3E+TGDAj9C1NxLILNFbiNbgkFRU6PfBlVTIS+n81o0n/WyQ1kdeqPQ3BOXlZhJFAVLHG8hOKhipvI1zOuHku6efKRZbkiZvvOaJiyrErZBBw4YOrB2aVFA4Ub8xf0zWL+kIDl/lFvotGJZ9AoHv4ogIloYV99W/RcL/oRa9gtSofHRBYQT0ftVNU2UtA6rbd8lp4qPZVx6ba5ANeN/MSHUTtggeZCpe89BDYx7b/qqugWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAW1KUUe; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAW1KUUe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL0vj22pHz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 22:49:05 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AB29E605F4;
	Thu,  5 Nov 2026 11:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AFD1F000C1;
	Thu,  5 Nov 2026 11:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879342;
	bh=/jC5d0rS+q4cmxCF0m5PTk+OxcNoBs/3lqvduRzrOxM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=aAW1KUUemLZXtLiBscLQMkwARKKI2/aCuLMFxQSgl5oGf4UH7b0ZE5F7dgXXx+uZq
	 i1rn4ANcWOW1sksF9sSPcSWshA9NN69aiXUsdNheSiI2ynrZiP5znuFSwxtnxE5iQp
	 uwvI43SzVYNEwLfkjWnCWPfwnOhFqfI3W+XTr80TSQMuj1sYxnb9F3mCNXjLmOAmlI
	 1CGONkKd5v44c7O0aehmvrpdwY3YHOjbHhxnLq3A1IEH5fHUvwqSjXXFtFYcLMXHFc
	 vIxV65dXJY2lkNDVVKjyyi0YCUB0CI0umuMrVNpWIvnDtgRBuDAH3Ei+bfYsOuvgiK
	 Vtwfu4x51L8Rg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 3C27B272EB3A;
	Thu, 05 Nov 2026 11:49:00 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20261104022815.1484320-1-vulab@iscas.ac.cn>
References: <20261104022815.1484320-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: fsl: imx-sgtl5000: drop codec device reference
 after probe
Message-Id: <179384023780.2186205.14628179165151508431.b4-ty@b4>
Date: Thu, 05 Nov 2026 00:57:17 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9xMAwbkFcOKEheJ4m/qgkj5cYKA3wwz80aPGGbWSH9Y=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLe5OrMXRK/fmPJnCNHdi4wPSZSwylZPO1fVFHWxOZUh
 jP1lpasHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZjIhkMMf7j9L22TvfX1jODt
 4IVXlAuWOq+TdPVeuG7+5hAV6VKOvWcY/gpvZwzN+Bx3fkrxn5VVkl3zFZ+UOm8+rtk2N/HuUmt
 5CS4A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 02:28:15 +0000, Wentao Liang wrote:
> ASoC: fsl: imx-sgtl5000: drop codec device reference after probe

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: fsl: imx-sgtl5000: drop codec device reference after probe
      https://git.kernel.org/broonie/sound/c/53865f2d4974

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


