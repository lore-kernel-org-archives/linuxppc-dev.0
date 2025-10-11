Return-Path: <linuxppc-dev+bounces-12778-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E126CCD184
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Oct 2025 22:32:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ckddc2dV8z2yrt;
	Sun, 12 Oct 2025 09:32:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.70.43.23
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760221117;
	cv=none; b=DGOsV5hdq/F3aw7Gfs+xFN1OEbN4/KsHJZC6A0sUSLsCbHSKZ6hbjSH1NyFBqYW78kEcibTqYh8Pvk+Xk45MHGAg96qBNPTWDqbgzRDwNS2t4LGPqsiONhTM/A5LqC1ev1lAuWCdaRigLrVfdVCybbZdBWgGmdWA6MXkqqGYqceRY/uUq4KOIISf3MqoM+Xh004CDJNZdroKGnZCoZMZgcEEAzygqBiBOvWdXLkkLHK+aYJwkxcCdfWvb6CU7RXA2SXQAdedvMG0ReIvzuhcJxPVvEVP78aWxSu4qTZBBDsGkSDeZ4jlXfjjPRtT3LMhNmhgu6SMmk78ZwJ/uz6RhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760221117; c=relaxed/relaxed;
	bh=w/ZBQzOzhlQR66VMzn75KGikRBMz3ljER3ZMViL48BE=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=TdSZMMcGw5DARbeFx7mEZLNI+thzvsfci+pb0yTPQ2+WMlQ0tPX/pkOdlVebDUhM3Bqj561+bhe+ptF2jK9q/B9akzeiz1HhCy06I7lI+WUy511ytMQ7rwxYt4w4cxF0w7N/egnoZAWk7VHqbcimHJ/RYf9/JrRMdvdqRCzvm3aF6hflikaW8CN4x8d5XtrmogqCbObtLH/aZhxCdO1+wCw+z0GOYnFkK9RVTdbUfUjMxJfOZ3kVDQG/XJWXecOM24hOZPwZHC1oBsaibNMMocz7U0PQebf3xaRYAPgVdOOalqYoZXl6E2VcHDuUSWsF85FrRn3Vn97Qlh0ixuge5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=fetzner.me; dkim=pass (2048-bit key; unprotected) header.d=fetzner.me header.i=@fetzner.me header.a=rsa-sha256 header.s=protonmail header.b=VrtN1eTQ; dkim-atps=neutral; spf=pass (client-ip=185.70.43.23; helo=mail-4323.protonmail.ch; envelope-from=alex@fetzner.me; receiver=lists.ozlabs.org) smtp.mailfrom=fetzner.me
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=fetzner.me
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fetzner.me header.i=@fetzner.me header.a=rsa-sha256 header.s=protonmail header.b=VrtN1eTQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fetzner.me (client-ip=185.70.43.23; helo=mail-4323.protonmail.ch; envelope-from=alex@fetzner.me; receiver=lists.ozlabs.org)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ckdL21tPrz2yrl
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Oct 2025 09:18:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fetzner.me;
	s=protonmail; t=1760221108; x=1760480308;
	bh=w/ZBQzOzhlQR66VMzn75KGikRBMz3ljER3ZMViL48BE=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=VrtN1eTQSo096r1iLpzN7FKKsQlwq500vWHM8mdENt23arQFaTNONhY2PG8kGS6wd
	 C0WmQVIcxqBQKgFylScgzngsV7ASn3UpQFKAqW/hOc6ehAaHXFFzkL95I3x9JtOqNY
	 T/cHZbiDAI1ftPftSMFg2nxw8AogJPkytrxH5B8/Uuh/Lffm1sO/oInjuQm+zqr9ZC
	 DXqVVsvlhkdDoyb9PzaRjacEfRqKU0QV2I42cExHGLvnWrgegjjI0WKdr8FzS89PCe
	 hE8qw3MhXSGek8p9pWVVzT8vuygnhDUJCCxZQySZVwhlEdURdfFaf4nrygyX4e/kyV
	 ZHuSI8dR9hrUw==
Date: Sat, 11 Oct 2025 22:18:22 +0000
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From: Alex Fetzner <alex@fetzner.me>
Subject: [PPC] t1024rdb: CONFIG_KERNEL_START=0x0 equivalent for ppc64 (Kernel 3.16.85)
Message-ID: <yEcgGewmm_K00goV2VDaiSwPgzZCWcRkHeVowwzmBOkeZHAFjGt6BSjU7ZwRTfKd1cFF6GKshrfTDzQ4LZj65Wkc2S4aPBKKIW6FxvAZ46U=@fetzner.me>
Feedback-ID: 141959855:user:proton
X-Pm-Message-ID: 29807ebfb2b291a2580ec53a8d8496eda941167a
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello all,

I have a legacy product using linux 3.12.19 that I am updating to use linux=
 4 and eventually 5.=20
The product use an NXT (Freescale) t1024rdb (e5500 processor).
I am right now trying to compile a 3.16.85 kernel that works as a stand-in =
replacement for the existing kernel. The product uses a u-boot load address=
 0x1000000 (1MB) and flattened device tree address 0x2000000 (2MB). The dep=
loyment of this kernel is such that I cannot alter these address.
The original uImage header has load address and entry point 0x0.
The original vmlinux ELF from the uImage has entry point address 0x0.

How do I appropriately alter a ppc64 kernel to have entry point 0x0?
I can create a uImage header with load and entry point 0x0, but the kernel =
uses a virtual address 0xc000000000000000 as entry point.=20
I see that 32 bit kernels have the configurable option CONFIG_KERNEL_START,=
 but this is not available for 64 bit.=20

Kind regards,
AF


