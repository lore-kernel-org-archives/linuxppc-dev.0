Return-Path: <linuxppc-dev+bounces-22470-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7C1CD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 07:35:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbZDr2Pzcz3bqh;
	Thu, 11 Jun 2026 17:35:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781163324;
	cv=none; b=Eep/WNRamxq4J+CF9TQtuzZj8CmCA6KoL567vF9+8t/8S2nXwPZRckafxrpEoa8YQFvpSZn1/0e3s6ah5IgEQnFPPlrXLLJPxp7BOGU2HNjlasv+3wxq4SvNSaL1T4HYOspLVgmx1BwWJ7HBWDtfEpugZG2Xnd0UoZqopXf/cPD31pxLLYaQyjURRzZjmz8tDbDyxPIHgCEsCaT+sWBGrmeJxTcA/4cMol94drII2HMaNUn3jrdt3HLM5CPbw3tgVZiC0Ll+RAR/kvkHQ5uCgwUJWljd2RbkYuCSnWRiglA+uHcTnyKhmOirVHSoutDJX+Krl33O75N5QYG3flCAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781163324; c=relaxed/relaxed;
	bh=mo/64/HPY/6XXdxYXG0j1Rf2IH961OLjSb7/zYXIAp0=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=iYiFh5D464t8GjfcH8QblZ/3fK0WhkudNC8v8kMhk7I/0/cBil8eBsXE4ZDuTnokXdlPeVOiC1FDWI1//M5FVPWQ7A5nzUKwL2J81pYMgmdmFX5mbKKBXkjZ8xSYJQjcau6cyrzVW9tCdSiufpa/4MpN7Hjstc6/2z2eMCWilwliCI15mWQ7g0sB5kDNi5Zt8sRTuMMDFL0FPs30QFiGI6tIT5pGjeyDWCjMRLJak2OJo9e5ufBtW5xjTVHyAu5h/LTLkFZ7l8T4+mqY0orrC8e9E8ryoIo6++DaThxfU0kDA9QTnjBC/kevr+gbELj75dnKP/x/uepoBw4Rke3Gqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z01QBw/h; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z01QBw/h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbZDq1Hywz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 17:35:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D79B56020A;
	Thu, 11 Jun 2026 07:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3651F00893;
	Thu, 11 Jun 2026 07:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781163319;
	bh=mo/64/HPY/6XXdxYXG0j1Rf2IH961OLjSb7/zYXIAp0=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=Z01QBw/hVD0yzmyR9h/PeeyZ0iRCgAk+/aPcn16UqS3zZfuWeP7a6qWfdqmwQ64c7
	 SUPKR2ROzkbXWRdLbWoisYB51wZF40L8vvw0MozUehUzOXbcsSsnQ0fbgMJJmCHGkW
	 z+TuJ9RV3obUIo8CPP/tRZUPc5Hs7F5upTIG6t0fkoVPZxquwXwNgAinfjXUhvkvqU
	 6YeQ2LjisVMoDUHycAma+Lu74RYAWxQFblvBsWwIvRFb7/kKDiutnbSyvdf+3vpuqS
	 Dp2GHlTRm5vmXa5cb7jZrXcCPOVrqwZElTLvCkH94I9VrnrjiQ9+mME23BBp+rSEGk
	 5s8EcKr+hihgQ==
Message-ID: <c52f5bc48973b580c8df41764acb73e4@kernel.org>
Date: Thu, 11 Jun 2026 07:35:17 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Sumit Semwal" <sumit.semwal@linaro.org>
Subject: Re: [PATCH] dma-buf: move system_cc_shared heap under separate
 Kconfig
In-Reply-To: <20260610142329.3836808-1-sumit.semwal@linaro.org>
References: <20260610142329.3836808-1-sumit.semwal@linaro.org>
Cc: Brian.Starkey@arm.com, afd@ti.com, agordeev@linux.ibm.com, arnd@linaro.org, benjamin.gaignard@collabora.com, chleroy@kernel.org, christian.koenig@amd.com, djbw@kernel.org, dri-devel@lists.freedesktop.org, gerald.schaefer@linux.ibm.com, hch@infradead.org, jgg@ziepe.ca, jiri@resnulli.us, jstultz@google.com, linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, lkp@intel.com, maddy@linux.ibm.com, mpe@ellerman.id.au, mripard@kernel.org, npiggin@gmail.com, sumit.semwal@linaro.org, thomas.lendacky@amd.com, tjmercier@google.com, x86@kernel.org, "Arnd
 Bergmann" <arnd@arndb.de>, "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
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

On Wed, 10 Jun 2026 19:53:29 +0530, Sumit Semwal wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> While system heap and system_cc_shared heap share a lot of code
> and hence the same source file, their users have different needs.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

