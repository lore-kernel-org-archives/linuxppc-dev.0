Return-Path: <linuxppc-dev+bounces-27406-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E3EC88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:56:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhq85KbXz30Vb;
	Tue, 15 Sep 2026 22:56:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789474193;
	cv=none; b=Pvg1NkdHaolBpi7uKeXVCd5BdAe/8z4q9BnebUmkzR8OnC7CXtNifMOIy2bMilksv61Al2DuitB6fmLfgdEmBiXowHL1GQeAbaiw0f+US9UF9Iry8HTLOttKnWHAzPKif4FrklH9pnBF5HXnHj1B6i/aYbvovdQ08MpYaZAp61x+SVeBxSsYFNDYWRlWNpK33T0oY2NFKgvbksQ9oKiYX1hhMtzLc2DKzhq+5vIY2ntMDhcQhX36TVMVst3sc8o29NOVPm14VAocFWMCifaLB33HUAhi/Z6/+K7FB2buer++xY8O+mYacFH+jm3SZWSi7DXPJueYsZ59PhiLStu+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789474193; c=relaxed/relaxed;
	bh=zv1rNZvSCHkzISCnzIgvhR1XdclekSPPoj8rLv8Qezg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ABPt9oz7syvB8GKIVpJOdZEJzbXAOxq421fzIRFJTV/LNXnJqBi2A1FYnr4g7MzfrF/KnVaavzokAN89d2CcpVK0dee+1viLpc+ccYThf3IBUJm6RWIMJ4Xe1sgjYtmv3PnQTb+OLCiO7vmQtrV+vyShMMsyqcnQLGwTkeOoNGGePeD5qzBFUfmVfvCEuQhxF1Gr6Ka6O0CCCQ41put/U+/7jZ8/0HY0nUMMWpHHKivRKZ650G7vhJid0gWnox3IDMhNB3sr6bj3S1zlCXYo+SLk+g/CU9VEbc6TAV3Y9J5hJ/8KBqkR8cXhYzeiEt4m8S1yYZC7acNlyi6yzm85rg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4ZZV63E; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4ZZV63E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgnD5D3Lz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:09:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CF82C600D1;
	Tue, 15 Sep 2026 12:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464481F000FF;
	Tue, 15 Sep 2026 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474190;
	bh=zv1rNZvSCHkzISCnzIgvhR1XdclekSPPoj8rLv8Qezg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a4ZZV63EloWFTnOUlHK58XwOK2rkeCsu03ufhBV72Tiipl5qWiGg8pKw75jRnalat
	 Px+Ej4QbTLpchvWen5UHVg+abfR3qMIoHWKRq5zOfC+6fvUdhpGBml50Plsl14BxoA
	 MD9L1UkPG2s8tttZuNhCrGp0Ac838MyFzPadcw7MIZBEqZ9CQQXdlYMZFCITTIwQVR
	 e8ZVbA+QeVGcVPqWoOLbEKnwhY2HpmkZP6Db2SJHGUaetI9dgl3FBXgJQQpNHkGFqv
	 7oyl/HjPvr3DAOtUTzbk2i14RAaCiMZAvTqJbij4737kik3jJY1RQy1e4vJFFsF6gN
	 uDBgNLmQTLN+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 32/50] liveupdate: install the session
 descriptors when the ioctl returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Jan Kara" <jack@suse.cz>, linux-gpio@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, io-uring@vger.kernel.org, bpf@vger.kernel.org, linux-openrisc@vger.kernel.org, kexec@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Ingo
 Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, "Jann
 Horn" <jannh@google.com>, linux-hexagon@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-um@lists.infradead.org, kvm@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, virtualization@lists.linux.dev, linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRh?=
 =?utf-8?b?YmxlKQ==?= <brauner@kernel.org>, linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-sh@vger.kernel.org, linux-csky@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-32-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-32-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:09:48 +0000
Message-Id: <20260915120949.464481F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D32


