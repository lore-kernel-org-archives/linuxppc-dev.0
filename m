Return-Path: <linuxppc-dev+bounces-25639-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D054FC55174
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 13:53:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hHMtY0Xptz2y1F;
	Sat, 08 Aug 2026 23:53:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786197220;
	cv=none; b=CihChOLzocPRULBk5Gt8leOoN7qG2Tu2yNjCJFaN4NeAsx3kjUTHk7Wk3/59uiVeKkVqDIW7lVGgOuRIF5cMCMWrX6ClVZlSS+iTyn3Fcsv6/YmwS1mc6Iqx7ABONRJ2vz4ukjycMNjlDGql1d3BrEHkFipCGcYrDcGk0ZGdvNyua9AP+xZAzN2cO7m045WWLAGoz7FJpvUYyLN0z6nDATZpbAyhCsS1XtkpKbi74e1QpqIlsPF0geQknpDGCHiemd4aCN7/oCrtD0nQH9QcnatrulmuTIFt3I7WxpoZhaIHC4C6qE7Kutgd/B6XADUYpPi7AxHpIV+x2kl6AvAbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786197220; c=relaxed/relaxed;
	bh=UGmYbDNp/zsEE4ZhhIguDoZqxe8hCpFF6XwrjiVGQt8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jDjm+Yumhg/x39n0RqvmjgR5ISe5xpRjKywaDewpdsURFawCsuVKABxewCmaxwXDFrJKCRz34nza91JQU9nzKijUcCX4xhex/t/Ji5OR02gRb8BMZ4el9Shhw7BGot97yUEOCM0yvcZsj4b55notqAcLrfFIMaxvzTwgHF1oVpzQzkBh7wXECCyClFv2ov+YHfIhcbW693HKI9mSgPFmDz/wHX8j1WMVWNMxFnLI5jcnW0w4Hc1EZZ7HxQNGFzS6NySKnGq/Mneitkjr92/PxRxf+XC+UmVEI7JDFsdgq4dXnPxE1P+6Gp3npWp8fd3W7wqr7GZi4IbK7vVDNJ2OpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojQ6x4nB; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojQ6x4nB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hHMtV3cW7z2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 23:53:38 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 055FF43D6C;
	Sat,  8 Aug 2026 13:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3131F000E9;
	Sat,  8 Aug 2026 13:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786197211;
	bh=UGmYbDNp/zsEE4ZhhIguDoZqxe8hCpFF6XwrjiVGQt8=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=ojQ6x4nBvODQCZ1gaWaQiBMD1fTOAkOrsl94xUkCAUh2ZyY3fy3MUHHgmEEtynC3X
	 YV/Y7Dwht1mmbnW2DUel0ijNFK/PlqZajPFpOS/xBXrQRxiCy9QFqPAS4lJPCueq2H
	 pM4ccd7zp6f/9wDq7SJJMqCWA9zNjwEaW3yl1NMI80ym+2o+4kuAZ+Jsuh27Vy5nxV
	 PsS6h0L/n86ks8nb0RBhEQBfvTscRfp9gYDPuMG/YKED9stlUQuJKl3z0VMrHj2/Uh
	 KcEiYXGYH38rADq4/mqeSEzFZvSAgL/i5MRR7vfJRc+/LF4awFIhtn5DQJrzTwds3l
	 vW/DUyQvlo2zw==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Frank.Li@nxp.com, phucduc.bui@gmail.com, 
 shengjiu.wang@oss.nxp.com
In-Reply-To: <20260807072202.380021-1-shengjiu.wang@oss.nxp.com>
References: <20260807072202.380021-1-shengjiu.wang@oss.nxp.com>
Subject: Re: [PATCH] ASoC: fsl_easrc: fix missing return on success in
 runtime_resume
Message-Id: <178613935118.577435.5668372548866263587.b4-ty@b4>
Date: Fri, 07 Aug 2026 22:49:11 +0100
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
 h=from:subject:message-id; bh=hkH0fQEvz1q8rnasSa045IDqrDKIN2Ms2FS9+zn9Z9c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqdzTY9SXlZ86x/M+sSlip/vnMIhc9hIK+i36ny
 AMJXHA9y5eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCanc02AAKCRAk1otyXVSH
 0MdxB/9Uzxm5RjA4jAnAsl2aRVwRlUhYUMT7t/YtuCrkutYV84pHoQRnwMXd/A1Xx4f19tY+5m+
 5E8F7Z5GD159IIZBwcYFJUBgyhPky91OminEMCSHxU7qIED1X2EBH/W6ZasXkqKIU4V+YPPEDQ6
 Jby0YuWQU4cIwh4rLPl7qLEvKqOkqI45J/kPBYPLZle8iRzhx+E73I0f9I/fdOLuVNZuFGOY21T
 R+3j2gEzqAr9VYEVB+0GCAo1YHB0Ou/ZSNSes3h/UCDTHjeXBNxXcNIudNhJIRGTnH45ISWav5v
 9P07AGgyIRKl5q5jvyEUoauFi3XO6a5P2Ay9406+i48JK3jT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 07 Aug 2026 15:22:02 +0800, shengjiu.wang@oss.nxp.com wrote:
> ASoC: fsl_easrc: fix missing return on success in runtime_resume

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: fsl_easrc: fix missing return on success in runtime_resume
      https://git.kernel.org/broonie/sound/c/82b6d37621b0

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


