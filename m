Return-Path: <linuxppc-dev+bounces-27395-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40168C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:45:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhZ46X4hz30Vr;
	Tue, 15 Sep 2026 22:45:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789473718;
	cv=none; b=UASoQnkXKLQFcujdUAhFQffnrs5KM/KTO9XauAkluk/cgJiIjX8OYhSt2+eUYxMPgpnB/SEVzdFP7lg68kgczO3twREqTsRrnFMs0r3sE3OdD6mote4/he+/TGf72gj8Ye1VW9tr9fccwHUe/3aSHzCzyc++9ta/QSrqIhJ5wfyvy5ytMRcquAW8yH7amjIRv/RQ8q+SmezMp8AokssLGes67il/LN9/mvx3P4ccpst3mSlj3MrJrftZ4f5mSjvMgbm0gqDFbVSV/f6cuIAEayx5QBghCCxxXpld8mzx17LHJL9/NXDjQqQjGaoxlF77j38AW5XwJ3j2wBepxPFgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789473718; c=relaxed/relaxed;
	bh=yaVzdP8lM5NkwsIfqLJMk1LB9QIq/dT8qJrlL2t7nR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YcXTIlImbTVNEZaHzaBS2Fhc8hiftRxMJu9wWjXnqCS/qO/JzM5vzk1C2ZW+XJN3Xjnomjxgb4PzEDqlLaNb/FdWGHIJWrL+ca8gKqtkKoAB7EK6o25A9NiHZZAA/Eg60NVADecDIzbJDXlN4wkfvTq1mJXzM9kxXRUYCn0wQw/jzkErboAgSEx49fuj4PAkcLAKASR3EfbcAevBJLHTLfUikz/R1IXO9qNTSk8KRTti6kgXKbb7AQgz6ZiyB12gypofkzb2/+bAIZas/WitPCwHtyyblouuLhrTU4fyNJ2VjzHdwAkrYJ05kARyxI7ISVqU22Elg4Z5sjRtxe9Kmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l52++faI; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l52++faI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgc50yhZz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:01:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B04684040D;
	Tue, 15 Sep 2026 12:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79231F000FF;
	Tue, 15 Sep 2026 12:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473714;
	bh=yaVzdP8lM5NkwsIfqLJMk1LB9QIq/dT8qJrlL2t7nR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l52++faImdy1ik2llOoUzxFM8W+OJ2XgjjuOa2l8s+lX7brqaeHpAYmZ4NzMpai4G
	 ug3NGNC5p0QWw1N5SrcuH1JNzc0OyB6fZWD/NF1d6szX9grpxtdkUDi4tpXooy6x+p
	 JBH3hHZryEmAGb6mrRF6PVK9CJEilmARd5Me/4O9iSahRnJEixJ4iyWa0Fy2QMNHa/
	 679PRfPUgFWQNItfWZewH2Q2HBpXsprj9rAD8pmB/m3WtcE/OlAB27TA7JatQQXEIi
	 yV560hB9vQUixGJJc7XE9I7TKlEm3Q7gGxUx/GBKXr8HLMxp8z5pfujIabo5IiT+sh
	 wkx7+O51PlMkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 24/50] file: make FD_ADD() a standalone
 immediate install
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-arm-msm@vger.kernel.org, linux-um@lists.infradead.org, "Jens
 Axboe" <axboe@kernel.dk>, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxl?=
 =?utf-8?b?KQ==?= <brauner@kernel.org>, dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, sparclinux@vger.kernel.org, "Jann Horn" <jannh@google.com>, "Jan
 Kara" <jack@suse.cz>, "Ingo Molnar" <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-hyperv@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-csky@vger.kernel.org, io-uring@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, "David Airlie" <airlied@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Oleg Nesterov" <oleg@redhat.com>, linux-openrisc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-alpha@vger.kernel.org, linux-sh@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, virtualization@lists.linux.dev, kexec@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-24-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-24-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:01:52 +0000
Message-Id: <20260915120152.C79231F000FF@smtp.kernel.org>
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

> FD_ADD() was built on FD_PREPARE() + fd_publish(). Give it its own small
> macro that allocates the descriptor so it stays an immediate one-shot
> for the hot descriptor-is-the-result paths (open, socket, accept, memfd
> etc.).
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D24


