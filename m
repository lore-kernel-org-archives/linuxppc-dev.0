Return-Path: <linuxppc-dev+bounces-27408-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4D5C88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:57:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhqt1FS8z2yjN;
	Tue, 15 Sep 2026 22:57:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789474288;
	cv=none; b=noJ/w+hiEohcoQIBLpd3yr2AdXxw6XedS3quWH8yI6LV6h5ppSfqeUyMXH3FmDtxDKzsuzF+vbAGdIMM05bTMKBKPZqlhYRlOnMw3H2cV1xni4lzjVEycKkZ5YHZJQZ4NdPJN+P+g50s4DJ27Wqtqq5MizDfWzTJ5c9+Do8sFvBvBdYDX5KLY5oAUdZzTP9oCyk/ep5Gxn3ECNhEv3z06KerETNm/SU0TS9mgGWbQc1G9JXfrmiCqBwW7whmX4fZb1agEmbi00u25Gr8dh7zQatVVzKkSo45jPejGvqBvPp7wLInYuku/oGnqWlEv/8bf7ZDqn9QNvWNSo1Xq97OuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789474288; c=relaxed/relaxed;
	bh=sOVPYbcZwP0qO0v/wyl6IpYJ7aj9qJBJUvOIh/HcLZU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h/kJ7mL8jyNtEWThxvD/tn0amxRI/h2R6FbJx+obe6WYIzdRSEWwqcZl0vw5i69mPV/Hu7D3FOXdEofeDXXH0D7qKHtsIMPkfrNb/XrVRVy6LWORp4vWgZLg50UmunG+SyeAAIFXD02tyG9cLWEAg5/PV8Jk8GqFo75IScYGHt21YFtxqZ97G7j9Ov5y5J4e/E3YAAtZyzmv8jbnu8ACsf9+HsBSYHj6YtBblWfgLaGVjzJSmlSQ82gPQJn+eu4TyC50mz/xbuwDAN7ta+4hFblkW6TEI52g/WMskC67jtOQ71DUhg5R8r/grPcvuB9pBablwkHFaRtpbY5HWxXvSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RmyX0EJ1; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RmyX0EJ1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgq363X9z2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:11:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CC954602A8;
	Tue, 15 Sep 2026 12:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D341F00893;
	Tue, 15 Sep 2026 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474285;
	bh=sOVPYbcZwP0qO0v/wyl6IpYJ7aj9qJBJUvOIh/HcLZU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RmyX0EJ1B0zOgT5ioEXRLk+o4F4Y5EudQ2MyBappoNbd4lClHN+PysLRe+lqvPVp5
	 tBwJMbqCeZEv7naOUmB5POnQKn+dbX0K1SIPTGnovxWaK3d1hrbCQzt+QTOIjSS0jv
	 ozOLD3b4lQSvA/CU30dXodluwPZzgV+Ca6K7iJVN6Vk+KD4JQXyjNYe7jK3mYcGLUH
	 4XnCIyui6X4vRwCLNy4FaV+3AmDMv+qiX7nSh5emNDsXdPMr643qZCL0VouKa3ayzv
	 pThUPgyUG/CP/C8WVCikSGDKsjSd8zkAPHVNK+58jF+szrJfKJpZ9+ygivmoI9WEAz
	 pHHOzSGPpXmoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 29/50] drm/virtio: install the out-fence
 descriptor when the ioctl returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: kvm@vger.kernel.org, "Jan Kara" <jack@suse.cz>, linux-csky@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, dri-devel@lists.freedesktop.org, "Jann
 Horn" <jannh@google.com>, linux-parisc@vger.kernel.org, linux-snps-arc@lists.infradead.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org, linux-um@lists.infradead.org, linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev, io-uring@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, "Jens Axboe" <axboe@kernel.dk>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-fsdevel@vger.kernel.org, sparclinux@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, kexec@lists.infradead.org, linux-gpio@vger.kernel.org, linux-m68k@lists.linux-m68k.org, "Oleg
 Nesterov" <oleg@redhat.com>, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRh?=
 =?utf-8?b?YmxlKQ==?= <brauner@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-29-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-29-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:11:23 +0000
Message-Id: <20260915121123.B5D341F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D29


