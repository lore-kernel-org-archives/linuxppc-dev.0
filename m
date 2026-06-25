Return-Path: <linuxppc-dev+bounces-23091-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD13C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 12:14:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gplZL2Glwz2ySS;
	Mon, 29 Jun 2026 22:14:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782735258;
	cv=none; b=lZsIVHiXE4wyy+WyATTVMOWtBZ02JFub/U64ApWvgnWc81rkvullyZv0PdcvFBO8nKrYKZDTADbq/wGYPBtOy6D3TRzIkLkYOObtUtBtHo7Bn1XSBKCupIO/1H+rxts7sw0qNNCuPitJdpERcDCCQmrVYvC6pfPj+Q3WeOQhmuIO7jgQrnpx3xQ4fnEa7zZax9zeDDIGLidji+gBfHYvinpN9YeDGjjvasiv2VfcrUj6VcDJUPAt/9oIYsS4Rt1aEDDyYfdUJuCTOaKtk+fZt8/iUY9Zrz3BTkpQ5NIzDoRMAUoIX9F63Dlvsb7coR2eA3WZVey8MmKrl0fSVQeNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782735258; c=relaxed/relaxed;
	bh=n+coV1M1k9ivDucBnlClOj7zKR27F4vBF8Pokzkw63Y=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QyHPXZX+luLVT0sK1Zt7C0vHGK+QSq6HsL58FhTDh5CiDs+3pYvpfMTi5RVo07l9mYmVwmCjMY1xWJkPrLwjs4TTCd1XDyyQ+/yzcxEGgx3YeIEG8xKXrI0eD4Q3+0NG37boWELBs20UgdZEHp5K3+F1EAr6DmPXzonZxEogoW5NUGJj9KFJFN8CdmzE7Zl+HQvWc3QxwjWBu4tlReWhzKfwbLs1tHGavmH/hiKhDnBGG6uVkA/mO8zo4/Ro+9glzLIq/qMe8NlURCV2qc9pgFr7h8dmSDCK5SOWJk8mQGGUN3MuVy9tohcl3wdZwDUJCR3Hhoc6JZcqLZsCiytJ/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Of51FpbA; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Of51FpbA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gplZK33lgz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 22:14:17 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F203A43C3E;
	Mon, 29 Jun 2026 12:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B551F00A3A;
	Mon, 29 Jun 2026 12:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782735254;
	bh=n+coV1M1k9ivDucBnlClOj7zKR27F4vBF8Pokzkw63Y=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=Of51FpbA6HZf9/yVnds+0yyBzWj8QCMKAo0CYcwO6gMOYO/mvx7EWIGwefwRhRHwS
	 JB581U6jI+P4OYASwOG/Aqc+cHn0tIOsxWN6i+7TXRnh5iEg1YahtmqfXY+Smiappl
	 Aw8aMt+kYoGhCMVhYEboehvN7Yw0c9+aBg8fLR3NaKokErsRp+tTRxeeyK7o7wbVyS
	 HfwHStRiv0i8oJZJscXlRdEfHfR4f4R4m4nBSw52s8qnkkKtDTnVoAbFxC68Uq7yw4
	 5lH30uDaR44kTY5KeIu5JD7dJ5CKSnyzLP+X14QFXkHApMRWM0x52tcXLXuB6zYWzr
	 xejSUPDC73oPA==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, shengjiu.wang@oss.nxp.com
In-Reply-To: <20260625102416.424911-1-shengjiu.wang@oss.nxp.com>
References: <20260625102416.424911-1-shengjiu.wang@oss.nxp.com>
Subject: Re: [PATCH] ASoC: fsl_asrc_dma: fix eDMA maxburst misalignment
 with channel count
Message-Id: <178239587658.51343.2769093541201001196.b4-ty@b4>
Date: Thu, 25 Jun 2026 14:57:56 +0100
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
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=broonie@kernel.org;
 h=from:subject:message-id; bh=S1uHXem2NPKorcIgxQtqKkiIBFoLN4lrRepfZPijNe0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqQmGTG5TwQoa6xRAxjRcbu9vHK0fnsbEKCdAdt
 1FXmqZvZ3qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakJhkwAKCRAk1otyXVSH
 0JfeB/0TG2IJV8dN6ol8F4L57VLrZBoF7T+7fvk1ZvZat7083qw8BgAq4M1SP4lKZqqC8VcwvM7
 gyHOadeU30f+zwRWtC8vLRF4LY7CcAhZTr83IJKDLlPfqTQ0+20q/xXaiBQj9sIPq1I1P0XHKiU
 Eg56u/k78XIchupjk+6wReOxi++HRMZ73Hy41hxD7b/degqTwGcFyfxoTobXXGAGeS061MKrTzi
 g1fSZz2G0fXIgqiOjHVU8XXYF7o1caxLQ7hPi9+2lJXIXCGPDF6Dv1Pd4EB8ZCAu/TjEO+FKvjw
 BwYiw5pXnyHTNoPy/vIXVA0rycSYxu8bzMbYi3Dor9GCx86j
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 25 Jun 2026 18:24:16 +0800, shengjiu.wang@oss.nxp.com wrote:
> ASoC: fsl_asrc_dma: fix eDMA maxburst misalignment with channel count

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: fsl_asrc_dma: fix eDMA maxburst misalignment with channel count
      https://git.kernel.org/broonie/sound/c/cf6f56990ea2

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


