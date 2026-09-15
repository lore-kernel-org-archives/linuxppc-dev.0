Return-Path: <linuxppc-dev+bounces-27410-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89A5C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:57:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhrL3dVpz30fh;
	Tue, 15 Sep 2026 22:57:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789474394;
	cv=none; b=HK587BuLOvdoDwwixacTdmdPHs7tl05wf1xUDq/pnepUaOFpZ6KgucdXWQrMVuhaiAsg3q2RoiTn1Vryjf8qHTyD3Z4ATzsdkWPvEOC3nceXCGFSG+7TFVkZlw0PePapcMFaWEHLtoLSCdbHIkZgOKoIKZM2Jqx6RExdXDMIQXgZYo3lAlpb/2dxOKS03izJopM5DVterthk8q+dlJZj8w7U4h+5ldkJ/eBW0XXdj4bRZDbollxVCITnfOy5NJCpB+KMGOFUyT4zTAl0AdGYaIZfDyO2QavKN5MvIKDE1nO45HxVSK7h28F8aXqTruz5edlpn1S1Wdl9hNMZjAjfdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789474394; c=relaxed/relaxed;
	bh=rcP1Zt+r+c8i7P9HMLnfG+KSwnTlxlPDfufoMKFt0yM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T2DgcLhSeqXgskAOGGfjq2UUnaK2X1R3IWtB/AfGEK4fvcr9HKSbs4o7TztpVdshTorrI19m9O9WNgsGK+jakUdYBb6MNkRx4uqQvt7aMurnjEhsjfEPI67rBfJ5LeSPJ0NUtkpY1Rk2iwVmM8Ix4jX/PT+7BdvPQiuorq6E4yHf9k37tbaM+IBBfLIJ1C0HQOeDAxwlxrShGqdWCmNpHH2rOWWSmx1AwLivkHY+cEcPadoRAjFj7nh6dILnbsHrsaj4mEyLapcLRaw7C+fQwp4emV9DJk7ZcUUYZ3zxA75F8fxEcU2dT2Xe9QVXOMIUv5ViwKMTvgx5Q9e1SP7s+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mxoLtCbZ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mxoLtCbZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgs54rbyz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:13:13 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 86C3F60261;
	Tue, 15 Sep 2026 12:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCF61F000FF;
	Tue, 15 Sep 2026 12:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474391;
	bh=rcP1Zt+r+c8i7P9HMLnfG+KSwnTlxlPDfufoMKFt0yM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mxoLtCbZ5g8NJT38V2nXx3kQMXq8zz7wa261boot03y/1mmOb8uEpnb4HgvVzXqbE
	 Lc+BLr2MEwB+7zjlCcD9Q9qeYqKVACCOsKFW9yMVpHmTXMqtHVkiNOOQlElz6DH2cL
	 qfBphOZ3delbUDrFqm1dV52+sHB7JppWyVGvQVAhcP+Vcr7mTyrRaVGoKVuRlWxgrA
	 a0ZQjTcB9Fxaqpd6c2a/Z1vb/mAmnfz0/bCd8zDO3h3sznLEIo6QHFgrENGMHDk9qf
	 flDXJ4YX6mmlM4kAG/dg8PRmGwgcbH40eS5i4n9wiRd9k9l8mEd5AlXPVBescbcVDo
	 rqQ5leD9k9+dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 36/50] nitro_enclaves: install the enclave
 descriptor when the ioctl returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-hexagon@vger.kernel.org, io-uring@vger.kernel.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Oleg
 Nesterov" <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, linux-openrisc@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, "Jann Horn" <jannh@google.com>, linux-gpio@vger.kernel.org, sparclinux@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "Eugenio Perez" <eperezma@redhat.com>, linux-alpha@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-sh@vger.kernel.org, linux-parisc@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-um@lists.infradead.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-snps-arc@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-36-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-36-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:13:09 +0000
Message-Id: <20260915121309.7CCF61F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D36


