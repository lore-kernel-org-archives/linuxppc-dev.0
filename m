Return-Path: <linuxppc-dev+bounces-26417-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B98C624D0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 18:20:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZDgF2WR1z2xmh;
	Wed, 02 Sep 2026 04:20:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788286825;
	cv=none; b=X9odaoVC8wL7VjhvcaNWpw++XTWNdNgEIR2XCY2FvdIoZ5w+DCtWfwvHlHdUbqmXhpjcYtjHSR0WPZz2MxMAA9PCLSB756uf/PgO5w3uN4CxiBVbIU5xYTLQ3RPRAtCUl5MC0DzuHLAXR1Fw++7Oz36AfvBfovT+DVnKrzrxHZfq8/nGHcwZpL9r/RFc6U+Dn+PCU7WZoXpsXU2Bfuzeyx3C0F9yi9YfCnoePGOKpZNPh65vPntH0sxMsLOYkATSUpC3Q3GZ8NyM8KZwdEeS9/Tto25Fe0VksSmokHZTr5AJYU79arP6QhQ3mrmUWPMGZAVvldP0oAOkfDhZyTAN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788286825; c=relaxed/relaxed;
	bh=BUKiKs0kChUCTOHYgzamNh5mNEW73GRcHBeBzMGIesY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SH9krnd7namnQQg4YOsS/fs4SRCfG+1zNYTsOBFQlpI8eh05bKjlJOatrtN+m/bAPpbtKavpv/j83pQ8TWPKhZ/wbKEP4O+hnMoyBu2iL8sGVmQgKcdoo1yD1xFcKyiwq8yhitx1OL6vbSOsx8hXipmTlexw5KpmBMJoZ4YY63uvHvfSOF5TMr7mPQbZCTxWUvfhcrgb4P6OuOkYUwKB0+/gX/mxJs5fvoRcbr5MJcqPppQ2BtA6x4e09ZI4ZNUmLhDY20qYTT4RBLhRRQKZMUSFWTeyyStypcByqjhwFlVVe0FgD6/HOFVnzfh9yn58R2lshZll+/mzyZViDCsBGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cpTqJ4GY; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cpTqJ4GY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZDgD5LBlz2x9g
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 04:20:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D7388400E9;
	Tue,  1 Sep 2026 18:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AAA1F000E9;
	Tue,  1 Sep 2026 18:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788286822;
	bh=BUKiKs0kChUCTOHYgzamNh5mNEW73GRcHBeBzMGIesY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=cpTqJ4GYDmFxSaFyjvKPTcRzxoFAS5d3mCysgFmhjT1XzEizGUAO4+FgHteSV96uF
	 syV4qUDEKjRso/XNl1LvpjsaEqdgeKrzSt+NNhj0N/NwK8gMcJLhdYgOnUdcvLxvwM
	 BgQkvwEYObrwyEoFfP3ptA3IB3u6pJ9KR8fkYQbE/wDVNbGyc6qoaRXVJCwSDEJpEN
	 v+GRAhiLDR052PizDZIMF+/0b3fMIAkrP/v7wXgv8LZvmWO+3qq7S8AXGOoeRIATax
	 hMvUrtMF93XUdFAm2wPMhMmsoib81SBhGukWmtOHsG5/jvDPc/2n4Wz/9D3LJvEnhq
	 Wez3x6DJDeitQ==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Chancel Liu <chancel.liu@oss.nxp.com>
Cc: Frank.Li@nxp.com, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260820021454.2229094-1-chancel.liu@oss.nxp.com>
References: <20260820021454.2229094-1-chancel.liu@oss.nxp.com>
Subject: Re: [PATCH] ASoC: fsl_mqs: Add DAPM output widgets for MQS_L/MQS_R
 pins
Message-Id: <178812881948.13461.18281205860019181872.b4-ty@b4>
Date: Sun, 30 Aug 2026 23:26:59 +0100
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1XVf+KD4fdDnv8zdLPNUnNbdVOkJCyHPqO72iXznzqI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqlxdiNOt9CuCwHjrDsFwMB0MoiPiegCVvK4wwO
 YBS3xKPMKmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCapcXYgAKCRAk1otyXVSH
 0K+qB/9aZ9Cwp0KGr5/WSsc2aONUsvWe7bw2BGN4uHfQwKFgwDw0wZ8G1wZk8LfdPJaOtcu136A
 33B7zgiHJW9+98Zx7ErhdJNzGFsKd69ONo0m1MWfiVP4uly4OfHTsEy1RME0ukVtxhb73E0LjpG
 sOSgCdD3DIQrk3PxkxJiYtopszT4cbX2rRireay7acnU4ENwbqQia0D++sdYkwjhaNs86AUd7lC
 rIrNLMFrwcvOK8AbWxnzLPhjK9gbvE66wdwY8CYZTrUk6nCUnazFKLuP4CGKny2C9TNuN0DYccW
 E03zG0f8Px6zubUrfwnGTZfmBG2OaajrbHkf0PpbOIZ3jkb5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 20 Aug 2026 11:14:53 +0900, Chancel Liu wrote:
> ASoC: fsl_mqs: Add DAPM output widgets for MQS_L/MQS_R pins

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: fsl_mqs: Add DAPM output widgets for MQS_L/MQS_R pins
      https://git.kernel.org/broonie/sound/c/040a7beba8bf

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


