Return-Path: <linuxppc-dev+bounces-27376-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4119C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:42:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhVz5db0z2yFW;
	Tue, 15 Sep 2026 22:42:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789472760;
	cv=none; b=S1ITwUR1+fcSPPxGeo+dGQ8XS3OzUL1O/6bzLm7QLnITAUZ367Zcsd/nPmsm0teJKlxTdx50sxiqIxkh8DPGh7kEuKhEYky92FemKJgBsSoWWDu7mlSOZL1D3l9fiTAtVuSZHg1RXhFxkX08FdXCX1A863vgRoE9Iw5vqdWecppbyjLzgvxDgMvk+CuoSbjXWLM0EhKNHb9hNMCB7XpmF3hUqKqxvhQcPELt1TO2e+WSXQjt5ZZknd0UROkkopzhiafZOZXNFYnLouaVRB8zTbsDrxcpYhkxWsqn3hsIdAxvPd5KDvzJJB30UcUW1AX/jXfbXe+d/eDkI6YkInjqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789472760; c=relaxed/relaxed;
	bh=84qdWoL1LKc5gtdlqTMvnJT+oufAgjOVJobzRLdUed0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QdvYd5KsEdmIzQIlW4saBj7DkNhty28F/sh12dQA2uxWf6onex9MB/GOBdQRrEwyMmdHASxXugFOMh15t0pYIuBPXwuBBAC476dQda/NgE3VArmfkQy1kHmjnWIPf3tFo+ehIc7s+on02h+aIsaFtz9lKIpZPTFHOgB4CV0UZ3lA9h8u8SwC0nZxG5Dx8FIovl7L5AXugwe5Oxji2DC4WxIWb7D0Mj+yBV2m9M378io7DZ5WEtMTNXXqiaVjzx1Riu7rSN1PuOznQLwXVHYAqZ8NV5SMpiYJJR4UZ3oQvUrRGSP8NDhO4nP+UDmlIv8DjIQJttfl5bDLoPNF2GKnpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OvyMOoJ/; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OvyMOoJ/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgFg2TgDz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:45:59 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 13D1743ADB;
	Tue, 15 Sep 2026 11:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6688D1F00893;
	Tue, 15 Sep 2026 11:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472756;
	bh=84qdWoL1LKc5gtdlqTMvnJT+oufAgjOVJobzRLdUed0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OvyMOoJ/eHXXAGCUuAHV9UPjednx+3v2kDsPpsRiMt2vJNRigBckYplzs+k1CunG2
	 VWZZat6CVLgoaSJTbzAssnUcFLqBHnWcBIQrLSfCF6yx/37jt+iOEtPkQuPGH8kPjd
	 AcdsSWp6kCGfJlkts3qZap21GHGOxCB9xpK4lKpyaxS4E3Gaqn2VwY0tbDq0dM8cvD
	 +S2ZTPvYUXYUWl8wkJIZFxNOYN02VLCEE6CbGr+QmxOcs6ih+Z8gfikh487gD4do1z
	 HtstDA3lVNKx0gLEevE1N9RvYOxqvCFfMI9vHNdE7EnXbFWmMIRc5NCWTLObCYGVL0
	 9PhkPHo1Z/4SA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 11/50] MIPS: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: io-uring@vger.kernel.org, linux-gpio@vger.kernel.org, "Jens Axboe" <axboe@kernel.dk>, linuxppc-dev@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, linux-snps-arc@lists.infradead.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-csky@vger.kernel.org, "Jan Kara" <jack@suse.cz>, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, "Ingo
 Molnar" <mingo@redhat.com>, virtualization@lists.linux.dev, "Peter Zijlstra" <peterz@infradead.org>, linux-mips@vger.kernel.org, linux-hyperv@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org, linux-parisc@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-mm@kvack.org, "Jann Horn" <jannh@google.com>, linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org, "Oleg
 Nesterov" <oleg@redhat.com>, kvm@vger.kernel.org, =?utf-8?b?Q2hyaXN0aWFu?=
 =?utf-8?b?IEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-11-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-11-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:45:52 +0000
Message-Id: <20260915114553.6688D1F00893@smtp.kernel.org>
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

> Add TIF_FD_SLOTS to the syscall exit work. The return path rereads
> the flags after the system call and calls syscall_trace_leave() for
> any of the exit work bits which commits the reservations before audit
> and the ptrace exit stop.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D11


