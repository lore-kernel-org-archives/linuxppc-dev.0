Return-Path: <linuxppc-dev+bounces-29496-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B85BC3DA7A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 16:44:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4cVq5snQz3bt2;
	Thu, 15 Oct 2026 03:44:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::132b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791996275;
	cv=pass; b=EricDsP5XlIqIBgbR8ThlfVJrsWWeY67fTN/3BjXNWByHQXxPJlqs7LZpQFrqpQRK/kuvUq6xuFm1pgrCgWhLlwwHDRVQG2aB9UWb7wjtuF/qadLwCxCBTm8xuZFG6Qp6Ia8GSW7yF6j8CS2qVoNqx81W+oM1Hv16FRq1XDlvnwmfIG9NzwldbYwfvmw6EtUkYOKMzOll+E1N20vN13S7jNdzC9HUTSPpAxXRcvly4Ab4tZjq7fquX3kblg3RfjJhAYq+iqR/6BXxvZEJdN55UYtbRSOdb3Q+Qq1IZThY+c8gXoruQZv8lfI8djq8/KPuo9fRes1i0q0wtl5ntTLiA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791996275; c=relaxed/relaxed;
	bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhbAeQ7KM3zuKmu2127mYykGS68zfw80SD9FxZpfTw9PcR7QfOK2j2dxU7Ey5Gc6049YXPRHAx20xV8Yjud1VqitfZ4clrIY87gffVmmD+5QWLunEwIv+alM8BKuRNwocvYy4Ge9wXSCwOnKIoiLwLGgKhrMCoLQA/sDGD9wwBy/UHoHOnCVA1EU9HzcqTFZAQwJ9DNYE5Zy24YIwav/hhwnj61xv3Np26OcGRqZYypDW+m6jZi3kCz4SJwK+EbmdTtj6EVCvwDK2ReOZ0af/HUgWIw3lXfb0PT7yGQVYVvxNuJFgLSqgW/u3u1alMxNcsidMTWzY4oUGrX/tdyr0w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fFqrqQW0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fFqrqQW0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4cVp31fdz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 03:44:34 +1100 (AEDT)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-33bb5afa736so522829eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 09:44:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996272; cv=none;
        d=google.com; s=arc-20260327;
        b=mvwxpVuwbfldzKr+AHQVCe18fivqC+kaVPSyRlWCmU108MqisdvTZR+LiuPY5K6fe9
         qijwE1si75kDaYZceX21rPBAHaKiPz3eGxIrPe3dBw61+DJXLJqqcsChkyGPF1YicJ1j
         PJb0YVIPGnKTjV/k532lFNHS1MBhryl0QeHINmB/cXHCgnVZHxdWa0I+me81/CziYk8M
         heNg7B2e2KqHmu0zgxK40ExKJDAmzrBDTFebPDITUXw6xrskZv0MuugMAUh1JngZbSTI
         rxejYVin6phIV2o1wRxtJdiqAkulIn9ZWlFAagwvjfSUH53V6WnT9WqSBtL4t9zNUZpZ
         rrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
        fh=4/nOvn0GxX1OTlDx1hMs3ABhV0XTVrkseeiaUWGuGA0=;
        b=euNqyVmjKDBVbjnjFS1rVzSwcFaweki5oyBwwCSNIYmTNjVaGmjXWdxYuSdPiYH0nz
         VU9V9K9VKT93E6sYGK+o0I/0dTHXRk8/psqhS2DBNsvveA1fbtr48dhI03cM0NNGzItx
         beQEdIrXbrJzM5/IKsx3oUI5iG6s7BeKClSbfjrckx+5SV+3CdiKDTxJc2VnfyYp8fcU
         VPFfT+7yg4G6y/bYYvuqDRHFnVVb/dSpqMT7fXMV4/Xw4EPz02h+gacKUEqs4gY8yJQ2
         Eb5tJZvYao111EJQPbH3l/LJc7/F+OU+mqJ00sOHJb9N6hbBL9SvKyH+ZtzrrvFb8JXs
         qO+w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791996272; x=1792601072; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
        b=fFqrqQW0FyVL214fBiAMvnxyPRqzFPnctZtwdHDUT0lzOjF+dHFAJfA7A11oyW75eG
         WFvC0IZo/ibM70QuTLlJ/QdTt6hDRuzw0oQrwIW1xDSwINk227TrSTxiiSCFkPNVpIoc
         xjwe4fiu2DM8GkZlERQ/88Oui9WzWmh4aeaki5VcgznbJOmoh2bvXYWrpSNHeMH+QNfX
         cIU3nS9u1lAtrEHxPmuMBZcetBD0MkdXzhe4EjCR8Fq59R9MIogDMGgnKkAAsrxibRLQ
         AFVo6evu14UjIwkf8NiSIrSkKcyemEtXb2GW7oVZwKub5io+93NGi725Nc1QPmLllRuz
         Gcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996272; x=1792601072;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
        b=FIKuwFWkbuaVxDdNDfFczfpy+f7hvbcz15mRp5Tb5VgabCXN8Sjklvmjf5lfo0q3aU
         xXcc75um2ansoS1W5u+32/atyaoNg69El5Evs4ZYzX9Mo5GHxF8VEH1dyhXTdU5zWcWW
         Y+xjKqPTArbPsfApP8Sa7/a62DhLLnUBd0bemaHSFNmtGGRmR1p1T5DRHAlBu1LPxK0m
         pJIp5oFtfECNMAWLeAPJE9P6EFUh9/mwjGD8jmolDmJmfAOVQoNhA0bC5iy2AJ/gOsh7
         LL5YNDBxOZ/LuYeLyoNH/Hrqiis4vnzq3MpxkXyvcYFJBeCBWPvqNZym5erg470wtzbN
         iIQQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+IyuSbhJ7WSCcjLx0vWGNHHw1D/IWYfu51DFEsxZUDREaraguHn+K8rZaIIUj40fPv3lbTT6c3q1pDSw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK3SmChVHluWkW1giMMFeJKXg7zUCt2kbP08aCR05lihzWtNqHa
	c0/z72dry/6kQu1g3wKd9cYbMbGnomswC5yZvvfQec+xJt17OZndcQvWvHVfAdxK2MPNTFEYQfK
	aB2ost5HRESil/cgbHlSxumnwKEl5Dlc=
X-Gm-Gg: AYBFou16/bJWCnDtDsl9NEI4AEkYdQB4miq3IaZVZTFM9mVGVa9N28V9MY4JoOIoD22
	FdjfCtRtiunF1wLwrbRMgBq/ixAKT9LP4SEkkf8E9blPKsEmw8X1wTk6rVxev+QXPAivTaqVR57
	1pPga/7Q1p63n2JItw88L0Wd99VXu1N3g5EjLia0QV02Ro6o8LiQWwV8YFhb/jjZyT8DtO//ksW
	SpApZXVliU+CnybX48Jm4iJyHbejG3ZUnAixQCSVH4k5dvIa9kDyCFYxSOgup3fZm0+jgrgTutP
	LmepQ7MkKCQ0zsW9M86v2QbjsIpah5wAqSggb1cWJxJIDMSszQZU8R37lZFVnogXn7UKD8iNbN2
	TRJN2O5a0QjiFxGnk9/DtPUXH2lSZjk0juDxodRbkABP6bvW79bSr3AjOvrh6sxfRtURpWIx9iF
	N0eupc7N283VWv3bV2n1+8QEmTYz3DnJ4f3WVylH1UXufMXjEzhck=
X-Received: by 2002:a05:7301:5413:b0:358:c9f3:b055 with SMTP id
 5a478bee46e88-358c9f3b260mr28158500eec.1.1791996271702; Wed, 14 Oct 2026
 09:44:31 -0700 (PDT)
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
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Oct 2026 18:44:18 +0200
X-Gm-Features: AclHuK_d31yoge0njHjovdIQh7JfJY6W-PLjzMLBq14NjY-schAqigzEJUAQwG8
Message-ID: <CANiq72=4WQ1B1oCSW=69u_Z=FFLE56hYCqDwWr+poQdzSTS31A@mail.gmail.com>
Subject: Re: [PATCH 00/11] kobject: Require explicit initialization of struct kobj_type::release
To: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ian Rogers <irogers@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
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

On Wed, Oct 14, 2026 at 6:37=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> I'd really like to have the attribute available, and I've got at least
> one user I can apply today that don't require fix-ups (seq_file), so
> if Miguel is okay with it, I'd like to snag patch 1 and send it with
> my seq_file "first user" for this coming merge window so it's available
> starting with v7.4-rc1, and we don't end up needing to wait 10 weeks for
> other subsystems to be able to use it. And the kobj fixups can continue
> in parallel. Does that sounds okay?

Of course, please feel free to pick it up (with the small tweak I
requested) if you have a user.

And if you don't pick the user, I could still pick the first patch up
through the compiler attributes tree if you and other folks want to
use it after -rc1.

Greg: adding the attribute itself should be safe and would unblock
others that may want to "protect" themselves, without having to wait
for every potential user to get fixed (but of course I agree they
should get fixed -- we should not forget about them, if that is your
concern).

Cheers,
Miguel

