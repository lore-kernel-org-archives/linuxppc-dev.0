Return-Path: <linuxppc-dev+bounces-27381-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5179DC88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:43:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhWm6J6Bz2yqw;
	Tue, 15 Sep 2026 22:43:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789472966;
	cv=none; b=gETZwhWkcgP0osksum5oKGNOtopw7h9Dy10q33lxFaI9S2pqrAFBrk1eTy7ZxBI31sH+3N6T6ANU7HmjcQ55UOtDReH3lYBYpOwoW/QWk9r7FJGzj06xltpYHXMcxzZls1L4xF+qRY9Flx7W2sU391LjtLCZmd+uzq37jdgGXKujJZ8oVAt4WdJ9PTXzv8T49WV9CIgvqRvtM67MZxuO19WlbQOJ/rNgZH4/Rg8oYT6l+TFhIzx3N4yr9VF+wLuA+FgXSdAMU9ulFpBWP2J8u4NijlLCR5ZdMKgk1vTLKX51oT01rFy5DXeMuoWo6HNoSGsJBS24fy/kUBida0WqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789472966; c=relaxed/relaxed;
	bh=eGcmjxpZCTXHRxx6IkfvznZnwzxo/1rjhgD1Rv2Z/Nc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GM9rJd2pDW8IAyah2yhRWQOFmz8bqLudvnkTfwSLAAj991ppi70pTA5pBnnxRwLWGXmTBAdO+AjVRFtjAai/CKKE/YKU0weM7CJfxf92+9QjKFkLnZNhkgV2oBU4WIOiJdCeIt4XspStwGrjcdimeoMH9arftD38i05IeK5hD17FyMlTVT/15wpifcCKgQjMExIpsJFIJRfn5qz8gLXq05S495x5cJvvG0l5yU69MedP5c70p/iGQ8FTfvPsY1Exsu7RtAFjhkoxEy9IXyawe0NvxMxifF9WsDEy+rSicAn/76ZCf8ECXeqSPN8Aw+kjwczEF4Zj/j8Qh9dP8T/8/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVgUMcUd; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVgUMcUd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgKd5wC4z2xSg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:49:25 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BFBA06025F;
	Tue, 15 Sep 2026 11:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3511F00893;
	Tue, 15 Sep 2026 11:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472963;
	bh=eGcmjxpZCTXHRxx6IkfvznZnwzxo/1rjhgD1Rv2Z/Nc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CVgUMcUdzZ3HeCX7d6oqPXdbOOpGnXFMxjmYOiUrDVNMDt6KSFLhwNsMaJoGe3qW3
	 gT6age4Ix8+ho3dxOuPdVPygCOYJmPGqaSEykNHcZv6dAOxJwunKYYu4Iy6A9HEIGW
	 hcxAvgkD63Nv91Yz6yOQLgb7Ly/W9NSezfZRhRwHurpZzKr7aOf2o+Cm4PxtjClXqh
	 MW7HRD1EbMfKOn51qnYtFwoyPkyekFswcsrTqcrSWt/vX+swYhoct8jk8UjXmMMElm
	 /5HuOJJSvXEi0+me6ynfkfTCY644nEmjpK012H06rZNZan+EQsBhkzseJGuSock+gz
	 vnG+SGZD+4dDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 08/50] hexagon: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Jann Horn" <jannh@google.com>, "Oleg
 Nesterov" <oleg@redhat.com>, linux-m68k@lists.linux-m68k.org, kexec@lists.infradead.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-csky@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, linux-hexagon@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-alpha@vger.kernel.org, linux-sh@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, bpf@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-arm-msm@vger.kernel.org, "Ingo Molnar" <mingo@redhat.com>, linux-gpio@vger.kernel.org, linux-um@lists.infradead.org, "Jan
 Kara" <jack@suse.cz>, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, io-uring@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-8-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-8-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:49:21 +0000
Message-Id: <20260915114921.AE3511F00893@smtp.kernel.org>
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

> Add TIF_FD_SLOTS and test it in do_trap0() once the system call has
> returned, before the ptrace exit stop gets to see the result.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D8


