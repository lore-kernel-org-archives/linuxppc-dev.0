Return-Path: <linuxppc-dev+bounces-29497-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7B1CC6B2D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 16:44:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4cW76zM3z3btP;
	Thu, 15 Oct 2026 03:44:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::32c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791996291;
	cv=pass; b=IDXIGTqB2jDvcDwhTBLqfj4QooafGiEDIE9Tyk0DBY707G8ZsRqt0GxAlkR2BaXTJw9KRgXt7ziGQIMJ3x4/8eB10e+QWz+ClBmIg33HBnsbLyOXrPwtUkkYRQPyvqhhtJD2QxaX9A9sSHkZ89TFFTro9ryyWbTj1Xlhb5PD63o1jGN3MtaG6JmhJm9olkWJvYus2mZvjUyp7pJt5yFc4kPAQH3uvH+ZdbWvYVMOZBU91hgFA6dU3Obvub4LdBJ9MyQXbLtyyeK0ZpTy6Nyco51P4Y6EojTyobvl+ztPfs1z6wnVriEc+XqMGZ7e5CUeTNddEY6nXtSQ539zddvwHw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791996291; c=relaxed/relaxed;
	bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJCIWgDxnSCOS8efOYpuHTznEQMySvy2jn0lZKcDD1FwULvNDaB1SqAAB3x1XuWlsmdoYe/u1o1GPUnaUofSv0h7OIxNWelCVYNb2TgbtwK0hroR2IcDKSDSLCb4RvOp/V/m2DupMDIf+1zj9g22wsC7sNICLWoo/qO4twc/xZCQZcSGLmDDhUp3BsHWIldqNdP/XGBHpKtG8CJ51SNdyqB+fG+uIRFqgFLaWZBOFeGQt2PZG2OTwcPEJota//JCBL7e4ePPQrSSY4ClZRonzIQxvHOYpG9gMKJS8y15N6lrPhz4+9cpLpNBg7p/VJ4r+tW3Zz63id4gJ/bhAHOuVQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uTak2yhq; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=ndesaulniers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uTak2yhq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=ndesaulniers@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4cW674dSz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 03:44:50 +1100 (AEDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso41009325e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 09:44:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996282; cv=none;
        d=google.com; s=arc-20260327;
        b=HnTRsqpYiyJSWVRdCpzZacVTeFE8GiJAYjOKQ/AKxYVU3/0GWnPSfpqybnL7t366Bm
         Ew/FeWRalfj9TOPrY68id3kWhUCiJpFGoZSJqNN53GcfKfTjK1udVHeWPcVlJAcumFsv
         PiCrS/cmu92ypCFLttpxaEX0c8njc57meuP8KqrzAs/Hgj8XVFjLjpBv8r0NotX/kcM0
         OaWU0OdVMuw/GyS/TVaqzoIOPR0b9vREhRyAeAyY2lVHHm1wVlMP4XZN8FXWWFmfzsQu
         OjnbdGAcdvMTBo407xlnjwmeFkrpx/jBhj0UetQNDHyprP2DxosG3NFQO1yq9G8eO1CP
         +c6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
        fh=zaNcJ+r1is9MIBOuNUqiC5Lg4MVlJ6vIryNGVZGCy5I=;
        b=YyTjdveo1HIUp6RN/jsUt3BnJVh7Gae1S2da6a4zef06kdTKPq6nmgYS6Qqh08zWzC
         LRkmVwAES5LgN7fF+3TQB4gcuvdfsS79VHFk3hpIdxBMUasXdCl67lDr0uTJOatk5c+m
         TLU36Vzy1XGEv45baBQSKkm8sTbbgztlTeeTXyQzkrihXsXEkWo8OKAvRTI8CF2gKPCX
         HOlwow3AIZzF/os81t0WDzNu/znV8pRjErRSXyPnoYcukSAFUUDqnm2bLhOlTATxQ4+A
         yZ4hJoDkQCoeYNQZaRpkNm1IFdwET0iMIHelU8s5+T3m0+CHmq8TGT7izDfSmckf0pIV
         ewFg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791996282; x=1792601082; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
        b=uTak2yhqKH+UU7GtvNoCMK5i8el41ozddCqOeTouMGDDwEZ9VAthKOm3rhn7JuJXiP
         IHTr03a2Qwo4NCrr/ZIgUyJDFcF5wt6IdwarDlhH/oZDJhgVufheyZMF98HWFKW+AOHh
         Vl8PD1ngD0vQGxLbP+3xzFQo/+G2mmyQXBQoaRinXTH3gmc/grnV1n/oG5pSsugBnst9
         d7w3J0zJ3NOuBhMWzZOWhT9SLORbKMscNb6LV3W9je93eDjWlTe7r2vliZmwi3iHDQZa
         sWSNRvvMkwLf54Gy0a8CbC10auXO+h4jvXrn8msGnUamFX/rMN57njlM+y15TnO5tjZi
         SlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996282; x=1792601082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
        b=AW0M1X5bk7KlvHoU0Fd0Q4+yzyE6zkuaz3FhRtyWIiv+oXNHmMkTyknNfDAsQ/UtuC
         6fpYPpE8AjGr5tp2BEbbccinZO9HJ/CQeWEtIfIyoRUJU7G/EX0GHPaHaRitFCCNe2hN
         /b10xSZIkr+QdygB/MR7mrcCbaXVnae5PfcH48uZgXDFDldtvt/Tvi0tWU9E2jfoJt5S
         3Elc5rM8GHwHYioW6Om8S9wTnf16icXymxyWZXT/JKiUY8l/+SpzbwUU43kdFvL9TLeq
         iBAuQpbH3V9daCcViPhoBkRTksHVDPzbJw1cF1o3gDYr5P/wxteGxt/KJtBREm1011M/
         FwNw==
X-Forwarded-Encrypted: i=1; AKwUvBwE8u3ApaJ9a2s09tMOSKtDNN2i56Dvogs4uqHJGYAgDHrCsdHVXQEN5yJnIhP9+QY0kSwM5Q90gzX1oqA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLa4baILiaTDSXUtOWXGF6NgR+SMDwUJMVJKKXQOM1GG/S1a9wM
	iVKOnPnxjEUZonSlDGP/A9GM2o/Cu3By80etGNrSV0ZSLi9DKGpg9ClVQlmPxUaN3PiIzMSDOLB
	XoPiwhZCTmg98VRLVzqfxUl9kNiYrlVHB3JQEM5nF
X-Gm-Gg: AYBFou19LLlLyja5+uzVJxmSc0oP2VTtZ2LzJwcgIEMRyMXuV4Ysqin1QMubIxMZUl+
	/py8sJV4yQC2Evy1svGmmJ3Bm+riiFyRNM9kqye/Rm0Vh4DvIYKd3O7j5lp4/mNND0uM1lBKtQR
	sJWkkjW5n0Rt0khn7jF9s7r/41SYOSR5vbWGNDn9i40zEyIzA2r3gv4+KawBEvy5GplajKcaNnJ
	gbiwSWG9UsxBjx8ESSp4qJkavmM5Fvd1JZSlKsCbrGm5UzffQ4wxZrFTY4uCUnBTFOzP5jzg72c
	ixCvz/ziTWmmfxQPa9Rp+mZxdN6FtN/zjFZSVDJ5fWTj10fzqUCAHuSxJd2A/z+iEPLQmidgD5C
	fCv3Cahx0HQwG2mX8SwYhBCiPFH8E5QSdG8XnbncNzZ6SUz8xxGA9u92E13iCU0XtZSTPF9C1CA
	IifdckF6USv5/QTPsQteMerPSF444Emd3ySNwGfnqWL54XRWIUlq9u
X-Received: by 2002:a05:600c:354a:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4a18e3ef23cmr329192565e9.0.1791996281614; Wed, 14 Oct 2026
 09:44:41 -0700 (PDT)
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
References: <20261013223946.1836757-1-irogers@google.com> <20261013223946.1836757-2-irogers@google.com>
 <CANiq72mLUh1JB=9e=tqStuL_H3=Ormx5v-uFkCDp-0zZm7tBrQ@mail.gmail.com> <202610140937.B68C8C9AAC@keescook>
In-Reply-To: <202610140937.B68C8C9AAC@keescook>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 14 Oct 2026 09:44:29 -0700
X-Gm-Features: AclHuK9LUe2FvddsKjj0vYiArabpm2vrSaqioSsrjl7koqqOn_VyYRh6l-6milM
Message-ID: <CAKwvOdm6nO6skW4-AZtmzpGoNyO126L_AN3Mz2fu23+3QXcshg@mail.gmail.com>
Subject: Re: [PATCH 01/11] Compiler Attributes: Add __require_explicit_initialization
 macro
To: Kees Cook <kees@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 9:37=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Oct 14, 2026 at 01:28:55PM +0200, Miguel Ojeda wrote:
> > On Wed, Oct 14, 2026 at 12:40=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > +/*
> > > + * Optional: not supported by gcc
> > > + *
> > > + * clang: https://clang.llvm.org/docs/AttributeReference.html#requir=
e-explicit-initialization
> > > + */
> > > +#if __has_attribute(__require_explicit_initialization__)
> > > +# define __require_explicit_initialization __attribute__((__require_=
explicit_initialization__))
> > > +#else
> > > +# define __require_explicit_initialization
> > > +#endif
> >
> > The LPC slides mention Clang 14+, but from a quick test in Compiler
> > Explorer and a `git log --grep` on the LLVM repository to confirm, it
> > seems the attribute was introduced in Clang 20+, no?
> >
> > If that is correct, then it is not available in all LLVM versions we
> > support (LLVM 17+), so we should add:
> >
> >      * Optional: only supported since clang >=3D 20.0
> >
> > With that:
> >
> > Acked-by: Miguel Ojeda <ojeda@kernel.org>
>
> Yup, I can confirm, I only see it with 20+ too.

Fix up the comment and have a coin, witcher.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> --
> Kees Cook



--=20
Thanks,
~Nick Desaulniers

