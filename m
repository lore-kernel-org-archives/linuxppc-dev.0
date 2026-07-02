Return-Path: <linuxppc-dev+bounces-23359-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD28C43327
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 05:50:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grQvq3gBMz2yXj;
	Thu, 02 Jul 2026 15:50:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782971415;
	cv=none; b=aMWMDCFEGQp3TqbkGWQm27gGVCwCfM6ye7n16+ECwrtFOPYBU/Smcw/5anxlR8cBAY5h1WhmWT90tbL6BAxydjNe3+Lp4dkoqIS4QKJt/oAyFRjXc5TDRPH4cKTbtYy5HKxJyFGHGdhboLg61TNRAXYmVLr2e7zn3lkClGImm560zHnTfAg/UkNfhxxoRHWeiwU+pc3F7tiIiUUKvgKXwxl1GQBmKC/jP6wxgR7IwJiLukLsZZxvlcIJSXOcMbXLN1pmenKhW2qzIHSGUzQ09HdF5cmjQSlK/revm9i5poUMY5k+TytH+09MkjLd3BmZhxYS+rR77iUJh8BGfB7Ngw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782971415; c=relaxed/relaxed;
	bh=Xn80YbNQRCy7u0axvID9/jx4xqkgYbtUOWMNeQphPIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7j0BpLqCPVNAOyyyQL0H2RoYhv4x2rox1hkiUMQCOY4b45VeZtBweg++2YViObespsh3M1aoj36wVwCzsk77habIQCFU/JSQPEslxPsi4604FXVkJLiTqlWIwHCO6HSrCMFPZiYfjia57BeQzg5cfqVlQtX9fPDkgjJsyK3CVUF0wk98Varzn+2RJvIa7UZtzUda5eJiCi4x5bjdds+DoYGZV+b5lNac/bAs0KxUdTToPiZkBPK/SsZrJQIYdyLTs/Yzh5iR3HBj52+MKMQ+nEariL2vlXqx1gS61UmYb0FPoH/jjdUf3itxTw/AYq79xz3PjsvkS7os+J2x6wYpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HOltenqC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HOltenqC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grQvp2K47z2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 15:50:13 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-37fc01a7835so955268a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 22:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782971410; x=1783576210; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xn80YbNQRCy7u0axvID9/jx4xqkgYbtUOWMNeQphPIk=;
        b=HOltenqC/EC2kpnEpnvGAN3pRKxP83LgAeIy9API21dtW7sn3dWZgVeu/OgfS5ob8c
         rpI7QniI4uKXD8bFqBqcznd7U2ZQm3FOdWzkzw81/rGDH4l0fQEEDfq7wj/ZtFcJNyUA
         ZUINrlZILxNXWht3c1jBu7ed2OTMB9k//A1oLJ305ls4CAYc1i1c0060OyNeHJSsYxgz
         Y6UA2fh3Xd6GyG4y0kFlO2azOIOZUBPHksDckAS/1kGCpdzKRGqEuUWr0kdIDczb5c8H
         0GLW/SmJuI2CNMvC+z/ZYlrAMy1eHG4kK3ed+lj9u6iaouCIbQk0EEqrIvkY6SXfBW3C
         lGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782971410; x=1783576210;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xn80YbNQRCy7u0axvID9/jx4xqkgYbtUOWMNeQphPIk=;
        b=iT3elACYNzAq6YTxxQdjUHS4xJUWHFCh/8RCJt0CXMpyxXLPvo5IM7ihMW6ydrweUN
         HZ/5qxwA0gYWWA+3C6krRr1G9D5LVmklZ+SPK02aBSM4lvE1TV1QJa0h9PcDMzdZ0tGu
         q+70m8icBWh6XVcf/I4s8LL/jM9SO/ecqf61Rr56NbI7wRSVy6qfMdu0+3wm3hpVgWbJ
         vDxGpn2S5rsaJZL5y9KYw6qE8tXEEwH6xBrFWm4nRL07Cz8+sQENXFDtaZs2dWA9DMD1
         e4tIAcqRC7pxpVa8m1vIzxoAT4sGKdkeH/Lk16t1ShBvEwtpZmpNZUDiXXPDcN6nmXn/
         9D+A==
X-Forwarded-Encrypted: i=1; AHgh+RpRsoysiT2/PM2D6JbfPC7GvZWdzNZm+D4NNnoaZkvyAErTt1H8P9tZsoaHxriTZsUfTf5DZ4AwYFArBtY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx/8Ez01VJeid8Xcc8rBVjsT8ajRGI4ZA8ZwiWyJEo/0+L1/ZX3
	iCJGmv1SkC/NM9IY2rnnUtjE0E282elrdmjVNlukRhJrgRTSlm0X6R5u
X-Gm-Gg: AfdE7cnYBxkqM2E1t4HA3kjOrfrSXXrSzcd5S/5u9vp3zjZmSWwWxDMeQzC6RdCub7t
	dzWi6/bsj5bNPInKN79i+mL+l+HfLyO1UkXa8u0jI3mSz2gXTUY/uZDQWhjm5IDrVXvZEM5OAKU
	l1SXF9UoBO/0eqBfksZ8FvL+b/RNjuw+4l1TCkQdGPyKyqsikRacH6z23tOJUXDCjic5QdgeFnZ
	Gv6nfuOGBYuQ2mn4tuIqpOr6ULCy9+FqW1gVGTrYLDqo4fXKN088gw7mP0jUf8PnUDsoQVEbWKs
	ZFzt5am6zYniDIN15jxXTWhrby+KjLO+lyJ24dskoP5gPqyvFpwz6RiK+lcAeEs2f6KwtNm6C4g
	bhu7tESyq2U7klgcjsJQnRvlUeO/BiZ1ppAVF7lPQh5CK/uM2XGRzbSylzhTax04QWDza5CbTEO
	2IqWh04vkE4D3xVpNXyROdv9z9qyAe2ltWIurzohdWOUTKxB/NXOgfNAC9XPo5lzfPcPoYJTk=
X-Received: by 2002:a17:90b:4aca:b0:37f:9cdf:f03d with SMTP id 98e67ed59e1d1-380baacb525mr3809456a91.32.1782971409925;
        Wed, 01 Jul 2026 22:50:09 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380e160b4c7sm441239a91.11.2026.07.01.22.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 22:50:09 -0700 (PDT)
Date: Thu, 2 Jul 2026 11:20:03 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, mkchauras@linux.ibm.com, 
	ryan.roberts@arm.com, ruanjinjie@huawei.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] powerpc/syscall: Fix seccomp errno handling with
 GENERIC_ENTRY
Message-ID: <akX6TL6v4aRPGdkk@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260629182946.419552-1-mkchauras@gmail.com>
 <a58675e4-f5a6-4a21-9871-904aad33b683@linux.ibm.com>
 <akSyVOsraz9waBf4@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <akTExSO3ZT7iRtBa@kunlun.suse.cz>
 <akTJbfXPKc10Xemh@kunlun.suse.cz>
 <akTP_YJvGwln_xb_@kunlun.suse.cz>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akTP_YJvGwln_xb_@kunlun.suse.cz>

On Wed, Jul 01, 2026 at 10:29:49AM +0200, Michal Suchánek wrote:
> On Wed, Jul 01, 2026 at 10:01:49AM +0200, Michal Suchánek wrote:
> > On Wed, Jul 01, 2026 at 09:41:57AM +0200, Michal Suchánek wrote:
> > > On Wed, Jul 01, 2026 at 11:57:00AM +0530, Mukesh Kumar Chaurasiya wrote:
> > > > On Wed, Jul 01, 2026 at 01:41:09AM +0530, Shrikanth Hegde wrote:
> > > > > Hi Mukesh.
> > > > > 
> > > > > On 6/29/26 11:59 PM, Mukesh Kumar Chaurasiya (IBM) wrote:
> 
> > > > > > diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> > > > > > index a9da2af6efa8..36d73933a311 100644
> > > > > > --- a/arch/powerpc/kernel/syscall.c
> > > > > > +++ b/arch/powerpc/kernel/syscall.c
> > > > > > @@ -20,7 +20,6 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> > > > > >   	syscall_fn f;
> > > > > >   	add_random_kstack_offset();
> > > > > > -	r0 = syscall_enter_from_user_mode(regs, r0);
> > > > > >   	if (unlikely(r0 >= NR_syscalls)) {
> > > > > >   		if (unlikely(trap_is_unsupported_scv(regs))) {
> > > > > > @@ -31,6 +30,12 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> > > > > >   		return -ENOSYS;
> > > > > >   	}
> > > > > > +	r0 = syscall_enter_from_user_mode(regs, r0);
> > > > > > +
> > > > > 
> > > > > I see many arch first do syscall_enter_from_user_mode and then check for return value.
> > > > > take x86 for example,
> > > > > 
> > > > > __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
> > > > > {
> > > > >         nr = syscall_enter_from_user_mode(regs, nr);
> > > > > 
> > > > >         if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
> > > > >                 /* Invalid system call, but still a system call. */
> > > > >                 regs->ax = __x64_sys_ni_syscall(regs);
> > > > >         }
> > > > > 
> > > > > }
> > > > > 
> > > > > So seccomp fails silently there if initial nr was -1?
> > > > > 
> > > > Hey,
> > > > 
> > > > No the -1 syscall ignores the error silently and returns 0.
> > > > 
> > > 
> > > There seems to be some inconsistency with the invalid syscalls.
> > > 
> > > Adapting the example from seccomp man page to ignore architecture I get
> > > on x86_64 (presumably with GENERIC_ENTRY since long ago):
> > > 
> > > ./a.out -2 55 /usr/bin/perl -MPOSIX -e '$!=0; my $r = syscall(-2, 0); print "ret=$r errno=".($!+0)." ($!)\n"'
> > > ret=-1 errno=55 (No anode)
> > > 
> > > but on ppc64le (with GENEREC_ENTRY):
> > > 
> > > ./a.out -2 55 /usr/bin/perl -MPOSIX -e '$!=0; my $r = syscall(-2, 0); print "ret=$r errno=".($!+0)." ($!)\n"'
> > > ret=-1 errno=38 (Function not implemented)
> > > 
> > > That said, behavior of seccomp on invalid syscalls is not particularly
> > > concerning. The tools that people typically use for constructing those
> > > filters typically require a valid syscall number.
> > > 
> > > It would be nice to align, though.
> > 
> > It is more concerning for SECCOMP_SET_MODE_STRICT or similar. So it
> > should be resolved to correctly execute seccomp even on invalid
> > syscalls. The syscall_enter_from_user_mode API is not particularly
> > well-suited for that, though.
> 
> In particular the fixup per
> https://lore.kernel.org/linuxppc-dev/akJzuEJRLniHk4Fi@kunlun.suse.cz/
> 
> handles some cases
> 
> ./a.out -2 55 /usr/bin/perl -MPOSIX -e '$!=0; my $r = syscall(-2, 0); print "ret=$r errno=".($!+0)." ($!)\n"'
> ret=-1 errno=55 (No anode)
> 
> but not -1
> 
> ./a.out -1 55 /usr/bin/perl -MPOSIX -e '$!=0; my $r = syscall(-1, 0); print "ret=$r errno=".($!+0)." ($!)\n"'
> ret=-1 errno=38 (Function not implemented)
> 
> which is the direct result of the ambiguous return value of
> syscall_enter_from_user_mode
> 
> Thanks
> 
> Michal
Hey Michal,

Yeah this seems to be a more complex thing than anticipated.
As per conversation on your another patch here
https://lore.kernel.org/all/BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com/

This patch seems to be redundant at this point.

Regards,
Mukesh


