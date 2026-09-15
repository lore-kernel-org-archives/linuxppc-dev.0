Return-Path: <linuxppc-dev+bounces-27384-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A477C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:43:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhX842PDz30Nl;
	Tue, 15 Sep 2026 22:43:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789473144;
	cv=none; b=Ba6Z39+EYk7rx6KbFGVOTgVcWrPcXTudgYTcLR2jCZ1/Ivd3hEDciw/1JoGUiZc9yeKdVSbyEHUFcDaDRXPpMEE9onIJSNEV8rPTX0+tog7EsLMC3cQXoCl4drrccuwAwmZ4chMLMOnYk6AVjHXQuaWl1EOqOCeGY8zPxoelg26Y6OXFnnXBP9Xv8C789qxxe9ErpxOVp/XNl3Te7Jhu1fA/+6I/k5+SrpnefqQZzEvuiIkFAd/4sH+jdiml7sl/VS2ALsoTB8txlQ4KJ/SfbNXK40qVXHjAunjI7EitfaTHndkamNiEEr5ZcjurFNV1WcALW+iDbft+TY/V9TRsAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789473144; c=relaxed/relaxed;
	bh=ekDoF5aUkaIqLM1AvgKs+prcUXxdZryD2GdHfQi8iAA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ftu1ckc4Zi2UMqG3Tohadt7w1RJkyiCy6CGSYtCKoRIKOMBdZo/o7YAMI+r81YdG9cMSaKvehAiEk09+xVHVBFeo1zRckixTxqKiPyPOGYzZR9bAA+VFtfMROQdB428qJ+s29z7c6XikMFhZh7OGUUIZpN1GMY1mJqGIfnNT0nd7HMFaH5/yF8H2gOi8PnppXP+ZOcf1+8gxdihTZjly2wkCGUfGxRWj4GBwIqbieAfnAECy0snKZSkwhfX5PG1+6j6gj/yjx3IluhDr1opBd05u7Y52dlNykah7mP2U4Jgs8Dx7k3XEF0ajcSUmyOOZCE+v3vglexHhoGsB2NBg1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gD24zazr; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gD24zazr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgP237Czz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:52:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DCC2140C2B;
	Tue, 15 Sep 2026 11:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F289F1F000FF;
	Tue, 15 Sep 2026 11:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473139;
	bh=ekDoF5aUkaIqLM1AvgKs+prcUXxdZryD2GdHfQi8iAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gD24zazrk8TigMiCd5ASn+dm6txgjVpHa5zvxMTtUFRuPgLF3PTUXkAm0k3tzbTVQ
	 kW4KsfY0HBGQif9CYx1pshd5pTSxWeoqAtmTVWdPBVqC5Vn35qXuEvnFfVWf0GTUKh
	 RUU6SoJAkl5L0Kq8QF9Rmz6Bec1Ua+EO9EvYsJxPA1pHKVceE0vbNalGCUnepaasCe
	 DK9cR0VwmXUnDDchOmLvDyG+u5nXi3gO659qnVPIeiexcntK9tyLliM401L/8g63N3
	 plW5ukJMt7+DcxaIYWdMgQ+GjvsoPq80PE5u4Yrt6L+3cW6+83I52c5iJrh0Haefuc
	 0OjHhKSvx0zPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 02/50] entry: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-csky@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-hyperv@vger.kernel.org, "Oleg Nesterov" <oleg@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>, linux-mm@kvack.org, linux-gpio@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, linux-m68k@lists.linux-m68k.org, kexec@lists.infradead.org, "Jan
 Kara" <jack@suse.cz>, io-uring@vger.kernel.org, sparclinux@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, kvm@vger.kernel.org, linux-alpha@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-snps-arc@lists.infradead.org, "Jens
 Axboe" <axboe@kernel.dk>, "Ingo Molnar" <mingo@redhat.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-2-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-2-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:52:17 +0000
Message-Id: <20260915115217.F289F1F000FF@smtp.kernel.org>
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

> Reserving a descriptor with fd_prepare() marks the task with
> SYSCALL_WORK_FD_SLOTS. The syscall exit path already tests the
> syscall work bits so a syscall that deferred nothing pays nothing new
> and one that did takes the slow path. syscall_exit_work() commits the
> reservations before audit and ptrace.
>=20
> Architectures without the generic entry code grow TIF_FD_SLOTS bit in
> their syscall exit work in the following patches.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D2


