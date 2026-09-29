Return-Path: <linuxppc-dev+bounces-28510-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44093CA5FAD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 17:44:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvQY01ZLGz2yD3;
	Wed, 30 Sep 2026 03:44:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790703876;
	cv=none; b=JmT9gcySWJ0HJWk/ASPJO/KiEUJfeyLCfSOOQNBzIQJeIjNJKnamj1XvCX6eaJqO3qtJ+OYoQk3E5FuE4uqWbJtdxl9kG18FmjOEWgdwqLQrgb1DfIPkEbPpmrGCaKXOFLfOgBWmUUj6geeywkRT0zh/7euwlV6tF1AEm3zIbGJbLOAxFp0UB6q7t4eXuPjIPm0OxVtUPlWaNSstXeMeHdSa6ihZulc2/12q0qu4kwjFfzYhh+Y2Excz+twe6Zlufk0WNpqVgbRhwfLh8BBoub2s56Rj7vJ0dr07s5xYfu4z6qCMxvF1BkrwR0UMx9wAMntvCst20759WSBERgEhEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790703876; c=relaxed/relaxed;
	bh=k31zVVbNicpwi9YDlhFvR6Wyco71XCVxmV3/xYq3pxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihLZJY7zEo4A3wPZmu/PfqixWJSPRbRJZC/vR+JEjJ0VgBHJ3F9gUWlETDgy1BGfTBOpT3PqtRq24LuMb+Yi2k+WdiQ8/KHUgkGvIE9O31gyOY9jXijZo2Ckjf6EBU1CAccpRPleIOGyxMZTsSrrFqF1SYJCwWp8dERTJ/xdeDHdbYtpzXYH0m0/W/+cEv4eIhEGkok28xejQsIfqF8EzVSrqCFoYDt14x0QnpCFhhs1dlQ2s5gQ3IiZxZ4z8+pjpnTOKc5LjTHQzaYf/D0HBYMyHAfiOhecwi2v1NvHg2suel/nunNtqB3vR0pRpaPw0DpSFCXjyrvwHPCvdNmQUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PT8OU7L/; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PT8OU7L/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com [IPv6:2a00:1450:4864:31::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvQXx74qzz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 03:44:32 +1000 (AEST)
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49b912df756so35116805e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790703864; x=1791308664; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k31zVVbNicpwi9YDlhFvR6Wyco71XCVxmV3/xYq3pxI=;
        b=PT8OU7L/9kirB+cI5yykcTS+UFMLaLQknyFsS/BKT+Omk3/Y6YQvDiRIHhkoYUAW8G
         3+McDsffFEXEyYgRZC8bSTtaKPMR/iH1zuFTC9EOpCUPl/GqsWwUESZCN1S82aLDsnUZ
         6fqxn5hIeHUJOcu9Db/r9O171rKq6y7dMZNSmvH8VF6cMfwTcx5QR9PnPhczXcDfWRGd
         gUMqLKOtqcYKER1lQJROjOA4W8GUSADXG+EHFQs6WxzUqDGUtwiDJOiojzFAY1kHJh7Y
         cLfThHOuPB/eqkFbqspa12RdQb6pLmgpsiYHv06jG3TtugVN9XhvgPq8v0FDOQkkAfFx
         O3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790703864; x=1791308664;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k31zVVbNicpwi9YDlhFvR6Wyco71XCVxmV3/xYq3pxI=;
        b=ayE59X+CGZfKko+XEpM4VaHIy3qCX5MNWQrY7B9U873eWdsCN39LyFvydzJkZwRSbE
         jfILorMz41mdi5jMT/2CoERKFR40DxUVciqF4F2KdYHH1eRjkTDpVKo+KTuQQBxb+h4g
         hci4yowuTAQI4kRrqKnYvFGsA+yRW0jQF7I1kmY4VPFzlscHUcK5QAUbjXMgVqv1pOVd
         S9Ta53Vesue65TT9D7nGLMuqqm8e8suQmEUzYaI08EU+NAXhfgvH7t10vMLvZToZ4506
         JDwtDp7eSNl4iNYGIic4NUmyVQlc4fGcPwsekra8F8i4ZwqiOHmBnPXkbl3JDX8dhLGv
         7pCg==
X-Forwarded-Encrypted: i=1; AKwUvBxfkat7J8+HR4Z4kuqwEb7OvsPacWl9inEVQjTiEmnoF/D/hgIJ2rtmq+Kpn+TghOldhv4lmPcduwoKRGM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kQfk78F+YsG8OGe4cu/+QWHPneVVw/sr8KLvKZ4mWQM4sht/p6
	daVJywMHrRMeQJm4FRtEwglg2zxDmlxzNAu97J7fuIglcHb/uXP5xGOQ
X-Gm-Gg: AYBFou3lca0FXPqqu8K42deYGtnqxSawJoyweSfexPnaraF5RSUffYMFIOxlPykaHbe
	NzgpONKJ/fYW0QmFyQ8QGSOH0WAZlehoPnhhw21nTB9eUWAkCNdtuPWPEFkLO8yvF+uwDTN0yiW
	QwMNV1dmlnEAWjVDX92Sp0mlvMgDqrudxT7QjLcv9IOia3Q9X2AObFHFUG1D54RlR4DnSwqIefn
	XINRVz1y0PU6enCBOi9t1sFZUOSmppSzGplw1P2X4WZMa9bFa4PT7oXQhbIfaJitplb+nUAEQck
	03+wLl2UzJsd7h55rM0F8wmEipd4odJan859svx1Oc+XFSjDgdai5eE3j7CE8S/xMmnxx217CAM
	nnb0jhHsfoOT0j7GvY0Kh+r5Se9iSWIIzyQTXcYMYcdKfFiTi8CyfcdfcjUqoke94sqSQJUsWvf
	EAwet+kaBy4Q76pvxzd/MyJpl5Vr2C9Uxr+84+2ypqNDwpUv5nuXZeOjLlNk6mxGUV1DqkO9VPA
	0JCwb/04IsYHqdpwESMuLV4oYng+ZCFwO4=
X-Received: by 2002:a05:600c:4e12:b0:49d:1842:f001 with SMTP id 5b1f17b1804b1-49fe66b6e0emr305056015e9.14.1790703863276;
        Tue, 29 Sep 2026 10:44:23 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfae123sm103285395e9.13.2026.09.29.10.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:44:22 -0700 (PDT)
Date: Tue, 29 Sep 2026 18:44:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Andreas Schwab
 <schwab@linux-m68k.org>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
Message-ID: <20260929184415.1920fe91@pumpkin>
In-Reply-To: <20260929165939.GA1890629@ax162>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
	<87zex4ic68.fsf@linux-m68k.org>
	<20260926121927.GA1486962@ax162>
	<are7cfMIHZZn6jLz@zx2c4.com>
	<20260927080225.37534e7c@pumpkin>
	<20260929165939.GA1890629@ax162>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 18:59:39 +0200
Nathan Chancellor <nathan@kernel.org> wrote:

> On Sun, Sep 27, 2026 at 08:02:25AM +0100, David Laight wrote:
> > On Sat, 26 Sep 2026 14:32:49 +0200
> > "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:  
> > > Do we even need to return a value at all? Might as well just make the
> > > function two lines:
> > > 
> > > +       for (char *d = dst; size--;)
> > > +               *d++ = value;  
> > 
> > Wouldn't it be better to add a barrier() or similar in there to
> > stop the compiler playing unwanted games>  
> 
> Wouldn't that just result in the same code generation issue that Jason
> pointed out on my v1?
> 
>   https://lore.kernel.org/aquyVkdYceiWdckX@zx2c4.com/

I missed that one going past....
You only get 'rep stosq' because the compiler first converts it to memset(). 

> Maybe that doesn't matter because modern compilers have better options?

A lot of cpu will run the 'rep stosq' very slowly (it has a big fixed cost).

At a guess the loop is 3 clocks (possibly 2; but that usually needs
you to use negative offsets from the end - and gcc doesn't like that).
That is comparable to a mispredicted branch (and you might get two of them).
It still might actually be faster than the 'rep stosq' version!

I suspect the fastest code is to unroll the loop.
	xor %eax, %eax
	movl %eax, 12(%rbx)
	movq %rax, 16(%rbx)
	movq %rax, 24(%rbx)
	movq %rax, 32(%rbx)
	movq %rax, 40(%rbx)
	movq %rax, 48(%rbx)
	movq %rax, 56(%rbx)
8 clocks on old cpu, 4 on newer ones.
But more likely to be limited be I-cache reads.

If you are going to use 'rep stos' then you might as well write
13 32bit words.

David


