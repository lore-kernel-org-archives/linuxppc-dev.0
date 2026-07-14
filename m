Return-Path: <linuxppc-dev+bounces-24298-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02F9C44507
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 11:35:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0YyK4SSCz2y8p;
	Wed, 15 Jul 2026 21:35:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784115337;
	cv=none; b=lP7UB7hN/ioi9XVYIykeT4N/b+EN+kVohIgBdeideEkRMsPPZAgdK4a8VnGrzsOkR+OzvS0O81c285er1Hw2tIOf16P0rphgHELsx3hew8V1IsYNxkh/tBeeSfZCmlVVytpwJkZIrFuQTrzq8R2rmjP3kgmLH7uNPdB9euyrAWJfPhio5h4GGwyuL/hljQEAxcDSztIxj2VWcp2/IXG6ctrjNbjePUNOWYuSlvT0DTFiXE4TBCSpSsPBvgOBWS3s/vj1/1ltf8z4GQ/mUsDP3jAlkWh75+tTVmk1zWcwAPDsh6pEUmnulbf/Q8xdM0xqokNapVvZAzqJg8yzjnRn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784115337; c=relaxed/relaxed;
	bh=jesZuPeWaeL9z/PHoWJHtu6Qq+AFb40j5P16AfqJxyA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EbgCnfF/3ZSryjFneuEV6afOFOnNg71/DpSnFNY6IH9kUeBi/ip1CaDVjtUSIogTOSyHkRSeYU9H1FJ6D1FCIMgUXg52QqLE/BubMk7/ybqp2oomT3WOv7m1CwEgc17Jb1GGj3agYraA1Rv8WS1Uvegdu92ilsv6vF53FnB1u8bObnoMvGHK0Sbb5VGi7/2Kv9BN0OIABcZcAsYqr1LbLngvkXxunvMpCX3iS7IuFzbljhgbav8lSEGQrZ5tDiNqJPOeTGqDLkxOQXflImg5LFTlca/9fke4NHadeAX8OsMU2xdAcUMnGBt2plarleaF4iyQf0X9w8LgaKv0GaGSfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DU7gCO/h; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DU7gCO/h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0YyJ572zz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 21:35:36 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 73E746001A;
	Wed, 15 Jul 2026 11:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711331F000E9;
	Wed, 15 Jul 2026 11:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784115333;
	bh=jesZuPeWaeL9z/PHoWJHtu6Qq+AFb40j5P16AfqJxyA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DU7gCO/hsLqTwwk7TrDDgi6SxLThPZZUBTDgrO/vIreh//foqleLzkS3qXzkElWtB
	 CQKaJF8wR03T1QTKHvCbSFm/OO8G6JR8351ZvqQ+kJLjx6xlt3W4hgFzvdQti/56z8
	 AdAl7uEqWLmVf0QiQAuxA4DZzP2OppKvovPu4dVvbzk60+2W591kBra8i7MQarcQhV
	 4WlAiIpr83zDimSizShclQeutXvBhvTeOXE0a+il4DdprKWBqwrQT7lW/+ViVJty6H
	 W36kWw2XuxnRh12PUqcjsBdUtsNN6cg06zSSPMCEBMj3vuMZE4NIWePo6cy6a9P3o7
	 FucInxpg9bLog==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Frank.Li@nxp.com, Chancel Liu <chancel.liu@oss.nxp.com>
Cc: kernel@pengutronix.de, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260710031333.3491445-1-chancel.liu@oss.nxp.com>
References: <20260710031333.3491445-1-chancel.liu@oss.nxp.com>
Subject: Re: [PATCH] ASoC: fsl: imx-card: Skip sysclk reset for active DAIs
 in shutdown
Message-Id: <178406418862.7661.7096078031628027721.b4-ty@b4>
Date: Tue, 14 Jul 2026 22:23:08 +0100
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sNEXueWVdWEvfYKYwZZOPFDO+l6YsE+OW3Ra6F4e6zw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqV3CBctjQmNjrs8DaxHnHGNriWx0pEgtvGK67Z
 99Q7E7K7dSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaldwgQAKCRAk1otyXVSH
 0Lv2B/9iwsllDW7+fFWuMbcXDu+pjbFkmouDD7PciHiUfac0zJWqUb8SwEPVm7oGXMOibcDq2Kq
 YYouaK3iixM869F51GmvpQGgKWcu5tKldP5a1KGcQLcD5SfJvvsd4oYraV7jkS2zWaKToBwYBjM
 mhXSdzMOSNTZyFo1oH7Dt2gv7gI9vW9Q4UHyxpFoY6/Lz0VPCcAzVfNRPImPqiCWBNUZ5irG833
 J69er+PQAizp+0z8ltrK5Coa9q3+igR48mHEgGulXvStCD73JTM2MYHoao8/eJFV9ueYHpT27sO
 IO1bOopuY7+1+mIo9ncpEwxUoLEhRN4sVHiQpy6KO7RHgqTe
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 10 Jul 2026 12:13:33 +0900, Chancel Liu wrote:
> ASoC: fsl: imx-card: Skip sysclk reset for active DAIs in shutdown

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: fsl: imx-card: Skip sysclk reset for active DAIs in shutdown
      https://git.kernel.org/broonie/sound/c/9f86aea99256

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


