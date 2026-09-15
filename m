Return-Path: <linuxppc-dev+bounces-27394-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A431C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:45:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhYf1YV6z30Vf;
	Tue, 15 Sep 2026 22:44:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789473658;
	cv=none; b=EgdRWLQsGL0cz3COwN1TmiPIknuKoQWh7PRO+FPTMxol1tf2bY4qIPMCTqb1p4NZIm1KAbAOTt1pv8nu80fuKWFkpo6kpo9HLZT9o/MvbLBdF9h4YZLVy9xJfYxhrLDlVT8l0huStXlVajFC4BB5wB0+s9NPEhfABfM90zaxmR2V/dw9LGwSsrmtKHNCid3sQsa5161s18EMyjevltpp2KV8WD6Zvcw4/xvKN9OImD12bKdnZ0ne0om7LIv3f24QzXGg75fwtkBuMQFC6CjDJmowA/gAFuD5UQoI4K9rTdv6GPWpkw0+K7YMAzAxn5M6U/IWUwwsJnkuDxGGIFeTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789473658; c=relaxed/relaxed;
	bh=MldQSLt+lfDM6akgn8f71Sps4Op9V02KPlLk0XcZRhc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T5knQVupnPVp2XsmDJnHoKX1dv8Rq16VVAamMbR7Uqrj/ZZJ8Gi7Vg2Uo3jGRHp0NKaUyqPmZDvGhx+zvMqD+IdZ9VbN3eOpe1DCg9+hLk6yQD/6kbDBvZ8jFjExLztIXbyzHzewYTOeF4UzNjUser/kNMiGhAq2gtV+Ah09MptBGsYNX+bztNJvX3wivZ8PX0miXW8MsG750X5Q8zwVgMUDw0HXHdXTqjwP1KGIql2511iJ4Mh4DIJM0jQhYOFUiN20z8FUH+Raj8lBp/hWZp/ZSayOrb7GOw2n5blYq3LqU/OYcnOjTZFNBh3LirozruHO8c2WCYqrYgmwZS6jsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYtZVg6I; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYtZVg6I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgZy2LYZz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:00:58 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 389B141B2F;
	Tue, 15 Sep 2026 12:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE4C1F000FF;
	Tue, 15 Sep 2026 12:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473656;
	bh=MldQSLt+lfDM6akgn8f71Sps4Op9V02KPlLk0XcZRhc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TYtZVg6I4Bh2MSIVyOp4GLsBjyldHMWNSOFvEULmB/p14azRXWqSnww77YB7+TPqN
	 ScvufVzu/TJTXHoXtbu6nkMmHWq4H4dMpP1MqQSi0Nmrto4rdEsiZifxC0Gp3ctWOs
	 gVm0pQG3DVlsqt2P+zJAnwEEyISNTbCWqNK7nqDQbAM5w/PqbddR2Jr7q9aHUm+QFp
	 3CM71ghQDVb22etuVzHNdfC2YmQHMxeMwBg3BFoQVgyoGYCR1SeIZz2CuWCHLj4qhZ
	 TcgsJSPylBVRit7lOZeS75JIgRGNA5o89jEC9Doqt4/emxXQvDifGb95FahnRJnIlz
	 1NumvA/sq5Uew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 23/50] file: open-code receive_fd()'s immediate
 install
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-sh@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-openrisc@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-hyperv@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jens Axboe" <axboe@kernel.dk>, linuxppc-dev@lists.ozlabs.org, linux-hexagon@vger.kernel.org, sparclinux@vger.kernel.org, kexec@lists.infradead.org, linux-gpio@vger.kernel.org, kvm@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Eugenio
 Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Jann Horn" <jannh@google.com>, linux-mm@kvack.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, io-uring@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, bpf@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-23-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-23-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:00:53 +0000
Message-Id: <20260915120054.5AE4C1F000FF@smtp.kernel.org>
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

> receive_fd() cannot defer to syscall exit as SECCOMP_IOCTL_NOTIF_ADDFD
> installs into the target task and hands the number to the supervisor
> and IORING_OP_FIXED_FD_INSTALL runs from an io_uring op. Open-code the
> get_unused_fd_flags() + fd_install() it did through FD_PREPARE().
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D23


