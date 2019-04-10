Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2BDC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 06:55:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE676217D9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 06:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK93nExh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE676217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fFKB6mK0zDqMq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 16:55:10 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fFDn63KjzDqJk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 16:51:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gK93nExh"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44fFDn4vTkz8t3t
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 16:51:21 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44fFDn3xqWz9s7T; Wed, 10 Apr 2019 16:51:21 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::142; helo=mail-it1-x142.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gK93nExh"; 
 dkim-atps=neutral
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44fFDn2cvgz9s0W
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Apr 2019 16:51:20 +1000 (AEST)
Received: by mail-it1-x142.google.com with SMTP id y204so1654217itf.3
 for <linuxppc-dev@ozlabs.org>; Tue, 09 Apr 2019 23:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zUPxCzFBLM0s0oCtRYe9XCZ7nPdZl+I/7ckSHIByvAI=;
 b=gK93nExhix+s+lGKpxQ/iuXDrErnmFvDiR4BO2JLgBL0IKwg+pI6MNJ/QatGR8Kz1A
 2GtyASB/NjLjrHz/5TZetB/ix+NYwYLSTYKqeFGCVzoxBu/ot/ihZS2fwOfpX/DlLyp3
 TCBgqz60ASzeQStfjUMPZexYcY+HxwbQtq2LKCOoeCzvQiCrUvt9LdGxAkY1KssFQinP
 fEa7dDq9jJ1NxomBlTdgAUkDL+II6u6UGR9HoRxxGHus+qxy+FLxUbdMFjY64TOV8KT9
 mFiYRsiS0f2ssRbKVrFzQZm4nn9S+AASriz0k9/cA+QxjnetgjDN3GKn8Wewajnd+a5Y
 Aseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zUPxCzFBLM0s0oCtRYe9XCZ7nPdZl+I/7ckSHIByvAI=;
 b=OzMUl3JT+6dfjW93yVFQqHbQNAx/RrBgJikJxQOWVIfYR+ZHpC9AxfGRZizdgmufJZ
 YLEKSjuWfY5ri7Ka21MM0++UEaDSaCd+LxNINQcHTJvyVrXTYeaO6gvd04gbhIli65kG
 gTOYUeBHi1waBds8QnodfLvoLgI45HRWro+g+ndS5re0ZZ9kihmSIgQoX00GBefNnV/i
 e47TdI2EMSOiggbYp6qck5mzcfn3TvDvGN+stEh+qUeEG5OZk8lH4URwTaZG9PQ97Ee/
 BuHoWaXnZSqI+jqhnXodKk7F4qkCDy8k7IbnzxAMS8U9sTvObaP/vol3I15mhZAalsGb
 pMyQ==
X-Gm-Message-State: APjAAAXo/InJcRTDDE8Uw8AiqX2SNdv/O1700p4okZpyK8cMjM5Twpsl
 6Os4sMaeF7ROrT5F5zOtTZjUg0flcsZY1pBdnDk=
X-Google-Smtp-Source: APXvYqzHged6YMiyfMJ46Z64EMI4jBGpbK989CTZV5hfZ1QL9wSAArJkyWP6hNXBwekG1tY8WuDmv3S9T0iCjrUg4dg=
X-Received: by 2002:a02:9f08:: with SMTP id z8mr29826364jal.6.1554879077798;
 Tue, 09 Apr 2019 23:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190408030804.5805-1-cmr@informatik.wtf>
 <CAOSf1CEZgHtz5u6F+N7egf3B+MiquFcsopm1yiMZvdYvKcip1w@mail.gmail.com>
 <864072306.101924.1554863718473@privateemail.com>
In-Reply-To: <864072306.101924.1554863718473@privateemail.com>
From: Oliver <oohall@gmail.com>
Date: Wed, 10 Apr 2019 16:51:06 +1000
Message-ID: <CAOSf1CFwc_D8JjHowNgpAQMjc=xAOt=53qV2Tj-obbyL=wU0rA@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/xmon: add read-only mode
To: Christopher M Riedl <cmr@informatik.wtf>
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
Cc: linuxppc-dev@ozlabs.org, Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 10, 2019 at 12:35 PM Christopher M Riedl <cmr@informatik.wtf> wrote:
>
>
> > On April 8, 2019 at 1:34 AM Oliver <oohall@gmail.com> wrote:
> >
> >
> > On Mon, Apr 8, 2019 at 1:06 PM Christopher M. Riedl <cmr@informatik.wtf> wrote:
> > >
> > > Operations which write to memory and special purpose registers should be
> > > restricted on systems with integrity guarantees (such as Secure Boot)
> > > and, optionally, to avoid self-destructive behaviors.
> > >
> > > Add a config option, XMON_RW, to control default xmon behavior along
> > > with kernel cmdline options xmon=ro and xmon=rw for explicit control.
> > > Use XMON_RW instead of XMON in the condition to set PAGE_KERNEL_TEXT to
> > > allow xmon in read-only mode alongside write-protected kernel text.
> > > XMON_RW defaults to !STRICT_KERNEL_RWX.
> > >
> > > The following xmon operations are affected:
> > > memops:
> > >         disable memmove
> > >         disable memset
> > >         disable memzcan
> > > memex:
> > >         no-op'd mwrite
> > > super_regs:
> > >         no-op'd write_spr
> > > bpt_cmds:
> > >         disable
> > > proc_call:
> > >         disable
> > >
> > > Signed-off-by: Christopher M. Riedl <cmr@informatik.wtf>
> > > ---
> > > v1->v2:
> > >         Use bool type for xmon_is_ro flag
> > >         Replace XMON_RO with XMON_RW config option
> > >         Make XMON_RW dependent on STRICT_KERNEL_RWX
> > Do you mean make it dependent on XMON?
> >
>
> Yeah that's really not clear at all -- XMON_RW is set based on the value of
> STRICT_KERNEL_RWX.
>
> >
> > >         Use XMON_RW to control PAGE_KERNEL_TEXT
> > >         Add printf in xmon read-only mode when dropping/skipping writes
> > >         Disable memzcan (zero-fill memop) in xmon read-only mode
> > >
> > >  arch/powerpc/Kconfig.debug                   | 10 +++++
> > >  arch/powerpc/include/asm/book3s/32/pgtable.h |  5 ++-
> > >  arch/powerpc/include/asm/book3s/64/pgtable.h |  5 ++-
> > >  arch/powerpc/include/asm/nohash/pgtable.h    |  5 ++-
> > >  arch/powerpc/xmon/xmon.c                     | 42 ++++++++++++++++++++
> > >  5 files changed, 61 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> > > index 4e00cb0a5464..0c7f21476018 100644
> > > --- a/arch/powerpc/Kconfig.debug
> > > +++ b/arch/powerpc/Kconfig.debug
> > > @@ -117,6 +117,16 @@ config XMON_DISASSEMBLY
> > >           to say Y here, unless you're building for a memory-constrained
> > >           system.
> > >
> >
> > > +config XMON_RW
> > > +       bool "Allow xmon read and write operations"
> > > +       depends on XMON
> > > +       default !STRICT_KERNEL_RWX
> > > +       help
> > > +         Allow xmon to read and write to memory and special-purpose registers.
> > > +          Conversely, prevent xmon write access when set to N. Read and write
> > > +          access can also be explicitly controlled with 'xmon=rw' or 'xmon=ro'
> > > +          (read-only) cmdline options. Default is !STRICT_KERNEL_RWX.
> >
> > Maybe I am a dumb, but I found this *extremely* confusing.
> > Conventionally Kconfig options will control what code is and is not
> > included in the kernel (see XMON_DISASSEMBLY) rather than changing the
> > default behaviour of code. It's not wrong to do so and I'm going to
> > assume that you were following the pattern of XMON_DEFAULT, but I
> > think you need to be a little more clear about what option actually
> > does. Renaming it to XMON_DEFAULT_RO_MODE and re-wording the
> > description to indicate it's a only a mode change would help a lot.
> >
> > Sorry if this comes across as pointless bikeshedding since it's the
> > opposite of what Christophe said in the last patch, but this was a bit
> > of a head scratcher.
> >
>
> If anyone is dumb here it's me for making this confusing :)
> I chatted with Michael Ellerman about this, so let me try to explain this more clearly.
>
> There are two things I am trying to address with XMON_RW:
> 1) provide a default access mode for xmon based on system "security"
> 2) replace XMON in the decision to write-protect kernel text at compile-time
>
> I think a single Kconfig for both of those things is sensible as ultimately the
> point is to allow xmon to operate in read-only mode on "secure" systems -- without
> violating any integrity/security guarantees (such as write-protected kernel text).
>
> Christophe suggested looking at STRICT_KERNEL_RWX and I think that option makes the
> most sense to base XMON_RW on since the description for STRICT_KERNEL_RWX states:
>
> > If this is set, kernel text and rodata memory will be made read-only,
> > and non-text memory will be made non-executable. This provides
> > protection against certain security exploits (e.g. executing the heap
> > or modifying text)
> >
> > These features are considered standard security practice these days.
> > You should say Y here in almost all cases.
>
> Considering this, does XMON_DEFAULT_RO_MODE really make things more clear?

Not really.

> With that said, I will remove the 'xmon=rw' cmdline option as it really doesn't work
> since kernel text is write-protected at compile time.

I think you're overestimating the importance of being able to write to
the kernel text. The only features that require a writeable text are
using the mem commands to modify the kernel text (a bad idea) and
software breakpoints.

Funnily enough, enabling STRICT_RWX make software breakpoints work
again since it enables a smarter implementation of patch_instruction()
that uses a temporary RW mapping to do the patch. Considering that
kprobes and dynamic ftrace are also implemented with
patch_instruction() too we could just default to the newer
implementation and force PAGE_KERNEL_TEXT to be PAGE_KERNEL_ROX all
the time.

> 'xmon=ro' remains for those who would optionally like to prevent shooting themselves
> in the foot/feet while using xmon.
>
> Hopefully this makes a bit more sense now?
>
> > >  config DEBUGGER
> > >         bool
> > >         depends on KGDB || XMON
> > > diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
> > > index aa8406b8f7ba..615144ad667d 100644
> > > --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
> > > +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
> > > @@ -86,8 +86,9 @@ static inline bool pte_user(pte_t pte)
> > >   * set breakpoints anywhere, so don't write protect the kernel text
> > >   * on platforms where such control is possible.
> > >   */
> > > -#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\
> > > -       defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
> > > +#if defined(CONFIG_KGDB) || defined(CONFIG_XMON_RW) || \
> > > +       defined(CONFIG_BDI_SWITCH) || defined(CONFIG_KPROBES) || \
> > > +       defined(CONFIG_DYNAMIC_FTRACE)
> > >  #define PAGE_KERNEL_TEXT       PAGE_KERNEL_X
> > >  #else
> > >  #define PAGE_KERNEL_TEXT       PAGE_KERNEL_ROX
> > > diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> > > index 581f91be9dd4..bc4655122f6b 100644
> > > --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> > > +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> > > @@ -168,8 +168,9 @@
> > >   * set breakpoints anywhere, so don't write protect the kernel text
> > >   * on platforms where such control is possible.
> > >   */
> > > -#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) || \
> > > -       defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
> > > +#if defined(CONFIG_KGDB) || defined(CONFIG_XMON_RW) || \
> > > +       defined(CONFIG_BDI_SWITCH) || defined(CONFIG_KPROBES) || \
> > > +       defined(CONFIG_DYNAMIC_FTRACE)
> > >  #define PAGE_KERNEL_TEXT       PAGE_KERNEL_X
> > >  #else
> > >  #define PAGE_KERNEL_TEXT       PAGE_KERNEL_ROX
> > > diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
> > > index 1ca1c1864b32..c052931bd243 100644
> > > --- a/arch/powerpc/include/asm/nohash/pgtable.h
> > > +++ b/arch/powerpc/include/asm/nohash/pgtable.h
> > > @@ -22,8 +22,9 @@
> > >   * set breakpoints anywhere, so don't write protect the kernel text
> > >   * on platforms where such control is possible.
> > >   */
> > > -#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\
> > > -       defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
> > > +#if defined(CONFIG_KGDB) || defined(CONFIG_XMON_RW) || \
> > > +       defined(CONFIG_BDI_SWITCH) || defined(CONFIG_KPROBES) || \
> > > +       defined(CONFIG_DYNAMIC_FTRACE)
> > >  #define PAGE_KERNEL_TEXT       PAGE_KERNEL_X
> > >  #else
> > >  #define PAGE_KERNEL_TEXT       PAGE_KERNEL_ROX
> > > diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> > > index a0f44f992360..224ca0b3506b 100644
> > > --- a/arch/powerpc/xmon/xmon.c
> > > +++ b/arch/powerpc/xmon/xmon.c
> > > @@ -80,6 +80,7 @@ static int set_indicator_token = RTAS_UNKNOWN_SERVICE;
> > >  #endif
> > >  static unsigned long in_xmon __read_mostly = 0;
> > >  static int xmon_on = IS_ENABLED(CONFIG_XMON_DEFAULT);
> > > +static bool xmon_is_ro = !IS_ENABLED(CONFIG_XMON_RW);
> > >
> > >  static unsigned long adrs;
> > >  static int size = 1;
> > > @@ -202,6 +203,8 @@ static void dump_tlb_book3e(void);
> > >  #define GETWORD(v)     (((v)[0] << 24) + ((v)[1] << 16) + ((v)[2] << 8) + (v)[3])
> > >  #endif
> > >
> > > +static const char *xmon_is_ro_warn = "xmon read-only mode: skipping write\n";
> > > +
> > >  static char *help_string = "\
> > >  Commands:\n\
> > >    b    show breakpoints\n\
> > > @@ -989,6 +992,10 @@ cmds(struct pt_regs *excp)
> > >                                 memlocate();
> > >                                 break;
> > >                         case 'z':
> > > +                               if (xmon_is_ro) {
> > > +                                       printf(xmon_is_ro_warn);
> > > +                                       break;
> > > +                               }
> > >                                 memzcan();
> > >                                 break;
> > >                         case 'i':
> > > @@ -1042,6 +1049,10 @@ cmds(struct pt_regs *excp)
> > >                         set_lpp_cmd();
> > >                         break;
> > >                 case 'b':
> > > +                       if (xmon_is_ro) {
> > > +                               printf(xmon_is_ro_warn);
> > > +                               break;
> > > +                       }
> > >                         bpt_cmds();
> > >                         break;
> > >                 case 'C':
> > > @@ -1055,6 +1066,10 @@ cmds(struct pt_regs *excp)
> > >                         bootcmds();
> > >                         break;
> > >                 case 'p':
> > > +                       if (xmon_is_ro) {
> > > +                               printf(xmon_is_ro_warn);
> > > +                               break;
> > > +                       }
> > >                         proccall();
> > >                         break;
> > >                 case 'P':
> > > @@ -1777,6 +1792,11 @@ read_spr(int n, unsigned long *vp)
> > >  static void
> > >  write_spr(int n, unsigned long val)
> > >  {
> > > +       if (xmon_is_ro) {
> > > +               printf(xmon_is_ro_warn);
> > > +               return;
> > > +       }
> > > +
> > >         if (setjmp(bus_error_jmp) == 0) {
> > >                 catch_spr_faults = 1;
> > >                 sync();
> > > @@ -2016,6 +2036,12 @@ mwrite(unsigned long adrs, void *buf, int size)
> > >         char *p, *q;
> > >
> > >         n = 0;
> > > +
> > > +       if (xmon_is_ro) {
> > > +               printf(xmon_is_ro_warn);
> > > +               return n;
> > > +       }
> > > +
> > >         if (setjmp(bus_error_jmp) == 0) {
> > >                 catch_memory_errors = 1;
> > >                 sync();
> > > @@ -2884,9 +2910,17 @@ memops(int cmd)
> > >         scanhex((void *)&mcount);
> > >         switch( cmd ){
> > >         case 'm':
> > > +               if (xmon_is_ro) {
> > > +                       printf(xmon_is_ro_warn);
> > > +                       break;
> > > +               }
> > >                 memmove((void *)mdest, (void *)msrc, mcount);
> > >                 break;
> > >         case 's':
> > > +               if (xmon_is_ro) {
> > > +                       printf(xmon_is_ro_warn);
> > > +                       break;
> > > +               }
> > >                 memset((void *)mdest, mval, mcount);
> > >                 break;
> > >         case 'd':
> > > @@ -3796,6 +3830,14 @@ static int __init early_parse_xmon(char *p)
> > >         } else if (strncmp(p, "on", 2) == 0) {
> > >                 xmon_init(1);
> > >                 xmon_on = 1;
> > > +       } else if (strncmp(p, "rw", 2) == 0) {
> > > +               xmon_init(1);
> > > +               xmon_on = 1;
> > > +               xmon_is_ro = false;
> > > +       } else if (strncmp(p, "ro", 2) == 0) {
> > > +               xmon_init(1);
> > > +               xmon_on = 1;
> > > +               xmon_is_ro = true;
> > >         } else if (strncmp(p, "off", 3) == 0)
> > >                 xmon_on = 0;
> > >         else
> > > --
> > > 2.21.0
> > >
