Return-Path: <SRS0=q2Dt=QN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE0DC169C4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 11:39:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C43A020823
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 11:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43A020823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43vfbq1h8CzDqPP
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 22:39:03 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43vfYj65LHzDqNG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 22:37:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43vfYj008Yz9sLw;
 Wed,  6 Feb 2019 22:37:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] powerpc/prom_init: add __init markers to all functions
In-Reply-To: <CAK7LNARGpmcSVt9qsKDsPNb3KZkPc+QP9Aeh6Q-=o+J-K88Sgg@mail.gmail.com>
References: <1548903199-32695-1-git-send-email-yamada.masahiro@socionext.com>
 <87k1iemsvz.fsf@concordia.ellerman.id.au>
 <CAK7LNARGpmcSVt9qsKDsPNb3KZkPc+QP9Aeh6Q-=o+J-K88Sgg@mail.gmail.com>
Date: Wed, 06 Feb 2019 22:37:08 +1100
Message-ID: <87womdkv17.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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

Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> On Tue, Feb 5, 2019 at 7:33 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>>
>> > It is fragile to rely on the compiler's optimization to avoid the
>> > section mismatch. Some functions may not be necessarily inlined
>> > when the compiler's inlining heuristic changes.
>> >
>> > Add __init markers consistently.
>> >
>> > As for prom_getprop() and prom_getproplen(), they are marked as
>> > 'inline', so inlining is guaranteed because PowerPC never enables
>> > CONFIG_OPTIMIZE_INLINING. However, it would be better to leave the
>> > inlining decision to the compiler. I replaced 'inline' with __init.
>>
>> I'm going to drop that part because it breaks the build in some
>> configurations (as reported by the build robot).
>
>
> If you drop this part, my motivation for this patch is lost.

That's no good then :)

> My motivation is to allow all architectures to enable
> CONFIG_OPTIMIZE_INLINING.
> (Currently, only x86 can enable it, but I see nothing arch-dependent
> in this feature.)

Hmm OK.

> When I tested it in 0-day bot, it reported
> section mismatches from prom_getprop() and prom_getproplen().
>
> So, I want to fix the section mismatches without
> relying on 'inline'.
>
> My suggestion is this:
>
> static int __init __maybe_unused prom_getproplen(phandle node,
>                                                  const char *pname)
> {
>         return call_prom("getproplen", 2, 1, node, ADDR(pname));
> }

Yeah I guess that works. My concern was whether it generates any code
when it's unused, but it seems at least with modern GCC it doesn't.


>> > diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
>> > index f33ff41..85b0719 100644
>> > --- a/arch/powerpc/kernel/prom_init.c
>> > +++ b/arch/powerpc/kernel/prom_init.c
>> > @@ -501,19 +501,19 @@ static int __init prom_next_node(phandle *nodep)
>> >       }
>> >  }
>> >
>> > -static inline int prom_getprop(phandle node, const char *pname,
>> > +static int __init prom_getprop(phandle node, const char *pname,
>> >                              void *value, size_t valuelen)
>> >  {
>> >       return call_prom("getprop", 4, 1, node, ADDR(pname),
>> >                        (u32)(unsigned long) value, (u32) valuelen);
>> >  }
>> >
>> > -static inline int prom_getproplen(phandle node, const char *pname)
>> > +static int __init prom_getproplen(phandle node, const char *pname)
>> >  {
>> >       return call_prom("getproplen", 2, 1, node, ADDR(pname));
>> >  }
>> >
>> > -static void add_string(char **str, const char *q)
>> > +static void __init add_string(char **str, const char *q)
>> >  {
>> >       char *p = *str;
>> >
>> > @@ -523,7 +523,7 @@ static void add_string(char **str, const char *q)
>> >       *str = p;
>> >  }
>> >
>> > -static char *tohex(unsigned int x)
>> > +static char __init *tohex(unsigned int x)
>> >  {
>> >       static const char digits[] __initconst = "0123456789abcdef";
>> >       static char result[9] __prombss;
>> > @@ -570,7 +570,7 @@ static int __init prom_setprop(phandle node, const char *nodename,
>> >  #define islower(c)   ('a' <= (c) && (c) <= 'z')
>> >  #define toupper(c)   (islower(c) ? ((c) - 'a' + 'A') : (c))
>> >
>> > -static unsigned long prom_strtoul(const char *cp, const char **endp)
>> > +static unsigned long __init prom_strtoul(const char *cp, const char **endp)
>> >  {
>> >       unsigned long result = 0, base = 10, value;
>> >
>> > @@ -595,7 +595,7 @@ static unsigned long prom_strtoul(const char *cp, const char **endp)
>> >       return result;
>> >  }
>> >
>> > -static unsigned long prom_memparse(const char *ptr, const char **retptr)
>> > +static unsigned long __init prom_memparse(const char *ptr, const char **retptr)
>> >  {
>> >       unsigned long ret = prom_strtoul(ptr, retptr);
>> >       int shift = 0;
>> > @@ -2924,7 +2924,7 @@ static void __init fixup_device_tree_pasemi(void)
>> >       prom_setprop(iob, name, "device_type", "isa", sizeof("isa"));
>> >  }
>> >  #else        /* !CONFIG_PPC_PASEMI_NEMO */
>> > -static inline void fixup_device_tree_pasemi(void) { }
>> > +static inline void __init fixup_device_tree_pasemi(void) { }
>>
>> I don't think we need __init for an empty static inline.
>
> I prefer 'static __init' to 'static inline',
> but I can drop this if you are uncomfortable with it.

I guess I'm just used to empty stubs being static inline, but it doesn't
really matter, as long as the compiler generates no code for them.

>> >  static void __init fixup_device_tree(void)
>> > @@ -2986,15 +2986,15 @@ static void __init prom_check_initrd(unsigned long r3, unsigned long r4)
>> >
>> >  #ifdef CONFIG_PPC64
>> >  #ifdef CONFIG_RELOCATABLE
>> > -static void reloc_toc(void)
>> > +static void __init reloc_toc(void)
>> >  {
>> >  }
>> >
>> > -static void unreloc_toc(void)
>> > +static void __init unreloc_toc(void)
>> >  {
>> >  }
>>
>> Those should be empty static inlines, I'll fix them up.
>
> As I said above, I believe 'static inline' is mostly useful in headers,
> but this is up to you.

No I think you've convinced me.

> BTW, I have v2 in hand already.
> Do you need it if it is convenient for you?

Yes please send it.

> I added __init to enter_prom() as well,
> but you may not be comfortable with
> replacing inline with __init.

That's fine.

I'd forgotten the 64-bit version was in assembly. We should really move
it to a separate file and put it in init.text too.

cheers
