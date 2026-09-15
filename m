Return-Path: <linuxppc-dev+bounces-27404-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8514C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:56:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhpp2bNZz2yqw;
	Tue, 15 Sep 2026 22:56:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789474149;
	cv=none; b=YR6tFqXnfR7LgTPuiPKc2P2FFuI8I6aExIHLWpnLpKnGy9AXai25fH+p3ba5xHnLUo+bbb81hOdB+cwgoCqUH1TlQ5aDHnsrbNphDqFPnQCOa+U4/VziFYziLPgdFs/5uw4HGjFZAG09Pn9v2BqiJnBqiJexrdr1oT9zalftoucg8dLkMIGvaxRE/YrupdWQtS4E92PLFfjXIq5lpXakoraqF/BkjRUO3niiEmCan8FOXjcu0wa07fKRiJ66dAfSReS9w3OVEI81iHPK3QCldVKTlq2bkiHGsDeFjCL24aEnrL+Hao3jUcMVzj3qr7fBp+xKQEH0/jVCvOgiAWCTBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789474149; c=relaxed/relaxed;
	bh=1io9HoRsGAc1uikZZU6WOsyCYXG2ohuKM/nD/zRqcpk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=im37t/PAkyNr79qudrweZ0xBAG/RqY9Rjir3h0S+B2A43mRTgFufSmReFzTHZi0bf3+srAC/R6HlwFYetoRA7kyTb0U3QhULFPxL8CMW2daG4TmxjwIAujnUz1Hu7zsaumqBqxKf6S3wDYC6EB2Kceay6x5l6gU16DQT6t4g+OS9dOxhg0XANDB6U1EMfkjkV1bxJSBc2egu1Vf2k+zwqQ41Qx6XFgnYSVvZcsYfmIjF9GKUvVooCPiWHHoV4zwzKd8RP1HdbVCVT+S03Z7FDsWRwKOmkSjqZSK4wg+RTfiEey7xHwlqHLcLIlRRE0LKwq4Z5s/hVyFXkqB/N8pJoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8RCCHlV; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8RCCHlV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgmP1yJlz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:09:09 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AB47260261;
	Tue, 15 Sep 2026 12:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C511F000FF;
	Tue, 15 Sep 2026 12:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474146;
	bh=1io9HoRsGAc1uikZZU6WOsyCYXG2ohuKM/nD/zRqcpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N8RCCHlVffAYpevobrB+HSSxJIDFQlpru+XuUbTtHjJ+eV1oIVuSwd7MGNhXxoQvE
	 0qXqjr2rait3fVxBCZ9NQmO10kK0KaPG6zwH9T5vPB8yCS66JjHDMs4as+k8T2Fk4v
	 e4FlPeCJiND/Nr5uQ9QzHHTvsCip6NFVrnbNCMKMQ1YJSo+H5BqiKdvJCfjdetXK15
	 IA8lwnZJYwWVEQfsXuIfAhEX4i1LbTqySG8jJzvB5s5qUpYo7CHSb+i+lKJf2KL3TS
	 6U9uLcqyT7Zv3ZiC4C+YKYpQCQ/wJlBcsNSQOQuLTJt3AVMsq3rQldu3icesMHZkog
	 thX6VB3gqrvHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 30/50] drm/vmwgfx: install the out-fence
 descriptor when the ioctl returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Eugenio Perez" <eperezma@redhat.com>, dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-m68k@lists.linux-m68k.org, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-hexagon@vger.kernel.org, linux-arm-msm@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-alpha@vger.kernel.org, linux-gpio@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Oleg Nesterov" <oleg@redhat.com>, linux-snps-arc@lists.infradead.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, "David
 Airlie" <airlied@redhat.com>, "Jens Axboe" <axboe@kernel.dk>, linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, virtualization@lists.linux.dev, linux-csky@vger.kernel.org, io-uring@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, linux-sh@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-30-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-30-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:09:04 +0000
Message-Id: <20260915120904.95C511F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D30


