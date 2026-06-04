Return-Path: <linuxppc-dev+bounces-22030-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D5FCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 13:17:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWQ9H0mgwz2yRC;
	Thu, 04 Jun 2026 23:17:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780579075;
	cv=none; b=gXXQYCYIV8srgW789SpCPCr6LQH4aBwwOc7UPGx2671dZ2s5o1ONbTypTs8hqO1vy1xRw5qLPuRSnOUxd3FW9YheOG8SANuTnNIxsnhQMOr0QYtbRmoI9aOYe/Uit/cu6Oe5ucNYIHvdngL1iU/LzavantCmEJ30TOD52eDBl3PJ+eHwJUscTnB0m0P/OEtSQVcMstTG6G0KnIBoYWVDyPnYgjU+DTIIJsYMnrbScBIZKqcNG8IqJlw9HazSAcDBPnnUxWEeSm7ch+yk4TrsXsOGMf8bDUVOBESh2FjLMjuykB3HlGBtaIu1JwAVLBYrzQ8KN0XNiXfRFUybt4Jc8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780579075; c=relaxed/relaxed;
	bh=/5uXpRyUrLn5meNm86Lfod8o8MpRd+piC/cq/gzPePY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ww0Z8mvsew6OnwR3HMdyjaspbU+5OBOtfvwGie6MDtj939nlQUotbVnCQ3UglbSy3vHza23JvCsiB0C8zrHt9WqAuofTbrxAw98lor2V7pZoyPKE8ZN8Fa7mdmDMXJkekgBLq3RlYPA24gh53bCBKlBCjVW4XFJ5aSRAnowm87N5eywpbs643WNjjbwTBNQUXWEvjsyTzyMhvSXgLV7i7jCfJ+Vk2YYs/cWhTTRUCBWbGg5qynXvOxgIV0ageDMvwcMptKiphWErs6LCbIe6hktEzWtV9R7a/kUM6MyQQgQE/2qUhYLnJGKCG6hMfNaFQA2URcXzlKTMsfKT5Rc/1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0WGt6dt; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0WGt6dt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWQ9G393gz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 23:17:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 32E826024D;
	Thu,  4 Jun 2026 13:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18A41F00893;
	Thu,  4 Jun 2026 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780579071;
	bh=/5uXpRyUrLn5meNm86Lfod8o8MpRd+piC/cq/gzPePY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=n0WGt6dt1Aqe35I11bb8enolwaDGwbGLDhIumRd3Lo0Z1MO2t/DbqRW5rOMh9nEbo
	 Hc6eUodQYJQ9ooe5XOpwKJJufujPBahJkw2grthcQ7KtHADU2pyPuXzyi7gNKmCk+O
	 CfFTDq+3n4rcfkDma77nRJpm/2fKj/9fmZcZegwaRw1vuJU3OGgZo6eVcvSVmx/x+8
	 7aytA9dEjUNr8EG9fn63hz+0tlK4vE0bRGREnB839IKOHGwh2WG/WKQ5RTn2GbqRoI
	 fX7jLNEE059aLHHEIHs0xWBnK/Zr4pa75eIjBTfy/oiGaUhQ9pH0B3ap7bpHfgK78i
	 vqAJHEDTgqnlA==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 chancel.liu@oss.nxp.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260601083327.1535185-1-chancel.liu@oss.nxp.com>
References: <20260601083327.1535185-1-chancel.liu@oss.nxp.com>
Subject: Re: [PATCH v3] ASoC: fsl_sai: Fix 32 slots TDM broken by integer
 shift UB in xMR write
Message-Id: <178056822812.53724.11372449372244956668.b4-ty@b4>
Date: Thu, 04 Jun 2026 11:17:08 +0100
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OxNdjiclvt3XWr9lGJv8pywSMILXl1KuxQxrcQ/M3s4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqIXr8KlHbpsbVkedXxSZs+2KCwbVlZw6puS5EM
 BwWP/BGFayJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaiF6/AAKCRAk1otyXVSH
 0L9zB/4/n0blZE1Z6+elV9oWF+udM4vqfGkMnWJ6r7KgA0pJQPK/xU0RuvGhc1HYtvCCLOWA5MB
 AyyPQV9u21xbPrmhusis2cGWvbNNU82MbW0cTYzeKGKVUG1a7kc2/3uP676Jxf/F91WR4+W6LnA
 W//1xv7sGbhK8AUYGsi8ZKuDhnfxSBl0U/R/cyonOkX/16sUvPoiwMdX3SPa9tJStkeDuOQB1zh
 Q3SGed42moVgdD4NH5sRQbrtDB+7HqsQcz3NXnX9EMFEBNJQ8rXZWSl7d+F3++zVHMHGwg8HEn1
 1OaWzdR6UbDB5ukkqiDb4EpgKakSvtIWAlnYnZD6RLVxtgkP
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 01 Jun 2026 17:33:27 +0900, chancel.liu@oss.nxp.com wrote:
> ASoC: fsl_sai: Fix 32 slots TDM broken by integer shift UB in xMR write

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/1] ASoC: fsl_sai: Fix 32 slots TDM broken by integer shift UB in xMR write
      https://git.kernel.org/broonie/sound/c/4790af1cc2e8

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


