Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EAE606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FY2ih7k7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNfVY6Kd3z2xWt;
	Tue, 10 Nov 2026 06:09:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794251397;
	cv=none; b=eXCk9LQMlkMqi91sSIlGpku1/YPgj/Snqwmd3BPSCWiKKxQgGtJz7ELI1z2ojEExGFMoE5rRIZ15/0Wm3zGccK4yngXu2qx0zpjkQxyTAdVQtaOKoCGDPnv+IC4DkkKV/4R0og1A0sy65fR8LXSxhm/AeF6JqBCk5fT9tfwczVP+uGQsnc6XlLdTlSqantbgPfOgmAb248u1/MaesEO8/4Ntqxgh7IljTiSMODdjseQ9RLaagEkMrRFRWCi+4ht08QlqzZzhHQpKNFrXYkb9xGtJpirieiFIFwNWk+ApQsJrzfvNuexzSeSIb6tkq8jkPOHcvYsCm4WIceZ1UDQPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794251397; c=relaxed/relaxed;
	bh=bXeo00zC+Fz/YIEVBhgtInz4Kk8T6T+8sTaeNUk6/H8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SLSTAa5XKfRFgbi/VotIJnVG+7cRfnOp1KbPHoa6O4ifOv+8uRnzKwj5F+U/zKp+QizC9FXZ3QaFCXnoXfiAdKETeS+hARQSiq9DJoTqkPJBHdhaJFlX3qHLyJ1pFPsaz65ycjP88WtFdo+ZBp9HWL72L5dU3IVrqEihRrT2G8usIFmNepLaCKjc8d4kOzWBWt+m8itGObkeTnzSiwRgS0H2dRot1IyX5RjCI602zKZF5EeCAqsGZYyTdyK5NFWs19GmKLxYAYwLP7XyImY6i8UlbzB0k0WsZ/YY7ARdjZSvtS9tboftKIxSvyqu/mbo3/4ydDkL5ocsm27OJeZ/gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FY2ih7k7; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FY2ih7k7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNfVY05vfz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 06:09:56 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 99DE242A8E;
	Mon,  9 Nov 2026 19:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496461F0089F;
	Mon,  9 Nov 2026 19:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794251394;
	bh=bXeo00zC+Fz/YIEVBhgtInz4Kk8T6T+8sTaeNUk6/H8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FY2ih7k7jZW05Nq+r2TcqolJl5AWk95Qz+JIpGAwh4gjHH93hf+tWO82G9zEarTg9
	 CCjmyPFKTLcrDsBVh9B2u800wiH4ryuUaWjJreMIsUSO8fRW8+nHFaUhzsq16KTUM+
	 OevrxascLS29HAk8qeqx3hzYHOD2+Wm7OJ3yzdR4G2A3Fm7Y+7CeKnGYD5j3CGmme6
	 bYrfFcqaHPkjUrB/k37cRkH8nep1sno3pAPpor1HpwJkkwYdJT9FlBXDEtEtEZur6B
	 tzxsb/idzrgsrYbcmLgxpDVv33c/ppsF+Mz3gXiFnsdvC2v2D96zDhevo2FSyZApq6
	 lJqWnOTfChSsg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 1B85B2F707A4;
	Mon, 09 Nov 2026 19:09:41 +0000 (GMT)
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
In-Reply-To: <20261104024045.1508542-1-vulab@iscas.ac.cn>
References: <20261104024045.1508542-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: fsl: imx-audio-rpmsg: unregister platform
 devices on probe failure
Message-Id: <179424330240.3711751.6306163881108747732.b4-ty@b4>
Date: Mon, 09 Nov 2026 16:55:02 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jg+mpLiVJDLq2jsfv+zC4pV1nIIzTvOIydQhC3VcHjc=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+SZW8+H/+//4LLXvaLs3eKLxjEde+o+822z/YeC70S
 enkR071XzpKWRjEuBhkxRRZ4rK4X9aXvF7Dd3BhG8wcViaQIQxcnAIwkWN/GRnuPNW+UZ2+gG3T
 dk9JCTWG479KdZdJPUs48vPR/PuJ6nqxDP+T2coU70SdsJ7x8nXmtS6uJUtTt733SrtsKiauY8U
 pZccAAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 02:40:45 +0000, Wentao Liang wrote:
> ASoC: fsl: imx-audio-rpmsg: unregister platform devices on probe failure

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: fsl: imx-audio-rpmsg: unregister platform devices on probe failure
      https://git.kernel.org/broonie/sound/c/a3aa7ec56c14

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


