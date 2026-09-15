Return-Path: <linuxppc-dev+bounces-27414-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F240BC88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:58:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhs40BMRz3bQm;
	Tue, 15 Sep 2026 22:58:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789474500;
	cv=none; b=GWJrITQnXkwkfCasyLyYl//0zAf1d3aoiNiyInHnRBF+Di3UFqw+S1mamwFadxXBF42dtFS3bBQHtp5W0dBYBdnHjtEQhSLq4go7Wza4NE+XIMniZYj8YVe9/h7NaZKA8qwSkWf2Eo88/S7D4ffaVQO5NSldSLzzb8QIuk8Z/RB0ql1myvlpZvEoPk+5kCXtTOv/X23pjUn6Ow3ZlrU7f35TDjwVwu995H9LT4W7oAXYEg8SfrPIwAkmlPQElKDJEnRhcRLsO/Jtqlbh7l1x5sscu9o6cDv46FpeAA6IIo8sQakZXqsQTWg7gOHHf3K9SiUiKkQa4LUBHMGl6cY6Og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789474500; c=relaxed/relaxed;
	bh=ejtHf7OrVCONiSGbsU0Szkqhw/V3NKRKJBvDExa4qrI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jAVffaRlojJ15cKFUFZFXegDhtCmiAKk5Ul3w42QuQw3JX6/vK1uQzc8RCVJXoDLPLD0kgY1V1e0Hy1PS+gHcc3AmGB4Zkr3HqeX3rkP6mShRuS8ij+CDd9AkvmkXIqIa++t9qFusknMsvnpw8QMUlo2daWU6ZnJWXjWk8Pek74F32hcmJlaG/zvKaqbAjO6+uYWsprHuMzy7QZaTCtB9fGzZnRlUH1L7eM5NSbM9sVbxGxzaMqFn2eWF/hmXu5vX+NaHk49FHf3Iv+0lQ7YNUw/Y3UNFsguiDq/OLWzxWhKe8DvhKXPFE0b3WGaNWsDEWxWRMxxaJ/RxXe4QShseA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQ3aDU0Q; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQ3aDU0Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgv74JHtz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:14:59 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 57C3740450;
	Tue, 15 Sep 2026 12:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398E91F000FF;
	Tue, 15 Sep 2026 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474497;
	bh=ejtHf7OrVCONiSGbsU0Szkqhw/V3NKRKJBvDExa4qrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SQ3aDU0Q8GsPtoMGWFzUtgXPVhQk5j3tT2hP5/IYPK7pNnGp/W35LdJkurCxq/UDj
	 jXECYSMyRfHDZKzN98Ln98DAG1rH6aAR4ISmzyGlU1rsDvw5Q93DNzrkBW2qSN7IRC
	 YJr9cCfLCK65yz/lnkKU0h/88SazD0WGxzlXFRwUnZmmA1pIC11CPHPte6Jw/NVEZ8
	 jp0yJWYB7+6Cgap52rqfdYHOC0u+j0XckjkUTQa+uZ9aKsrGomUpcl6BdIHpYiyzm/
	 Rqj2wKLDgmWRUAKCkxgoX9x9LTH43+wakiVHy5v4VFxVPQvMYbRVfHWWmjs+K15B5a
	 6EBFBzK+SsdcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 34/50] sctp: install the peeloff descriptor when
 the syscall returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: "Peter Zijlstra" <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, "Eugenio
 Perez" <eperezma@redhat.com>, io-uring@vger.kernel.org, linux-mm@kvack.org, linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org, linux-parisc@vger.kernel.org, virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, kexec@lists.infradead.org, linux-arm-msm@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, "Jann Horn" <jannh@google.com>, dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-sh@vger.kernel.org, linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org, linux-openrisc@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, "Jens Axboe" <axboe@kernel.dk>, "Michael S.
 Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-m68k@lists.linux-m68k.org, "David
 Airlie" <airlied@redhat.com>, sparclinux@vger.kernel.org, linux-gpio@vger.kernel.org, linux-csky@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-34-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-34-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:14:54 +0000
Message-Id: <20260915121455.398E91F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D34


