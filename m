Return-Path: <linuxppc-dev+bounces-16738-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7262FE81BA9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Feb 2026 12:02:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8jxS60jzz2yFm;
	Mon, 09 Feb 2026 23:02:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1331" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770638556;
	cv=pass; b=niCStEP0lMq8wcFfW/NfECydbYLFuoUeKKpreeOvlu/vQLTxMANvCoccu0BeJBY/0kSVNohvH7CLv8O24moPWJ1N2DdOg6KLTwvGPKkmGXcopgiGLYI1GfPz0ZExVm4pB4bgIFU9Jjtvq/zIDlVz0DQDGbS4Td736lvDISXWZu3Zw582EXudtmUeCobfOiHqkEWBsBT/IftbIuqnv/PCVUNGeBGSDG7ertN5Z1sv2Eb2YUSkF1ZO+aCGIRAKcnsT30aqKi9+UZwz2CQb+TAnUxsbg0tCU4o6I2RWXFdPGTZDGjio3xRfg0z8wX6NaEji4vBVG2IVjAGkpsxN1Q6s0Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770638556; c=relaxed/relaxed;
	bh=dZhWDaNsdwvI4rNW3NtCt5JiKEi9H9HsfZTRb8EfKk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSAiDV7GNbx2Os3ZPck2T+ZbBa1jZsw7tXaYcZRet1QgPh1nl8/AqkO3zmhIWacFy6wq2d0HOseI1ftpqLafX6g2yiAwT7wrWSLe+L3/B9PTiG7qWSfM70xKW03kmnRicJ6Xb/ip2/iRu8/SidNycTRB93SpU4a8FNyXAAxmjPqCXj1L5BCLwwhzGyKxXaoXXNIXKTykIDIA112Kq14FOb6dwW26CBAcVvq8i5e8qZZMM2dPwtQteWJY1ngleQ5FNP0MRKEkLxrrNq/UTDg+5t8LUVmNWVUz99EKGmNRxuh+OzRdqn40+08Ol4BIlH7LilWVWqQn1wBsayhVxdbZWA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aHNR3tgC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aHNR3tgC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com [IPv6:2607:f8b0:4864:20::1331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8jxR55Csz2xBV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Feb 2026 23:02:34 +1100 (AEDT)
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-2b836208f23so139857eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Feb 2026 04:02:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770638553; cv=none;
        d=google.com; s=arc-20240605;
        b=ZGxzbayMTXMpt7v+ih4sdi9Y7N/SNze6SCf844Ej4numUgp6ZuAvLtkgzBOLsWHfxL
         d+oBOGA2cIauHfX+wcJv3Ul2omS4TDbcntKwp0OYDYQ5Z2FzFZ/FkolcuSVDAIYdRhNy
         SCuXDQj8Kqv5ZHJ41FDXvPePsPyJ49lwsEL6eP0k1ufIcABE/NhInEro/3xkiqLb0V48
         MLz1MmSIXlMNyR7rSSgYLB7anRj9Fgwd5FiQVk1oOQefx01wUdv/hPt3DuORlzKVu8xd
         xmu400LiFCG9zu8xIGijv1Oc8CQOfp6LpOADxI/76PYUGfZXT7MRWOyek+vM+GYoOwaE
         EepA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dZhWDaNsdwvI4rNW3NtCt5JiKEi9H9HsfZTRb8EfKk0=;
        fh=NHUdF5wWEEjXWiCXryWaBwebfvbeK39/OmR7VcS8FFA=;
        b=WAD3aVmNW8DSTyNJDzwAbFCcNjq8sgKa0YOIVYJR7oFfptiI1S/IEE0b3P0jhCczMQ
         4CkMBKAYP7dgXxfzeeDZSfv5HANVXpxwjlxYmXX5JtWYdxQ1O+5o15ogypnwwcnIoYPg
         v/6SJa1MzG+6E6DbQ9gGqTgsr8MFsr4l1UFCgGpr7rsfGKr73uWt9rS6+XW3rgukYbux
         QMpLYRBBzM2MizhLUxUBalMz2XBtl8m4wCs2RGG5pk2o+rgfI4XeZJnZvHsFIPwTP+2H
         U7XC427m+qpew1KPtn+w/HX28z3HX64Am9xntvtGRc5aX7dgsr4IErj2bPKInucoWdDz
         dsEA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770638553; x=1771243353; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZhWDaNsdwvI4rNW3NtCt5JiKEi9H9HsfZTRb8EfKk0=;
        b=aHNR3tgCLvZFSmM4kafFBT/3nXSTIRd30t5SBj0SuONLPz6JQJJ5uzmahdSpeNWHyj
         06SqNu56tFACYUQ4tcljtiyrKImxLOywqx+pRWgGfXc1VqWRemoRaIyDBIzctxOqPVEO
         zFcgEga5/8fwqDan1Xw5d1ppye5BiXmQ4bmkFQWA60/lzAPFdOQgpeJZZOt9MLb2cmRO
         AqAkQqRndppQXCxlGfqxCf0PAWzMJ1Woz208UEnpVi+RbOB6qgS9or/I1o61X9K7nf7h
         z71/BzinbTj3b2C5xNs3EdOdUjXverXsnwSVC+jGgR7cmNlXdqmlpW6mR5XV/NeEDtH8
         tkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770638553; x=1771243353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dZhWDaNsdwvI4rNW3NtCt5JiKEi9H9HsfZTRb8EfKk0=;
        b=JPgqg5trh+dR3vGw9TiLbiniYge1sx4oLC1ucuA5BuXftRRMXdUGSrOms737SE3lQA
         ZRQKD3mDHWffl920JR+l8Xf1hVJACkJYKu4HjqlSgO3VfBmZ+V50icnrnJSDRei1HUv7
         dQ+u++j5dHTP8VFzn+adxAjOgvSZ5SCfGZ7+2tcxyQ9lXGTKOnKnZwEECURkQ1KRtAfY
         aRsXmMR4NvXW2qCGjuHJChd4ZHl4I2QJrw7f6/gECRzxUvaUkRReMiNAvSA/W4DJN47A
         /GQMMf4w/xqubagOtvm5ofrjXdKEhLPtXdtK0k/2BQRAYeREaJCxyXApKX6Tt2x84fxL
         EtQw==
X-Forwarded-Encrypted: i=1; AJvYcCVK3+YzuMhy2Ctvx0fRjxBkkCrNjPaT/gslC3RD3/EzNBReDCMWzuzbSDXo7ueNgZFnqxy+TCAtkWBxVAY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxsMtQUodR1e1AwCIZRUKKgDBsJj6J+SB/lvIyDtIecbwDdH0z4
	1LORh+8j9O1ueZwwSfctVFZOX+alojpIw2UrjnOJ9tFb9Q+rbjZn6QrPTa6l+9OjOfsG+9fD+BK
	KU7S7OePmjRC5x1QDZ2ixMhXyASFv7NY=
X-Gm-Gg: AZuq6aJNkrHI4qhbVgPyzx98Cz0diED5uKN3MlO2Q3Lof4IC1EoKOwmRfHx1kyyruUV
	iA/Je+DYoUNbgULJ1Qlf7BzfoXSNkaHZNzW69B/UHKaQSNqxq6XAcIq7TRNYK4gD7IkbN0gHiQV
	qol2VcBzcahbXstV2w3ftr0WxAj4ywoi3lRpUJR81vTAd+F32LJwAdxAptAkdYiY6TpOBKGe8D4
	qs1/P/0K515qR09p6pOd4CdG4AEJKOIvqGA6fiKjzCn17vgcd5p8HdgL6KJtiju8KQcmUTZX2mW
	IWfrZu8AME9yDDGpDPwIL5QNtWy2oE0CgF4OKufRq0HDYBOLHko+w7ZYyG1ssDkhjJy9IyREN0c
	r63Eiy/mC7L6l
X-Received: by 2002:a05:693c:6085:b0:2b9:ddef:2c13 with SMTP id
 5a478bee46e88-2b9ddef3bcdmr780273eec.5.1770638552639; Mon, 09 Feb 2026
 04:02:32 -0800 (PST)
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
References: <20260209105456.1551677-1-mkchauras@gmail.com> <20260209105456.1551677-3-mkchauras@gmail.com>
In-Reply-To: <20260209105456.1551677-3-mkchauras@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Feb 2026 13:02:20 +0100
X-Gm-Features: AZwV_Qj0qLrj8jckFchFsbULIvtu6ZjFQsKyUw2LAuw6MCkfc5efrXbsku0JQ84
Message-ID: <CANiq72nqH=H4a_Yo17KPmku5pPRMVRBADgj8j+=TcR=3r0vOdQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/3] rust: Add PowerPC support
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: linkmauve@linkmauve.fr, ojeda@kernel.org, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org, corbet@lwn.net, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, peterz@infradead.org, 
	jpoimboe@kernel.org, jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 11:55=E2=80=AFAM Mukesh Kumar Chaurasiya (IBM)
<mkchauras@gmail.com> wrote:
>
> These changes aren=E2=80=99t the only ones required to get the kernel to =
compile
> and link on PowerPC

Is this patch not complete, then? It is up to the PowerPC maintainers
what they want to merge, of course, but I don't think we should add
the line in `Documentation/` if it does not work yet.

By the way, regarding that:

> +``powerpc``    Experimental      32-bit Big Endian only.

These levels are mapped to `MAINTAINERS` ones:

    Below is a general summary of architectures that currently work. Level =
of
    support corresponds to ``S`` values in the ``MAINTAINERS`` file.

But there is no "Experimental" level there. The idea is to know if
there is someone being paid to work on this, or not, etc.

This should also be changed in the other patch that adds ppc64le --
e.g. Mukesh, is IBM supporting this?

I guess it may be simpler to not add this line here until it works
properly, and only add the ppc64le one in the next patch, with a fixed
level to one of the `MAINTAINERS` ones.

Thanks!

Cheers,
Miguel

