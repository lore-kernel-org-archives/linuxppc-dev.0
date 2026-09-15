Return-Path: <linuxppc-dev+bounces-27419-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950A2C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:58:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhsm5cfFz2yqw;
	Tue, 15 Sep 2026 22:58:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789474696;
	cv=none; b=OSNH+FMJxMZeoN+y/Ip81eVEukCyUXVCmOdPBdVV4cs47MqSqh2pveLJcE03NSeZKJqFrrpayjt5Ixr2bJqf1vDclSCFWRSdtMOFboQZA5Cjf4WA3KqJ9sfoeHLo54EN7jlEFN+Y6t8VAhnfZUbXahGVlvaWnDHskK0R/hdqaij4vBJyv7efSdEQgGMXy01siaMBjvkrZmNVrpor5IO1GZ4DuUMVlMQzzhM97I/TQKviEGgrUJx785WJ2tsGk+qKGXy89+GIgiatq1DPD1CoN6mEB368ynCzRX7m87MCqDDPEM9eU78NbkmH3CI8rYq+ofkliaRFAhG5xLfHfT+KVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789474696; c=relaxed/relaxed;
	bh=DwzX8JNIUuVMxDXzFkUeKbOg0dKKxVjarPGggP7ls3E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bM/jBlrbTLSykf0VuQEYNCXMJwiw+9k0crNmEq2vjhru+of+IzJT5OF2W/MpZISbuDTo2CXv4atSjfMCslW6vsBd0KzjPt6mdiF8zxDrUwn+/bP0EVG0r/ihHs4iMWSbjkbxqC2EHloP4eMAiHiq9ssn4R6XXJSvEQOHfUbhVKKEUmLA55rAucRUuCn8zXFaomj9ohZKCoJa7IZSunkMkdQLDi9EuWiM0WFvglBwRQvd6H4vRiDHWKYgqohNvVd/RQqbXQjKy8zNKy7Au6Uo3PJGMWBnCj1sqAgR3UAM3FYSh8KZJgRE3Y55wK41V0r6F5N9Tvzo2pkkZO2o3MrJSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+YTN+mc; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+YTN+mc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgyt09JQz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:18:13 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D8E1F43247;
	Tue, 15 Sep 2026 12:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00241F00898;
	Tue, 15 Sep 2026 12:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474664;
	bh=DwzX8JNIUuVMxDXzFkUeKbOg0dKKxVjarPGggP7ls3E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T+YTN+mc0FREo7pxVue32qEB7jpbaic9tPuOqusrLGz+h61wQ9mk1jbsp4T4uum+o
	 PyFcrywxhBL6lkrZRNcnpslokzefZeAzR3ILqmBsMGWMqYv8jIXs9vvVcxYbK2/0GC
	 eaxftvggM2rbYvLpD33hv5D2hCTVmB4HxTZAux7lFOj7n37ELzTfsQdzy7w4+7zax2
	 OOhtkPuMszdn+0PFv34fTrYHBBJ5CYYMe8NNjn6CDmjHaFQhZDHc4EM+U9KZ+/UGbq
	 UKCjWQKVffzLeaWI/mu8BEh57NXEGpdr4xo0iEchfSB7vEOpEOZ5gcwVOziN4Vzm0b
	 J0urwnVYa8Mjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 42/50] drm: stop unwinding descriptors by hand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: sparclinux@vger.kernel.org, linux-openrisc@vger.kernel.org, "Ingo Molnar" <mingo@redhat.com>, linux-csky@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-hexagon@vger.kernel.org, linux-arm-msm@vger.kernel.org, bpf@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-mips@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-alpha@vger.kernel.org, kexec@lists.infradead.org, kvm@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-sh@vger.kernel.org, linux-um@lists.infradead.org, "Jann
 Horn" <jannh@google.com>, linux-m68k@lists.linux-m68k.org, "Alexander Viro" <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, "David
 Airlie" <airlied@redhat.com>, linux-hyperv@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, io-uring@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, "Oleg
 Nesterov" <oleg@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, linux-parisc@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-42-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-42-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:17:42 +0000
Message-Id: <20260915121742.F00241F00898@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D42


