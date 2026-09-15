Return-Path: <linuxppc-dev+bounces-27386-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AF5C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:43:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhXR4Cs2z30RT;
	Tue, 15 Sep 2026 22:43:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789473252;
	cv=none; b=VwpAwypl0wf3b/SqtWUSGU0xTiAspi8Yq/dp8Mw186ljJD5d6LHKKHThDGuz9TazXVwZ0OTZgAckhVF4rLLaUWMw/5WLehqMSDgjV27jrOfE8mlYkF4Wnmp0qyQxCE58jrb9qiopmpVAjRqC+YGNVyTytwrz2I37Oefq3dgpK+WldS6iSkMhjE7HNjx7TdPR5UD92uQinywMu9KkstC267SD8mqNKmhlzQZNum1sMiWI4kUoBCdF0G0SO/YQk++Ws1D0+vZ6JSCm9XXAjl8H7fHCA5Rg9J/aOSeeb0rUWE0LWkZv1+E4jmi/qf8gWE/MK0HFAfKkmn68vJKNMeljsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789473252; c=relaxed/relaxed;
	bh=AG30xjDiMKCtDyqoUWBdTqe2A6YC7BdfmCSY6YO8TME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MjMaa/S9JEJ0Aj5xe0tGOaWhS3f0Rzj7caqAz04m45PXuZwBpq9UNYl7YYEM3Vc69P6wUpMQ4yunOa5X/q5q+zC2+evKm4gmB3uKKIUu5ME3oZpQ4d+kb+MmTgf8YMjTRTRkBfDHRyBp3X4ZQ3Ddzf6kRDv0u5qkAhv9Xi51vX+B+Uk35D7g2n4DsQOCC/6OyPk5BCmQg3S9G9xF5NqWepwQyX+wyE2pUipMtKhWJ8y+Qmxq7AYhaFyOoefCJlIS18nRxAdK9+TvQ7lbKliec728hMaQHcOalxjYEuhayhPoBeRycdZZzQyuJDal61FewtFrCiOdxBo7D7Y4BPPmpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxGdVbxm; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxGdVbxm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgR74ldZz2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:54:11 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E345643BD2;
	Tue, 15 Sep 2026 11:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0B31F00893;
	Tue, 15 Sep 2026 11:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473246;
	bh=AG30xjDiMKCtDyqoUWBdTqe2A6YC7BdfmCSY6YO8TME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jxGdVbxmN8Kp7YM+vv1k+Lwtl83KHaJbgpKLbkY5B9ndglNTkZCcuaHvygk/C/p23
	 gtc5IvLgRXflsaT/JbeYSUg8MT7dnkGaEESjkiYYG1vk2eMg5A4bJo85Hl9wv/nzeS
	 eGLkK/gZnGZt5sYUblxipqPSDfZOU6WkQWeqEOXj7sSr5LV4NAo/AueirSWL/XnsKl
	 hRst8P2ASZag12PNEDM5uHg4yR4m5hctoI8grNV4iMcvJNyl1ZXEvQ3SkS6D43rgW5
	 SD5U4o/63gzEV7FOsh2ZQJJdmW/ba916cBMFpTju6k1xEUWXrbdXF1KZviyBg5srWx
	 +dlhemDHcpIKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 12/50] nios2: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-um@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, virtualization@lists.linux.dev, "Jens
 Axboe" <axboe@kernel.dk>, linux-hyperv@vger.kernel.org, io-uring@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-arm-kernel@lists.infradead.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-csky@vger.kernel.org, sparclinux@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-gpio@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org, "David
 Airlie" <airlied@redhat.com>, dri-devel@lists.freedesktop.org, "Eugenio
 Perez" <eperezma@redhat.com>, bpf@vger.kernel.org, linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "Peter Zijlstra" <peterz@infradead.org>, kexec@lists.infradead.org, "Jann
 Horn" <jannh@google.com>, linux-openrisc@vger.kernel.org, "Oleg Nesterov" <oleg@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-12-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-12-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:54:04 +0000
Message-Id: <20260915115405.0F0B31F00893@smtp.kernel.org>
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

> Add TIF_FD_SLOTS and test it once the untraced system call has had
> its return code translated into the r2 and r7 pair userspace sees.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D12


