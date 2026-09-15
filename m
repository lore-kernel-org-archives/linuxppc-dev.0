Return-Path: <linuxppc-dev+bounces-27416-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C52C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:58:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhsK08Pfz30PJ;
	Tue, 15 Sep 2026 22:58:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789474519;
	cv=none; b=axuQUECUWH41TF7doXT2EyVhAnBSLOcJ6Y9rd9FE76f6w6aNFARE2hDLCx22ZcAZmhZWmaCiE5rY+dIgsRqq30nvRWTQ+EGVdZ/bZjiUzofKDs1MLTsqYVwvPYJhxh0UFFB8xZ266y5L52fI4eBPxPEz59yTDFiPW/QWfQW/UNH2F2x6YFxnJpae4xMkR9dRm9JqyAH+kNLtdj4qABjLIj7gPS/3ABe4vu7qFJbikQT44g6qtesmztcbw6qHSCv2CvDC/Q6vHVXvN5/SktRvRKJxr6CRgPGO1rjszw9/FkS2xeejZ233EbeIVIObRHC3vaIY3mp/ksxDg14JrIWixg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789474519; c=relaxed/relaxed;
	bh=7Ki6bSBJwaxJJeHi7SKUuFLkbZmfL/7uuTnWaWs93uA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZArzbhZZ3GfPKYHWMsRJ+IklchLeYGLpzPV1dcdK9BqOIyaLTdDA90Hq6A2DQiG3h09a5LcbVlyDukEvSFOtNL7RWGH/TY8NztiGTLLCKBfLiSuqU2cvyXgQg3auKdZ4e/tBatnsmRvAdNrtXvhKBUiqMNgwcaftUiLljiCv/FysBaAexLfypy11mYRkSqT4hqK0YIdTN8sLeLJ2uZXfpRZEMP79ACqNtnQd+/vua0LCeWKuSn/aL9tm/YEy5R84P0ko9FuSWOh82SqzYm9N451GkX7a/gDH7sGe6sCWCyEGfurU4mtqza9oMerHP/l7Cx/sncUaHoMYGAf1mke+rQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kI77b5Cs; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kI77b5Cs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgvW1HBPz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:15:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4720D60261;
	Tue, 15 Sep 2026 12:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295751F000FF;
	Tue, 15 Sep 2026 12:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474517;
	bh=7Ki6bSBJwaxJJeHi7SKUuFLkbZmfL/7uuTnWaWs93uA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kI77b5Cs1CCH5C2TVxPIT8fy3wL5A+5GVvFbNqnc8ywtIl1xsP+kz2+YtB6oqe4rq
	 l5MIumARVSkDXAKZVkJf4FmmuUstog7U7WkwkoO47/GequtFboDqXFKBhm8gRVl+8O
	 R05h3rhCE8VlU3e70rQ0v5HNwr7mByz6nbAUN2qjsZ4EdPZrSzKMrkSw0ptkltPWdD
	 1K9aNz+rSv8p4Ksfg6V+iO9PxpNKvssHsTIw8bHe/sGHatYYCzuFLzRvKplACIwjle
	 MkbJfnFHm3eFE1Z3cOPmlWvybtFLHN5O2L13O1dy8fXdonFCUhJlZiezPlMPDhpdxP
	 QdqQbUTSLLEqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 44/50] drm/etnaviv: install the out-fence
 descriptor when the ioctl returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: virtualization@lists.linux.dev, linux-parisc@vger.kernel.org, io-uring@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Jann Horn" <jannh@google.com>, "Oleg
 Nesterov" <oleg@redhat.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-mm@kvack.org, linux-snps-arc@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-m68k@lists.linux-m68k.org, linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org, linux-mips@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-sh@vger.kernel.org, linux-um@lists.infradead.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, "Ingo Molnar" <mingo@redhat.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, kexec@lists.infradead.org, "Peter Zijlstra" <peterz@infradead.org>, linux-csky@vger.kernel.org, linux-openrisc@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-44-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-44-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:15:14 +0000
Message-Id: <20260915121515.295751F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D44


