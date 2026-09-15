Return-Path: <linuxppc-dev+bounces-27422-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2824EC88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:59:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhtF2PmMz3bWX;
	Tue, 15 Sep 2026 22:59:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789474792;
	cv=none; b=AvRMzKGKwu7nghNLKSHa0FoG7yPrlxya6FKyMs7VLSoHeEFQ5Utq9Rb6nxWPL2STivHNochNxJonqSZF/Qa6bfAcY89k7OFpUhNmLj7DrPNW4tzPCs750zHf7fpgqbweZKKCz+WmJgcACKzcgUyTE6XJBbth1AEuSQ9HqdvzkdGbx08z/U0PE8OJEfR/3O/YlkssMpdI18bHuchw/QmX+mg/7yiU5c4aFqCtONqpE3XqljFNuvmyn9zjc/0j2+kkOurOXqK3kFCXxKNUC0v1Y3B1LlR8r//ueFE/7glghQmRcoWXtFlsZBVIEPcZPsmmDIVmCDSK3J8CQbcixpXwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789474792; c=relaxed/relaxed;
	bh=s+9PDH0CZ1Vr08YyoCof+UTThGpQ93yPbrI7mSCf5jg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OQJyhamTbs7XDUf5Au4fRUMxvWRsAYQ31Uu7k7CuZAOcJFTjjXqngyH6TGtIrR8w0quGDUhED759+Mar2Ql3zLrPQy0birIYPgUiYNH0hxb4UPPbawZ62/Dr+Yv7lMSMO/Jbu7NtYam76aABTyRjUmdPqd6TcLfngYTPe8WF84T25mmc1me1QWunuc3ylEYksfOTHXkci2PBwMtIpKxQ6fajLfrT096lbX4I+sUKrCAw2FzqacKa6PgnqEX2aRk77M6MRjLUjWayNVii0e56cuXQtfb2ZUNvvkzLcQWgdCQv2Mr/7SbMtGNCqpns1u0u6apRpcwIwd1XViZ5f2325w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m0z6lytA; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m0z6lytA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkh0h0Dsxz2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:19:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5176C4069F;
	Tue, 15 Sep 2026 12:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B431F00893;
	Tue, 15 Sep 2026 12:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474784;
	bh=s+9PDH0CZ1Vr08YyoCof+UTThGpQ93yPbrI7mSCf5jg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m0z6lytA0Lb7PeCTJJ9wan77NmP+WaqiiLFqlwKeXKPuaHqeXDGZgjSEE5Nqy5ZTD
	 uXplubyhODu8Q/NNq14/kXJbT/9AFQwToWT9BIY9E7L4zCHdhq4qOYWiAgbLHBLAxF
	 XtT+b1kvKyB39r1HyAihRAZd/uoRrMfxf0YZCrLmFzS7pKcK/CRl1fiGl+0H5LKWhV
	 PlUaIzcMF+cm9TI4V6HSienMOrDlPf4JHELixv0sjOAXsqO+TJlLMDqNaOXk1sfBNv
	 cjEFW+zAMBlSevojGz84ZSkbXhlbmUkgsft9l8Pqsgamb08/hqshJfCjYTrtd+Gp+Z
	 XZIjfnkZC6SUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 50/50] Drivers: hv: mshv: stop putting
 descriptors back on failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-hexagon@vger.kernel.org, sparclinux@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, virtualization@lists.linux.dev, "Peter Zijlstra" <peterz@infradead.org>, kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, kvm@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-fsdevel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-sh@vger.kernel.org, linux-mips@vger.kernel.org, linux-arm-msm@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, "Oleg Nesterov" <oleg@redhat.com>, linux-csky@vger.kernel.org, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-m68k@lists.linux-m68k.org, "Jens
 Axboe" <axboe@kernel.dk>, dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-um@lists.infradead.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-mm@kvack.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-50-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-50-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:19:41 +0000
Message-Id: <20260915121942.11B431F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D50


