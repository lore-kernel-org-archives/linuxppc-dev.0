Return-Path: <linuxppc-dev+bounces-21316-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C091CD4F5E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 10:21:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLkwZ4qfBz2xdL;
	Thu, 21 May 2026 20:21:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779358910;
	cv=none; b=SnFTA1wXpUHzgCT5Xk5RxgtQrRw+KzIaQVL7K1AVSauzfy0wtjLEG4llOYc55FUJNwrIzjmInknTXs8q8KWsgVrceT5kDl8tsd+7hIwgVaOFQ3UIeVYt1d6tmyQZ4CTK0QbS7lu7HuXEl5+9gUyk8jv43nb2gKXhoJ4lwx3MRKPYrvvA/pXkJblc5/hu+NYubCFBQxxH8vU5N+5bx8LaZdILg5VJB/mqzVE9KspRoJl0P3I8MwQcYZBqiTs0NbHH2zmA2cX1XNJZM2Fbm3tis+LH7z72LTrAUJtKX6YQd+2D6vQII4xrNwXbpOv0AQfIgS+eFVY5dPNB20U29w/HDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779358910; c=relaxed/relaxed;
	bh=JMPwawuoo+FF/ktT9CWL/B41j3xPKyCYtygGQ631+OI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0c2a41sMVbGXt7agfwlfPLM2jHHPDeUExwzf03ypZZ9GR28Olh6ROaEUUECq8bHhxGZPafjgzJm0/DE4vvQewjhtZP7QmuNtgRhoqO+f/ekdekD53s6EDyx6PUTjgZ75wuk2SuhIpInl2jjqUrjIKiskUc8ShQ4ArvpCiqTxlSDP8t5ojykutt4X0gIRrk7blwQgdVt1uP/tAL1sc5ATnNMNSG2UX53cP8WciBtdiCPcApgOKF8BtPtwGB7mtWbbig0Nl3QbIzeh9xY9ZWTeJpyDCRROy4Pei5T66xaaowm5tLQr8wALsSjmzefQEuD7v3KisljlUhTbrW7taj67Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GyujhIcl; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GyujhIcl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLkwY6dcPz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 20:21:49 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A73474407E;
	Thu, 21 May 2026 10:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8940A1F000E9;
	Thu, 21 May 2026 10:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779358907;
	bh=JMPwawuoo+FF/ktT9CWL/B41j3xPKyCYtygGQ631+OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GyujhIclQPg9DYXc/avMXQpQYuUEVt9xTmVMfACoSMdeycwpemfk5L53l6XWNuQHl
	 oOjJ1MwucNSkhqlAQMuyXCBp3vFibdR8b4/JpZKqii1oMHrSanHqZtL769xnRN51rw
	 rW/3+yHMuzfwagGcfCuC065ls555G7vsXUyI1pftWEg4zaw/Hbljho0P8e0NTR41FD
	 HzA02akNd18S1hFMGIJe5CVwY9dtsrm6bez3LasEn+jkqLJNWHG2NLbHlqO5x47HeE
	 /k0W8/xgMkwpSXRqaJuMJ9ZD7uyrvKWA2wJYUBDCQu74LR+KPKy+v8oua7XKjViXRH
	 QVCfJSJIQdlBA==
From: Kees Cook <kees@kernel.org>
To: linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	Sayali Patil <sayalip@linux.ibm.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] LKDTM powerpc enhancements - Part2
Date: Thu, 21 May 2026 03:21:21 -0700
Message-Id: <177935887882.2266323.11773405239596341070.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1778975974.git.sayalip@linux.ibm.com>
References: <cover.1778975974.git.sayalip@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit

On Mon, 18 May 2026 12:26:03 +0530, Sayali Patil wrote:
> This series adds a new LKDTM trigger PPC_RADIX_TLBIEL, to validate
> machine check handling on radix MMU systems and improves reliability of
> the PPC_SLB_MULTIHIT test by adding isync instructions after slbmte
> operations.
> 
> Please review the patches and provide any feedback or suggestions
> for improvement.
> 
> [...]

Thanks for the CC! Yeah, with everyone's Acks this is fine by me.

Applied to for-next/hardening, thanks!

[1/2] lkdtm/powerpc: add isync after slbmte to enforce SLB update ordering
      https://git.kernel.org/kees/c/3f21a4426e6f
[2/2] lkdtm/powerpc: add PPC_RADIX_TLBIEL test for radix MCE validation
      https://git.kernel.org/kees/c/122b52f0bab0

Take care,

-- 
Kees Cook


