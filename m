Return-Path: <linuxppc-dev+bounces-27409-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90330C88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:57:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhr51wBlz2ylm;
	Tue, 15 Sep 2026 22:57:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789474337;
	cv=none; b=HDIl/q/IOud7p9GndZRHIWUs+4JhoUUuXzu7YJeE3UAZAJFiGvOMFbgXz3+sEFMbCrKSqeD0HEo24B+TotQRPjhE4K1IuuMf5jFl6tU52t2Jm8OsAK6sA72XDpQhC7bzOGtJ+yukN+hd6Tp2g1ixM/AtXL0oSt8j/BZr34d3paIwBlPXnNqbbUKdQe0Ej0hW0yEdJYBCybNIz+2zbjalPF2mh9ufU3XXN9v71CKDnnfJwW3KchiS9zNS2hZ1UkEmh3PxQ6T1r3XRZ+aM/H7OjDYtq093dmp+7uRyV02ZYUuSUmNtsM0nAbb4IVKkoTWTK3xoGgmDL9lpe/C6fPrh/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789474337; c=relaxed/relaxed;
	bh=dTvFOp6vSGe4AZsCgKO980b0BeYwtUxBQL5x62d5jw8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gwLJTEecHvbq9gOEm7Mk15PwqGojC1/7ej4tDHzT7LolpHbqAd15424iCEK03My1x7yYNfl5dWRJksUQurpzV0NUAJbQyPAzn/GjBxtN+QvQcuTSFmkr0I5yVLcITfoJ7zqgMkgtkRdQs7EjYHt9LVRWKbWb6AbbXQ0zwFEfsaCBIiWfCrKL1iUB5nZ/R0uwUS/rhbcNZygcHEMxVJKvUVGxqRM2y251Py4VZRteqfsaGR83NEhCr0zaxVSn6D3/Gmhy+k6gZvqWDRefn47DjHiMfCGwlPLiIl2JleWjFcXCdxpsANlEdtJ5jEiWHuVbIPIYdslQV+rLwQyW22L2yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EFlkG4kl; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EFlkG4kl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgr10y2rz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:12:17 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5A19240523;
	Tue, 15 Sep 2026 12:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7195B1F000FF;
	Tue, 15 Sep 2026 12:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474333;
	bh=dTvFOp6vSGe4AZsCgKO980b0BeYwtUxBQL5x62d5jw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EFlkG4klTh9q0ksv7M1hSJKTTDQQe7H5iyO2zHATvBU+UXti67y8RU1/odOq/zhGR
	 VYQ/UthUrZvWy+XndwZ77DKsyT/9Ri6pFxYRhTSWuJI+DH+4yLpyuhu8mAIrHMk8t/
	 6kDv1q8AwhLZ6F1rb+P8f3KP0PwnSljmvJWSc46nWvAQt32cRvhQ+HBCxLIdV4HK1y
	 DBbf6pk3x8FN6xy4faUytIL4oO+ojk8F8MkK5f1LgG4gC4ZmwrIhyHU1W79T6CKby7
	 mQNMHJsClSUixl8DuKxj7EGI22mNfTcwiHmk42y9GBCpJ9M/rUqbu9RbXfhHzUFMg4
	 vNY+QKqLhGlQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 38/50] perf: stop putting the event descriptor
 back on failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, kexec@lists.infradead.org, linux-um@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-snps-arc@lists.infradead.org, io-uring@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "David
 Airlie" <airlied@redhat.com>, "Ingo Molnar" <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-hyperv@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-alpha@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, kvm@vger.kernel.org, bpf@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-hexagon@vger.kernel.org, linux-mm@kvack.org, virtualization@lists.linux.dev, "Jann
 Horn" <jannh@google.com>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-38-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-38-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:12:11 +0000
Message-Id: <20260915121211.7195B1F000FF@smtp.kernel.org>
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

> Rely on the fd exit path machinery.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D38


