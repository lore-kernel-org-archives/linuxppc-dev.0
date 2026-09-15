Return-Path: <linuxppc-dev+bounces-27292-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F03C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 06:05:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkWhR2Z1Wz2yFW;
	Tue, 15 Sep 2026 16:05:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789452311;
	cv=none; b=O+RDriB0a7Syz3bIeZrLPoxiL5zf4ihb3A3T1sdfD5NcmJRTzDDU2V/AWwyvQ2x6H+d1jCOS+ptKLyAAR+u9jt7XbAaawAmOUSTrAz/zBzuGPjBYNZ2jveDJCJB/ehbBex95pU29mnJ96dAYU1myV3rgSaW8Cwj4PSTnNFshgOQqrGGP1SFtSQBvHmpxsADK70M5hFRWn97XvnlaSw30SQSJVGiLhoZgXDZ2IfFvrLBtPeOzs+EyoQ3uPdxFEhSpestNbkBHRflw+WSfKoL7WsGYfxBDlbivnDdoeSSVacDP9gJj6vrqYK8kocjwSk6QnFaUEazkC2aFT108yAtTJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789452311; c=relaxed/relaxed;
	bh=IiTPck6bjeGRRCtyg1j/NLgfFWRzUbzwsyl4vwTkvY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nw2rwsHMzi5lKvtddh30TA3q4afpGp+uCsXrPIeTOsp1TzD4R6Y8+sSJDyYVbXyZQVoRofTKXODdPWzKH/JDwyrXChPzlsQlZ2SlHH8qXmBW21UB+8tZ+USXTATbI70HvOD061En1I8Q0XnjJE/sv9RwAUBdChElOQxDoZSN9UEocbQOMi9uu6O3R9IuEGa586JZHdxjFjmfQnOP1UozzsfpSLlK7DM7xcl8ESaiqkP1aPQUc/IQCF0MipIa1dYZ+2fn4ujkwA4PGHJWzJH7MMt/DPc/gsaZ6xQPCd04yib6BHTa9o5j3jPwqrAonnXAXjyZccIdSgNMT7ZjYH0gUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rHFI2iOa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rHFI2iOa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkWhP2XXFz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 16:05:08 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2d90ba1d807so38499575ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 23:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789452306; x=1790057106; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IiTPck6bjeGRRCtyg1j/NLgfFWRzUbzwsyl4vwTkvY0=;
        b=rHFI2iOaH0d4QsUcuDDYbqfJW9mQnVqKW2T/FK47+HXcPluz3WMUOQKSCklY3f9MK1
         X2FNyhxCJMnmXG/7FRy/tNDuv5UTtH168BEuXJEiH31MndbsgnyTbDVLe7vq4kY6mmsj
         aHT2HFbIbt7dltAG/oPsKi2lNcncFL7iQp09mbmUv33kkFpJnh57CHZBP1Hg0GufGjKL
         0JpMpFYPT1N/+yCEZPbxvNttpgvZ76c2szUn3gbcvuVSoFOLRLjxtPUp6QYiiI3V3Uf1
         RTv0TDQXsRrPgahK7NEjJ8k26M1rI82o2PfozF0X0z/6pr7iknV9bspOLutqnUb3Qt4a
         YKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789452306; x=1790057106;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IiTPck6bjeGRRCtyg1j/NLgfFWRzUbzwsyl4vwTkvY0=;
        b=vU9f1MOna72J1hzOu+b/0Uglo6TOlNmFRFWhx0oA1yZgT3KxtgLHH8AD56jEmJG1Z+
         sEe9zUfqGfdFErZOzSkSZwbZ8K0c9ZIe34ZsQgfTMCwwcj6buosWP9d6vJbiVl5S4ICU
         PtqtUV0Gf0USt0kg61YArrhYbaszU1d2kLyQar6435MXcLHOEECf44T1xN6gtXtYIgOO
         PEliRWm/bWDOkYWkehsTBcf2ugPqu/jxYqJ/lPd1RXif5/ZwWNSFbW70g3gUf7NVdyAS
         aR+N9TmoRL5Nvr3sr46jX9A0I7M50Vj+ivkKYDv7jPogOIYHeuF4mUMS3QjRvKkH/SoV
         +bFw==
X-Forwarded-Encrypted: i=1; AKwUvBwfobN6P0SElH+LgjD1vByEur1DOJDp8FN4PQqaS+Rt8x/5o8cmt3UBMrVU1kB/umtHVkLCtQwBT+H5eW8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n6VsMo/jX46EIOLn23gI3KZak/6NmAWYNG4vGzQniIoE09hS48
	dIGmi4Z25t+oRd2RbxreLcyXYiHiS8BJ05PtJf1AaxXVNdizW1RWvnB6
X-Gm-Gg: AYBFou3QwZHjGcgg4tnunR7MX80+Lk2T7xTQtMM2TlcvoRSdzxJrE829nS+YVIrc2w7
	7S/P2rJR9qjDvRaD/IRm2s4P+bUpcmN7T+X8a+8QRaQiwDyjV8pItbBU7CNgY8DKwKhfFanKKvI
	8Rt95k/PBJlCpv6A6JeXVeplGvcHayQ+C7viLjmDJ7hRdMLknlTHS4dQW55kVggcYqIlY/WN3Y+
	o1HYaJ6MEWzbTTdVrKh3/nIVamleVQGriFGLamTk1nU1FtJyTvFDDOp30BNz5N6I0Km5rnVQzlO
	c3TUXLMKRkGAXsn+nJWFu9yHfEH9v0z/Uc9WHNG0EHsUVR7CEHY7Ynak0qBQS8aqL10J4uQrhw5
	mV4iCtd5PYYBScXrfIdVKynn5YnrDA59yGGjLh2RjacBxVjjZ5c7dz8tQ6O33TbjES9KlZ0vKMl
	bNEISyEZfzehMFDx+k3bA8wi5tAZiIs+aWbJOshkjUgzYpd/inb88NbFGEMbgF8VnKRpz1v5Co8
	d/XEPSmKUMzO8pprCQC5WIhI8Jn3yWIkG10vp4oE97H
X-Received: by 2002:a17:90b:1c90:b0:39d:f660:fa9c with SMTP id 98e67ed59e1d1-39df660fademr8118240a91.10.1789452306215;
        Mon, 14 Sep 2026 23:05:06 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfd9bb4basm2994065a91.3.2026.09.14.23.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 23:05:05 -0700 (PDT)
Date: Tue, 15 Sep 2026 11:34:43 +0530
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
Message-ID: <aqjfwrSg5kf9tf4F@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260908064948.999530-1-mkchauras@gmail.com>
 <b3b1fa5a-c836-447f-a658-ad66183c23c5@kernel.org>
 <aqOrCdvUB5lFjNsS@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <2dedc7a9-95f5-4a7f-8d38-6b9351db402f@kernel.org>
 <3d327595-791c-4a7a-ae65-afae80c9c848@kernel.org>
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
In-Reply-To: <3d327595-791c-4a7a-ae65-afae80c9c848@kernel.org>

On Sat, Sep 12, 2026 at 08:53:16PM +0200, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 12/09/2026 à 19:35, Christophe Leroy (CS GROUP) a écrit :
> > Hi Mukesh,
> > 
> > Le 11/09/2026 à 19:39, Mukesh Kumar Chaurasiya a écrit :
> > > 
> > > [...]
> > > > > diff --git a/arch/powerpc/kernel/cputable.c
> > > > > b/arch/powerpc/kernel/ cputable.c
> > > > > index 6f6801da9dc1..44115f904c2c 100644
> > > > > --- a/arch/powerpc/kernel/cputable.c
> > > > > +++ b/arch/powerpc/kernel/cputable.c
> > > > > @@ -36,8 +36,8 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
> > > > >        t = PTRRELOC(t);
> > > > >        /*
> > > > > -     * use memcpy() instead of *t = *s so that GCC replaces it
> > > > > -     * by __memcpy() when KASAN is active
> > > > > +     * use memcpy() instead of *t = *s so that the compiler
> > > > > replaces it
> > > > > +     * by __asan_memcpy() when KASAN is active
> > > > >         */
> > > > 
> > > > Does the initial problem still exist with the new
> > > > __asan_memcpy() approach ?
> > > > If not the comment should be removed.
> > > > 
> > > Hey Christophe,
> > > 
> > > Thanks for pointing it out, i took a deeper look into this, here's my
> > > understanding on it.
> > > 
> > > On PowerPC during very early boot the kernel is loaded by the
> > > bootloader/firmware at some physical address, but the kernel was linked
> > > expecting it to run at KERNELBASE(virtual address like
> > > 0xc000000000000000). The MMU mapping that makes that virtual address
> > > valid hasn't been set up yet. So far for a window of early boot, code is
> > > executing at the physical load address while all symbol addresses in the
> > > binary refer to the virtual linked address. reloc_offset() computes the
> > > gap between these two and PTRRELOC applies it to any pointer.
> > > 
> > > So PTRRELOC(&the_cpu_spec) gives the physical address where the struct
> > > actually lives in memory right now, not where the linker thinks it lives.
> > > 
> > > Why *t = *s would be wrong?
> > > 
> > > In set_cur_cpu_spec:
> > > 
> > > struct cpu_spec *t = &the_cpu_spec;  // linked (virtual) address
> > > t = PTRRELOC(t);                     // physical address — where it
> > > actually is
> > > memcpy(t, s, sizeof(*t));            // copy into the right place
> > > 
> > > If you wrote *t = *s instead, the compiler generates a struct assignment.
> > > For a large struct like cpu_spec, GCC is free to implement that however
> > > it likes — including emitting a call to memcpy(). But crucially, a
> > > compiler-generated memcpy call resolves through the GOT/PLT or direct
> > > symbol — which points to the linked virtual address of memcpy, not the
> > > physical address. At this point in boot, calling through the wrong
> > > address would jump to garbage or an unmapped page.
> > > 
> > > memcpy(t, s, sizeof(*t)) written explicitly is different: t is already
> > > the corrected physical address, s points into the cpu_specs table which
> > > has also been PTRRELOC'd. The explicit call goes through the normal
> > > early-boot call mechanism which is safe.
> > > 
> > > The original comment said:
> > > 
> > > "use memcpy() instead of *t = *s so that GCC replaces it by __memcpy()
> > > when KASAN is active"
> > > 
> > > This was added because under the old KASAN scheme
> > > (!CC_HAS_KASAN_MEMINTRINSIC_PREFIX), KASAN overrode the memset/memcpy
> > > linker symbols globally with C wrappers that called kasan_check_range().
> > > If the compiler turned *t = *s into an implicit memcpy(), that would hit
> > > the KASAN wrapper — calling kasan_check_range() at a point in early boot
> > > where the KASAN shadow isn't mapped yet, causing a crash.
> > > 
> > > Writing memcpy(t, s, sizeof(*t)) explicitly made GCC emit __memcpy()
> > > (the raw assembly alias exposed by _GLOBAL_KASAN) instead of the
> > > KASAN-wrapped memcpy(), bypassing the shadow check.
> > > 
> > > That was the secondary reason. The primary reason that t is a
> > > PTRRELOC-adjusted physical pointer and the copy must go through it
> > > correctly was never stated.
> > > 
> > > So the KASAN comment is not required but i think we still need to state
> > > why memcpy is required. For PTRRELOC adjustment, comment should reflect
> > > that.
> > > 
> > > I'll update the comment and commit message and send out a new version.
> > 
> > Explanation based on kernel v5.10
> > 
> > The problem was not linked to PTRRELOC, the t = PTRRELOC(t) followed by
> > *t = *s works well in term of adressing, regardless of whether
> > CONFIG_KASAN is enabled or not.
> > 
> > The problem is that with *t = *s, gcc emits a call to memcpy(). When
> > CONFIG_KASAN is enabled, memcpy() is instrumented. But we don't want
> > cputable.o instrumented as we have KASAN_SANITIZE_cputable.o := n in
> > Makefile.
> > 
> > In asm/string.h we have:
> > 
> > #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
> > /*
> >   * For files that are not instrumented (e.g. mm/slub.c) we
> >   * should use not instrumented version of mem* functions.
> >   */
> > #define memcpy(dst, src, len) __memcpy(dst, src, len)
> > #define memmove(dst, src, len) __memmove(dst, src, len)
> > #define memset(s, c, n) __memset(s, c, n)
> > 
> > Because in non-instrumented files like cputable.o we want memcpy() to be
> > replaced at buildtime by __memcpy() to skip KASAN instrumentation. But
> > this is resolved by pre-processing, and pre-processor doesn't know that
> > the compiler will emit a call to memcpy().
> > 
> > By replacing *t = *s by the memcpy(), the pre-processor replaces
> > memcpy() by __memcpy() when CONFIG_KASAN is enabled.
> > 
> > See the difference:
> > 
> > This is v5.10
> > 
> > 00000000 <set_cur_cpu_spec>:
> >     0:    94 21 ff e0     stwu    r1,-32(r1)
> >     4:    7c 69 1b 78     mr      r9,r3
> >     8:    bf c1 00 18     stmw    r30,24(r1)
> >     c:    3f e0 00 00     lis     r31,0
> >              e: R_PPC_ADDR16_HA    .data..read_mostly
> >    10:    3b ff 00 00     addi    r31,r31,0
> >              12: R_PPC_ADDR16_LO    .data..read_mostly
> >    14:    7c 08 02 a6     mflr    r0
> >    18:    7d 3e 4b 78     mr      r30,r9
> >    1c:    7f e3 fb 78     mr      r3,r31
> >    20:    90 01 00 24     stw     r0,36(r1)
> >    24:    48 00 00 01     bl      24 <set_cur_cpu_spec+0x24>
> >              24: R_PPC_REL24    add_reloc_offset
> >    28:    7f c4 f3 78     mr      r4,r30
> >    2c:    38 a0 00 58     li      r5,88
> >    30:    48 00 00 01     bl      30 <set_cur_cpu_spec+0x30>
> >              30: R_PPC_REL24    __memcpy
> >    34:    38 7f 00 58     addi    r3,r31,88
> >    38:    48 00 00 01     bl      38 <set_cur_cpu_spec+0x38>
> >              38: R_PPC_REL24    add_reloc_offset
> >    3c:    93 e3 00 00     stw     r31,0(r3)
> >    40:    80 01 00 24     lwz     r0,36(r1)
> >    44:    83 c1 00 18     lwz     r30,24(r1)
> >    48:    83 e1 00 1c     lwz     r31,28(r1)
> >    4c:    7c 08 03 a6     mtlr    r0
> >    50:    38 21 00 20     addi    r1,r1,32
> >    54:    4e 80 00 20     blr
> > 
> > This is v5.10 with commit adcf59187e270 reverted:
> > 
> > 00000000 <set_cur_cpu_spec>:
> >     0:    94 21 ff e0     stwu    r1,-32(r1)
> >     4:    7c 69 1b 78     mr      r9,r3
> >     8:    bf c1 00 18     stmw    r30,24(r1)
> >     c:    3f e0 00 00     lis     r31,0
> >              e: R_PPC_ADDR16_HA    .data..read_mostly
> >    10:    3b ff 00 00     addi    r31,r31,0
> >              12: R_PPC_ADDR16_LO    .data..read_mostly
> >    14:    7c 08 02 a6     mflr    r0
> >    18:    7d 3e 4b 78     mr      r30,r9
> >    1c:    7f e3 fb 78     mr      r3,r31
> >    20:    90 01 00 24     stw     r0,36(r1)
> >    24:    48 00 00 01     bl      24 <set_cur_cpu_spec+0x24>
> >              24: R_PPC_REL24    add_reloc_offset
> >    28:    7f c4 f3 78     mr      r4,r30
> >    2c:    38 a0 00 58     li      r5,88
> >    30:    48 00 00 01     bl      30 <set_cur_cpu_spec+0x30>
> >              30: R_PPC_REL24    memcpy
> >    34:    38 7f 00 58     addi    r3,r31,88
> >    38:    48 00 00 01     bl      38 <set_cur_cpu_spec+0x38>
> >              38: R_PPC_REL24    add_reloc_offset
> >    3c:    93 e3 00 00     stw     r31,0(r3)
> >    40:    80 01 00 24     lwz     r0,36(r1)
> >    44:    83 c1 00 18     lwz     r30,24(r1)
> >    48:    83 e1 00 1c     lwz     r31,28(r1)
> >    4c:    7c 08 03 a6     mtlr    r0
> >    50:    38 21 00 20     addi    r1,r1,32
> >    54:    4e 80 00 20     blr
> > 
> > So my question is ? Do we still have this issue nowadays ?
> 
> I now did the same test with v7.2 without and with adcf59187e270 reverted. I
> both cases I get memcpy().
> 
> Christophe

Oh I got it now. Thanks for the detailed explanation. Yeah the comment
is not required anymore.

I'll send out a V3.

Thanks and Regards,
Mukesh

