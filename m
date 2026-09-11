Return-Path: <linuxppc-dev+bounces-27101-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1146C88E42
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 05:23:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh2xq2bsPz2ygK;
	Fri, 11 Sep 2026 15:23:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789104191;
	cv=none; b=HCX6vWSgj+k5viVkeVxG2rGeV2HOl2BZJbluW6Z2Er7ZM2TGToWKV4+fAPTAYZhgyQZ1i4W1c0rgoAXtaYfR4jVex2ddV39bm82dijE+ffFL1MQrowz4hH2PCA9VxJ9EwvD6mW/sqhXc8GufPW4pkl1YzKoJMjOuLD0cYaseRsti1n7cBP6bq/xKZtGxejFSu6UqBH2W24QLOi/EORK9xcbKESVkI/Vd1Qv9fsGV9t5rVDhp5HPd78XJlgx0qZT61L62P7KJXKOI+GOM+cORdQIR3q+CTm4dABmNmaWY8aYyxl7nJOeLImqzHb4G8KT0OOlhmGhZKXocFkiDuqh9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789104191; c=relaxed/relaxed;
	bh=+mZRoA9PODrPhpIJV/r8XJ2VpWLCKH5KZbcXxYdds34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjT+cbL0ITOCDmKZG8LcY4DCU1gG2UXmyR9t1hfgs4ILKVi8jn981iXX4pB++BLJWgX6QhlVE8nYKlgV7OSytWQ/tnF/YMxxy07O7eJBbkOAGaYbd/j3eou0xTi1tvltWaMiutoNImX5O+1uaWcPDXtkG1wpmuDqgE3WFywxC2lScwOPhi+OP/ZVSrGRwFVY45jOTSzsPgv0fGUMy1q4x/4eJ6+Q2b2/f2UAdD6Hb6NLgPDZRkvLvVlrqJvT8Xj6zkS8VFrZcpqVsrX2CvRmeGIgWbdy9FJjAuJKiyn5jpwmYDYqwlAb6meUNhiYcbl3WtVAZ9GCq6fwEnMKktXH9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4RXfBs0; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4RXfBs0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2xp47rZz2yd7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 15:23:10 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AD52043BDE;
	Fri, 11 Sep 2026 05:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A8B1F00893;
	Fri, 11 Sep 2026 05:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789104188;
	bh=+mZRoA9PODrPhpIJV/r8XJ2VpWLCKH5KZbcXxYdds34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P4RXfBs0nPp3VWp10lsNlf2bnkwuFmzTreTSpWlbyZPkzqZ8fM+k7sRwdeD2L6pig
	 GuaHY/gzhEwxZz7MYL+Z+q0XqhlqrLRHzljXZ7m+VtdTlNCON6VEHPcQJeCfmNMSxI
	 6QPNykGgyEvwD9NfBO2BVyiKEMRgJG3podow0KFbj1QXvXjSSao/vbpgEBWyx3hZq8
	 T8MppCQOFy2T3Um5yvLPEYoRY0YABML6mTn1uGukKb+pWxKejY+tpvzCR1L3CwtpHY
	 d/1W1KKGxmT7AnM+i+YCuB4Nwip5pNftCkvFAbJN61ucbfGzFX1EfTGDQY4/Eykuvq
	 f6DhMbMaM85KA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vincent Jardin <vjardin@free.fr>
Cc: Christophe Leroy <chleroy@kernel.org>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable+noautosel@kernel.org
Subject: Re: [PATCH v2] bus: fsl-mc: register the object drivers after misc_class exists
Date: Fri, 11 Sep 2026 07:22:50 +0200
Message-ID: <178910416254.316287.15938875439475759696.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260909-for-upstream-fsl-mc-initcall-order-v2-1-b7a04634fcf1@free.fr>
References: <20260909-for-upstream-fsl-mc-initcall-order-v2-1-b7a04634fcf1@free.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=797; i=chleroy@kernel.org; h=from:subject:message-id; bh=K0L3yJTFVuuzwDSP40fpMdTeNGFWENUWsbw5HIR+7tQ=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQtnmDQXeqnfltynoyFjlbODMfQg2WuBbks9bn3pt9O4 nt8VO9kRykLgxgXg6yYIsvx/9y7ZnR9Sc2fuksfZg4rE8gQBi5OAZiICjsjw4oQcQ4rmUt9K80s y+5de716Rtn5FzFnmLtsPorNYpjb28HIcCDA+2uV7LPe9zqiXdtstztZ5jyfcfWgR5BMuqTDQqf VjAA=
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Wed, 09 Sep 2026 19:04:40 +0200, Vincent Jardin wrote:
> Unbinding and re-binding the root DPRC fails with:
> 
>   sysfs: cannot create duplicate filename '/dev/char/10:256'
>     misc_register / fsl_mc_uapi_create_device_file /
>     dprc_setup / dprc_probe
> 
> It happens when the fsl-mc bus probe is not deferred, without SMMU:
> - the dprc driver is registered at postcore_initcall,
> - the DT node is populated at arch_initcall_sync,
> - the root DPRC probes right there, before misc_init() has
>   registered misc_class at subsys_initcall.
> 
> [...]

Applied, thanks!

[1/1] bus: fsl-mc: register the object drivers after misc_class exists
      commit: 7e9023a18eec88b716d8d46a29c4207186fbd828

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

