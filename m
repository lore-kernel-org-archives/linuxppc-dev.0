Return-Path: <linuxppc-dev+bounces-27396-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815F3C88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:54:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhmg1Nl2z2yFW;
	Tue, 15 Sep 2026 22:54:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789473744;
	cv=none; b=XWtCPUVR1TJh7jY4jQ4D/QgDKc+yEvUoFAYM3YYcLY+vMdhBx1nDRNHQTQGOr3cRZaHp6SiSzp/eulmN0PQ8Z6DraYUEQvEhkeQVU5ydBUrxHLdDApaqBiC+NViraxyw48hre97yQhbqEQh39yuHA4My0leDNmUmjbHYJdlQ/hG3duf/NozunWfnLmuPnZ/JlUZ1JZoH/EJBDdaJTcLK/HNbxJOdh1IaxUAOTz70dpeZ+LFEF4OCjLCrM1PgLEtzIXr2tYzMgJQ4hLrLSuyfFekJ/uDaFrNXWMPmHm8DV3B1anvY7X5ODh0iP5byJ3tDCOYn9WnmZFsY3S4/igueXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789473744; c=relaxed/relaxed;
	bh=qcYOVYEeSBwNAHSV3oGOxIoOYP16KGnVjnu+hbqVsEY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oZeQvGTse3ooH34m5cR4CS4FvM8bXTM/u5Yr0jwS276F7A28INwFolnxHKIEPD6+myuo1C5Oxmuj9A2oOLBlUFAAU9VuWJqk67AQuLz92akaOjfp46l1461reP42p9djl72Uy+/mYJ8npqiUhvGkDY99are7SVZie7Ep5olVna3/3MAGtnkiDJHN0X1FjxeTnP/lVhaxxADYA/odWaUrnLW6UQ1eMqrTkEqDhETiGcnYlqbRzcLIV/z2OeADPnYgREUuiQGQ3kcyfmDP2EodimZFO5gyqFNTn3qZYLjiW/ah6be55g8zsolBD2rX77BjwpSKdpOdvCuVXyfPyAWlLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f/BEG6N0; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f/BEG6N0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgcb482gz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:02:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 196F94141B;
	Tue, 15 Sep 2026 12:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2CE1F000FF;
	Tue, 15 Sep 2026 12:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473742;
	bh=qcYOVYEeSBwNAHSV3oGOxIoOYP16KGnVjnu+hbqVsEY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f/BEG6N0RGxUq5W/HXCadDNiWy6mZwl9CV9CowG89trZuBhbvX/vWsAwHcKt0jPgW
	 SJ2ml9rORw02KpW+BBtA/RAwgHeaOMkDEM/bw2FOM3cvOGpK4o5aTZomhO8RUcQ5S/
	 HUGzy85d+v2Rl885i1mtVPRNCYfGq7VMLkzir6Qo74z8OfaWUxRKM2kqLaxvoO35hD
	 g2OjURXxrNOf5LxE5EULxkvtM4dwb4/ru0HDhvJo0tuYkl76FUzGi2h5pCD/fdlSaR
	 IpwMuTLI+Jg1YfgtVCyH+xGpSt50Q2kgFNlZVyEcwXh9ZMIlgJii4H6dAqtEZuqtWP
	 6++8DIfAg5DTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 20/50] file: warn when the descriptor table is
 unshared with slots
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-csky@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, dri-devel@lists.freedesktop.org, "Jan Kara" <jack@suse.cz>, "Jens
 Axboe" <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>, "Jann Horn" <jannh@google.com>, kexec@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-hexagon@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, virtualization@lists.linux.dev, linux-snps-arc@lists.infradead.org, sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, io-uring@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-parisc@vger.kernel.org, kvm@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, linux-openrisc@vger.kernel.org, linux-um@lists.infradead.org, "David
 Airlie" <airlied@redhat.com>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-20-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-20-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:02:19 +0000
Message-Id: <20260915120220.2B2CE1F000FF@smtp.kernel.org>
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

> If the fdtable is unshared or the task exits we can't install
> reservations. The reserved fd isn't reserved anymore. execve() would
> leak the reservation into the child.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D20


