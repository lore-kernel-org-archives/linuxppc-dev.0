Return-Path: <linuxppc-dev+bounces-29495-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFDBCC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 16:41:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4cRW2rv1z30Vs;
	Thu, 15 Oct 2026 03:41:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791996103;
	cv=pass; b=EKyawZgviR3vIgw/A8LggYfIvtT6KA2sKHA+UMD3EoWsouHUN21vszoiImnvmBDWKhUbfYxCFVlQsGWI/WTPgYKePWtsq7HFshUeAVQQdTaS6XjBRn3dNU6n/OU/MXE4SZJqTJ1nMYe7eQRztUh3d6jWBy98lMkSp8ryjwhVVvoGb4LgacWbwVo9c5lgxZ3P+wCDBvMGU+yOovu0hdW/pvMZUmz6+5njTCuhSyxplWHnZjahFK5S2boNHLoBHc7rgmBbM2eDShJmUi50NCZxb8MPzHvQXT3cRHrSWzusf+TVfsr/Bu3FrHDBUx1vS/jdR6ioV4FbDfIDH6vz8TJwbw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791996103; c=relaxed/relaxed;
	bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HraG9Pj1fKizoEGoNDlLyZwWpZH8XN/agN4Cv9mymGLG3arOmU1XU/yP1mUYrTZGdKGV7o17MQLNbq6j58ntAPhIxvLiJ/2ZfQz6QXd2QOSW0qKl4N8gjYs8GxEg0j7R34Efm8YIK47NcCzWYZMYOSdLxTNVMbXzx/C2Gv5Vd+XXlEf/nNSuadzc2Eqt858Z3jfKGKOxsfH5anoErFmH4dYwqogUwFb9htEh/ifPjNJ9VvLq4NEUL8ov3K8Blu6q1jmWrGNMVskGtmtucSzzKfYFzxBoY0vw/EBCeHKIpdVij6yKXPzJ+OcjiSY8gKtY97fYBQrtfpOAFuR75p9PAg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=c0tbN9tQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=c0tbN9tQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4cRV07NJz30Tp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 03:41:41 +1100 (AEDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-533202fe429so1288911cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 09:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996098; cv=none;
        d=google.com; s=arc-20260327;
        b=Y60ogG81vi9+J1EZOj3bJMaPkLG9ik6aVI+zUI+ZpsIwgBCr32NHA5sTNVzJJOmDN+
         YxImu/PrMbo7IDLLQePhudylv8RqcGXi6/kPIRvKVY6NzFP4VooU5pHRq2TynTE6pq1o
         4DKMiOVwevjnkn3LGJfDRgJG2NsquiySNPOq0MyqpgQCpIrW9B1lJv47JbWYJmMcl6pA
         AHbmvecFaFblN+zBSsQx42aYrWbrypvjaEzd3ZfgCTD/svzV+IZnu/hhlzCH1iNo5mu+
         N4EZ4JmUbQpoPj0BQfvknM28S2Y7ZYenB1RXd2pwfU7dgI//ON+5IYpxNhZCUNIFFSB/
         MEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
        fh=16S6xr/5A08E5Ck2+v9GaKtkahzMDY8qbIgfXgNnPdU=;
        b=B8RXClV7xuvXSFiOQSrs8GITaKGNH/+Insc5Kl4ptY1A/utEf/wKm/c6Py3YG+85Yo
         XKKGtouvTcirLoTImhcvig03LG13zMAdGIGLS/9uSar/5wVp7913SwqoXw3jtakwrDii
         J+pZx3ocNTuWQ22xk9bD/6u73uZ40SVIafCPF9LAV/E4Oqt3IiDZz9QysyvaH0BmVGA6
         jB9xDb/cpwXwAv9TiqudND+G42LP1DZxouK56JVpYsf0QEF7TauHupcHr6mUAqVXkyTS
         8EPROBtWJhpS7d4L1UPDowRTxMaq9Td2b9PMNmYubuspph7E+LbR3FQdDZWr+ZVoueKr
         k6dw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791996098; x=1792600898; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
        b=c0tbN9tQE2qE777vM5Wlyc3PuOiYsqKi5Cwvwqrrog/18gWY6Y3DTVOzRqtAh45Tg5
         BJVC46g/LMk2zSpDKNbHr5lQmxZxTmWpHLr88uSIruw9mzzM7TaO0XHocfHgRtlSMKiW
         KjmZAyOKdSsu9Um3Xd+7pqLbz9IPhryghcJ4CAMlnt6NHFsTUYRE69IWqv/wFwTasMoT
         IdoLZxRZM0O+2E85g8is1VvCcgwWTzft8MVUY17xqFRRaXme6MslxPQQGi0l7mS9oyfk
         eas+a9SO0OkScqn7gJQjavDmqBboRdlcpN04A41c2OdQH1eSl5vQxh4cGJasmssmsbUb
         QOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996098; x=1792600898;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
        b=05FnzwS/6xkyZr1utVqxGeQRCGrp44WWaFbZ3te/h0gswJDKZ95znFgbEWpafQfd/2
         1I2yKtuI/+p8eJWvQ7qwUPC4NGK1U+z+fRjlAZ1kHD13fLrqRE9C6HiMFi4f0aKCmi+W
         TKC0DEc+ljLSFu+cfwEbJFEATRqFf9G8N61mazz2mI/6mT+P8jKWbok3IbacUHuaJrg8
         r74Yqg18nUzjCoIX5eQa+IsVWGIAOS9lOykO4UcuxMDR2titBZCm14KE5BAAmFCMZqVw
         Tl4N72LkpPELN0MaKF3K0WleeqBo1LYDEdBYctd0Zb1B94OdhJC6dY/G852WC5seb4Es
         Z7Eg==
X-Forwarded-Encrypted: i=1; AKwUvBxNLYITKOWSxMMYIS4VXGcoXm/sFPqZZBFmoL/U5xxSmn0d3byWcm/zFhbar/paSCUmjcNqzQRekihLP54=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJR454ycI1grgTCfsk2J2gRXaQDeZe+RqGBLPKFPS9IUsXrW1XK
	NT6JboVnmQ+v8RbVT5+gdgKt24hSWYtkXKVSzAXYl0NFJ1mT2OAsymg/zZMlDevxPlEfNI/adC+
	qiSQEvvmAUFroqjMy2QxUk4bXjQ3Sm0LoWx9MljHL
X-Gm-Gg: AYBFou04+AmxHrSgOnvJw86/L2Rfi+SQKLOQSBtx4bDXf0B2S0QMuMR7Q3koDC4H38M
	IPSPYuVbQcNzJxCEZCSm66uPP2Tj26UllxM/3zd5EHfuY3JpbzAHpL3qRAIAXRzdhidzTWwQT19
	SdoAU+zw14e9l5ogSgmwPnvB0r9pF7uGIQj3qesw896Gts49XYOLRW8ymus304SpMGq6pvHihtA
	TSLYdJR6OO1iY/bM3dDeQFUIJgAFgk3ZOmr01C1g4y+DFKnXRzpT9IXQutxc16EMigcb9q7aKXV
	y02teiPj90pEcKn8d5ocrjki650k1gu0p3WtC//9jM8z2WoRO62v2nV9FnFU43XmTkH5bRDRr7S
	uStlrP6+yrg==
X-Received: by 2002:a05:622a:1108:b0:533:9746:9a86 with SMTP id
 d75a77b69052e-5360573c96fmr14813151cf.5.1791996097367; Wed, 14 Oct 2026
 09:41:37 -0700 (PDT)
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
References: <20261013223946.1836757-1-irogers@google.com> <2026101425-why-boring-4f2d@gregkh>
 <202610140932.5F9CFCE5@keescook>
In-Reply-To: <202610140932.5F9CFCE5@keescook>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Oct 2026 09:41:25 -0700
X-Gm-Features: AclHuK8_g-YOJgMR77fEpf5RTsveF4u_ERdXz6lvoN6wh_uF7KP8ZsaUSV1ti8A
Message-ID: <CAP-5=fVLWh4uay2HGy6DOpZmtTr5WAd-TehAkN+P-pQgq_BZhg@mail.gmail.com>
Subject: Re: [PATCH 00/11] kobject: Require explicit initialization of struct kobj_type::release
To: Kees Cook <kees@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
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
> On Wed, Oct 14, 2026 at 07:36:41AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Oct 13, 2026 at 03:39:35PM -0700, Ian Rogers wrote:
> > > Clang supports the 'require_explicit_initialization' attribute on str=
uct
> > > fields to enforce that the field is explicitly initialized when an
> > > aggregate object is constructed, emitting -Wuninitialized-explicit-in=
it
> > > (enabled by default) if the field is omitted.
> > >
> > > Following discussion at the Linux Plumbers Conference [1], this serie=
s
> > > introduces __require_explicit_initialization in
> > > include/linux/compiler_attributes.h and applies it to
> > > struct kobj_type::release.
> >
> > Cool, sorry I missed that talk.
>
> Yeah, I'm really liking these compile-time checks. :)
>
> >
> > > As Documentation/core-api/kobject.rst notes:
> > >   "One important point cannot be overstated: every kobject must have =
a
> > >   release() method, and the kobject must persist (in a consistent sta=
te)
> > >   until that method is called. If these constraints are not met, the =
code
> > >   is flawed."
> > >
> > > Annotating struct kobj_type::release caught 30 struct kobj_type
> > > definitions across the tree that omitted .release:
> > > - Patches 2-10 fix 10 struct kobj_type definitions where dynamically
> > >   allocated kobjects, ksets, or enclosing structures were either leak=
ed on
> > >   kobject_put() or freed prematurely before kobject release (risking =
a
> > >   use-after-free when CONFIG_DEBUG_KOBJECT_RELEASE=3Dy).
> > > - Patch 11 annotates struct kobj_type::release with
> > >   __require_explicit_initialization and explicitly sets .release =3D =
NULL
> > >   (with explanatory comments) on the remaining legacy struct kobj_typ=
e
> > >   definitions whose kobjects are static, per-CPU, or embedded in devm=
- or
> > >   parent-managed structures.
> >
> > Sounds great, but let's fix up the users before adding the attribute.
> > Looks like some of these need another version so it might take a bit of
> > time to get them all merged.
>
> I'd really like to have the attribute available, and I've got at least
> one user I can apply today that don't require fix-ups (seq_file), so
> if Miguel is okay with it, I'd like to snag patch 1 and send it with
> my seq_file "first user" for this coming merge window so it's available
> starting with v7.4-rc1, and we don't end up needing to wait 10 weeks for
> other subsystems to be able to use it. And the kobj fixups can continue
> in parallel. Does that sounds okay?

I'm happy with that. I'm working to address/incorporate the other
feedback for a v2 of this series, but I can drop individual patches
that have already been merged. Thanks, everyone, for the positive
reception in getting this landed, I plan to follow up with patch
series for the other uses I found.

Thanks!
Ian

> --
> Kees Cook

