Return-Path: <linuxppc-dev+bounces-27418-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFEEC88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:58:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhsb2w2dz30TL;
	Tue, 15 Sep 2026 22:58:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789474579;
	cv=none; b=gxKNTMofOTGkI6VL7WYFi/JUn4t+r50pQpKZP/hU+kfVfBVDXcznmxsF4Qc5I9Ms4pwVp4Ag9j7CvlXKbu5wCePuC2Ehoy/NbgUTNBGrLrvclidjz2syRF3VsYuTQJoPVJ7YJ0+TfWY9h6vNCYpz3KvsOZuVlacGLLgXFUS+RZAB5FqzMA6wYgBygX8obdPf2APrHNgB/GcK+0a0NeQJY+TVzT32sTVIRMp65HqnSfDgJ1NKDa2ZedVs8XrD/tD78CIrvlALB+maFXRFY5iepjHAVNoTCUtru+T3yJCmBRX3xrNQ3++a+gYn/pyba6qm1jWQh+4TOyegDrJt3l9Rbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789474579; c=relaxed/relaxed;
	bh=NXoYVTwqvD2Mc3uJ8C8rBTgBxVVEvgW7tv7MPPRhfTM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FAeCOcD9Bz32b0Qh8e8YzZx/y756zUjVHhobHAtRz5XJ/CWKhYOnbGs/v9Cer98yO+YNdoHfJnJ3l/h99mYccrMudZbCCz4cKF9tUPgcH7u/64D74007LopRfravpbS2z/aQV+vYu5jA6fbuau+MJmuCqAA17vPq4mjr4F51Bjhczn1b4/tcW0smEjSstYMNkwwikGjMGfg6qWrK0MIB9Vu7Og72R72js8aiDmgJLN6iKIbybsmFZ/+STX1yW4zpkNd4rX1dZ0aTbLPTZGsb+DVWPyBvNfQimzMk5ujt5sLESGrc4UwHhV6w7qqvzpvlQuoAmbxzlWzK5Va7F9J0Bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CNterPT/; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CNterPT/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgwf4tNMz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:16:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C1B07602A8;
	Tue, 15 Sep 2026 12:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99711F00893;
	Tue, 15 Sep 2026 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474576;
	bh=NXoYVTwqvD2Mc3uJ8C8rBTgBxVVEvgW7tv7MPPRhfTM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CNterPT/ZD51jedu2KNQ9rOU/4D4o9j+Aviy118d7ID4ZpJ7DN5B0QTVxpbOLDEcp
	 WjkOW+IygybTEM7hIhEUp9B9F8q2tKZJbdjojW7c1kYBcsALaPVXdNvNpseaoF6sxz
	 d08hoYd15gcHpNwA06y/3FcZ6xOwqFvsocjr/EGRM5cC9tuus0kDJdaqEQg3Qm4M18
	 ZeSXiq47TwxgervFWeMWsQkRc5DykbFskWfeoeMxtxMfVCAG1jD+nF5Voy10SVLA4z
	 9vITY1nHgUqKUhmEPiCFbTS/22e9+k7WoslJgfuFNfW4pirOY8jtykHYXqI9jsapd+
	 +JW1ZdYPtifnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 41/50] KVM: guest_memfd: stop putting the
 descriptor back on failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "Jens Axboe" <axboe@kernel.dk>, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Jann
 Horn" <jannh@google.com>, linux-sh@vger.kernel.org, "David Airlie" <airlied@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, bpf@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-hexagon@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, "Ingo Molnar" <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org, linux-mm@kvack.org, virtualization@lists.linux.dev, kexec@lists.infradead.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-hyperv@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-openrisc@vger.kernel.org, io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-41-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-41-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:16:14 +0000
Message-Id: <20260915121614.A99711F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D41


