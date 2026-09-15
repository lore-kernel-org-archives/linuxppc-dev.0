Return-Path: <linuxppc-dev+bounces-27380-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84964C88E7B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:43:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhWb3vWXz2yqq;
	Tue, 15 Sep 2026 22:43:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789472907;
	cv=none; b=lcoxmt3K3Z38kXAHMbCwwGbGhrR+5mqLCWL8XlJ2jWPk028lvSH7+sVIEEIl29+CHCump0CdfmWHKwe2djeK4nA5O6LHuHAwcR4OQwCsabLhIBBgr8/fxaw6erzwriLdNft9VqJnPJIk40cMjVoMBHFqOosLKf3f3ToTorJs0E8kTHotT6IXpA5d0jhLWLRxYAj/D2zQ0l7rW9MEvk1ZvAMKlFbYCHwL4gYHiGLcN4cnTdprgcwyzi3lLXPW2Vp32R0sbnepeqrFbg0psMDM0E0cS5Wb9kF3Ykvo+OHl9VNAFYZ+fdUjFp2mQbtKHWyKxKDCiLLym3bD/ClnQlHzDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789472907; c=relaxed/relaxed;
	bh=snQOL0WONF4IRsaF3EIs3wlmLSFM44jqM+liurayMLQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rygm1qILpjBvhJYEszbTVxFdefPjw+vE35GXnn5hnH7gyONMfpP0T6DtuUo4XpyIX5m4uSWBltRyZCJnEk2204I85JDHvm5qpuDhxQUM8e3soxSbup1DcXZVGSvDZJgdAJrEH5318lpXVT7gwtoOME0516pdV0EE5g0geZBsyJV/MSeUdMfRVVBLomTCjAlzAPfq39F9LIqhKwHQkp6Bcg19csbBWgajlFV8Ov94fKjrx0PUEWIHy3x3fGgY6gwrBPsXxDVeeNVytgk8UNCwXB0hSXC3QfMQ4614lKVNoCEMdD0ndHtnvepRyAhZcGznWhpXJIXLTVU/oGnyPIcRTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=or6y3CyS; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=or6y3CyS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgJV67lfz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:48:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EF34F6025F;
	Tue, 15 Sep 2026 11:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB181F000FF;
	Tue, 15 Sep 2026 11:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472904;
	bh=snQOL0WONF4IRsaF3EIs3wlmLSFM44jqM+liurayMLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=or6y3CySlL1bdxzm9++3Y5GlWLcEPN0LrDGjXv4IhxYT8SwPi7kInte+CrlQcFfkp
	 1XQmoKBf113PXHQChs2avy8UGIIquFVuSvMCoCSNMtA9/3wH0G1HosQnaeUEIWka2B
	 wWhLR1WkDA4HzYixhD6H1F5tbulUxFG0FnA5+hj8l5IA14GNeQQ0O/Dk84ZVAgSj+v
	 HbNF4/Hpt5pQyZeE6+47+X/P7J02CVGZbdLDaKVKYgjpAgC0Jr6q5hx+PjdmH8SQ8K
	 ZwTjgJT8b9Hr2cJYcHzxNGopiariE1M/El0VM6I8g6qSqO3peUD5vDy8v1Fyu9cVcC
	 cthdt2i/NUkkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 04/50] ARC: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-hexagon@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-msm@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Jann Horn" <jannh@google.com>, "Oleg
 Nesterov" <oleg@redhat.com>, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-sh@vger.kernel.org, virtualization@lists.linux.dev, "Peter
 Zijlstra" <peterz@infradead.org>, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-openrisc@vger.kernel.org, kvm@vger.kernel.org, linux-csky@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-gpio@vger.kernel.org, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-um@lists.infradead.org, "Jan
 Kara" <jack@suse.cz>, linux-alpha@vger.kernel.org, "Eugenio Perez" <eperezma@redhat.com>,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, dri-devel@lists.freedesktop.org, "David
 Airlie" <airlied@redhat.com>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, io-uring@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Ingo Molnar" <mingo@redhat.com>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-4-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-4-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:48:22 +0000
Message-Id: <20260915114822.DCB181F000FF@smtp.kernel.org>
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

> Add TIF_FD_SLOTS and test it on the untraced return from a system
> call. A task that reserved descriptors takes the tracesys_exit path,
> where syscall_trace_exit() commits them before the ptrace exit stop.
> The traced path already ends up there.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D4


