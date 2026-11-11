Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB3B606A323
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VgXqKn+x
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQJcS1Pj8z2xLs;
	Thu, 12 Nov 2026 22:50:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794484248;
	cv=none; b=eqofJiO0AuJv/A+09oFJ56xfyEZgWdytZcbOxnBJCXEkSY0H8oRITM8QQY27cFF0cZoHXNUXdGSWzXm0Dpk3/wzva0qkMDetM42HWXOCBYQU+ZeXNUzhu2qL8wO1NCB7+xhysTdq9YeGItRx/KRY8lM0oXpsG1NrjV+yWN4bBDkMGPTcatDDg0QBZhzv3H1YSdYdcBpJ2l0oSEQjNzkRs8AcIJ9zurBP4p5xR+GlU7z+6dRt6MVFxK8lObv5Ou0ShurZU8Tl6/Ae+4UXljKevZuwj8TrAKxjxenqGzWslHnVCjTs/AQKv8EA/4e3L+aer9IKMfu2WMZS8sipdVdVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794484248; c=relaxed/relaxed;
	bh=345mQoD8JftdJx5JnjWsiPPU+f0H9IDLTyjnMxP2r+U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gQ2fOSUWxnhh23Vz14YjNPv141zYyUskNEdBJhklEt9IpUwaWDEtjVQYN78IhnWBQwqJRFc5p/HmPwBW+nJW0Wk0UVpuMtMZMe0D4WD8GS4feHzYwo9TafKw5TeQeRNrXLm796EOFfIKy8bqiMIOcDZZ3Jns+dXiOd8vrkPXSKLUXBT1CAmPiaEqZ6sliigudArhVjiE/Bm/SXc1P/r/tDWCT8wiDgsR3hTdB0fJy3baWD0ag8bqoX/wryf0g1P+JWHiTNXLkfkM8gIsKSFEKMFndssqDu5VHpxzyszVDtHxK1p1vBe4XnUhg4itBf7XtQWuUdbbFycMDfoq0oKdHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VgXqKn+x; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VgXqKn+x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQJcR4TlHz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 22:50:47 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8233C630BD;
	Thu, 12 Nov 2026 11:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7387F1F00A05;
	Thu, 12 Nov 2026 11:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794484245;
	bh=345mQoD8JftdJx5JnjWsiPPU+f0H9IDLTyjnMxP2r+U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=VgXqKn+x/tpDxSir1bzndBinsZRrZOcD8AcT9hE78xD5+gmyh0J66O3jdgzVaP6oC
	 VI3lpOikrotkNf/sOzME5+d+gMRMvrQC9R/CPFzb5R/iEETRFp3hUJp/lO8AbvdmZa
	 +Tfk444H47v/et6t+5Q4NN7xBKOhoqW5Prkva2PJJr0ciFTM7CkwmVTZHkK/fylKwv
	 jIJ7SKCxu30pZPrq+a3AanA2AawKPRNzwrI9nZBWuzRJOTyM4yqba7FerZQH8VnssM
	 e4FursPuKyehAavTWJ8FlvZEe3ceoO3wekiFyqK0IzDnjxow9OiIaHDDQB9UCKmK08
	 3Q693A9mbFyYw==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20261104024047.1508601-1-vulab@iscas.ac.cn>
References: <20261104024047.1508601-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: drop the ASRC device reference on
 probe exit
Message-Id: <179442016743.393238.15199613082080741753.b4-ty@b4>
Date: Wed, 11 Nov 2026 18:02:47 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=broonie@kernel.org;
 h=from:subject:message-id; bh=lZ2H/ml9eX7NRB3IqtIG43AmPeJvw7J1SXjcXAaI8xk=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLK+rhDU+p2674WExoOlfa7NxlfY66xyOlP3HlEtmfRs2
 ZfPL3UudJSyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAiu4oYGaZsdrEO6du27JqI
 1USzZlu/i9889nekP5v5ZdFO98BwzTZGhoMWVQ90O9qltaau5H+z7uzxrbZvAqJ+fjy9cNXVm0e
 4QlgB
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 02:40:47 +0000, Wentao Liang wrote:
> ASoC: fsl-asoc-card: drop the ASRC device reference on probe exit

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: fsl-asoc-card: drop the ASRC device reference on probe exit
      https://git.kernel.org/broonie/sound/c/a3ab9f0e66d6

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


