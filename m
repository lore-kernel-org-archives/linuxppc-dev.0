Return-Path: <linuxppc-dev+bounces-27144-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D016C88E4D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 17:40:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhMJ52XG7z2ygK;
	Sat, 12 Sep 2026 03:40:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789148405;
	cv=none; b=A8zRKNPQq6zG79rAHqZdNj+PDV4wnYwUHkYWarRmbRLlqtJo//pd6dCfZD6goATfOQHN5VBU6qH62p9z6g0pGGetcgsEFf0AzthXdvwTBwpZ9uC7E34Q7Pn0tlAe+lu1o0QpTn/Cs1kIY4g+kTx7N5MOhqzwIMIHMXj1LOkJap0UC3+liEjDiJmUvOpeoibn8wiK+DpBeTJw6AM/TOJNlNTQjFkWTcltmwtJgfMU9b1KrD85W/g6mJlVb0l34PalRmDfLGtPtp2XXYWCO+PwxXlDjpYvlZAd4zz3Cmu+Gof+rQfkYTD4iewmnnnhBweI2JrEQg9nZpW784HLocF15g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789148405; c=relaxed/relaxed;
	bh=wl3IKortcFpGKddT3RAr007iJEhPfwcrwYUS/tqDJm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRik7VdbH2w2XUajAz/T2szv96Dh32K9Ap2JEUKf6HbUdXzRuqzIwXhrx2gxu+LG6ZlmiDMmkY/DUMu3nD2PiT6wYfhSG8XNKlUB38v0NL5DhSM7bSG8oe6ShpKsbWluZDNPZc6BwAG31Qun4RAIJkwYumJHefB6PBfkf9P48AIOK/TxXgaHea73p1ZVBHyqd0OxspL0TX17g1+ZuoNP7IW8v2Vo1twsXYC1cnYj1YJMKA+o8LUHIvLg9tN1QMKAX4K/5nHv0fU2LsrrfpoDdJq5B2Z4BS0laX+Ra9gnZVUo0Oie2Kza30WtXjgOnbW9ou4zckm/GL2YZg06IBjwyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d7FoBvv8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d7FoBvv8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhMJ36gGMz2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 03:40:02 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-852c481415fso1503225b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 10:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789148400; x=1789753200; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wl3IKortcFpGKddT3RAr007iJEhPfwcrwYUS/tqDJm4=;
        b=d7FoBvv8onm0Tpm3QKiOnU+I7b+NLD9ITYCXl5lVG6E1bajN3//03OOA5WEl3sv+Bj
         rC6d3DvMVvSAM6jTKAXJSZSWVtcU7K5Su0ZbwgsYtTCfo+X/MmS0c03skpgDBHMoorFH
         shE/sj1pmqt+g3cYTXW9/Jr/B0uMrcYxR1viIBeZqQryu6Ug96MtfZstHCgfIMC/jPud
         ok8isgdWR3k2ZtGpkXvftafdRcdbEwfUxVScrEDmAcOHFBlNDjE3cL/t5Sa94m/1/RwQ
         aF06/H3O9pNlf2NxgOxYfCaVs1kOM31NvcQMVRmbdWul0HCNyfOGhBAqCNoQvErkezzE
         6MOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789148400; x=1789753200;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wl3IKortcFpGKddT3RAr007iJEhPfwcrwYUS/tqDJm4=;
        b=ZUfiW166ygdQ0DuWhKq9Wekh5F38XuYp3gXkI6YZrQPAfzBComqgWyRnBrqHGj/BvC
         AsYjLi9K9TENHrxi9LF96wG3ydJo6SX8kOIogZ0V97F1mqYWvcCQaBfgPUvcflsiDb0q
         VjA2a65W9HK7oLE/+eJgVcCgnFJx8U/SW7mnh5cBLiT6I0CspNauA7VjpNTFrwwvGwL0
         69Oc5hTL1mRTo4VRuKBrH46j4U8p1mWhgjFxNis/Wu8vBErsadxBe+Z/HBMZ0WtMBXwF
         qIZde/Cg0tMElKLYvnICJPCMiqoBc3wQ88BmkOFMMPVncNXx1Jop0HTv5+AoeXCgolSA
         BMDw==
X-Forwarded-Encrypted: i=1; AKwUvBxcRWQq9777Ia5j0LaN5TgHvx4BnjfFcV24j2lkvaXfLEZKooOOCmggpdKGEkSbYTZz33Ve1rbi4NujdGU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lrHteccLSuAekCs5LT03lgjYJiaoeXwRAHGWQGey8AhFn0FHvH
	1moGGXNBvP+7I6lHShAyqrBSBlLmHBhVhOuSJuEkYxTlMgxMHpDpl61c
X-Gm-Gg: AYBFou17+jGujTrc1rc9Iu5K5r4nFah+8ZIxLFuwuDurefoyIL5wakF7O/tGwJYLzqQ
	ZLZ+qiHfJumoBbzyu2uGP/FkkIFqY0J6FkgRNbuB09l6+0OeqibanoJs9SCFQmr7rX8ppnQLkhf
	HEmcs5nIFEUlYYvyqetWeLOnqHGJSQSg3IZ+fRUMvHm249ol64tGG2V/qTjOX3l9tn76FBhiKCf
	xQqqIXXsuXGha1e41+RMTBsyIZ2zcpaqrJ8AuGKTCZ4K+QVRRa1+Sb1DPz0zZKK4FfDwSGkDx8J
	sI9ArrdVppFRj62wfkupUStDEGUL/ixLzpA77LY67PS2iOjIfV4Lx8QJBFs89CztXeb8pG4sxa+
	m1hS8mH10NRq3PlNFboi2Z6glVu56I4BCPF5rptZkpGTxjWMzO77bEa5imPlpqlV46/1qgPElXn
	0ipP/cLixABnVfuV4CKzXqlt0FLiYE9pkjzIB2hB8whA3jr8JZ/MAdaBidMW9Kz0JaHXybzJe7v
	U4nHREOqjOcdXxN+HG2kEBTqMB4uj+iAd5W3CGzVFEXTA==
X-Received: by 2002:a05:6a00:28c3:b0:848:62ab:7b7 with SMTP id d2e1a72fcca58-86b3011a6efmr8754763b3a.16.1789148399726;
        Fri, 11 Sep 2026 10:39:59 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29bb9ecesm1428361b3a.43.2026.09.11.10.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 10:39:59 -0700 (PDT)
Date: Fri, 11 Sep 2026 23:09:48 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, kees@kernel.org, amachhiw@linux.ibm.com, ritesh.list@gmail.com, 
	robh@kernel.org, sayalip@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-riscv@lists.infradead.org, 
	linux-hardening@vger.kernel.org, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH] powerpc/kasan: require memintrinsic prefix support for
 KASAN
Message-ID: <aqOrCdvUB5lFjNsS@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260908064948.999530-1-mkchauras@gmail.com>
 <b3b1fa5a-c836-447f-a658-ad66183c23c5@kernel.org>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3b1fa5a-c836-447f-a658-ad66183c23c5@kernel.org>

On Tue, Sep 08, 2026 at 11:59:14AM +0200, Christophe Leroy (CS GROUP) wrote:
> 
>
[...]
> > --- a/arch/powerpc/include/asm/kasan.h
> > +++ b/arch/powerpc/include/asm/kasan.h
> > @@ -2,20 +2,17 @@
> >   #ifndef __ASM_KASAN_H
> >   #define __ASM_KASAN_H
> > -#if defined(CONFIG_KASAN) && !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX)
> > -#define _GLOBAL_KASAN(fn)			\
> > -	_GLOBAL(fn);				\
> > -	_GLOBAL(__##fn)
> > -#define _GLOBAL_TOC_KASAN(fn)			\
> > -	_GLOBAL_TOC(fn);			\
> > -	_GLOBAL_TOC(__##fn)
> > -#define EXPORT_SYMBOL_KASAN(fn)			\
> > -	EXPORT_SYMBOL(__##fn)
> > -#else /* CONFIG_KASAN && !CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
> > +/*
> > + * powerpc requires CC_HAS_KASAN_MEMINTRINSIC_PREFIX whenever KASAN is
> > + * enabled (see PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX in arch/powerpc/Kconfig),
> > + * so the compiler always emits __asan_mem*() at instrumented call sites and
> > + * bare mem*() inside __no_sanitize_address / noinstr code.  The old dual
> > + * entry-point trick (_GLOBAL_KASAN emitting both memset and __memset) is
> > + * therefore never needed.
> > + */
> 
> This explanation belongs to the commit message not to the source code.
> 
Hey Christophe,

Sure i'll move this and rest ahead.

[...]
> > diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> > index 6f6801da9dc1..44115f904c2c 100644
> > --- a/arch/powerpc/kernel/cputable.c
> > +++ b/arch/powerpc/kernel/cputable.c
> > @@ -36,8 +36,8 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
> >   	t = PTRRELOC(t);
> >   	/*
> > -	 * use memcpy() instead of *t = *s so that GCC replaces it
> > -	 * by __memcpy() when KASAN is active
> > +	 * use memcpy() instead of *t = *s so that the compiler replaces it
> > +	 * by __asan_memcpy() when KASAN is active
> >   	 */
> 
> Does the initial problem still exist with the new __asan_memcpy() approach ?
> If not the comment should be removed.
> 
Hey Christophe,

Thanks for pointing it out, i took a deeper look into this, here's my
understanding on it.

On PowerPC during very early boot the kernel is loaded by the
bootloader/firmware at some physical address, but the kernel was linked
expecting it to run at KERNELBASE(virtual address like
0xc000000000000000). The MMU mapping that makes that virtual address
valid hasn't been set up yet. So far for a window of early boot, code is
executing at the physical load address while all symbol addresses in the
binary refer to the virtual linked address. reloc_offset() computes the
gap between these two and PTRRELOC applies it to any pointer.

So PTRRELOC(&the_cpu_spec) gives the physical address where the struct
actually lives in memory right now, not where the linker thinks it lives.

Why *t = *s would be wrong?

In set_cur_cpu_spec:

struct cpu_spec *t = &the_cpu_spec;  // linked (virtual) address
t = PTRRELOC(t);                     // physical address — where it actually is
memcpy(t, s, sizeof(*t));            // copy into the right place

If you wrote *t = *s instead, the compiler generates a struct assignment.
For a large struct like cpu_spec, GCC is free to implement that however
it likes — including emitting a call to memcpy(). But crucially, a 
compiler-generated memcpy call resolves through the GOT/PLT or direct
symbol — which points to the linked virtual address of memcpy, not the
physical address. At this point in boot, calling through the wrong
address would jump to garbage or an unmapped page.

memcpy(t, s, sizeof(*t)) written explicitly is different: t is already
the corrected physical address, s points into the cpu_specs table which
has also been PTRRELOC'd. The explicit call goes through the normal
early-boot call mechanism which is safe.

The original comment said:

"use memcpy() instead of *t = *s so that GCC replaces it by __memcpy()
when KASAN is active"

This was added because under the old KASAN scheme
(!CC_HAS_KASAN_MEMINTRINSIC_PREFIX), KASAN overrode the memset/memcpy
linker symbols globally with C wrappers that called kasan_check_range().
If the compiler turned *t = *s into an implicit memcpy(), that would hit
the KASAN wrapper — calling kasan_check_range() at a point in early boot
where the KASAN shadow isn't mapped yet, causing a crash.

Writing memcpy(t, s, sizeof(*t)) explicitly made GCC emit __memcpy()
(the raw assembly alias exposed by _GLOBAL_KASAN) instead of the
KASAN-wrapped memcpy(), bypassing the shadow check.

That was the secondary reason. The primary reason that t is a
PTRRELOC-adjusted physical pointer and the copy must go through it
correctly was never stated.

So the KASAN comment is not required but i think we still need to state
why memcpy is required. For PTRRELOC adjustment, comment should reflect
that.

I'll update the comment and commit message and send out a new version.

Regards,
Mukesh

