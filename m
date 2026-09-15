Return-Path: <linuxppc-dev+bounces-27438-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE10C88E77
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 17:36:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkq2H6ylgz30Sx;
	Wed, 16 Sep 2026 03:36:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789493799;
	cv=none; b=AFDcF+/VKnQyWGmbaW/S6d8LsgujaL3JaM/4v54Qx+Y82GHiCWKmy17PyUscWq5BCUbJqTLgjPJRXV6Oj8q2KpPyV2DuM0ep3geu2WmHxkhK6QZnJlo4wUl1LDn4Icz7CLfLukHAB3VaYaAstgcDZsogBp3AndFi5c3gza6j+ulO7Nr4ylPatphu5fj3M/lQnBpm9+HHmIFL6MPdPItGCAQspupE2dsNYUyvXp5BOMAUxCUzhVgumdFDEQDYdezv7St/iwsrKUMYaqiiMqmKnfBQqj6dM4jiEVID6grvuFVr4jA3+uBYWzUJ1I78RHDx5xP0fhlbKL3Rx4LtlgwhnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789493799; c=relaxed/relaxed;
	bh=OxZYM+VpkLS0sx0hjuecPxta3+zHycbz3PaIGEaDaaU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JYG0wmP7SzM5MDK6dJVXWz0dlJ7eDzGh8k1lw4oi9Gn4vlYe4MhxKgj0v0q9JHFj0Cq6euevyMbyiV81bsYcjSothDXpnSDs0vUrkBayXXnQIXr6pFiOoMcT2YcOe1TyAtVcGGxkr9KpX9qLhlJD4y914iRTlZi97Vtw/aPQJoB4cT4whQrrTpekjrD5F/YfJqAP1L6oZKBiumNeysP2bC4qGwGQoa2OJVoUSA41SOrYNEdVkT470T65jdjIFMMeJnD/ZBY4SDkUgYk5ReyFYVLQ1xwSufXxxTsRGQNSIXN12WSu9F7OwJCfyHmrj6FuDv176OlfuTcTqpemT03tiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MkMm58ze; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MkMm58ze;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkq2H2Fzyz2y2f
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 03:36:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 68DC1602BE;
	Tue, 15 Sep 2026 17:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E091F00893;
	Tue, 15 Sep 2026 17:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789493797;
	bh=OxZYM+VpkLS0sx0hjuecPxta3+zHycbz3PaIGEaDaaU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MkMm58zeQrM65Xhqh8VJUnyMJaTaaOUHosSHb9fLUDAmnU1v34L4cioOVjKRtVHmf
	 aaR3TSVhWDeP12/D0ykczDHXeOkAD+zbVv9FSs6SjbHJcLESNNMY9zFS7M4znHsKBM
	 YUuVIhxZJDxI7QDVVe2ZAqDmrXMdRg0W7PyiK1Ahvm0BQzUru7HMj07INxfnloYid8
	 R3sRP5Enou8IFXYrGNGtOp/ArHdp1RAipYQfsFnHc1ccsiJYunpX8Tzt8nqIVDKywT
	 9BvsTbzGATFjeto2FngYCQgjVg18ZTYBYPRKKkIob0BNKaNdYxNb5dm5cN6Au81Z65
	 LJIJnjJ+KKlHw==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Zhang Wei <zw@zh-kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260911220439.177474-1-rosenp@gmail.com>
References: <20260911220439.177474-1-rosenp@gmail.com>
Subject: Re: [PATCHv3] dmaengine: fsldma: convert to
 platform_get_irq_optional()
Message-Id: <178949379485.248239.8580173639743489517.b4-ty@kernel.org>
Date: Tue, 15 Sep 2026 23:06:34 +0530
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
X-Mailer: b4 0.14.3


On Fri, 11 Sep 2026 15:04:39 -0700, Rosen Penev wrote:
> Replace the per-controller irq_of_parse_and_map() call with
> platform_get_irq_optional(). The controller IRQ is optional when absent
> and the driver falls back to per-channel IRQs. The corresponding
> irq_dispose_mapping() calls in the probe error path and remove function
> are removed.
> 
> Moved before anything else in order to handle -EPROBE_DEFER and to avoid
> doing extra work. Simplifies the if statements as well.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fsldma: convert to platform_get_irq_optional()
      commit: 0838d7cfa42536d2cdeb90074417fae33a2585a6

Best regards,
-- 
~Vinod



