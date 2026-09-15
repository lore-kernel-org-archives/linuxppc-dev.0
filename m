Return-Path: <linuxppc-dev+bounces-27425-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A747C88E7F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:59:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhtm1Wcbz30VV;
	Tue, 15 Sep 2026 22:59:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789474884;
	cv=none; b=AmhTQ0FHewOaztOV18NFIsu2r2C/IVgHclijvVOTqJOhJdDnUDH52aBdJ/gvcUCYQO0jll4ipgCqrTGcjy2w+A1pkP8bzNWdm4xpTcEYYN/7ERwxp9SVpOkO9XcAfrJc4hQLSciERsLEPBy5IiAn/6KbrNb1QO8zeccZS8KnCtP94NU+L768lsP+0T9iaYH5Y6RVFWJV0Ep0U/HIu3z40Vyk4UMTb1liFcOMrwQqtPADwCAF2hIOL9VvuCqm3rn+ozsjZp9zD9n58CumXJsQakmhhXX1gcOXT1+4Vuu9F/c4rpszaJW00I5c0j5FR/q/6cZ3eRDVHJxyoY+LmRExsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789474884; c=relaxed/relaxed;
	bh=Uc7cO5xoe1cQZMzNgyouoEulYOfR9Lrcdm/hjSDUACk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FwxaRIVOjtuRhaJ8iBYcW6t4+zW2JOVPAAIiHZYl8lnPzGJbKTQ1uNxGwRnM74SrAGtp2tmSa4VaJQ2GH1VWVerBDO7/ajx3ic4kboaOFnRERGtCZBRHjc6vTpZ4gN3Tz4GLd94eKNT9W82GMcKpxmgl6fznqTEbuhZsxTSlaxezbaj5zpaclmNotvd8opYO/GkbldZ0fh2CanjVRb6NZP2M4O/j14sy4MnWHjeNWBCnVE0xoS+2mTpl4UuqF4SMx92A6RWJAvP3eZaMzc8l1hHVADagqW3HOLDVtp0E8CWXEbHHsIub4JaUgv/9wT793dbKV5BbZk/vMwYh5VolZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RifjIpqw; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RifjIpqw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkh2W5G1Sz2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:21:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8201B600D1;
	Tue, 15 Sep 2026 12:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789A61F00893;
	Tue, 15 Sep 2026 12:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474881;
	bh=Uc7cO5xoe1cQZMzNgyouoEulYOfR9Lrcdm/hjSDUACk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RifjIpqwJ9OqsSvNVf8dpgAPRIXNtpH+2TvjVYCOe9JUquNlggyFFXGJ0dnsaYmCg
	 GQ9XosyxDDx8GSMITHICVAvNL+LxNcmxvQMQP7A3d1sqIXZ9RcF7rJNLS5wAMhcPOo
	 SPow9eKiSuj2zKpRt8Cuw1b4X6SN6EeInZhqMldrk5L5hldvpE4fVZKWhOZYYZiNwJ
	 uht3jZCMYXSw+Eavv2okVbNxYC6NRCTmed+SaIPKeRXggq0abWEv5pETdDXtyZFTxL
	 +PtN1edDe9OuMct6IEevtSb0WL7MUHUyK38VC8DLpI0Q9G8uZMCxYp4zSbGdcMEgO3
	 kB54THZRs52CQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 46/50] xen/gntdev-dmabuf: stop putting the
 descriptor back on failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-gpio@vger.kernel.org, bpf@vger.kernel.org, "Oleg Nesterov" <oleg@redhat.com>, "Jann
 Horn" <jannh@google.com>, linux-mm@kvack.org, linux-openrisc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, sparclinux@vger.kernel.org, kvm@vger.kernel.org, linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org, dri-devel@lists.freedesktop.org, "Peter
 Zijlstra" <peterz@infradead.org>, io-uring@vger.kernel.org, "David Airlie" <airlied@redhat.com>,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-m68k@lists.linux-m68k.org, linux-arm-kernel@lists.infradead.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-um@lists.infradead.org, linux-sh@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "Alexander Viro" <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linuxppc-dev@lists.ozlabs.org, linux-snps-arc@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, kexec@lists.infradead.org, linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-hexagon@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-csky@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-46-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-46-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:21:19 +0000
Message-Id: <20260915122119.789A61F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D46


