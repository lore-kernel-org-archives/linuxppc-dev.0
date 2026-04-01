Return-Path: <linuxppc-dev+bounces-19227-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F733D6AAFD
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 19:15:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fms5M5qdYz2xls;
	Fri, 03 Apr 2026 06:15:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775157351;
	cv=none; b=LWeC2YomKzHvjpWBwYLCsAoKHw8aSDYTdoimel117pJacFQYlIrLk0yejFgoZyzj8b/tUeiEGKCpaNvT+jVa/z/qbswKsu1AqlUlVPYYnR2UKZDbeEcUUDJubWuWzhTLkZ29/ius58jouESoVdP5KtILFJNf1FrTemg6sSqrc3N5nWjnw5ZDITkgGi7TsSLsKNI95ExLX/sSvOq6yjAGXsjkmpIpj7tSQX9ciTDa3inwfu/tlI5XdURMtFJMb82dPVIUhdB8b79D4Z7ef3alXjWNg6f60iNDbR7TWwDDgDOEdpe+QKhF7KkbmiLu+s3QHjHZowQPX3Jn/mCqp1hWiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775157351; c=relaxed/relaxed;
	bh=NbDoSkWyuf2UtwcfBcDHfIppf+MUUewMnqR4Eac2Hcs=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SLP5AKwiIMdaZtqZrEGX35Gvqd6WLjriOpsMmKWLJM19dE4GMAFpiqAdB1cta4Aq4evu2AjA8BSBg0x6HdtDivgRZkL3XDw5k5K6io6T5BsGe6LL0+BkNPOfBBvgJ3VEOSAJhNjlspoV+jLnCnGihB0KOfamGvX51XPPtpGjIugmM4bNnYeN0lkr821LhgpJfnHIXoMvl9UE49cQEKhYM7/5mdZSO9cVXKpj/ZMeUBV1tfv9iTft9vuWCcMuClAP6tjfTQ5uOaMO9s0ve1EBuAkHN8oRMuQduKoJVxIK2jLnxbGEIVJBLqdxuE7otvxAMFZCi9eI2tpVpO+FPcvGWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=raXHMfkD; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=raXHMfkD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fms5L47bNz2xTh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 06:15:50 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5610843F3A;
	Thu,  2 Apr 2026 19:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CBCC2BC9E;
	Thu,  2 Apr 2026 19:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775157348;
	bh=P/Vd0gmXyAvoE9rHTTGEhmfJxecRbM3PHJNDjDDNFjI=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=raXHMfkDHpKLPDaf1PF9WFIjvxuxDZsll4bhja6AFArdt8zzd0TUWgYBVgzbr6LMU
	 JM3YvvbhqcdhE4b9ABFLXZq8xCnAO7e21ByjY+qvBHE4enwvV6l/aBUb/aNMHMiJEh
	 WU3Xlr6k23bVHsRsAHsju5JEeaZXyRdWcle2hNfs0UczWJCuk1Ekeky7jnhtWsChjF
	 4eIPmQy5I60tOBlUH8cUZ19vrZ87jYuEXxLprm6pYIdyBtaCstckDNy3yj8baBT36M
	 AsWbuckP1lll25B1vSx+yy5WibDmWhFKKdLCva4si1q+9Hk/rCFns1/FjCvkGlKBmE
	 Af1feqNlQJ3Ug==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20260401094226.2900532-1-shengjiu.wang@nxp.com>
References: <20260401094226.2900532-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 00/11] ASoC: fsl: fix mixer-test failures
Message-Id: <177506428638.145704.927918795289166991.b4-ty@b4>
Date: Wed, 01 Apr 2026 18:24:46 +0100
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
X-Mailer: b4 0.16-dev-efa4b
X-Developer-Signature: v=1; a=openpgp-sha256; l=2648; i=broonie@kernel.org;
 h=from:subject:message-id; bh=P/Vd0gmXyAvoE9rHTTGEhmfJxecRbM3PHJNDjDDNFjI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpzsBhv2ShjYA5Aa+ZfiBVEwOP3siXTbB2YSbyV
 1vjnFbUH6OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCac7AYQAKCRAk1otyXVSH
 0JMJB/0cQz8bfmIZlTYmjvAVfiQcotiZ56KcGDJY0CRaA6X/tw+rzOdJ377N6tNXVtKGRSP7Hm5
 4Z7rgRLkCNeBcvS/nu5UP258qCAUR/fBxTlC8ZIQ+w5GOwx5TAN2r0A17b4ZK+0MmTmbOOW80hm
 yqNif/LoMEzNu9gziYkvS4zMuV3PwD1EqrOFC3JEoCozPklbK3o+hEi5GZOkzU9oAA85/g7bJ+Y
 zdj0u6Yhtt7K81zLZbdD4a4Bq1H82ps1mFYwzZp0SbkiMSDf7Nvq3mqCpmjykFixeFjj1oB0mta
 JIesTxfWFE0J8qyzM9PNkye/D2Ny+rjZ7R9w1eQM4BoQNolp
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 01 Apr 2026 17:42:15 +0800, Shengjiu Wang wrote:
> ASoC: fsl: fix mixer-test failures
> 
> Fix mixer-test failures. Mostly the issues are that event is not
> generated in put operation.
> 
> changes in v2:
> - add back event notification in patch 11/11
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[01/11] ASoC: fsl_micfil: Add access property for "VAD Detected"
        https://git.kernel.org/broonie/sound/c/c7661bfc7422
[02/11] ASoC: fsl_micfil: Fix event generation in hwvad_put_enable()
        https://git.kernel.org/broonie/sound/c/59b9061824f2
[03/11] ASoC: fsl_micfil: Fix event generation in hwvad_put_init_mode()
        https://git.kernel.org/broonie/sound/c/7e2262099069
[04/11] ASoC: fsl_micfil: Fix event generation in micfil_range_set()
        https://git.kernel.org/broonie/sound/c/fc4daaddb276
[05/11] ASoC: fsl_micfil: Fix event generation in micfil_put_dc_remover_state()
        https://git.kernel.org/broonie/sound/c/7d2bd35100de
[06/11] ASoC: fsl_micfil: Fix event generation in micfil_quality_set()
        https://git.kernel.org/broonie/sound/c/e5785093b1b4
[07/11] ASoC: fsl_xcvr: Fix event generation in fsl_xcvr_arc_mode_put()
        https://git.kernel.org/broonie/sound/c/1b61c8103c93
[08/11] ASoC: fsl_xcvr: Fix event generation in fsl_xcvr_mode_put()
        https://git.kernel.org/broonie/sound/c/64a496ba9763
[09/11] ASoC: fsl_easrc: Check the variable range in fsl_easrc_iec958_put_bits()
        https://git.kernel.org/broonie/sound/c/00541b86fb57
[10/11] ASoC: fsl_easrc: Fix value type in fsl_easrc_iec958_get_bits()
        https://git.kernel.org/broonie/sound/c/aa21fe4a8145
[11/11] ASoC: fsl_easrc: Change the type for iec958 channel status controls
        https://git.kernel.org/broonie/sound/c/47f28a5bd154

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


