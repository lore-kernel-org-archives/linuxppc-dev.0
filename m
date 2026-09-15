Return-Path: <linuxppc-dev+bounces-27387-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB82C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:44:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhXZ0GdSz30Ng;
	Tue, 15 Sep 2026 22:43:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789473305;
	cv=none; b=iw05TZi3J349KCHHvgsclfrl2Ii4+p0vDv8it2GFkTiwofg0hVPgvljQUcZwTyPGP4aksUAr8JG71DY1peVMcEfZ5rj49OWDpOw+qmnDYujINtA/rN5J8aWv2QZt93Bau2V8CNwrC134c5RBoDu80NZViXZ7Ovf/NMOxQsF75+VgnMn9isXbEfu8eUyuCstkhtfGqkDvbNqw4PHmci+cJPHuamQr53o6Vq6wyW7mdxYY7E0BTXJS8nx+S/YwxEPKOved2NzlpVEX/I1Mk0vtXpXC9kWvaAzD0K0jt9IZiEwn8CwFdi0zxJQN8LJKXuS9Agq6Brr+0IxjPP0ebk2pPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789473305; c=relaxed/relaxed;
	bh=D7g9xDZ0omvORxToAZd7wz5+AlCcHiBcOzmxibNhlVA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z6/kgFCWOQnk7dk38krkSnnoCOUhRYEWyIe0RSHjz955m4PK3bUnndQ+JYD4zaL3EcZWgqxqknnAXAONj6s1pYT6Dwyqfa0YmXVHwqnNYEDBl8E63KH1PTkr7S2OUXACb5y0eyDR7dn9nbMmqR5Gis9gZ8j3hkt9zYtTQ0JrctxsbzX+edzr/nPESpeo32+HozVS2KsWdq6Gfcn6jt6qDQoGJUsIraF1gftZcSG8diAje/miobOLBgAfWDSVU4/nI5QGAw3SYj1inosMRaZ9sMKzu9OcSMVdoAOpZpdJ7gE8U++y+vyYJjG7D5QsmMjBGXTc73o1r43cA5sD0uBvNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZyJu22BU; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZyJu22BU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgS90vgVz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:55:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A243943B4D;
	Tue, 15 Sep 2026 11:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D521F000FF;
	Tue, 15 Sep 2026 11:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473303;
	bh=D7g9xDZ0omvORxToAZd7wz5+AlCcHiBcOzmxibNhlVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZyJu22BUp/krcHqRNTq7jKcZ/omh/8BK0J0GGcmbyy5eXF7HLUhGysm81swJVRcRo
	 fJATPHtnqwBnOk6PWVqaIPLWcfH7MWcD4yqz6G7e3EGCMvuO13BOVBnpv9ez1pkoHo
	 h5dypooXJxYBa1oPbCPR5mUV6AbHtDqPpwLdNjZnOwcsbqEhQDByZ9Y6IWPAHL+aCB
	 IGdiRVZ8zo4AG0M9gKDQBs0eP2aITK9r+bHOxAfCyl+sA6VP5e3n+m73i2wu6dE27u
	 SdD2cWl466lslpt4/j2EFsvQA0Pnw2GlUhysF9C6CVND6+HZdKJG2WejdsdT6gvwdV
	 rDjhEE9s7krJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 15/50] sh: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: linux-gpio@vger.kernel.org, "Eugenio Perez" <eperezma@redhat.com>, "Jan
 Kara" <jack@suse.cz>, "Ingo Molnar" <mingo@redhat.com>, linux-hexagon@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Jann
 Horn" <jannh@google.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org, linux-mips@vger.kernel.org, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-csky@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, io-uring@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, virtualization@lists.linux.dev, kexec@lists.infradead.org, linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, "Michael
 S. Tsirkin" <mst@redhat.com>, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-snps-arc@lists.infradead.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-hyperv@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-15-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-15-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:55:00 +0000
Message-Id: <20260915115500.C1D521F000FF@smtp.kernel.org>
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

> Add TIF_FD_SLOTS to the syscall work mask. syscall_exit rereads the
> flags after the system call and goes to syscall_exit_work for any bit
> in the all-work mask, but hands over a copy shifted right by eight
> when the bit was in the upper byte. Reload the flags there and test
> the full mask, so that the bit reaches do_syscall_trace_leave().
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D15


