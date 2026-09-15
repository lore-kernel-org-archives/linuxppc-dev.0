Return-Path: <linuxppc-dev+bounces-27401-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF26C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:55:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhnb1S4yz2ylm;
	Tue, 15 Sep 2026 22:55:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789473930;
	cv=none; b=Yvz9WmjzlQgLZ30n1sNnD3QdgKYD/MBmdMRs/bNZyQhQBd5P3wQMdpM8XYILFsztW4CR7D473wiFaNqgDeObXtBNJyqRgdz9T0Y8fnFka9dqH7bAU/TBUn7G2hLiBC7ur9+Mr8uiGnwLeCOieKkCn+XS3Sjf5qsAHecC6GA/3cXblf0Sny1qzFguXk21PDBfRyFvCjfS+mvSAqwnS6TsWDXK2rKvc7rcmQ/O4rcIRNHF2D3mpSkXag09OnYslE9QVoWc0V/umsFy41dFM0joatRHGesfAgqm4S728SEul1Pmn7+AsrQJYhUfKo5b32A7o4vQzm8AUY5/fEMhRonXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789473930; c=relaxed/relaxed;
	bh=9fBEtIbr3AFyAksoQqS3Fbydy5vpB4nMaKZT39mGc48=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jRdhOavVDs07NG03PiZXWwBWnBTr0n7IelJ4WAIoslBGyYelMzclDKi5x3/gIzl9KkQo5mu8Tx8p/eCFJEQVzIhLuUrNRM5VVC7AGNd9zJswOZvWZ9zRnJFbbfIMUWQSpi9Lx/kz7GblcIWIvnHTl+hBGefArk7aW8iXVrqFsJm0J4X0TyxNE3g27jYQj8POuuyjDNR+R3MI/nYzvLq7TarO1QVWRreLS8xEuIYgOgOLrJA8QzdACxee8SIfvlr6LfyCdC704qGJu7cVAXRDvEkELctuXwPnTZRaAD59+Mu9J4jdqG4iltzSK7GFJd8UT/989/deaNOi63U6lCLagA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ciTyjsYi; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ciTyjsYi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgh931qVz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:05:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 618BA60261;
	Tue, 15 Sep 2026 12:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4910B1F000FF;
	Tue, 15 Sep 2026 12:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473927;
	bh=9fBEtIbr3AFyAksoQqS3Fbydy5vpB4nMaKZT39mGc48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ciTyjsYio6YcUd6U+CzkUXMFWJVI5JN8YpF3LWAF35D4RcZO6WNyNNLXWTcTNKx/k
	 phMotj0kCSRJiLRwEB6PukDAqeOWTf+ZkB0jp+D5F2leVdFoUNkcjEaKJx1upIioCP
	 CUcHsmrqrKX9GAlkCPX6E26buGa/rDYMQLBRn2YZpYiLqv6kE2OPMZp+B2G/43JgPY
	 VQ3gvXiSdHMDyE74NA/AxGmidg9o/oGBR74v2qXcAt1S74qyth1DbIflVP8V9zvpQm
	 0rcjVCp5RxoIduGdCiF4608I/waS+6ME56RhQGnLGMkkRdYNrNVYyQVY30p5DEkuKy
	 JPaEc4INykdeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 25/50] file: reimplement FD_PREPARE() on the
 deferred fd_prepare() path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: "Jens Axboe" <axboe@kernel.dk>, "Peter Zijlstra" <peterz@infradead.org>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org, linux-gpio@vger.kernel.org, virtualization@lists.linux.dev, "Ingo
 Molnar" <mingo@redhat.com>, linux-um@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-csky@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org, linux-snps-arc@lists.infradead.org, io-uring@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Oleg
 Nesterov" <oleg@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-arm-msm@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, "David Airlie" <airlied@redhat.com>, linux-sh@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-25-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-25-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:05:24 +0000
Message-Id: <20260915120525.4910B1F000FF@smtp.kernel.org>
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

> The FD_PREPARE() cleanup class allocated and installed immediately and
> required fd_publish() to be the last thing that could fail. Reimplement
> it on the deferred path. FD_PREPARE() reserves a slot with fd_prepare()
> and stages the file on it. The syscall exit installs on success and
> drops on error. fd_prepare_fd() and fd_prepare_file() now read the slot.
> fd_publish() is gone.
>=20
> Convert every FD_PREPARE() user since fdf.err can now become a simple
> IS_ERR(fdf).
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D25


