Return-Path: <linuxppc-dev+bounces-24125-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683B3C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 17:50:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzVMM4rgFz2xPb;
	Tue, 14 Jul 2026 03:50:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783965007;
	cv=none; b=XEqfsbBJlddM8hp7q+CBpyvganWyDmP2q9X/PC3rHc5z61dzl+2x9p204x1KconKC1Iug8TnVYqIFBsmCz03rl5tqJcyopZooehYudfR7x0ba2u8T+tKHpz9tqjE0lm30K8qZiwB3ltsf5zSwMq+2YARlCJxDRE4FYNCZ/NTAlpKQ73LXjw3Th7fr65Zu5OOPA8bPiSmA+i7ev8SSDEAmxk0KbcLnS7O1fzFQqu3WE0LekpQRXCHYRZSv6fLKI63rbNSIn046rKfvzgbjKG3WJu9LB4zLDxCuRFU3V4pydfCa8GxQRiDCO3LWiKNnY3Bs3cnP4yU74bKcJxucTMQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783965007; c=relaxed/relaxed;
	bh=oTqpNPCaWrQxOsBv2avmtmBMYaMvgyoucn1YWrXaago=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SEpZMmmDSaBkRDLe9t4K+0A1EE2KArpw/hYpTT5L8YQWkb1Jq/4S6AFFpIXjR7Idv4STLW4EfxX3sN/WDKrYZXm/8ci3XOqNRg9bJx+qpLLslaWiT+r8NKY9moepRDgekWVOHW3TYB/bFaqjjqdIihn4QShgE2obDwjzYlTGOTfEbOdExgDxnmI+5pK6x3oQfT2qSkINK9lXsgDQuzfOAW/3RRGUcq6SG4AFpv7HR0TSnfzpLxea+rc28/2qJ0VABhLvw19lSg/7TNv83GnmkSRphI/yCjuUv4BR2sdxHWM1Ib8w0WksKjcCw9Ni8y0VsTt09BmDqQo6k68vlwF/XA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XKgx89sE; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XKgx89sE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzVML4VTCz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 03:50:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8BDC160008;
	Mon, 13 Jul 2026 17:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD8F1F000E9;
	Mon, 13 Jul 2026 17:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783965003;
	bh=oTqpNPCaWrQxOsBv2avmtmBMYaMvgyoucn1YWrXaago=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=XKgx89sEZ/fdakH+d1jsihzM+Hf1QrNEJmCO6B+ZxC4EvVwq/RqbtVp5gsleEvsXe
	 Sjcm3pxdeLZbvdQuU1VehdGGY39NusKqkyM07/JMobVlGYaosw7VvZ2j2xlGejgKda
	 yXVoP0uFJS4esAzIQENF7YXHTy46UF0T5GolMgsS2Td/7lpqbkEh0A8nqj33A6M0iE
	 G+l6s4AtFu9UyE/f5ctBrNL6OXPJRDuDQEBSJlhfgiDE6BQ27QotEABBJYMTNxgIoH
	 BZngLeZpYglHNB4YdNgyXcwLFOCaKS852SVVW0ElaSksKH7ufEnXpd0XyNgtxUwEnl
	 GBbclhO5Qf6yA==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, Chancel Liu <chancel.liu@oss.nxp.com>
In-Reply-To: <20260710070835.3749817-1-chancel.liu@oss.nxp.com>
References: <20260710070835.3749817-1-chancel.liu@oss.nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl_sai: Fix spurious BCLK on resume by
 clearing BYP
Message-Id: <178394658034.7914.749887010931841655.b4-ty@b4>
Date: Mon, 13 Jul 2026 13:43:00 +0100
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WtYPtV4MJog93ZrJwWt4xWHTXtBb2ZPTGPHT9LdEwVo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqVSVI9NfilzGwGrSIbV2rLiUxrG76zo2fxrROo
 Egxs2c1VECJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCalUlSAAKCRAk1otyXVSH
 0JnAB/4rmEQnGy06Oxp63y64WqHpuVgj2i/+Q2l0NCUNs6XjWAPuN5VesKQc+BMOOZd26HIHiFp
 pS+4ipcRwKkhAtPNuU5rmp72gqK2rUkAurZOM6H4wEmsyiZ2vj3hZUXarmBvUnFaFBuJn50DD61
 JefN0tFt3F7IQf1JxEhp2PndCUROzTs3bRFoYensPBEhOp+17OVHRBnYOSwDGSarlEU4WlrWwVH
 TDL6mOnMg/Wh3cJnM1ZIMcZJMmBfnKufWqAUhIsEDHvi8SvOsq7XTOqXsAMeC3Zd3ERqG0nsQpa
 vDzPl3UvG7jGuFvVMJjwq3Q/Ah9saLYf0rmOeH8z4chmkekj
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 10 Jul 2026 16:08:35 +0900, Chancel Liu wrote:
> ASoC: fsl_sai: Fix spurious BCLK on resume by clearing BYP

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: fsl_sai: Fix spurious BCLK on resume by clearing BYP
      https://git.kernel.org/broonie/sound/c/d091132889c1

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


