Return-Path: <linuxppc-dev+bounces-20134-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3099FF8850
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 23:22:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3jQP5WXhz2xSF;
	Mon, 27 Apr 2026 09:22:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777245725;
	cv=none; b=Bniv+RD3ozZHLvHQ0GLSOd5+fjdopL1rhZSPmGD73Wf3/HRiZidQuU72yzuw+se6lufFBIfzqsk4NuQTKZDUEZvYK4Mr8iYx/ItsOpe7LMqIOMqvNRfaswJwxKOjYg7mutu7n+fMyw6YUpRUcT9O3eBoaOJPrwZSr4sgT/4T7pgKPpCR5rMAs+Z+yIwj2P/UwA1yHyndVhYY4YhHnCpjeW+f0GEr24VdCfKD1JSeIbyBfFgb9jZnec+kzTjEgeOTLV+XCT4Cnh2522ylEzwc/2A8P/nVAoE6erepnsHYOowLEj0A6H8MZrgBc9eiKzVP5Uqi1R4Hn6ALEWdW8nYveg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777245725; c=relaxed/relaxed;
	bh=ypQQNqCQu/S6ZE6B0dnkDq8DxxanR+O/jiiAcihRFqc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h/k+ACKKsRisFFQe2QI7NAvshM6Ix+1VKuv8FRJUR6de6wfGVyoz69RZRaBqdkbpL9deP7PdEM1LkhMzwXnHcM+0Ke2oCTCiQGmuymhhl1sQR182zvtLlTAgKyTWy7Y2lm25EIDj6eX9ifQdsdhZ+iaMbmkcOtydPSPscnf5OkVbcTTIf+PwTjiz0TyR3gv6SjmDDifW8bCZhKnpZD7OdCogxugLkzjZ454Nf6PbxxHUEgkKGxPuY4tgADSwOD0+5cXuFNGLcSSAD0RO3L2xa0PTApzLJbnUMxfH+TGGtL8j1kOJKw0adlxnUT39ENsTRxumeOskAmDd0nkqbvCyOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OkV90V9H; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OkV90V9H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3jQP0n72z2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 09:22:05 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5E30460138;
	Sun, 26 Apr 2026 23:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE61FC2BCB4;
	Sun, 26 Apr 2026 23:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777245722;
	bh=DNbyBiB+kR7DtKPb1naiFdHB1FjL/D3BXevIDYDiQy0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=OkV90V9Hh6JlgQBXjJbVZnjQGLpLyFDESzKVS9G3epcjpWZBHOF3uTcatym/10Q6h
	 2NorljMetwRsAx9BoWRB8B+sv42vjswefASSb74cUyriZBAY3FFa2ZyBjK1vrSb4SX
	 Xdt/rV6z+ICy8rv7pJfta9H/Yfrj0TrLRi8F7OKHBAgKB+J/2GaRh+p5vqdEcnWGt4
	 zFYzcgtLx4NzgvAkHB6zv7fMqKmlt3zQeDq9rCgjmRc7VRGj3T4a4Mbzl+54z8pQPB
	 zdY2K0LqWLCtBUs54iD/FnEOa42/40g3U/19AV4bxAQUDUJNxoaWV41XLUK0fvesr7
	 /rlxN6emIRGJw==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20260420085344.2081805-1-shengjiu.wang@nxp.com>
References: <20260420085344.2081805-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_micfil: Add DC output remover control
Message-Id: <177724018870.266775.2671015409036578113.b4-ty@b4>
Date: Mon, 27 Apr 2026 06:49:48 +0900
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; i=broonie@kernel.org;
 h=from:subject:message-id; bh=DNbyBiB+kR7DtKPb1naiFdHB1FjL/D3BXevIDYDiQy0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp7p4WhB2Q7f/tY73pPKy4AHh5gbpCF2ia2cdk4
 UnFaUi9KpOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCae6eFgAKCRAk1otyXVSH
 0DEYB/sH09HagHwadjLYVuAG9ec9j9nSdptX+JxgfXlJiTT9ICQo34hm7ymyoa4By6p+F5uw0WK
 pA6DU09UAsWGyZGbwPK3BavwUAc6Ks//Qe7xlPFjZqxZKh2vdkwQ8XHvZp4DlilC4Nrwnfc0hjl
 E7ziJjOtkSnvZPMB6m7NDGTJjgRihuftLOfVOuQ+KQlhQ1nSuuXBFaP3YpUfmCPoNjyQ2kOF7Bt
 ou6nHKCAhXsKV1cqjjvOfecsy78cKi63PYHEXBMuAfsC6uraXFyZ3dUWHaS4cGZRHIjR0PVuh3I
 8BSF8h6mWyxNYmDl8S+ckq9LLaFaVbIKU5kFEBWRNtke14ac
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 20 Apr 2026 16:53:44 +0800, Shengjiu Wang wrote:
> ASoC: fsl_micfil: Add DC output remover control

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: fsl_micfil: Add DC output remover control
      https://git.kernel.org/broonie/sound/c/e9a6f077e415

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


