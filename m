Return-Path: <linuxppc-dev+bounces-27433-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01FCC982C1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 16:02:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkmyB2Phcz2yFW;
	Wed, 16 Sep 2026 02:02:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789488178;
	cv=none; b=a2M6PnUoGWCRG7UcmmGt3suqHXn5HhtZBKsDti6vFZBI0NH/0h+FuYMtFcnBPKg+T685zInJjJ1k1SNsJJmPunytSas0jVQYOM1o/VsGMDH+kY/zbmOdjGskS6vu2bT6p3P09rjXbV8vwFTS3nh0CnyoKTqttAowjq6MLn0vwpeEt+WHfwLn9lGrjwitvUyREzSPMg9bXDdAi5Oo19jPZGCDtm1dWm/eHJNjCpcRoOViesm2m3XHyD29lylc5MGv+WTEyShYrG+8W3cgm+7JV1W3NmcDQt8eadxbEEL1NL6CLWre5HgcZYg/BSIqcKZc/MnCGGDM4HposHOBMljgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789488178; c=relaxed/relaxed;
	bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrjWxWH8hBaNDFcPTiLkAFPTG4b0Nm2gNaSpD2Xf3/nC/ALQopb0fuFMW7ogQ/0LxmOyWOXWSgt/YQnuig7ucXlU9PvEmSzASB2lv0dHrGcfwpqUf9buzvfNYvJFPs/ErAMnLaqHhclSZYxTkfVnmJD7dBbX3BA9lImGFmEWr9HjgYBO1B2kXdUDQNQ9AmA53fxH8RM6wUVC3PPiIAwFQhmS/SvFjJ8HX6e5zOJXI7nwg9eH8Z20vaApMS3XsoPWR+0IQ+yF7WeyHSsSJ0sXakyZz1rgTImMYgFkvLJvSsl+006i08mRIJLdq2fMKeW+cbWAgOfSnXHK9ykbwhyUGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=YA+yfRYi; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=YA+yfRYi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com [IPv6:2a00:1450:4864:34::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkmy91TWXz2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 02:02:56 +1000 (AEST)
Received: by mail-ej2-x10.google.com with SMTP id a640c23a62f3a-c254fa4c24cso537095466b.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 09:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789488173; x=1790092973; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=YA+yfRYiQSE7vv6qHyqGwoKtg9T0/F5nX9clvfdwrlLy5a5nnctPMQc2bwvjS8Q8a5
         7VCVjJl69UnYX6iqmTPoTyMtwPp8kac5JwYeVpDf4uvUuzLOlzztwnQTEeTNxirnLwqE
         XjEMIbKptuNkqq1EzYm+Gg42Gw1FtipJw6xLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488173; x=1790092973;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=Z5IjWCiZ8djKgae00d8qcz09Ym4c/Yl1ysRC4fobgEO1WBK4yHtg+856abDSpj1l5O
         7K5I8vNMTuXPYKC5y5UsFvLsozeMG2B3koQ35Juj9XuFmQVsOjZhyOv6TcrEivMv2adq
         n7MuUm9puQ829iLRh0v7YaPTwVt3e21Uf1ehqiw+jXOAw1//Ugt7oZ5PZe4y6y34K2MR
         ClrDxFgLCa0VAhW2RZAj0lBEdqr4+8sqctJDeTZPy3QgEO+mS4jFArd4AGr4EaHv4GMJ
         ZwAboXeFX4UtQHQDKfB21FqqtGuRdFRDjyL79VDHBRgeVYCXPmRP5VpfdlbqQJ4bekhK
         qp8g==
X-Forwarded-Encrypted: i=1; AKwUvBxC2LBlIWI9lWg4kNJlGS1KoEffYYYlF6DdJa1nhLsGFBC1DSpmadn307M66mVlVA29uxc8tsgmnwhxSUg=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mtVC1ojda/BYEpaQJaHL74ZjpGZQ8DyTxlKJpGuWDyte0HlzQs
	4ULU9EEmhdzccaws1Fw3gn9kclQSqHWC7WPGMVHF9zHav4pzgCW2si4oZLXhqwDQikhNq0vYkVh
	rfuyUii0=
X-Gm-Gg: AYBFou34/Ny0Vu46z29ypkntVj13tkIMX3VIJ0P4oAn6696xwUVP7PN++J3nL3uGwcl
	Rge2lv4pwODpKe6gcDV/1jrsznYokR6E5+wjGfyFUzmH5pWdv5GpOfBUjVSAiw/7/tlCR6bhNzw
	tAj38iN+5YOXR0wp1Q6ru7NqQLDZjMC7fz4d0ly/r4RoYX534LmWQCjNU4QCXpdZHsSwa5z+REr
	eIrN33oFIvIyDN3hr9o0dsSprUN7TXQyS1HbtLC7M0ZXQTig94+NT+Wrnimj43LOsqDWDfCKiVD
	+VqdDgqMs/N6JdUwDD8e1SfmS0gCJiyP+WTKDINTLG/3r5xGv+dB6Etbslkvrk0M3UM6k6REOES
	/9f1G+smt0/lhxNxhI6akSmD9+Pbz2NDswiJjG6dKX6xUcnWwMueQ/bkhVSH1IYHAH4U7VIxFtO
	bHqeVwGmsxoEEKABSLAHWFrhhrICHq/oVF+wvHmccYPzwqSdYZJcmv7qs5Ad2eXQ4EUZv3RW6IK
	50YfKPZJRC6JTV2vcSphLL+QtrWcSECWPVLYmxqW8wFju+hqg==
X-Received: by 2002:a17:906:7949:b0:c26:19de:9acd with SMTP id a640c23a62f3a-c29b871bc0amr522991266b.37.1789488172712;
        Tue, 15 Sep 2026 09:02:52 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de453ea0sm761966b.11.2026.09.15.09.02.48
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 09:02:49 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c293c683202so502087266b.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 09:02:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwAQqnJ2nYjNmNDzOKQzSLk95/b+rbMlmWDfLVDBNCDZ4ynGpSQQ9Ha8d640tLPLGFwJGIHo1Z0xIweMjg=@lists.ozlabs.org
X-Received: by 2002:a17:907:cd0d:b0:c29:439b:d5c1 with SMTP id
 a640c23a62f3a-c29b86141b9mr553591866b.16.1789488168046; Tue, 15 Sep 2026
 09:02:48 -0700 (PDT)
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
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 09:02:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
X-Gm-Features: AcwNN1WK06t9f9BcKFBIanysXcyUXK4eRICuH4x14s60AdlpF6ijCATIYaYAAvQ
Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wrote:
>
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

Honestly, I am *not* a fan. At all.

I think this adds complexity rather than removing it.

The diffstat tells a story:

>  106 files changed, 962 insertions(+), 861 deletions(-)

in how this adds a hundred lines more than it deletes.

But to make things worse, it adds them in bad places: low-level
architecture assembly code.

Those extra lines are *not* making complicated code simpler. Quite the
reverse. They are taking fairly straightforward "just deal with errors
with normal cleanup in the place where it makes sense" and makes the
*straightforward* case simpler, while making the big picture more
complicated and subtle, and adding new code to places that are not
simple and just blindly do somethign that makes no sense in that
context.

IOW: it's more code, and it's more abstraction, and it DOES NOT HELP.

And yes, most of the well-maintained modern platforms (read: x86 and
arm64) use the generic infrastructure and they don't show that
low-level asm effect. So for those cases, it's mainly just  that added
conceptual complexity and a new odd rule - and makes a *successful*
system call go through that "extra work" and indirection phase that it
didn't use to go through.

So it just spreads out the work, and moves it to a less obvious place.

All for the very questionable advantage that you can now randomly add
a file descriptor without the few lines of fairly straightforward
rollback.

IOW, I do not see a single real upside to this, and I see immediate
downsides to it, and a more abstract complicated machinery.

I do *not* see why we woudl want to make this be a "every system call
exit" kind of thing. If there are places that think it's complicated
to do, they could have *their* local little stack of fd's pending. Why
force it onto the low-level system call entry for every system call
when there are only a small handful of actual real cases (the vfs
itself, and random ioctl's by odd driver subsystems).

              Linus

