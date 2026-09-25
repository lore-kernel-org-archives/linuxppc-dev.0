Return-Path: <linuxppc-dev+bounces-28173-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FC6C9830D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 06:36:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrgwP5cLnz2y2J;
	Fri, 25 Sep 2026 16:36:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790318213;
	cv=none; b=RZ8HanID0ANNQkChIc004ScjaL419HkYeDEOw9IMZVaWroMuHNIIchrni3vsMxqzADfixQv3Bbu0v5uuUNXMf51AzwSOPynlWDl3zklPgC1dSaUt1uxjp/RjU85mSpDsGN/VZEF1nUAwnUotHW9ikk8Dx72341Q8tIimK4qbWUDYE4LHlAVBne07PoqQ5q4vizY8RUBZlmvSTgFsehmk+QAWm1MPCZmbKq3MNk6ZQirfvN7WPDYvLMTJu+Q/kOHPK9FhrddKOvGgvDuAWSTmkMGy6ej9ZbgJj3e6J3UfkkYfj9fs/fCUXITvFKW1l5DEs1I7pxwEM6JEreH5LMgl+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790318213; c=relaxed/relaxed;
	bh=GkZl7SRHY1wbGx3TBWUhC4BzBN19cLafsEXyXuI3yfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyo/zqTB2rgcpiM7pmICgI4J+xge2b/PgvrbM3JT6OtCK9RgKWrZ5GCMSjHTc3t8rlrrYUaxtg9R83KTw4CLGN/VoeYn4r6jEKPThQPvfuE9p4uP1NbqMSYKnX9nnYPkI7x3qB9QHscYGaHK5d/9VjczwL5K6U2oVgI8X2N4jgc5TYjW7wQ07yedUhnR5cbjpqzKdNCDQKwLUtFlrFJS9JnlNUcTpkzrzGS5YKOOHqQq3Wy0QiBXDzzM6K6LCuzSAiDMj5BEP6qpTxqM8l/ECEBfFsCDOsKii0t6/6f2MmGBL6KKY8Ob6njdZcN+rSd1LSgi9yHBzsNrQz+nbiGH9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FXQwNiuV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FXQwNiuV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0f.google.com (mail-dy2-x0f.google.com [IPv6:2607:f8b0:4864:36::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrgwN6sckz2xnS
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 16:36:52 +1000 (AEST)
Received: by mail-dy2-x0f.google.com with SMTP id 5a478bee46e88-33bfb26865fso410897eec.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 23:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790318210; x=1790923010; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GkZl7SRHY1wbGx3TBWUhC4BzBN19cLafsEXyXuI3yfg=;
        b=FXQwNiuV8LmGgfR6gnlvwoQhoyGAiD6A/kkCYPm1X9vkpskO8mG9Vm32uyGAcVGfqm
         E6cKk203Y0SN48/Ll8N4nfN2/X5ioHL8X1LEEXk9eocwV+mGvLM0p8h/wwsvS5jw9IPA
         J3Lf38e4waGHsavIqzu1LkiQK/IH3w+J+PCdh/O14EQp5jCABP+AnQhUJSs0IdWqZueO
         I0a4DHX25gJnRX0sz59Ow0ryv5/YHsjpehzcj4DSi/pD9qacWZFza4O5udjRHDpsY4K9
         A5pXKrkUDNnrs9FEXYBNTk5DaLftF+h1yAuv5e6UNVyBGlOLkP/79FiDnnmrecNVKI2l
         +fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790318210; x=1790923010;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GkZl7SRHY1wbGx3TBWUhC4BzBN19cLafsEXyXuI3yfg=;
        b=oNSsHwunt5AKqaSrhMFKYB1GNLDp3We0tSV+TLixG6WUuu5wvq+xq4OkRdic5jYNNe
         HvaEALoe2068ntviic7xlW4L/KyQ5k+h8lg1J9ZjxN5ID6NPlwFIFp1K+VUQGwMNb2bB
         hTfKjpClQLl5LXrU9KkY4QDiMFezK8+XBPG88dw2g62m6AesV0HpT9qhZXk7T2w+bzoP
         mkj0q3/DFtuN43Cms1L2KrSMB3PEi0TGpQpbmkwR9QPFHtsmrzMKUlD9SKIkus6zpbj+
         pLrTlQ56zHPde7TUx0qkCQ8GnTyo1a8l6nUBb/SNuP04kg3xk9O48Rm7LX4Zk10z55L3
         yvZw==
X-Forwarded-Encrypted: i=1; AKwUvBx+DtqpfCPZbiGMkrVrPZpfmKjBvX2gJa0OtS8+h24ZzoJGBtT+7Y3fPBzqd9RSDhjoyhfTXkd71xbwGVY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mYlydLF6gTBd4lDuYxfuitOcAzjbP9z/jwj6g/QssLZuqbFbGu
	3UNZc7vdxPvspLbD2oWYHk37/sb3alO0/qBhsKfJI4xulVy+7GGDQu93
X-Gm-Gg: AYBFou051fMDW/Y5wjExopHMMoO2eQc+A8r7vTFFtdyVF2/sYwEmZL0KuA+M0i+9Ugc
	THTNWQeY2fCqskmcVYEi2YztZoaSK5S38bV0UPxMdDnT2SYlyZ+Ym6gprIR2BpMr+midtLiNCjs
	mJj60B8UWxwIuCkSAYW3uU7kvtLabripmDBKdgyiAIJOOkgC0A8DTda8IlFK6AKWR9aIvgW3MHC
	GPmpJ7KCQBqm1BZidG5I+2EYt0flRb3K9051OW0/HLFecwStGJ0M/KI9Gs4+cnb5d+zIpNmFBfN
	kWNEhLa8+oY67H/rV+W+pVH1eUqEOqE1fUuQIFNpcqh1r4wHsxXywzSkEOK/W2krcLBK69/kksA
	OUnjCXkgeE4P1wnOkKX17stNWdI8hWrQWQ1GXePME/2cDX6c2/7goumslJDHnr5aI4NThBdkDK5
	bUX4Yb5q7D5TrzCTirRduQ0I6KDhwDBuuQ1ebZ66RlOZzDz0GojJljLn5PES4HosoQc0oaALbZG
	vf9RzFJDPH7vqkXCev5kB0xniqGaSyCxvjJB4rVssXr
X-Received: by 2002:a05:7301:160a:b0:33b:dc33:7f98 with SMTP id 5a478bee46e88-340db4b9d18mr2352154eec.14.1790318209994;
        Thu, 24 Sep 2026 23:36:49 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145727589sm3789127eec.23.2026.09.24.23.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 23:36:49 -0700 (PDT)
Date: Fri, 25 Sep 2026 12:06:28 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, catalin.marinas@arm.com, 
	will@kernel.org, mark.rutland@arm.com, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, 
	daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, 
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, jszhang@kernel.org, japo@linux.ibm.com, jpoimboe@kernel.org, 
	seanjc@google.com, pmladek@suse.com, thuth@redhat.com, ynorov@nvidia.com, 
	joelagnelf@nvidia.com, david@davidgow.net, fujita.tomonori@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [RFC] rust: kernel: Add KUnit tests for ARCH_WARN_ASM bug table
 emission
Message-ID: <arYWDWmMJgIAt1_W@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260922054959.955093-2-mkchauras@gmail.com>
 <20260922064735.GS4121339@noisy.programming.kicks-ass.net>
 <arNxAn7I7NCVWmD1@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <20260924111557.GP1837346@noisy.programming.kicks-ass.net>
 <20260924151335.18402A8b-hca@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924151335.18402A8b-hca@linux.ibm.com>

On Thu, Sep 24, 2026 at 05:13:35PM +0200, Heiko Carstens wrote:
> On Thu, Sep 24, 2026 at 01:15:57PM +0200, Peter Zijlstra wrote:
> > Untested thingies for arm64 and s390x.
> ...
> > diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
> > index b6ba4465f59d..8bbb082fd5e3 100644
> > --- a/arch/s390/kernel/traps.c
> > +++ b/arch/s390/kernel/traps.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/entry-common.h>
> >  #include <linux/kmsan.h>
> >  #include <linux/bug.h>
> > +#include <linux/uaccess.h>
> >  #include <asm/entry-percpu.h>
> >  #include <asm/asm-extable.h>
> >  #include <asm/irqflags.h>
> > @@ -55,7 +56,12 @@ static inline void __user *get_trap_ip(struct pt_regs *regs)
> >  #ifdef CONFIG_GENERIC_BUG
> >  int is_valid_bugaddr(unsigned long addr)
> >  {
> > -	return 1;
> > +	u16 insn;
> > +
> > +	if (get_kernel_nofault(insn, (u16 *)addr))
> > +		return 0;
> > +
> > +	return insn == 0x0001 || insn == 0x000e;
> 
> I have no idea why anybody wants to do this, but it looks like I'm not
> alone :) In any case: the check is wrong.
> s390 uses only the monitor call instruction and this should be
> 
> 	return insn == 0xaf00;
> 
> At least it is not possible to set a kprobe on bug instructions, which
> would make this "interesting".

Hey Heiko,

should i send this out along with ppc. I am not paricularly very good
with s390's assembly, but if this looks correct to you, i can send it
out.

Regards,
Mukesh

