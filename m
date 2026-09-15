Return-Path: <linuxppc-dev+bounces-27400-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144B2C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:55:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhnR5TV4z2yfH;
	Tue, 15 Sep 2026 22:55:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789473894;
	cv=none; b=FyKUr8DEYM3bBpv3T+xh/JU7IKRjN6WEE6QitRXTOc17nt7LDpeW7KR+iDw/3ji/HoIPBkzyNsYyZ++i0vKRaoy2OFgUZUslxZeYZDIyhvwWIxdod9mlliT0PT2pKGRVBRYw/ykafmMmJQcc3biXrG7n7ayYpm9kmH7sohfU+sG4bAkq1bw7WHf5wkOoG83Z7l4Ptbie1zk8baViGSK3nn7uQSiDaGQc05hFGVRaeLLx+Y2d5NpgNPKlPZmD27SI3dd3AG96J3RLOUp3lwH5p1+xkDpyU7hGBYCmlcRLgDclW2nVefJOeuyCS4jvp+gdKTRhGr4KB+ZAlrmeBR78BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789473894; c=relaxed/relaxed;
	bh=JAT+dPINnJ0baLSnWeyqna2pT2L+zf+r0Hb38LXbJr4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K2iDGGyC+qpjFjjl2itxmfSTfv+G/2thCX+azKuYIeXmdHhpmumlbBMaxOYwV+byMqRBK7Ra/Y7lP95SLlXxqcoxEpGopxLHCEvKzxLH0FpC/1VrAshLvLa255L99ZT7lwCnd0Wy8h0y9kN0s2dXfEWadbSwleJCGEHfgra7ZPN/pkU1bTZwtrhCx79F5IlZEuBLb7Ng7J3+hu/b3FxxnTQuFy3IoNbzRXEtAhQW6h1cw5ZG8t4QoHLPQFda5JAS6xdGjIgQPo5bfrQVkogD5c5SkVXGDdZT15dEr2r69PbzF+QhzW8gr7jJeZpVa1LeygpBLA+A6R6QjJynefzSGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mh0aJRjv; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mh0aJRjv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkggV0Yj1z2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:04:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D371E42D5E;
	Tue, 15 Sep 2026 12:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92CF1F00893;
	Tue, 15 Sep 2026 12:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473889;
	bh=JAT+dPINnJ0baLSnWeyqna2pT2L+zf+r0Hb38LXbJr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mh0aJRjvpgxlZiLKhSATPqRfUaES+f2XTT49Q88vDM46+M2joHhrL5IXTe47rLwKc
	 lQ8SWuZa+L36m8Iss1J2WPRz0FGDuI7oSB9RhNnd6Q/OBlecSo2ec3ESUds1YiK9AY
	 yE5zSTou8yCIYMwaO7fw3TkKtVt9q88AVkigmJ0j7/I1yD7epQKS1vU3wqqB1ahaXX
	 LNYP3gTZ6O2PbkoUguLy6zmGopGbgX6RXuAS1J3tZlp1M2JrhXEo7fKehrQrDDD3RI
	 cFHwW76z9ATTIL4qO2fc49BAVBC61Nonh5r1ZU9cD24BOO9dRalQfLo+8prJsERH0V
	 r769lDt95U/fA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 27/50] drm/amdkfd: stop collecting CRIU dma-buf
 descriptors for a final install
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-parisc@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, bpf@vger.kernel.org, linux-csky@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, linux-snps-arc@lists.infradead.org, io-uring@vger.kernel.org, linux-gpio@vger.kernel.org, sparclinux@vger.kernel.org, linux-mips@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Oleg
 Nesterov" <oleg@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org, "Peter
 Zijlstra" <peterz@infradead.org>, "Jan Kara" <jack@suse.cz>, kexec@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-openrisc@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, "Ingo Molnar" <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jens Axboe" <axboe@kernel.dk>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-27-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-27-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:04:47 +0000
Message-Id: <20260915120447.D92CF1F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D27


