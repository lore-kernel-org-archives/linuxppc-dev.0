Return-Path: <linuxppc-dev+bounces-27415-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0B4C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:58:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhsB51bvz2yqL;
	Tue, 15 Sep 2026 22:58:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789474502;
	cv=none; b=UCQnnR9bfsBlDRPWqpEc9ZjqmaKQWgxLb29w2oXGqB5GbgARQaPPXk0Dim7q12Pex0QaICAz/eKtMmDiEhtdp2v9H+KnfE/2xN4e6p1uYgwEs95sLgc8MPCppW0jiQZTEqpNUpFJs1CFDd+M6imU0iQAfq7bHHjnCgPEaT66BSoHE+iB+3RGkUlrWJwRfPtGhbp8Ge0jNMDbv6kVg4rzPd5OQEc3abjdfYYFC0Q4Hmx4bB+bCpG1LWX6324lVAGzYF6NCt1VC3ahEwT7MShG9QQBX9PC7Eb1Gngyibs4UP9ZOhNVo9rNa504U7sEhGq3FFvan8equVWmt90Cjc+Q7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789474502; c=relaxed/relaxed;
	bh=QRMZ7mmRdl98Hr0Jzx0dLUsIBC2R/cA4CuoG4//bR+w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xj4YsuPriUVQ5itMdeHCoJq0aD3r6jZWdHuZ9XFNWUa6Hgu6YxzCEbpTW98wkUPdEmCEguIYzayuWthUpv7d4FsLs52K8oQKWBSOgwAdE65N0Jy4jvqZcrn9+YGboBosyJ1+rsVG8ciADGwMFdDSq5gxKSPvpKnqdhVwVRabu046KXHK3Hxls30SvXUCy+X+bWd/JO81s0QLXj/CUW9BlvTI+MJ4ZXppWXUfCrIwVDvFLoJetQYdAl1tD+SzMC/AC4UDLk7d7cAQjX11hEDj9AkUjdTzRgd4QKEtnbQJLdXwLeOkTW2wOIdrFmpVMrGZqHOgdP+WOzJav5uZs2TEfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XPGWfVIh; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XPGWfVIh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgv96rHwz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:15:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D5277602C4;
	Tue, 15 Sep 2026 12:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD1B1F00893;
	Tue, 15 Sep 2026 12:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474499;
	bh=QRMZ7mmRdl98Hr0Jzx0dLUsIBC2R/cA4CuoG4//bR+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XPGWfVIhJ/wSL6Jd1KV8QYkaPXQevpxTo5YKyPKDIrxlw9MIHMHo5cZnoqRuYBPzW
	 YAB/BBxKyr04OnAz1fXuFsMiapL3vJK/RuyN3woNJu65a7GotPewX23h9YHqDCxQPk
	 2CWF6CYq7PbvZJuYpGBlpn9YbalxW+tFPh2E8PMbxAki0JSstQ2YNM5+QlpENVA4OR
	 4S8OeAn9BG92ITePDtvvACim8Vy9KB2TGUTfda+kW7PhqaNdVyqOBZvhFMBFu6IU+R
	 cXVP4LUVIrc7LmnOQ3vKo+sFLx/fVgoMs3/93rCsxZ1sqN6D06XnUMiUCyDHo1Jf2m
	 gcjyzu+b66/Nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 37/50] tpm: vtpm_proxy: install the server
 descriptor when the ioctl returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Peter
 Zijlstra" <peterz@infradead.org>, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux.dev, bpf@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, "Jens Axboe" <axboe@kernel.dk>, "Eugenio Perez" <eperezma@redhat.com>, kexec@lists.infradead.org, linux-openrisc@vger.kernel.org, linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "David Airlie" <airlied@redhat.com>, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-alpha@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-csky@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-mips@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-gpio@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-arm-msm@vger.kernel.org, linux-parisc@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-37-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-37-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:14:57 +0000
Message-Id: <20260915121457.BBD1B1F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D37


