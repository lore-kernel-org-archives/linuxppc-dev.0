Return-Path: <linuxppc-dev+bounces-27420-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1813FC88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:59:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhsx6wCwz2yr0;
	Tue, 15 Sep 2026 22:59:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789474716;
	cv=none; b=BDoZbEUZU+BkXXV/nRZMN+CFXfyPAO9mDagx7WFYw/J+fI+6STXxwlEK4scy/TCv9cZlf83LKmiTl7XqlIRRV8eNNUDI9ChLSyKRfEPFsN9EcDLVNfLLUqYThCDbrnIVVOx6/srkg2hqIuOARj0TGa7n9Ez2jMGoBW9wSd+KE6Ec5GIpDWlCf+yvtCqfaeq14RAcPQRmjqKsjEmfRpHrRsJ3ZrcW+PZfdf8Kz32ygQXXpwX7el96G6blyMGM7CWzn9Kj4K68DSAslUUhqRk6UXjl9d/PlvavTRTY5IlAzNw8g8hdVle5BRYfmcPCJ303kX91xl8UPP+ryEv7EigBww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789474716; c=relaxed/relaxed;
	bh=3Nr8gcCwi6DEWSLP9EN8/l4h5yq3GfGsy2oDZDwQTVw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cueNhuJWUzL2SjOAj1qQ15dDcLisAiWGmrHgGM2dobwb1jaDIfu7GHyMlaeidpGszFB/cZ3wlCfJ1/xmat+iKTCOS1XiUUH1D1L03ofVvfduz2Ec0HVZmD0Kb0JHejEQrdZylnfgI4reIWA0eIjDhqhtkgWzUe8wvgBlndZWDYUZBPxSFatrqazCtxleMBIO288ywquKI5ez7cS3FY8VPVgmwtLYK9KypxE5Rzp4tPk0dl/OvS8S89Sz3Hd7N+7wKZtgrHQoWkv7wWIG6Tq6iTk0P29Rp89DTPmr64xppxKEP/4TN4u71GVnqbulRYuQTXb12RPtJFkfWpxblUDxag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=al7xG3Qx; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=al7xG3Qx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgzH5bfVz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:18:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 24A0A41B11;
	Tue, 15 Sep 2026 12:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6100B1F00893;
	Tue, 15 Sep 2026 12:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474714;
	bh=3Nr8gcCwi6DEWSLP9EN8/l4h5yq3GfGsy2oDZDwQTVw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=al7xG3QxpordB8FaZac1xk6QWAEGzphwDCGfy40ckeGGdeDP1tbwhbJklTqx5QQFT
	 ODvPZmGs3Rku3J2uQB3ChHYQAriES6YPKKW/TWgpaSESxWFOwioknFfQIhOZdlb/lh
	 RLkOhFE53P9jFChtaD6A2+vi4SogD6zm9+SM0eAaXOgGkYYLJJfSgO/RrU1jMf018L
	 IsZndXI06LzsoDnaEX00kNg9+CSe+xR/UDoSJpVb9b2SoGOi1j19PuVJIg9jG4HZNR
	 dl5cjIQ8g0S9+wNIlluWxOi9Rk+9A+i9qr4Dl8RqrHyi07ZG8WPpqBJZWgaHICrgtm
	 ZwEgDuMch+DXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 47/50] iio: buffer: install the buffer
 descriptor when the ioctl returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "David Airlie" <airlied@redhat.com>, virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, linux-openrisc@vger.kernel.org, linux-arm-msm@vger.kernel.org, sparclinux@vger.kernel.org, linux-mips@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-hexagon@vger.kernel.org, bpf@vger.kernel.org, linux-gpio@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-hyperv@vger.kernel.org, kexec@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, io-uring@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, kvm@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-kernel@vger.kernel.org, "Jan Kara" <jack@suse.cz>, linux-csky@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, "Oleg
 Nesterov" <oleg@redhat.com>, "Jens Axboe" <axboe@kernel.dk>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-47-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-47-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:18:30 +0000
Message-Id: <20260915121831.6100B1F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D47


