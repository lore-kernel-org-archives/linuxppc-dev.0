Return-Path: <linuxppc-dev+bounces-27379-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FF4C88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:43:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhWS6Hzxz2ygp;
	Tue, 15 Sep 2026 22:43:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789472894;
	cv=none; b=UOc3ssi3Zm8kQ0epuOaXYDcWkvTB9zs8fxxqWP0bop2HfraHEQIZ3VMw92kx4f631UchXUgJNllWd8X1QLeoaMmPjJqFX/kjCvN2nE8aHWrMjfb4PG/jzurheuOLKIWyhLmXddoipOR8CITTuw2VgIWXgiX80JrKd//DYDgPv7m85YPxjpTOVsjAb+vkZg0Fd9uqGGdbUeCR16agfCeI6zbNNpnLarN4b6MQxkc/1MqOkjNmMvVikwb13uRSsD/aAWwnP6Qd0mB7MlGb5u/pY9FiAHCuEYG+zoD9Ew8o3bdle4TJvQCxSjXbB6bFLpg42yOgnsJMvs7CsX6EwY5ISQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789472894; c=relaxed/relaxed;
	bh=+hCyRfdYxaDHjUjrbC2f1l+hk2nsMICX165AMlBJOFw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xo4h0uhaUpFlXftHI5mSwMfZKrGwwx0RTqBTH4kMDAgWWcToucW4RRjTxDtAOhYohTo4yqvJrNzU3kmoBFlugAvmX46EPTsVcrdmkGb45Z7qTGDxLfdv0YP4f1LGITCemg21rPU0Rq9oyQktv7jLe63EDuiaEP6U7TsAkBgMY9NDP0B5Hl4uiyJA4/HcahelEHI0ggAsvR0Fzi2MycFm9p4gfkAlRrNKEE+E3TlJ13F5RFG36A5NMfYPEp2Qszny90/vqTPW4GQdMj80ZKN7RCOTLvVLzEUHD4A1J21FfyB2Pe8cPnDkjRHznIJjm1SHgyRrz7ShB0qzpzHqAFf2Cw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XT+DfR2f; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XT+DfR2f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgJG0qJdz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:48:14 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7623741342;
	Tue, 15 Sep 2026 11:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973821F000FF;
	Tue, 15 Sep 2026 11:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472892;
	bh=+hCyRfdYxaDHjUjrbC2f1l+hk2nsMICX165AMlBJOFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XT+DfR2fI9lSDVHTRxc8fxOJ84VdAucgEp1D7Rsg22J1SRRtMEiE19TvXZrbO4lIZ
	 TxJ/l2gehvn5l2kdO5dHi1/HiNiTrodHb341ROtDKEQB4TK5qE077C+sr6m2ZRGq1A
	 YhT5vOmSLIZn+aB2D2xVS3UmQD+O73OuHKWdb/9Q6SJtudR7Vr4EWHcVJIUSGq4wWb
	 EwguAAzu7/EG5DnE1SXHjXkeQUDSQ1mouWrUTfOdgFhzkd3ZU0wbFF/c3Yr6mjzm+T
	 iHVYaDYddqfXs43IVkcTAt+29bmm0zSxlyvXzfaYtnXgwc/VcrMwi/snt2mFoFeFgS
	 xEBfPHquaOhWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 06/50] arm64: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: "David Airlie" <airlied@redhat.com>, linux-parisc@vger.kernel.org, virtualization@lists.linux.dev, linux-mips@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, dri-devel@lists.freedesktop.org, "Jens Axboe" <axboe@kernel.dk>, linux-um@lists.infradead.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Eugenio
 Perez" <eperezma@redhat.com>, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org, linux-csky@vger.kernel.org, linux-sh@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-snps-arc@lists.infradead.org, kexec@lists.infradead.org, "Ingo
 Molnar" <mingo@redhat.com>, io-uring@vger.kernel.org, kvm@vger.kernel.org, linux-hexagon@vger.kernel.org, bpf@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org, linux-mm@kvack.org, linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-openrisc@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, "Jan Kara" <jack@suse.cz>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-6-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-6-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:48:10 +0000
Message-Id: <20260915114810.973821F000FF@smtp.kernel.org>
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

> Add TIF_FD_SLOTS to the syscall work bits. el0_svc_common() rereads
> the flags after the system call and takes the trace exit for any of
> them. So a task that reserved descriptors ends up in
> syscall_trace_exit() which commits them before audit and the ptrace exit
> stop.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D6


