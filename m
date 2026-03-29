Return-Path: <linuxppc-dev+bounces-18976-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9646F3D605
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Mar 2026 16:21:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkKPl31rWz2ySS;
	Mon, 30 Mar 2026 03:21:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::132c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774801275;
	cv=pass; b=IRi+vFj7PQpLdIAPJ8DSiLYkJtCsl6wWtLDk/SCzRBupEXLHX/s4/DpvHeX/2qihnhtpZkfPbhn0eWpI9xdRSkHSC6cAmKgAcdL6pLXJS7Kf+1MS24J0SngKh9NQEQbYvlpWIp6C9lWXx1KAvO2Oo3eAdDi34tRmFqfMKExMlPd7/I/TSVYMZ/EhoxLsgD3nSkAo1jnVxd/rmSHWNBule8HdcLsKyf/XH5FtV6kbNmnT812nQGhp+9TBYrXjlS+sUmiEMMrGqeFuEG4u4UbEAc/Ly0gLbaeLgjIPieOcfm0TanwDf3xModlKTp3T6Uqr2L0byZKSc0bDjSCBAT3dgg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774801275; c=relaxed/relaxed;
	bh=jzhX8aUExH+tPlkIe9SsNqXDM4K/iyQcLa9dIBG1ZSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K84Eh1QeWpeQkR9AIn+bTMBQ6jZ69iJ9R3EIu2mSJhxObDSH2ePdkAyHyVk9HxYOz/8YwwBdbMEs8ZnCHiima0D4pRGu1eByoCqTUQQ8ZH+nYdasIvmOr+9XgFUY4htbQWZhm0H+cGVQ1+mGpVBhksal38nX91GqzxAOLvdyLzaMdnxkM+gKWGBt/JZA/R9OQ6oDTAJYG7XzpycDD8HTzVpfhqdEBQE8OR9sjQ6/HuAJcnciU3eSsZZSiCyoeQw1zWrdNj6mKlHUbvv8tdaUhoB61GdadmInHZoy1PtTozwae/rH4g7W5YpA90EjB+whZ9jynRsY1p9TFz7Som7F2Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mfYqCzRE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mfYqCzRE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com [IPv6:2607:f8b0:4864:20::132c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkKPk2RpLz2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 03:21:13 +1100 (AEDT)
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-2c44547f6d5so44254eec.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2026 09:21:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774801271; cv=none;
        d=google.com; s=arc-20240605;
        b=ItODmKZ200yzW2I5Pxj60qJzHtfhHqGTl2dMVb7JzoQeH3BpXm0N2tbl05yeKbVJwY
         s16h8AZXhWxuhwTSiUc7L4ZhfloAwWDP4WVinSU9J4q90XYODfVEVO4dF+VjbCRRTtcW
         Bcb0BKaLlbMkHIVPDyx2K4EfyzoXmVIg0ebIHY1nWY70em4AybH6DSgz09s1sj6iJH2Q
         MbtItZtcbIukJL4AJqhxBjPgi324XZaHGTMwwgacp64QqBUd57ojFovBemq8mkszQcdy
         AgdF+UX59uZmxoSEvBwAh8sGNiNK9AvCSh7AU/DWJtivSuUy2T8SIFODEliZkBN489os
         A0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jzhX8aUExH+tPlkIe9SsNqXDM4K/iyQcLa9dIBG1ZSU=;
        fh=/Y/nZR1h9T4OxJUdaJkDLj7K47rKsbvmy80+qFWYFIo=;
        b=B5aIrU0Iz6w4BcpgyofMxQ8ZJAwGIouFEhE9FVV4NnB90F+ko0x0sLtdNA6tYYhCJz
         F+UUOzINFx54BjIDSr75xMGnkH5oRJEUYfbVVs4+Pga3jMAv4xW1jDgKEWQHfbxr5JsL
         wsNcXPjvFZ72/WSJXHF/4JNUg4Ifp+u7gykbfv5nWgEw5brQgc9pEV1N5iSoZk4X1XVC
         KFUeZ/1R6LfTVleWgniAnj0u7a8tx7jqjVBDducjsZRXSkhA8Dbu/i0SRcMgQBiMV0lO
         e7o8v4vmtWoolxhhcG5rqlVd550Em0ivPjAskghne5/2hcU7xbFftQxd+mTfVbamHBfd
         2DOQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774801271; x=1775406071; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzhX8aUExH+tPlkIe9SsNqXDM4K/iyQcLa9dIBG1ZSU=;
        b=mfYqCzREasqyCtO4fV4NgL5eytqDVSIe4pYI8ScPdldZ4DQ7mHR9oOt3PanSZQ8R6h
         PXGkyA08LqRfJ0ZMk1PQtC0aIi8CpIb0tIxAhhzavjsmJnXpaYnLD+lMJM+WhR0Vod2+
         NMawq3e8SRsMBy6genxcvEKPuCz/AdnNjKBd3srtxYGNzq67H21vb78dh/322DDi9lWj
         2q1jGGGZxdAvdDj8/wt5HrgoMGMq6NhCzrO9ip9K0KMXeV54k2EEbBzpUYnuIYh3uA76
         rEze3R6A2noU0nbuRL1g2WmO4bguyz27iIDS56DMAIPPy3q5sgl+TdDMmA+uRmHsb9Xs
         f0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774801271; x=1775406071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jzhX8aUExH+tPlkIe9SsNqXDM4K/iyQcLa9dIBG1ZSU=;
        b=mD7h5cA/I8L2X8FZYQCKkov5v+qkuNGovr+nU1Wyt0DjC931M4bI/RpnvVEBNWAQ3H
         0EFwrrF/bWk4YxLJC9/qsIq+qtRLcUfH49o+WHPrht7F0Wi/U8H1zR/5gmm+Nin81H4Y
         M5rwZfEgPIoOHLOlRbceuR8RA70ErotuQEocQ8cZG23pCwiJsL2UwM+u90hsrtYEEOsj
         u57eM3Wso+9GodJEl6pNnRbPXtGwh8mS8oXUP6bRCCQxgyVrOOIoclg6wUufU1G2/g2V
         iOrHKuuJjjxOIIfMLOhrRBKSWxQb16c57xD31FlxGQdv8Www7dWz2Sq8E1MHedZXh9mS
         u8qg==
X-Forwarded-Encrypted: i=1; AJvYcCUU1ZgyWML5y13x+bBi5gNaraiyEwvcarCucXttd8ZtvJWXhJbASF9KLnFhBh1Ppd7mOD7bzLSBLx5xgA0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy1kXg/1YdcvxzR61/kc16OqxWQPiaV+MJyl/2nlj5dceaPOfWJ
	CyHaRhpLsqqh06Znn2iua14AwYM9EtCfThVZNqnz3LdaB0UpPuLlRr+6MJg+dCPSziOFEwol6N9
	QvILuXX6vB3Mf6rRdnrWoAKQNJ1JnBBM=
X-Gm-Gg: ATEYQzx+DRaTkvBIc6MShB9ZaKWZVgz5uR2fK++pnaVUjT/yR0SGxb2Y9X5UuYd9ZHL
	htAvgVcR1ICeKL/+MFHjhC83Xn/UWqSA0L8sq1uxtCkePqfYMQAj9AtHiKUSb5jUyUBGzMLizQ1
	uZtLKLFjsM5afr9cpW8NTli34ziflOEGJ0NzcR69H3HU66ovsXsUBVwI0Borys9XizDloSOjMR/
	hTd3iVsmpqQPlh5A3gWhoVZ65WcLKMUNfx5QQII589s/O+Sv33NzW6QYqYfncO/MFOkkoAGQH95
	pxNh0gIMvUjwUHvyDhD0Lcafqsn87MFxSMCSIKm7Wg+3U9klslPfJArrZSp5s8P5KQMWQmlPZJH
	bUgeSNqSCz+O8GVyXSlRmD1NPqXxvTAdxxg==
X-Received: by 2002:a05:693c:3008:b0:2be:298c:a11 with SMTP id
 5a478bee46e88-2c185edf989mr2411276eec.3.1774801270816; Sun, 29 Mar 2026
 09:21:10 -0700 (PDT)
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
MIME-Version: 1.0
References: <20260329160254.2592207-1-mkchauras@gmail.com>
In-Reply-To: <20260329160254.2592207-1-mkchauras@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 29 Mar 2026 18:20:58 +0200
X-Gm-Features: AQROBzCTvoth77fiJhrDvkboImGbMF58MaL_C2S-dTbD8IoN3PmaT8yKe1R-C4o
Message-ID: <CANiq72nUf7cikhf+kCdCgoydpMJZ7HuFWR8jzRvHSoGNGCv-0Q@mail.gmail.com>
Subject: Re: [PATCH V7 0/4] Rust support for powerpc
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2026 at 6:03=E2=80=AFPM Mukesh Kumar Chaurasiya (IBM)
<mkchauras@gmail.com> wrote:
>
> We are actively working with our LLVM team to get the target for ppc,
> ppc64 and ppc64le in the rust compiler.

That sounds great -- I imagine you refer to a `-none` target? Are
there any links to e.g. upstream Rust issues or PRs that could be nice
to add for context, if any?

It may be good to put this in the commit message. Also, other links
that we should add:

Link: https://github.com/Rust-for-Linux/linux/issues/105
Link: https://github.com/linuxppc/issues/issues/451

Thanks!

Cheers,
Miguel

