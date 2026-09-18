Return-Path: <linuxppc-dev+bounces-27685-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6DDC88E75
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 08:39:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmQzY2DNgz2y7r;
	Fri, 18 Sep 2026 18:39:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789720793;
	cv=none; b=JLvIC+2lJCSaK3ay02Vd7G7GArKgLFFTlI5Sco59TzFWRejE6tZt/fseubX6yxy5OKP+8bsm/Aut9EA7/8AXFJl8eRAvBf4mJCSF44uigNNO1wTfXBBbIuiKlfLdJTTTkMqALfzpNtMr3zQXfcB0rAcovwJ5IL8U2OAVs+/lHhe4i4uTUzXjO5Wcpqv2N218lESPRvMbUNMLGzd3x9yJsoETHRCjEFFZRPNyngfb9BpPosdfCbCHgcS9WZRYLtAQxrwsM4bwzRKeVCYAbHWjKBzV01Gxm6EYcCmg4k4gs20IAze5aPfj6/k6AYjAFck3NX3ID1xY9U+sJqUGZzyi3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789720793; c=relaxed/relaxed;
	bh=4NyvQt/xrr7/J2Rj9IMwy3V+McdYcbrXcfwVdArfFoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dc8sYRgd8UNOaLzA4OQPw3ks0gPwmmrg+YXN+xMwIbM8NmqpO2CnHGtQx93id24ER7ej/xy4q88BYXol1i4aOD+JmALTwqzMBYWYKI/YzXkPXgqq0Lh+/R/zS1IsXaBSxaoyGVLd3x9By9giX9tgX5QYULnKjjuE2Cr3qNfpBKVUyIKfvGh51u80vStvUBuxwzWEbysyVkQNOeMKT4PtGxh6mTQOhQf+ylIHZuLWqiZ+w6AItVMLpJGCZNoJ/76iMXfBPcuVGqPBOJzoe63szbuAR809bCNEX2cnoUR6SERvjrgKHjs/HZdvIWguM5TYYWQAinyPmLh0X27yrSL0Zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oj77CiL4; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oj77CiL4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmQzX4MVFz2y2W
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 18:39:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B2EF7404FD;
	Fri, 18 Sep 2026 08:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF931F000FF;
	Fri, 18 Sep 2026 08:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789720790;
	bh=4NyvQt/xrr7/J2Rj9IMwy3V+McdYcbrXcfwVdArfFoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oj77CiL48FknHrG/C+PhbXizZUrccbyaIuo3sONdOz2U0EvXATU7wC8FbnrJo60pH
	 QpAm2SeEbdoxJ/yoATNd0P0VxnhXE6fJu7qNIUQ2UTuBxXG3u/MFGuSliTvss13rZF
	 v5pAsTYW3qNHQ56yCV6KcYHzt5z9hfjHNxw87z+4T6hpY6dfai1Zr3fgq32vL5eG7L
	 HsGhskkQPvusqC2fGVVPyVjpqnLE3a0QHxAVnXHiXL6Qb7G30yPK7oUIe8l87lgHeN
	 ltaNmSB+jSb8Z8G7ksFALjofzsIkOaju8gcqyyij9pL1VP+UFwqeUouFc2aB/0ZeMV
	 6kb8zmJwnr0OA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: broonie@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Cc: Christophe Leroy <chleroy@kernel.org>,
	herve.codina@bootlin.com,
	leoyang.li@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	qiang.zhao@nxp.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] soc: fsl: cpm1: tsa: Fix clock leak in tsa_of_parse_tdms()
Date: Fri, 18 Sep 2026 10:39:38 +0200
Message-ID: <178972077003.546774.17878987805855996127.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260917152719.2160395-1-vulab@iscas.ac.cn>
References: <20260917152719.2160395-1-vulab@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=614; i=chleroy@kernel.org; h=from:subject:message-id; bh=pC3q+eVOwKtbzxx0BZcSBlwLSzb+dYpbfXOvP0gz5ns=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWSt+XH6buLtv9na7FOKuo6fmv0y1mOv4ZXC3YLNRmFf5 xSlCDU86ChlYRDjYpAVU2Q5/p9714yuL6n5U3fpw8xhZQIZwsDFKQATOVrHyLBd81a/VUC7/Lvs V8wR18VXh8btmL879cL1SyfqXllejt3H8D/hjcFkRYddXBcy5nGpc3U/+rEidmt79dx94flrQvX 7r7AAAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Thu, 17 Sep 2026 15:27:19 +0000, Wentao Liang wrote:
> The error cleanup loop puts l1rsync_clk and l1rclk_clk a second time
> and never puts l1tsync_clk or l1tclk_clk, because the branches that
> guard the transmit clocks use the receive clock field names.
> 
> Use the matching field in each branch so every clock acquired by
> tsa_of_parse_tdms() is released exactly once.
> 
> [...]

Applied, thanks!

[1/1] soc: fsl: cpm1: tsa: Fix clock leak in tsa_of_parse_tdms()
      commit: 7b3b0598c00e67f2df85d0b4cd99eaa3be6c9bfd

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

