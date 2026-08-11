Return-Path: <linuxppc-dev+bounces-25751-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7F1C5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 22:20:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKQzs09kcz2y1Y;
	Wed, 12 Aug 2026 08:20:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786486824;
	cv=none; b=enWyUhrFTgIuQ8KtbZW/7jzbEpFVujF0NYoEEVqTd6ydMv9MwhHIB+6GPO77bZ4LOSP3cB+79OjJZYWmIhGa4cxSQxL1PImzGfDLTm7nNhfQCxLguxE2JLDg0f8bXQ/6fR6Y4yI3dSiGkzg5b2tWy32c3WYAME24Q9iAvjXMU1kw5U64N59Spju9A0LyIZqUqv/KEv5IiBZT6n0o2T7uERoMHr6LVyXtqUZqh0o0izbeOvt6X5m4MhhClG3z27eextdA4/ycVHmc5qIzExtlqO59Uzyt19UP6eQOG7ZqY66TsMrZ5OzcWhduoHxNwPqKqnhcJCmWca171KapoCPUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786486824; c=relaxed/relaxed;
	bh=bgruTceOhBSt6ExD5rb9r1mmzE/uAzzfIg/kARi5H4E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W4qhRAKLN/s76NNPFDd/jxRqchW1pnA5xOdnPaM6Jy6q1bPaOdsjeEvCUel2pLhU4/ngZJkOqPZj/39wajKyPAmscJIJz+ZxJBrM5pl3MxQcWuWbkorwsvuXng1weNnQTnvO/7D2XTG201xgLQukH3l1jjSUSa78AUwvWlUbu0mA9TT8FxV93IZDY4V9SXotUDcbeyIqkyOmaVdEDUYCNd4aDZQwIF7jYYrVzDAW15U+3OutMZ84J4QYPEyqkkfwoqLCjD5xAPP6qDYf/prz2RO+VKVsPTsr8tZg8g04faKLZzkXv14F1leeyg4kVIBg8eSfkm3g8EQtc2hS9zmBjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aVwq5eBm; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aVwq5eBm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKQzq54Gkz2xwN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2026 08:20:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EF5BF43A7C;
	Tue, 11 Aug 2026 22:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8349F1F000E9;
	Tue, 11 Aug 2026 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786486819;
	bh=bgruTceOhBSt6ExD5rb9r1mmzE/uAzzfIg/kARi5H4E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=aVwq5eBmgS0q8i3fcVBkoeIffemayJOditKOlU0eF2SYaQ89Z3bwxDTk/L6Du+nus
	 xmHN5WASIu0Iy+qW+7ElSveYK53Brr8Vy5lpuLTz/PH7s4a42diUXbxBwT3NhsnRym
	 QYJaB7C2p1NpLovshNr1t6wMa46LfN6hbuPZIDRO7z6PnNwNKFCWJJYoFpPjwp0d5s
	 qdl2Uui3ap2/aSQqju9SEZlQLS6LZR1xcq0gkakwgTDPKpQYtjCfQASn21GxC9loTZ
	 DbWBVNOP2G6w9ezAZpKJ7kD8KKBnu0IqlLZLaXqUHxn4KR8el4oRBlbGd02A07306c
	 jCH45/WWlTzVg==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, LiangCheng Wang <zaq14760@gmail.com>
Cc: Mark Brown <broonie@linaro.org>, linux-sound@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Wig Cheng <onlywig@gmail.com>
In-Reply-To: <20260805-fsl-asoc-defer-cpu-dai-v1-1-43f7f538e384@gmail.com>
References: <20260805-fsl-asoc-defer-cpu-dai-v1-1-43f7f538e384@gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: defer probe when the CPU DAI
 device is not ready
Message-Id: <178648253837.119683.3220582369920670222.b4-ty@b4>
Date: Tue, 11 Aug 2026 22:08:58 +0100
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
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159; i=broonie@kernel.org;
 h=from:subject:message-id; bh=rGzMYl8k8YFPBqs1xAPBOcPcRdC/awV46Xpycd9gg3o=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqe6AgT9j0MeDOeEtLSitTY9e2bQsFrJYbuEaKE
 vEPNuskkFWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCanugIAAKCRAk1otyXVSH
 0PUuB/9IwWDS7rJYhTs0Xg/SnYB1CFKANuW6Du7FdO4P/RMiV/8qMf8nFnk2tfwJAEXBZhVqFEa
 ZdOZ9l2E8DN/9s/FbiJLcvrbA9l0ptxpmVKof7aUPFFBqfbX+FXfu68HzaAezloLfhWi+V32cPm
 eEZKxhNMZ0CGfrnD/ld2o4O+/xVFC61FXJZrkkIYk28ITpJF8gxeROA3DuEprnopWDULdImvatN
 6+3v/R0WL0x1eG8hwkqCLODhWelE9pO3IXw5cMnQQDpOADCtBVjN7ho//cz1NlkTGfrQ1+C0Ouf
 sEuKGKmPbh4zTy1dfnEloQDfqggqGSElzcG5Yw0ryvEnj8SH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 05 Aug 2026 15:55:43 +0800, LiangCheng Wang wrote:
> ASoC: fsl-asoc-card: defer probe when the CPU DAI device is not ready

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: fsl-asoc-card: defer probe when the CPU DAI device is not ready
      https://git.kernel.org/broonie/sound/c/0286324da660

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


