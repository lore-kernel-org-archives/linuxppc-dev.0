Return-Path: <linuxppc-dev+bounces-27964-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4A3C982EA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 06:28:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqRqj0NFgz2xs1;
	Wed, 23 Sep 2026 16:28:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790144912;
	cv=none; b=na9DyFivxgJZm5v4jLx9tPtVhT37Zq3gv2UzY5m4AILymCU2LEiEId5NlQJzMfcfAhHN3i8zWm9rNWeT5Pbw/KZUgD9hvzZoYIDsmm8eWZl85FjQJaqSz+RLfKzwcQ+BJgnpbjJzGZeiKtqGiWHbWtbP41A7jK8J6h/6A4xDIHA3eU6uEd7p6B5UzXFhsdKLRUneLXpakwSrOkMIYRYMOEDBXHcZLdqSaQet3nQaZFQDMOvspGOFWJxEsIG61pjrY6bZOo1L1PkY1Gl4sd2mX2bgRsSrkxHd8KrxEzNPhmzIzgrZOn6HH+0LNCZwmNh4D+De2nLXLdYt2AF34NHV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790144912; c=relaxed/relaxed;
	bh=2hUFOEJST1qHgvJkQDivOVNilsD3f7PYYgSWMm8/mzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSdPpFaWsH6mVbH4fZPcGjuWM5CEIp/FnGgZkyGyKaXE5eJqA2tn5LsWZdU2KML9cnFqsi3UOH/7ziCJje5ej6vBFWMVAe/yIORgMlm5aRpuj4WRuYpoDXyjtuH5ye/Xdq138BJGvmmsvHPQte2EUFHY1nPdgSChUpZqH3pjq1L8TNeIafBRJ2mF6CKMM4/vxZg7CaTkFUESohiXgFwJDR8upZSkJNF6+eB6ZLvVrgYfDz93WhRwBN/TJ5tpF8R+gzAngUIvZ9is+EuNG8nY3U2m2SVWgS/Y+v3cU7m1QRXE/GbJaD1gplVVDq8fK2I+azZUxL4altuA3uTk7f70WQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TONZtmUZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::10; helo=mail-dy2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TONZtmUZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::10; helo=mail-dy2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x10.google.com (mail-dy2-x10.google.com [IPv6:2607:f8b0:4864:36::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqRqh1xnTz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 16:28:32 +1000 (AEST)
Received: by mail-dy2-x10.google.com with SMTP id 5a478bee46e88-328664c1479so342751eec.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 23:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790144910; x=1790749710; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2hUFOEJST1qHgvJkQDivOVNilsD3f7PYYgSWMm8/mzk=;
        b=TONZtmUZqGnmDtSMtjH71UAMK4LiFimTEAh7S7vDRWWazWl74MfQWiqnnfFX+q+/av
         UQjiyce5QWsnlkKIrU/Ujnfv60k7TnkvUliOHxnpGr4mWikU37TgS6r62v8tOdBXlWEF
         MxIF1hH0m37R3G/EunIGclPMeVOvSebqtRzG6gczeGJoqsQ+Lz6Ite/eKWnbX8YPFcBD
         CroOo91pLaqIW/f+TwNYrNmVmDZB4e2zlY7pcSR8uKjYiYuMMVRO7F2xFmw2KWQzJ0zr
         JEK8HLk4sAmil7y2l9dZQjnOgB/UlSOEQY46vCK8fc2dCPN6DQSx1Oe3aW391iIu8q2w
         XQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790144910; x=1790749710;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2hUFOEJST1qHgvJkQDivOVNilsD3f7PYYgSWMm8/mzk=;
        b=NI5iomMIevDUImr1fAx7GI5bJTpdj1BnsSvOSFljbPM1WjeXFX21I7EvBh2HE1wWtU
         UkMSraA3qmLR7sMPB4bP0HLPzKoetD3C/bW92ifOnUlqdpbxO0f/R7KUiqRKJUEFCB44
         qLwGPcMbdod4DonhnXYeNZFQGcZZ9U+BJLGSdvXQYWpiDd6CchzWhXLlIWpGJEssbetn
         YPKImn3ZeS6h8gwkrrOdKFQ2+eqTiVXs0EpnRszV8H1AgNIvXzSv+lC6no9waM+Z44a9
         7a0NMzPm+cucdv2b34EDRejcbRVuWt93SCDLAl3Dh7RgTgG2iHZhC9Nvk19REg0i28L1
         NA+w==
X-Forwarded-Encrypted: i=1; AKwUvBxUGCPqfILYjQbLAiIrp2GBmscmVTrL/WJDv5gi0mPdzLyjnkhFqdpzFXn4CqhAAu0gcw6fKvxTDFF5R9w=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m9Q/5InqVg83mEGqKpD9VBgCrwmdIChRAzngqK1ddedANmHEt9
	hWq/dVCzCx7B4v77JTXUC1phAoV2SGNGwCileiXNRH+d6iEKn8LGTnNf
X-Gm-Gg: AYBFou0KQupsvpvgLFgDbJCXAy7Z80b0DZ4yS2Rm2bq/Cqi9cxhXeUI9m7T21jUremx
	VjnDgnaCo9Q/WghaybXAlaVRKSgc1NgPrhjM3lfFKyeZ4SEwgBh6kCkH3q6ddYgmPFrnmn9NEqu
	Hx6o7sg0BZshUqygbnoz6GYc3AeOcS8o2dAqgyAQ2CdVROmdhU4l6PuNGYt3h6PvMkf2W8++JtN
	CsYU++TGv2YAGmMZT/YNrSdibxvUr3OXV5NToCEzzqS6EeYf2DDpsWFylMXD7XNOh0TETKJ5wPE
	p93mLqNPA3f1wPlehXwGDIN0XvYtQm2E/I1cWNtUTVHliAhGplL2K0ocxoGFsA+IZHxQRu3kgZQ
	ZJV3cuLCfFjri7EQ3x/4dqj6KX6Rx6/AnjsHMnvOyarQ+fN2wB539B3cMletugReLEdaA7CrpLX
	fV/BjLFT72g0VY1US0M+97zYJPmTAomf9aCx5Y9RhyMnsDyJqqMdpyPA+DtGDKRC2Nw92y6VfYw
	WkPHbib7b39xljM48jwQj/1pCvqKXpM78NHZUKbSwOfmNQn9rdhTA==
X-Received: by 2002:a05:7301:3a86:b0:33e:5c4f:f46e with SMTP id 5a478bee46e88-33e8d8d2598mr1603719eec.30.1790144909601;
        Tue, 22 Sep 2026 23:28:29 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e97236754sm3074867eec.29.2026.09.22.23.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:28:29 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:58:13 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org, 
	acourbot@nvidia.com, work@onurozkan.dev, nathan@kernel.org, ndesaulniers@google.com, 
	morbo@google.com, justinstitt@google.com, jszhang@kernel.org, japo@linux.ibm.com, 
	jpoimboe@kernel.org, seanjc@google.com, pmladek@suse.com, thuth@redhat.com, 
	ynorov@nvidia.com, joelagnelf@nvidia.com, david@davidgow.net, 
	fujita.tomonori@gmail.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [RFC] rust: kernel: Add KUnit tests for ARCH_WARN_ASM bug table
 emission
Message-ID: <arNxAn7I7NCVWmD1@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260922054959.955093-2-mkchauras@gmail.com>
 <20260922064735.GS4121339@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20260922064735.GS4121339@noisy.programming.kicks-ass.net>

On Tue, Sep 22, 2026 at 08:47:35AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 22, 2026 at 11:20:00AM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > Verify that the __bug_table entry emitted by ARCH_WARN_ASM has a correct
> > bug_addr displacement — i.e. the arch's trap label reference resolves to
> > the trap instruction — by calling find_bug() with the exact virtual address
> > of the trap, mirroring what the real trap handler does.
> > 
> > To support all architectures, each arch that implements ARCH_WARN_ASM now
> > defines ARCH_WARN_ASM_TRAP_LABEL, a string constant naming the local label
> > at which the trap instruction is placed:
> > 
> >   x86       "1"     (ud2 at label 1:)
> >   powerpc   "1"     (twi at label 1:)
> >   riscv     "1"     (ebreak at label 1:)
> >   arm64     "14471" (brk placed at 14471: by __BUG_ENTRY_END)
> >   s390      "0"     (mc at label 0:)
> > 
> > The label is used consistently: in ARCH_WARN_ASM itself, in the
> > bug_addr back-reference inside __BUG_ENTRY / _EMIT_BUG_ENTRY, 
> 
> 
> > diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
> > index 23ab05438269..6cca8880660e 100644
> > --- a/arch/x86/include/asm/bug.h
> > +++ b/arch/x86/include/asm/bug.h
> > @@ -62,8 +62,9 @@ extern void __WARN_trap(struct bug_entry *bug, ...);
> >  #define HAVE_ARCH_BUG_FORMAT_ARGS
> >  #endif
> >  
> > +#define ARCH_WARN_ASM_TRAP_LABEL "1"
> >  #define __BUG_ENTRY(format, file, line, flags)				\
> > -	"\t.long 1b - ."	"\t# bug_entry::bug_addr\n"		\
> > +	"\t.long " ARCH_WARN_ASM_TRAP_LABEL "b - ." "\t# bug_entry::bug_addr\n" \
> >  	__BUG_ENTRY_FORMAT(format)					\
> >  	__BUG_ENTRY_VERBOSE(file, line)					\
> >  	"\t.word " flags	"\t# bug_entry::flags\n"
> > @@ -101,7 +102,7 @@ do {									\
> >  	"99:\n"								\
> >  	"\t.string \"\"\n"						\
> >  	".popsection\n"							\
> > -	"1:\t " ASM_UD2 "\n"						\
> > +	ARCH_WARN_ASM_TRAP_LABEL ":\t " ASM_UD2 "\n"			\
> >  	_BUG_FLAGS_ASM("99b", file, line, flags, size, "")
> >  
> >  #else
> 
> Not really a fan of that. And I can't really tell what you're doing with
> it either. The kunit is in Rust and thus unreadable :-(
> 
> I would rather you fix up is_valid_bugaddr(), some architectures seem to
> have an always true stub because of the callchains always being from the
> break instruction.

Hey Peter,

thanks for the suggestion. I will fix up the is_valid_bugaddr for
powerpc. I am not very good with other archs asm but i can do it for
ppc32 and ppc64.

Regards,
Mukesh

