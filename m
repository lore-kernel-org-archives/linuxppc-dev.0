Return-Path: <linuxppc-dev+bounces-27640-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF396C88E72
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 22:39:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm9fF31pkz2xfB;
	Fri, 18 Sep 2026 08:39:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789684741;
	cv=none; b=jw8/PURL2NN8M2s3zYw1r40rYLONoNISpmaMqlH3gFOaPOKbvk6F8PAVujLpy1g/zXh5+FWTp8k66h/EJNjK/c6G19xqnyD6MKZe6JQgmf8DWjXzWXwqN+N8hlh6QhW2Y0aZOmy3bOBUQp1tRIDXXosNlJoE7vZlSsQwVZbTU6/trCcVqF6KPmkOptny9dtWNRks6G6XrSsjiSsQ3vDJzdNIIDN69YxlObCam/uBELEUdvV/mkzsnUnNchezK/RtA8bgtNXZM0eLC4Uzat0fXJPQwn62wj6tykdzrQhnQxfOQ4i1XHZVSTMhRPqolF/1YCZGLZMwV+/lAKMVdbuS3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789684741; c=relaxed/relaxed;
	bh=FYqD+8EuHNbP6ZIkLeQ20YUnJezRRXMcecWfjRiQZw0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ja9nbRrUWqPVR3/BBZrIBNmtFXwxwQgn5UZAl2pr859kYmXGMeTpY+3fjjXShSm80XPOGxw8CVnHN3ygGdCDN3Wf3P4ByhN/hfyJF0UY0xhY2Ag6HvMC6E5w7fz8ydz7wmT1JEUvYzGFzr3x4ZWjxceqVIFBbkAVW7UAxc6Syvx/94bk2DjuyNbMnuzNK98L2V3SlKg75sk6vKUaqQ+Z52Y9momapHVHU/+9IkScijVUuTnfmuYO6wqIOG5Xp/YxYfrRw2gZOMxV+2E1fZm8IOqb/G4QMp9sNTg9/kzBKCYtuRaZpLZl/aEJW3jCfNYalgRyu+EDeGAANYJeaWFDcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DzwVsXoX; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srini@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DzwVsXoX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srini@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hm9fD5bBvz2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 08:39:00 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5C44D4015C;
	Thu, 17 Sep 2026 22:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986F41F00893;
	Thu, 17 Sep 2026 22:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789684738;
	bh=FYqD+8EuHNbP6ZIkLeQ20YUnJezRRXMcecWfjRiQZw0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DzwVsXoXHLMEaSwh8pkPEtTZNMxKgNsQlbsMxoVgE6nuxkw3wcNDQaK6f+HiIiWIR
	 VuedDSXpyvp/BYW+rDGHCPD7sripNpVxMuH6d63EF1h90INd98Ajq2S3kIt64SZp4C
	 QcjWZpTzIX1/K+PiEnIjwv0K3aZyl7SJy8m+xYkqj1//ac48wqkrz8Y+fOYdwk9G2H
	 mzADuqrUn/xju4AAj9rY1p/FSZ5xZcdq3upVmldTPYTgsehphCm0wthg9NZi1vjNxd
	 ZsqAiD5E+9vIz2H8d5MNFMZ/aejOTey6vbLh48rAn2we7H2OneoLeAcZ0mf5B0kkyD
	 46uX+D4jfGQkQ==
From: Srinivas Kandagatla <srini@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: brgl@kernel.org, driver-core@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, iommu@lists.linux.dev, netdev@vger.kernel.org, 
 linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
Subject: Re: (subset) [PATCH 0/8] driver core: prefer
 platform_device_set_fwnode()
Message-Id: <178968473139.466806.13272492778306156816.b4-ty@kernel.org>
Date: Thu, 17 Sep 2026 23:38:51 +0100
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


On Mon, 20 Jul 2026 11:24:47 +0200, Bartosz Golaszewski wrote:
> With the final platform device and software node rework changes having
> been queued in the driver core tree, Danilo pointed out that
> platform_device_set_fwnode() is no longer used and should be removed. I
> argued that instead we should prefer it over the OF-specific
> platform_device_set_of_node().
> 
> This series converts drivers using platform_device_set_of_node() to
> platform_device_set_fwnode() and does not intend any functional change
> as the semantics of:
> 
> [...]

Applied, thanks!

[8/8] slimbus: qcom-ngd-ctrl: use platform_device_set_fwnode()
      commit: bb74fae19700fd1fa92def9daf49e6fbdea26006

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


