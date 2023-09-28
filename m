Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A961E743C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Sep 2023 21:11:51 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LCXy2p3u;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RxR4Q0l0fz3dkS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Sep 2023 07:11:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LCXy2p3u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=song@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RxR2J0j6yz3dHb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2023 07:10:00 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7024D61D8E
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2023 21:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D63C433D9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2023 21:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695935396;
	bh=J48G7q2dfvunzXe1tvK4+YBYxHYkh0UDxUPeKF0gmAo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LCXy2p3uzlkF6XDTqe+TL+bXQcRx5BomuAXELh8mxdyp9qwUP58rInZbpIcbM3glf
	 VEWJQwBj3LdkjJ5B5HydAafgtEWOR0rYcmjqD0LYhce9UUC6x7+IiQl7bVmIriJmhL
	 tabHvP9fLm8wvyBlaa5oifw0dMmoLmIXV+REkfmd0BgGqbKCcYz7wkydhl5V+2BAOS
	 jrEAoR6zbztePCv9KXutr0MRvL+35Ye9NvcZEIwpRsyFK2y8n32+SEdNsn2OKQNSBL
	 HGYjxAWrtZqi7uQqOe/GQx+A+3vMC6KWRFNFALt+Phhna+o+2UTHTzVD5z6/DQZZPQ
	 Qlk9dtzdXLggA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5031ccf004cso21436202e87.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2023 14:09:56 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxl/QwhJEglEWRwYrRuX9Dw9ntk435BECDHZgQQYImkId7VH+ju
	ouh0tmsqMtPBPG9iyGmqEfHwYygxstfRpOXzTCo=
X-Google-Smtp-Source: AGHT+IGO3l8pkUj/r3UKEYdGea9o8YaYCh7E69o9Ca0lJkrFgm2S+nq4EQxS1uOTl1SzpmTFb84P8wjEE3KdKZnVzzU=
X-Received: by 2002:a05:6512:1189:b0:502:a46e:257a with SMTP id
 g9-20020a056512118900b00502a46e257amr1977126lfr.56.1695935394750; Thu, 28 Sep
 2023 14:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230928194818.261163-1-hbathini@linux.ibm.com> <20230928194818.261163-5-hbathini@linux.ibm.com>
In-Reply-To: <20230928194818.261163-5-hbathini@linux.ibm.com>
From: Song Liu <song@kernel.org>
Date: Thu, 28 Sep 2023 14:09:42 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7TRmqGQ+-sFbUpWV7_8OftKFLpsKjnUzRWvQMyZoTwgQ@mail.gmail.com>
Message-ID: <CAPhsuW7TRmqGQ+-sFbUpWV7_8OftKFLpsKjnUzRWvQMyZoTwgQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] powerpc/bpf: rename powerpc64_jit_data to powerpc_jit_data
To: Hari Bathini <hbathini@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, bpf@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Sep 28, 2023 at 12:48=E2=80=AFPM Hari Bathini <hbathini@linux.ibm.c=
om> wrote:
>
> powerpc64_jit_data is a misnomer as it is meant for both ppc32 and
> ppc64. Rename it to powerpc_jit_data.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Acked-by: Song Liu <song@kernel.org>
