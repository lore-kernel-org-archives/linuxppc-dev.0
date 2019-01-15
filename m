Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4984C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 11:16:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD9A20657
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 11:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="SwjA/ixW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD9A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43f78P65g5zDqfG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 22:16:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::d41; helo=mail-io1-xd41.google.com;
 envelope-from=dvyukov@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="SwjA/ixW"; 
 dkim-atps=neutral
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43f76114kXzDqZy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 22:14:48 +1100 (AEDT)
Received: by mail-io1-xd41.google.com with SMTP id g8so1745482iok.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 03:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qsV+aqXVBvoYu4pL4QZpfvMi167TM8gOAx6NETd+SBM=;
 b=SwjA/ixW7FNY+NX5f46xAM5B3PubG5co1+eOpVbM9y2UCXzByTOzV/5dBCYSUP7eL7
 kkkIC7Vl3TuHao0CJbSzkfetOUm/CKmc9u4Gz3WWnVEBRnuW6uXGI2OQMiaN8N2r2FL+
 +jtO8sdGOSov5N4ZZdAS45Ivd5BJ+gCshu4G3Z7+kGx5H5iakFTG5il+BSCtWAYc8F1X
 S9g7e11ZjFCC5Chim2p+3UwQ6MmosH8X9LWKBRW6UofLIk7S9hbBFyhuJG4QC/X+RzWq
 uIZq1vmdw07F7UwXCYQXKkx5qGEnjpIFkRd570XpBMqdJWFLznEu39sLmZHZnJOJUVad
 U61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qsV+aqXVBvoYu4pL4QZpfvMi167TM8gOAx6NETd+SBM=;
 b=GGjcoOILfuSTI0TsOxwOPB3opoM2iLPJSCqi2xfCaSeM26aPfJylzJKy23Xuq3oL8s
 LXomC/CwNMvQhqAb+jWdWnP3bMhHgTcjVRYKvU0FJaBB9xfHBZ4E86jlHzbuoW8ou7on
 r5biVIA5OsrF/H5xcnpeL9N6JhbQJ/aEIn5cIPTjc6dpRa+zX0ugrDfTtCOv/fjYfJdQ
 KyM8GsI89vYic57ySIUo0k65hpYAeo2tlkA0gObk1fx6Vbs8bc/iaEcY/fu9LqL3xj5v
 HpKYMEsLejWS6ery8nedZNR6Tl0v1OJXmJC+5Se8vgCimcroD5vZGezcd42WsCLAeJCN
 NPUA==
X-Gm-Message-State: AJcUukfuOuN4B2fWwz1aGh7xpYPcfN6n53kiBQDfdIS2zD40VdjzzptD
 MRseNrhMWCuJLX/NKchxf/0e0aISlJCPp4lpyBWHUQ==
X-Google-Smtp-Source: ALg8bN5HZsOooPEZE4Ngupk4zGw6GRfDgO/Bqfsa0epv4ApaPxWfUPrOe2kzQOgDPc9sGgTpLsZEWkbUeb34lP3PkO0=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr1377869ior.282.1547550886384; 
 Tue, 15 Jan 2019 03:14:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547289808.git.christophe.leroy@c-s.fr>
 <0c854dd6b110ac2b81ef1681f6e097f59f84af8b.1547289808.git.christophe.leroy@c-s.fr>
 <CACT4Y+aEsLWqhJmXETNsGtKdbfHDFL1NF8ofv3KwvQPraXdFyw@mail.gmail.com>
 <801c7d58-417d-1e65-68a0-b8cf02f9f956@c-s.fr>
In-Reply-To: <801c7d58-417d-1e65-68a0-b8cf02f9f956@c-s.fr>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 15 Jan 2019 12:14:35 +0100
Message-ID: <CACT4Y+ZdA-w5OeebZg3PYPB+BX5wDxw_DxNe2==VJfbpy2eJ7A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] powerpc/mm: prepare kernel for KAsan on PPC32
To: Christophe Leroy <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: LKML <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Linux-MM <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>,
 kasan-dev <kasan-dev@googlegroups.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 15, 2019 at 8:27 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
>
> On 01/14/2019 09:34 AM, Dmitry Vyukov wrote:
> > On Sat, Jan 12, 2019 at 12:16 PM Christophe Leroy
> > <christophe.leroy@c-s.fr> wrote:
> > &gt;
> > &gt; In kernel/cputable.c, explicitly use memcpy() in order
> > &gt; to allow GCC to replace it with __memcpy() when KASAN is
> > &gt; selected.
> > &gt;
> > &gt; Since commit 400c47d81ca38 ("powerpc32: memset: only use dcbz once cache is
> > &gt; enabled"), memset() can be used before activation of the cache,
> > &gt; so no need to use memset_io() for zeroing the BSS.
> > &gt;
> > &gt; Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > &gt; ---
> > &gt;  arch/powerpc/kernel/cputable.c | 4 ++--
> > &gt;  arch/powerpc/kernel/setup_32.c | 6 ++----
> > &gt;  2 files changed, 4 insertions(+), 6 deletions(-)
> > &gt;
> > &gt; diff --git a/arch/powerpc/kernel/cputable.c
> > b/arch/powerpc/kernel/cputable.c
> > &gt; index 1eab54bc6ee9..84814c8d1bcb 100644
> > &gt; --- a/arch/powerpc/kernel/cputable.c
> > &gt; +++ b/arch/powerpc/kernel/cputable.c
> > &gt; @@ -2147,7 +2147,7 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
> > &gt;         struct cpu_spec *t = &amp;the_cpu_spec;
> > &gt;
> > &gt;         t = PTRRELOC(t);
> > &gt; -       *t = *s;
> > &gt; +       memcpy(t, s, sizeof(*t));
> >
> > Hi Christophe,
> >
> > I understand why you are doing this, but this looks a bit fragile and
> > non-scalable. This may not work with the next version of compiler,
> > just different than yours version of compiler, clang, etc.
>
> My felling would be that this change makes it more solid.
>
> My understanding is that when you do *t = *s, the compiler can use
> whatever way it wants to do the copy.
> When you do memcpy(), you ensure it will do it that way and not another
> way, don't you ?

It makes this single line more deterministic wrt code-gen (though,
strictly saying compiler can turn memcpy back into inlines
instructions, it knows memcpy semantics anyway).
But the problem I meant is that the set of places that are subject to
this problem is not deterministic. So if we go with this solution,
after this change it's in the status "works on your machine" and we
either need to commit to not using struct copies and zeroing
throughout kernel code or potentially have a long tail of other
similar cases, and since they can be triggered by another compiler
version, we may need to backport these changes to previous releases
too. Whereas if we would go with compiler flags, it would prevent the
problem in all current and future places and with other past/future
versions of compilers.


> My problem is that when using *t = *s, the function set_cur_cpu_spec()
> always calls memcpy(), not taking into account the following define
> which is in arch/powerpc/include/asm/string.h (other arches do the same):
>
> #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
> /*
>   * For files that are not instrumented (e.g. mm/slub.c) we
>   * should use not instrumented version of mem* functions.
>   */
> #define memcpy(dst, src, len) __memcpy(dst, src, len)
> #define memmove(dst, src, len) __memmove(dst, src, len)
> #define memset(s, c, n) __memset(s, c, n)
> #endif
>
> void __init set_cur_cpu_spec(struct cpu_spec *s)
> {
>         struct cpu_spec *t = &the_cpu_spec;
>
>         t = PTRRELOC(t);
>         *t = *s;
>
>         *PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
> }
>
> 00000000 <set_cur_cpu_spec>:
>     0:   94 21 ff f0     stwu    r1,-16(r1)
>     4:   7c 08 02 a6     mflr    r0
>     8:   bf c1 00 08     stmw    r30,8(r1)
>     c:   3f e0 00 00     lis     r31,0
>                          e: R_PPC_ADDR16_HA      .data..read_mostly
>    10:   3b ff 00 00     addi    r31,r31,0
>                          12: R_PPC_ADDR16_LO     .data..read_mostly
>    14:   7c 7e 1b 78     mr      r30,r3
>    18:   7f e3 fb 78     mr      r3,r31
>    1c:   90 01 00 14     stw     r0,20(r1)
>    20:   48 00 00 01     bl      20 <set_cur_cpu_spec+0x20>
>                          20: R_PPC_REL24 add_reloc_offset
>    24:   7f c4 f3 78     mr      r4,r30
>    28:   38 a0 00 58     li      r5,88
>    2c:   48 00 00 01     bl      2c <set_cur_cpu_spec+0x2c>
>                          2c: R_PPC_REL24 memcpy
>    30:   38 7f 00 58     addi    r3,r31,88
>    34:   48 00 00 01     bl      34 <set_cur_cpu_spec+0x34>
>                          34: R_PPC_REL24 add_reloc_offset
>    38:   93 e3 00 00     stw     r31,0(r3)
>    3c:   80 01 00 14     lwz     r0,20(r1)
>    40:   bb c1 00 08     lmw     r30,8(r1)
>    44:   7c 08 03 a6     mtlr    r0
>    48:   38 21 00 10     addi    r1,r1,16
>    4c:   4e 80 00 20     blr
>
>
> When replacing *t = *s by memcpy(t, s, sizeof(*t)), GCC replace it by
> __memcpy() as expected.
>
> >
> > Does using -ffreestanding and/or -fno-builtin-memcpy (-memset) help?
>
> No it doesn't and to be honest I can't see how it would. My
> understanding is that it could be even worse because it would mean
> adding calls to memcpy() also in all trivial places where GCC does the
> copy itself by default.

The idea was that with -ffreestanding compiler must not assume
presence of any runtime support library, so it must not emit any calls
that are not explicitly present in the source code. However, after
reading more docs, it seems that even with -ffreestanding gcc and
clang still assume presence of a runtime library that provides at
least memcpy,  memmove, memset and memcmp. There does not seem to be a
way to prevent clang and gcc from doing it. So I guess this approach
is our only option:

Acked-by: Dmitry Vyukov <dvyukov@google.com>

Though, a comment may be useful so that a next person does not try to
revert it back.


> Do you see any alternative ?
>
> Christophe
>
> > If it helps, perhaps it makes sense to add these flags to
> > KASAN_SANITIZE := n files.
> >
> >
> >>          *PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
> >>   }
> >> @@ -2162,7 +2162,7 @@ static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
> >>          old = *t;
> >>
> >>          /* Copy everything, then do fixups */
> >> -       *t = *s;
> >> +       memcpy(t, s, sizeof(*t));
> >>
> >>          /*
> >>           * If we are overriding a previous value derived from the real
> >> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> >> index 947f904688b0..5e761eb16a6d 100644
> >> --- a/arch/powerpc/kernel/setup_32.c
> >> +++ b/arch/powerpc/kernel/setup_32.c
> >> @@ -73,10 +73,8 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
> >>   {
> >>          unsigned long offset = reloc_offset();
> >>
> >> -       /* First zero the BSS -- use memset_io, some platforms don't have
> >> -        * caches on yet */
> >> -       memset_io((void __iomem *)PTRRELOC(&__bss_start), 0,
> >> -                       __bss_stop - __bss_start);
> >> +       /* First zero the BSS */
> >> +       memset(PTRRELOC(&__bss_start), 0, __bss_stop - __bss_start);
> >>
> >>          /*
> >>           * Identify the CPU type and fix up code sections
> >> --
> >> 2.13.3
> >>
