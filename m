Return-Path: <linuxppc-dev+bounces-27398-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F73C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:54:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhn63hrMz2yps;
	Tue, 15 Sep 2026 22:54:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789473800;
	cv=none; b=UXNjYk2UfZl1hFrsTsQMBqYfiN3wcVYyM9nCW6CVMsxnleb80axFzYf1nWGFKbyBbcceK36q3p/UXmShb8ViK1nT4V5SBhwex3fyOQlgTJb4vCb0WJUCLL+YELhARXXnv4nwb3IIaaWYn0fhHngw1jHWy/0YLFHFhmp53Q/7zh9T/F5+XyMA9pZc+afvCLaqgCRWsKajbuLtM8ScekOMtUMuffAGDuXUOEgqY6nIXWMV6ypkHGi7WVm5LovKreGEnTTbUve3oNdLvdu6shldTPfLA0kVEQR7qIZHhzMRXzn5G2B4yudkBGzpuVtKCtjB9UkFoFrPPb6m/GArx66FGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789473800; c=relaxed/relaxed;
	bh=+u7ApoOuOF8zgpGLaZZqOsYtXtnXCzj3vZ61f6s8LvY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K7KmMzp3zFiSy2ZmddOiflqXdhhl+OZ33ewiti06y7BlG6j+YW1xsv/YYbuvFJO0mBZ0XSxPdmPDKZiEfF27qVoVhodslBXY6VblKYCwAkXwCPMJEAYlNsB+6hooAeK2hIy/9XJaq1KMrWwoqmUbXgta+frg+0ohiPOyNok2bYgGsvZRhNfSt8qblbNcfnCR7H/IZVk94Rwl7X22C5IrSoYATnfIesxmjdRe9fA2ev7J0dda5e7a9UPziyqoiro9Yr6yKn4Svio3XxCc0l4ExRu3X/V7/8FWb9Sncpd4BSgoo7a7CyhpzSwgpiX8b+mITnhd+6yWm/upHqpAe6PSdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THnhYqif; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THnhYqif;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgdg6NwJz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:03:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 84F70409F3;
	Tue, 15 Sep 2026 12:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53111F000FF;
	Tue, 15 Sep 2026 12:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473797;
	bh=+u7ApoOuOF8zgpGLaZZqOsYtXtnXCzj3vZ61f6s8LvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=THnhYqifnsYIWurKEUAhE5a21iMJPlZD91gXsYeEKbrZccsHcRXVqGfm5oAHxQqOd
	 e1wuKKqVeBYXyc2aFoavHWSkhBnSVerlDl5LdiePK1NOkSeaQW/idnPwhZZFr9qO2U
	 cg7uUETVS3OG1gBkYBAm+yUoWRGRSH3/1l1cbZ2tR32pl+WFSqQtvnmtWPmcEO4Q+L
	 BxuqA3mh6TGj2Aku0WcupA4zXl8/Qqfs3dDrK1fqU5kv2LzDSbBcXV0J8UBqa9cxEY
	 w/xfA2bcbpba0mU4z3odT8FBDfF8Id5jJPBmzjOTZnLPQ12i2X8SrT2BDKLxXvMAyA
	 ptXGYIc0ZxCJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 22/50] net: install SCM_RIGHTS descriptors when
 recvmsg() returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, "Jan Kara" <jack@suse.cz>, linux-arm-msm@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, bpf@vger.kernel.org, linux-um@lists.infradead.org, io-uring@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, linux-fsdevel@vger.kernel.org, virtualization@lists.linux.dev, "Oleg
 Nesterov" <oleg@redhat.com>, linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, kexec@lists.infradead.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-snps-arc@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-22-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-22-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:03:14 +0000
Message-Id: <20260915120314.E53111F000FF@smtp.kernel.org>
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

> scm_recv_one_fd() allocates a descriptor, writes the number into the
> control message and installs the file right there, one descriptor at a
> time. Everything that recvmsg() does after scm_detach_fds() can still
> fail though. When it does the syscall returns -EFAULT while the received
> descriptors are already in the table and the caller has no way to tell.
>=20
> Reserve the descriptor with fd_prepare() and stage the file with
> fd_stage(). The number is written to userspace as before, but the file
> is only installed when recvmsg() returns success and dropped together
> with the descriptor when it returns an error.
>=20
> A control message that doesn't fit still gets only the descriptors it
> can report and MSG_CTRUNC.
>=20
> IORING_OP_RECVMSG reaches the same code from io-wq workers and the
> SQPOLL thread. io_uring requests commit their reservations before the
> completion is posted.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D22


