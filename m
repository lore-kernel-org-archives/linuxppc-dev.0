Return-Path: <linuxppc-dev+bounces-16595-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E998E9D41E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Feb 2026 17:49:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5ntG52Lqz2xm3;
	Thu, 05 Feb 2026 04:49:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1231" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770227382;
	cv=pass; b=k1SDu2CvDagRWgKx7SLp7egK7D6fxSKpNsyrqPvzZP8aNOvZ7/mSKvMTEEShnI8UtRsgAtsNBZ2b/zBzybilWl/VIZ1Ube+eqobCxi0AvLUzd/j9XDwIeJ4d7WHsGZicn8wvPiZcRjVPr/xJcnRnAYJcsY/kQEfv8IXlCSAj4gaMt0glEFwLqQlCX6EdiYAIY7q8r2uw9ejo7A1uK1IkgXisyjsKiHFgPB8vPn4s1zEEuE7JORe4W6zdEixuVLsvBhwmgWGarrUogmpiNHXpSZ2L9lRjOsvR5F4StPcVp6kAZd01qW7fOEyMQaLa5f5i3BmLEZe/zhTb0hYkxzawFQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770227382; c=relaxed/relaxed;
	bh=xDefLCRgV/TQ3JHNjcWIRVQ67vN0JwqCI2ji4ZmQrkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIcwHl5v6rdsY+GXq8pgHr3pOPk8C5ZKSqop3A18Gte0lBOyM2MDoFbIiZcaYRSlSuPHfFcWPoWuYth/du6Iisef9R8EDJb1/yIrsiqBIJKdDiG38dkJGPSjplasZr3xRoTe6FI4Npt8vnVuOEqmfavTYkv6ftYqk0qqZYWYBHiGDlNM0oYzu5OZMtF1DbYiF7fLCiD9/Ztqtn82gdNR48sZGklc8rR0bV6p1mR2GjU7xl7u8WxX0DAf+bqxvwNvdTY7LzMVBkiNpmHgQcGm7hbigfYNi7bfOJcEkD9B6hoTzq/TL1DU4nuIv43ZJy+PH4MKmMrnnZsSAzuTgL03Pg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DZU1RheK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DZU1RheK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1231.google.com (mail-dl1-x1231.google.com [IPv6:2607:f8b0:4864:20::1231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f5ntF2tpvz2xJ5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Feb 2026 04:49:40 +1100 (AEDT)
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-124a5810e41so16848c88.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2026 09:49:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770227377; cv=none;
        d=google.com; s=arc-20240605;
        b=LnKV036V58HTLL+A+yCq0dyxCYvAFEz6EQ0hWGKHTBpzrP05mD9JIUgFCzuNmht3SD
         6b1pHQWAPcSOy2+Lc+iIVNdWeMqMXQ30heu7KJOLqk126H8KnsmRdWdicvG/i+56QfTa
         mY+ZUgqIxF4VS5NkiNO3Lff1Qz5N/FeNhE/L/nxs7vND+4YlBow6UgpfPhZedSeUfXig
         vGLOSYycimrHcH33PSey130xE+hGdF/DbtFvzFRWcWBLWXGDORCIZpeWcoshPa+YTdZc
         NqtZ3ZEPLKgAoVYCP5tuRqhn47e5TDxB9EcV0QJu2WQec1/IqxawozmAIeoEAN9mbbI0
         IjbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xDefLCRgV/TQ3JHNjcWIRVQ67vN0JwqCI2ji4ZmQrkk=;
        fh=TxlFIUXtko8YFYZfPxMoKTKA/9IyAvv/H2srSvqfBL0=;
        b=RrIjSYXV4HaI4y/GKb2BWoJBwORsyEysLIcKPjhAtGhzMkrJvODNEfVhYGBnNMczwV
         OcfJo8ZAVfbm8BcuQGLFylLcR8H4uPGC3qrSOUJDwfL8iT5OxTC23jijeTIe/xrWY1T0
         LxqiEojmpmmIjIxkH2/ulkd2kr6ejZBNCJfOQQZBv85aLhkH2f+xacoLxA60YZxrr0hy
         Hs7wYoxX376oOV5hV2axZeijFdzHC5YSUG1OLdeESL7kTNNa98SjujM7GxHp94mHHu06
         vMw8dAgY0/NdV7klZNQXjmX2o0WBd25fvF5bOr41oC3m3oD6jxG2qsfP0p9wJHY1uXiZ
         yqkg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770227377; x=1770832177; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDefLCRgV/TQ3JHNjcWIRVQ67vN0JwqCI2ji4ZmQrkk=;
        b=DZU1RheKzUuDqY7DdZ49vh3Aw6YezwuoyGhkFYGwPMapAhUYJJ2I0ek32h85QpCi27
         IPL3SV8Y1ubknxqg5s/8zuqYgbI2jdeYryS+tyC625Q5ZWdcy2cvpYyv19q08Rjph3tZ
         KfZkdHzCD14mWYIfW4ED1O/Z0r84HSHzh1rYS4tF3ko9y/0dMYiCQ+akmia6+iA7jboO
         IAN2hN//fay2F4XyP+fzkUIGbYOxGoaqkEkEhB7cd6ELPHtMpHiAai0Rzg5pv4j7kwh8
         HPo9LECFhkbt+bFqM7/yJq2qLDCb3hgoF7Bgzy6yyYBKczth42LaX/fLdlTVWUoMI7zx
         ECDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770227377; x=1770832177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xDefLCRgV/TQ3JHNjcWIRVQ67vN0JwqCI2ji4ZmQrkk=;
        b=ls4ONH6ExOLAZ6JFMvs5TDIFVPvnlobUjSVTEp8lbjVg+ZsoHmysgx8LPotEIDbRF2
         PsFtc+CUm72916p4NFeN+yHLq9FKW0gy1q6lpy1a19gmG+BfOBHZ2UvTZ76+eYAr8E0V
         OB0ic9rxbXhPNw5Ypu71wkh2tuoGgNjsOUi+5p+ojg23jadV1UBTAWWQOi7wDAsc+nnJ
         AcFSUShp7bCAakFCvrm+IuZ4b5Osb8nV8GZgFcP1YXWDKtT+MTekcWMi12GMF0O5auGH
         sytnSW2LE7SGhoIqMsNRy775bryTicUcez35FXfc9IuhWOk8J1amJmW1lEWCccMV1rj3
         vTEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ9V1lUQnkjP6iCSElrtM6e3ZdW1lwnR/TgXZJcn70PExnkVBcYLGW/0XSZEqe62+IQR9q5zW6Y25upvA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwQQBoxiU9SKUcZ2gKQwAwulDlMe1IF2JduT8y3pVt0xqLhn66n
	FtaahaFO+Rvnly6TxcgUYW0oOELFouiK7mLQqQVAoNvpxxOoed991J+K1Ccsu1c+pUBM2NHk+HV
	MGl7WYUC7YWt50/GbkCG7ov1mBX/m7Ks=
X-Gm-Gg: AZuq6aI/bB9TX3qZ2D0EiM708Uq3Sa1PHhLcrgjtnyFmON11Fn//82pfz0/2wD56hpV
	yp8MsRC7wW4h3meqrvT5YDmMKiyLZzZOqZQVDNuDNF1HQBb2NfIm4+H1/QZcQat/0B7mGtgyzKJ
	+o3z9s3mRc+6uS//RXDYHcMouinnzH4GLTQtBynpzB+wiiphXUdF6Dh8poS+8/NJ5U0Q33ajZRy
	5lpQYaeRpziyDnTFJl0+50eE1Umse/fa82kgRJzTGaUjqGXsXDCmerl8DeaoMG5I2OVFx5+2fGd
	nbtY5aOs5i0PGb5zD3ADa0I6jBER849TWX5ra2ne78H+EiMEJo3QZNl0jdOAZom9l9BzpmBLusM
	VO+xpm+BoIgOw
X-Received: by 2002:a05:7301:4592:b0:2b7:1008:9f2e with SMTP id
 5a478bee46e88-2b8329d7929mr884867eec.7.1770227377226; Wed, 04 Feb 2026
 09:49:37 -0800 (PST)
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
References: <20260204042417.83903-1-mkchauras@gmail.com>
In-Reply-To: <20260204042417.83903-1-mkchauras@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 4 Feb 2026 18:49:23 +0100
X-Gm-Features: AZwV_QhpXt59DsIzTmuh2ZPPW6T9uONYBCxBt7FVK2mswJ22l7u_sEZEOBg8s4M
Message-ID: <CANiq72k41tCq7-LccTz2NNpUF-0sOqPvbj-z+Qz0msud3O-3AQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Enable Rust for ppc64le
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 6:54=E2=80=AFAM Mukesh Kumar Chaurasiya (IBM)
<mkchauras@gmail.com> wrote:
>
> +    } else if cfg.has("PPC64") {

Can this be done via flags, i.e. avoiding the `target.json`?

We are trying to avoid adding new custom targets, since the idea is to
remove our reliance on `target.json`.

If it is not possible to do it via flags only, then we should talk to
upstream to add the needed flags or perhaps a new built-in target.

Thanks!

(By the way, Michael back in 2021 did the original integration of
ppc64le before Rust was merged into mainline -- he may want to take a
look at this :) I see he is in Cc).

Cheers,
Miguel

