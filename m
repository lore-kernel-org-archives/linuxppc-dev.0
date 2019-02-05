Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5CCC282DA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 14:00:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55033207E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 14:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xba7Y1yc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55033207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v5n52gs4zDqMT
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 01:00:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.90; helo=conssluserg-05.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="xba7Y1yc"; 
 dkim-atps=neutral
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v5lG2M8kzDqLs
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 00:58:33 +1100 (AEDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
 [209.85.217.53]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id x15Dw6sC001746
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Feb 2019 22:58:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x15Dw6sC001746
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1549375087;
 bh=AjgLywK2VDzp55WjU1GyDmSsVxNAlS6VPujdzvOAsSA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=xba7Y1yctyll8CcukF068TbGO0R6QVw2Ns0XsUzLqllI/Ff66we/WmrMwFru3qizn
 40LYpWnDT8vBxS7tBXLqrlG7Y43I3BnWvbRsV2J518Y3ee36psbinjPqSjg0VhcXNh
 uLzOGu4EdAW9zlMOCqf7ZLRKYVneKGONOZJ54Gnk4QpyI9PNH2w7E33/I4oGwtJjb1
 GgsUYGmRI/JPbFpWtBVDlVRMS9a2fCDADdIpxKUdtGyXms+MclqTTKttBikrd0GU1O
 foy8x1BauA+yhWnBOMaxCL5QiIWlB0O4YAJO8uTKSfdE/mJKAZAPPE5eDXGcFKNt1B
 pGunQBPwVKH5w==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id n10so2140816vso.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Feb 2019 05:58:06 -0800 (PST)
X-Gm-Message-State: AHQUAuamodIt10252SK8Fm/3CHF+Q1cWZQGof+fiGr/ehUxb2COQxUi2
 i96uUfYZvn6t1/SX5t4HGjQM1CIq0mGcDVp+3N0=
X-Google-Smtp-Source: AHgI3IaYfiLYqqe+Yn3YjcLynHJboGBRJAfVFK/uyA45qYNAw3yFl9dWRhlpKi7APD4ZBQNgkEbRR2VZNgPjlw7MIaE=
X-Received: by 2002:a67:485:: with SMTP id 127mr2176110vse.54.1549375085786;
 Tue, 05 Feb 2019 05:58:05 -0800 (PST)
MIME-Version: 1.0
References: <1548903199-32695-1-git-send-email-yamada.masahiro@socionext.com>
 <87k1iemsvz.fsf@concordia.ellerman.id.au>
In-Reply-To: <87k1iemsvz.fsf@concordia.ellerman.id.au>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 5 Feb 2019 22:57:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNARGpmcSVt9qsKDsPNb3KZkPc+QP9Aeh6Q-=o+J-K88Sgg@mail.gmail.com>
Message-ID: <CAK7LNARGpmcSVt9qsKDsPNb3KZkPc+QP9Aeh6Q-=o+J-K88Sgg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/prom_init: add __init markers to all functions
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: Mathieu Malaterre <malat@debian.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 5, 2019 at 7:33 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>
> > It is fragile to rely on the compiler's optimization to avoid the
> > section mismatch. Some functions may not be necessarily inlined
> > when the compiler's inlining heuristic changes.
> >
> > Add __init markers consistently.
> >
> > As for prom_getprop() and prom_getproplen(), they are marked as
> > 'inline', so inlining is guaranteed because PowerPC never enables
> > CONFIG_OPTIMIZE_INLINING. However, it would be better to leave the
> > inlining decision to the compiler. I replaced 'inline' with __init.
>
> I'm going to drop that part because it breaks the build in some
> configurations (as reported by the build robot).


If you drop this part, my motivation for this patch is lost.

My motivation is to allow all architectures to enable
CONFIG_OPTIMIZE_INLINING.
(Currently, only x86 can enable it, but I see nothing arch-dependent
in this feature.)


When I tested it in 0-day bot, it reported
section mismatches from prom_getprop() and prom_getproplen().

So, I want to fix the section mismatches without
relying on 'inline'.


My suggestion is this:

static int __init __maybe_unused prom_getproplen(phandle node,
                                                 const char *pname)
{
        return call_prom("getproplen", 2, 1, node, ADDR(pname));
}


It is true you can use the side-effect of 'inline'
to hide the unused function warnings, but I prefer
as less inline markers as possible in *.c files.





> > diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> > index f33ff41..85b0719 100644
> > --- a/arch/powerpc/kernel/prom_init.c
> > +++ b/arch/powerpc/kernel/prom_init.c
> > @@ -501,19 +501,19 @@ static int __init prom_next_node(phandle *nodep)
> >       }
> >  }
> >
> > -static inline int prom_getprop(phandle node, const char *pname,
> > +static int __init prom_getprop(phandle node, const char *pname,
> >                              void *value, size_t valuelen)
> >  {
> >       return call_prom("getprop", 4, 1, node, ADDR(pname),
> >                        (u32)(unsigned long) value, (u32) valuelen);
> >  }
> >
> > -static inline int prom_getproplen(phandle node, const char *pname)
> > +static int __init prom_getproplen(phandle node, const char *pname)
> >  {
> >       return call_prom("getproplen", 2, 1, node, ADDR(pname));
> >  }
> >
> > -static void add_string(char **str, const char *q)
> > +static void __init add_string(char **str, const char *q)
> >  {
> >       char *p = *str;
> >
> > @@ -523,7 +523,7 @@ static void add_string(char **str, const char *q)
> >       *str = p;
> >  }
> >
> > -static char *tohex(unsigned int x)
> > +static char __init *tohex(unsigned int x)
> >  {
> >       static const char digits[] __initconst = "0123456789abcdef";
> >       static char result[9] __prombss;
> > @@ -570,7 +570,7 @@ static int __init prom_setprop(phandle node, const char *nodename,
> >  #define islower(c)   ('a' <= (c) && (c) <= 'z')
> >  #define toupper(c)   (islower(c) ? ((c) - 'a' + 'A') : (c))
> >
> > -static unsigned long prom_strtoul(const char *cp, const char **endp)
> > +static unsigned long __init prom_strtoul(const char *cp, const char **endp)
> >  {
> >       unsigned long result = 0, base = 10, value;
> >
> > @@ -595,7 +595,7 @@ static unsigned long prom_strtoul(const char *cp, const char **endp)
> >       return result;
> >  }
> >
> > -static unsigned long prom_memparse(const char *ptr, const char **retptr)
> > +static unsigned long __init prom_memparse(const char *ptr, const char **retptr)
> >  {
> >       unsigned long ret = prom_strtoul(ptr, retptr);
> >       int shift = 0;
> > @@ -2924,7 +2924,7 @@ static void __init fixup_device_tree_pasemi(void)
> >       prom_setprop(iob, name, "device_type", "isa", sizeof("isa"));
> >  }
> >  #else        /* !CONFIG_PPC_PASEMI_NEMO */
> > -static inline void fixup_device_tree_pasemi(void) { }
> > +static inline void __init fixup_device_tree_pasemi(void) { }
>
> I don't think we need __init for an empty static inline.

I prefer 'static __init' to 'static inline',
but I can drop this if you are uncomfortable with it.

My work will not be blocked by this.



> >  #endif
> >
> >  static void __init fixup_device_tree(void)
> > @@ -2986,15 +2986,15 @@ static void __init prom_check_initrd(unsigned long r3, unsigned long r4)
> >
> >  #ifdef CONFIG_PPC64
> >  #ifdef CONFIG_RELOCATABLE
> > -static void reloc_toc(void)
> > +static void __init reloc_toc(void)
> >  {
> >  }
> >
> > -static void unreloc_toc(void)
> > +static void __init unreloc_toc(void)
> >  {
> >  }
>
> Those should be empty static inlines, I'll fix them up.

As I said above, I believe 'static inline' is mostly useful in headers,
but this is up to you.


BTW, I have v2 in hand already.
Do you need it if it is convenient for you?

I added __init to enter_prom() as well,
but you may not be comfortable with
replacing inline with __init.





> >  #else
> > -static void __reloc_toc(unsigned long offset, unsigned long nr_entries)
> > +static void __init __reloc_toc(unsigned long offset, unsigned long nr_entries)
> >  {
> >       unsigned long i;
> >       unsigned long *toc_entry;
> > @@ -3008,7 +3008,7 @@ static void __reloc_toc(unsigned long offset, unsigned long nr_entries)
> >       }
> >  }
> >
> > -static void reloc_toc(void)
> > +static void __init reloc_toc(void)
> >  {
> >       unsigned long offset = reloc_offset();
> >       unsigned long nr_entries =
> > @@ -3019,7 +3019,7 @@ static void reloc_toc(void)
> >       mb();
> >  }
> >
> > -static void unreloc_toc(void)
> > +static void __init unreloc_toc(void)
> >  {
> >       unsigned long offset = reloc_offset();
> >       unsigned long nr_entries =
>
>
> cheers



-- 
Best Regards
Masahiro Yamada
