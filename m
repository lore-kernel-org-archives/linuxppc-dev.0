Return-Path: <linuxppc-dev+bounces-24872-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917AEC531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 10:18:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7vgy1bbtz2ynZ;
	Mon, 27 Jul 2026 20:18:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785147518;
	cv=none; b=mV2kwJAStOAVKIBqN6J4a3LBtNVhomQk/a5TIPkY3GIuG5nesD6z4uu0+zaMVzLHUvkUz6/DKDb1NEoxyPVKSA8fMCN5a/KUolF0grTUD2Ad/qPogwCYl+X2dsyjXnSwyoU9s1l4TRnb4itXRHfrDpgVilgORnq5Mov3FXpIJpLpSPPf1ThiWEjDDHbZFAOnaooTFR0+cYU5Xyyipjxk0cqED/lEgN7gG4v4naxvAJRHAUg6NlOayMNsBksqPyC0qxqTObnu59s6XTzI+DDy7MMxWf26VjFB8HQ0HCvGH+Nc+x/u1mJkBeXYjGGlACFr+UOscTFDQmucI9G+P0bNjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785147518; c=relaxed/relaxed;
	bh=anN6OkhNmZN5rfojNfj49R23fREKeQy6o6tuVnDAthw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVkcYJC7UwAXNTQR1KEKAFZbA2twrm6ACRPVZpIoEEsb0YBKrSMwROzBO5sG5LUqQ6R12HOWTTDiCq5ZtftmEzO8nRZ2NA2bUnTu2/djW3fPhAZ7YwQwVFJ5w4YPwLpi9aI2VK8Sa254WIlFH6K2cVH9Tvt030kbr1v/rHCctBs3m/ahAcvcWr0H2LC/UCYxPFY6E/0oIoXDLFKXuMv7nnASEayk/h7VEeM5Ixy/7Qeby375bAiYouiQWZnJMrnAxiiBCnQ1OQVkV0JiSt7sfrVnTrwChiNgusy0ZTDxPxOnpNYSLw40NTY0EkcHPapcyZcgrGM8ZHvx3QH4IG6GOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9ZVino8; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9ZVino8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7vgx4BFnz2yhb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 20:18:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A46C343FB0;
	Mon, 27 Jul 2026 10:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367D51F000E9;
	Mon, 27 Jul 2026 10:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785147513;
	bh=anN6OkhNmZN5rfojNfj49R23fREKeQy6o6tuVnDAthw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R9ZVino81q9zjUPoHRUK9Jw08Wqpa6CQ+xSQSGQegEtHcSXkxQFNgJKzusYjsHptp
	 cX/YBzal+rQNmXtUZhAXYDG2L9GW1Bg3gHqB+49KrZcjApDL/W2ye1yR3hpsF7Rm8v
	 VBSNxFVyKzawmx4m5giUaojN6RCDzXa5WMt+3nILO3C1fs0Et3ygIl57ATKqsrC875
	 JmTXjI0mNxGAMB5LpP9XoOFjVDisach/xz69XdlCdRQRBIRQgMZ4W1BhVYqXDaw9nb
	 luCwM/KYZjjJDP7sWPIY171spZnyJNtl7jpaI3jI9JlnKgXpMd9HXHlhENyYDarsp0
	 NxQqgl5wLGi6A==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Roy Pledge <Roy.Pledge@nxp.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Pan Chuang <panchuang@vivo.com>
Cc: Christophe Leroy <chleroy@kernel.org>
Subject: Re: [PATCH] soc: fsl: dpio: Remove redundant dev_err()
Date: Mon, 27 Jul 2026 12:18:01 +0200
Message-ID: <178514745089.65524.2547109396537618281.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723024748.30105-1-panchuang@vivo.com>
References: <20260723024748.30105-1-panchuang@vivo.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=496; i=chleroy@kernel.org; h=from:subject:message-id; bh=RvpL6q+ypK9jjNxeg1QDxvDBu9u5Z6E8rgNAlFoBt3Y=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWSlGyRF3td6dWWFfaKLR/bsbcZ1702kQ5dImixntWrrv X6AV+pMRykLgxgXg6yYIsvx/9y7ZnR9Sc2fuksfZg4rE8gQBi5OAZhI0B6Gf2YHv2i+STKx/npF IS4mLuPMtLoCewPTlB8ipo19PM/nTmL4n3bmRDT7n+nfPLfmTKj0MlPfsLZ5J6NnJNvDiLfrXqv c4QYA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Thu, 23 Jul 2026 10:47:48 +0800, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
> 
> 

Applied, thanks!

[1/1] soc: fsl: dpio: Remove redundant dev_err()
      commit: 863a06885322bb1c0f43fe93faf13ad3e34b3f90

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

