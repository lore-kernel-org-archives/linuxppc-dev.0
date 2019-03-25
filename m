Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0531C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 06:07:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D6E3205F4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 06:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bx/TV7JT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6E3205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SP1F5ltPzDqB4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 17:07:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.82; helo=conssluserg-03.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="bx/TV7JT"; 
 dkim-atps=neutral
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SNyn0mN1zDqB4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 17:05:03 +1100 (AEDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id x2P64cLV003347
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 15:04:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x2P64cLV003347
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1553493879;
 bh=B4ChcblG4ZQCd4nPunH/ssjXK/AEQyd4y8j5fV5njEw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=bx/TV7JTsBNMGbuPK8R+CBCP0wAOOn3oY13hgQhR+xfNOD4GwNNodI7oD/duPafHg
 tZqBqM6AbapEEnpRLV+uu2OEWpQo8LK3w+bNaaT8pfJ+p0Ddrnv8CVma9V6Lb8O9/7
 7DJGRUycWOtHNs3skGj4DQWdRmO6hvoYmqkSnLbuQqNvAFRbM10WCqdbsyQLPc/Kwo
 nU76uLlp9G1NwPBNrWttm1LZ1E0yyWCufbUgUIoDjcqY8LO8+H+LSBvXHlshN3kpnj
 35bdc9kJ/cF3GN4CCMEfdWPoYgi+T3QchavqTZYm7uAuNWHcJDaKuUD/Qji/oHpxGQ
 G4eBS+RohBA6Q==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id m11so2599797uad.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Mar 2019 23:04:38 -0700 (PDT)
X-Gm-Message-State: APjAAAU3H5MkkUAn7zAdfW8Li36SRn/H1SuNJfrufnyofTneC7swEeQ9
 us2p+nsvvSwGkKw0rnCBVFPBEWscGT6b8FNsD5U=
X-Google-Smtp-Source: APXvYqx/S8UOKUHBbtCAjh/Xto7MQMzfktT9FG80DWAu/KsZ84Kmo/5ph+OPt43eFgITDysVhkw/Jr0iRpDR7nqg7EU=
X-Received: by 2002:ab0:7493:: with SMTP id n19mr12913419uap.121.1553493877627; 
 Sun, 24 Mar 2019 23:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQu9hmeSgKO_B1LhXqq9Z923H25HXNS9XYNvFi55WrFYw@mail.gmail.com>
 <CAK8P3a0-7LRE4ByO2Uf4tb5mR49SbZzBu0AgHpS=03FAMWFLgQ@mail.gmail.com>
 <CAK7LNATjXoNrbt2SSgR4omiQEBppOkF6mdcVJjpw2B+ihGQvGw@mail.gmail.com>
 <CAK8P3a3Y+r95FNpHjPznD5g1PSS=OuYdzT8VH9XNY2DTUhB-Tw@mail.gmail.com>
In-Reply-To: <CAK8P3a3Y+r95FNpHjPznD5g1PSS=OuYdzT8VH9XNY2DTUhB-Tw@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 25 Mar 2019 15:04:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNATJMtDpu9vRcZ+EZxRw9LSfNihCrNi_o0JKLqP-PjcOHg@mail.gmail.com>
Message-ID: <CAK7LNATJMtDpu9vRcZ+EZxRw9LSfNihCrNi_o0JKLqP-PjcOHg@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable
 CONFIG_OPTIMIZE_INLINING
To: Arnd Bergmann <arnd@arndb.de>
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Dave Hansen <dave@sr71.net>,
 X86 ML <x86@kernel.org>, linux-mips@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@redhat.com>,
 linux-mtd <linux-mtd@lists.infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Arnd,




On Wed, Mar 20, 2019 at 10:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Mar 20, 2019 at 11:19 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > On Wed, Mar 20, 2019 at 6:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Wed, Mar 20, 2019 at 7:41 AM Masahiro Yamada
> > > <yamada.masahiro@socionext.com> wrote:
> > >
> > > > It is unclear to me how to fix it.
> > > > That's why I ended up with "depends on !MIPS".
> > > >
> > > >
> > > >   MODPOST vmlinux.o
> > > > arch/mips/mm/sc-mips.o: In function `mips_sc_prefetch_enable.part.2':
> > > > sc-mips.c:(.text+0x98): undefined reference to `mips_gcr_base'
> > > > sc-mips.c:(.text+0x9c): undefined reference to `mips_gcr_base'
> > > > sc-mips.c:(.text+0xbc): undefined reference to `mips_gcr_base'
> > > > sc-mips.c:(.text+0xc8): undefined reference to `mips_gcr_base'
> > > > sc-mips.c:(.text+0xdc): undefined reference to `mips_gcr_base'
> > > > arch/mips/mm/sc-mips.o:sc-mips.c:(.text.unlikely+0x44): more undefined
> > > > references to `mips_gcr_base'
> > > >
> > > >
> > > > Perhaps, MIPS folks may know how to fix it.
> > >
> > > I would guess like this:
> > >
> > > diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
> > > index 8bc5df49b0e1..a27483fedb7d 100644
> > > --- a/arch/mips/include/asm/mips-cm.h
> > > +++ b/arch/mips/include/asm/mips-cm.h
> > > @@ -79,7 +79,7 @@ static inline int mips_cm_probe(void)
> > >   *
> > >   * Returns true if a CM is present in the system, else false.
> > >   */
> > > -static inline bool mips_cm_present(void)
> > > +static __always_inline bool mips_cm_present(void)
> > >  {
> > >  #ifdef CONFIG_MIPS_CM
> > >         return mips_gcr_base != NULL;
> > > @@ -93,7 +93,7 @@ static inline bool mips_cm_present(void)
> > >   *
> > >   * Returns true if the system implements an L2-only sync region, else false.
> > >   */
> > > -static inline bool mips_cm_has_l2sync(void)
> > > +static __always_inline bool mips_cm_has_l2sync(void)
> > >  {
> > >  #ifdef CONFIG_MIPS_CM
> > >         return mips_cm_l2sync_base != NULL;
> > >
> >
> >
> > Thanks, I applied the above, but I still see
> >  undefined reference to `mips_gcr_base'
> >
> >
> > I attached .config to produce this error.
> >
> > I use prebuilt mips-linux-gcc from
> > https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/
>
> I got to this patch experimentally, it fixes the problem for me:
>
> diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
> index 394673991bab..d70d02da038b 100644
> --- a/arch/mips/mm/sc-mips.c
> +++ b/arch/mips/mm/sc-mips.c
> @@ -181,7 +181,7 @@ static int __init mips_sc_probe_cm3(void)
>         return 0;
>  }
>
> -static inline int __init mips_sc_probe(void)
> +static __always_inline int __init mips_sc_probe(void)
>  {
>         struct cpuinfo_mips *c = &current_cpu_data;
>         unsigned int config1, config2;
> diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
> index 830c93a010c3..186c28463bf3 100644
> --- a/arch/mips/include/asm/bitops.h
> +++ b/arch/mips/include/asm/bitops.h
> @@ -548,7 +548,7 @@ static inline unsigned long __fls(unsigned long word)
>   * Returns 0..SZLONG-1
>   * Undefined if no bit exists, so code should check against 0 first.
>   */
> -static inline unsigned long __ffs(unsigned long word)
> +static __always_inline unsigned long __ffs(unsigned long word)
>  {
>         return __fls(word & -word);
>  }
>
>
> It does look like a gcc bug though, as at least some of the references
> are from a function that got split out from an inlined function but that
> has no remaining call sites.
>
>        Arnd


I applied it, but
"undefined reference to `mips_gcr_base'" still remains.


Then, I got a solution. This is it:

diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index 830c93a..6a26ead 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -482,7 +482,7 @@ static inline void __clear_bit_unlock(unsigned
long nr, volatile unsigned long *
  * Return the bit position (0..63) of the most significant 1 bit in a word
  * Returns -1 if no 1 bit exists
  */
-static inline unsigned long __fls(unsigned long word)
+static __always_inline unsigned long __fls(unsigned long word)
 {
        int num;



LEROY Christophe provided me a tip
to find out the cause of the error.

-Winline pin-points which function
was not inlined despite of its inline marker.



$ make -j8  ARCH=mips CROSS_COMPILE=mips-linux- KCFLAGS=-Winline
arch/mips/mm/sc-mips.o
  CC      scripts/mod/devicetable-offsets.s
  CC      scripts/mod/empty.o
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTCC  scripts/mod/file2alias.o
  HOSTLD  scripts/mod/modpost
  CC      kernel/bounds.s
  CALL    scripts/atomic/check-atomics.sh
  CC      arch/mips/kernel/asm-offsets.s
  CALL    scripts/checksyscalls.sh
<stdin>:1478:2: warning: #warning syscall pidfd_send_signal not
implemented [-Wcpp]
<stdin>:1481:2: warning: #warning syscall io_uring_setup not implemented [-Wcpp]
<stdin>:1484:2: warning: #warning syscall io_uring_enter not implemented [-Wcpp]
<stdin>:1487:2: warning: #warning syscall io_uring_register not
implemented [-Wcpp]
  CC      arch/mips/mm/sc-mips.o
In file included from ./include/linux/bitops.h:19,
                 from ./include/linux/kernel.h:12,
                 from arch/mips/mm/sc-mips.c:6:
./arch/mips/include/asm/bitops.h: In function 'mips_sc_init':
./arch/mips/include/asm/bitops.h:485:29: warning: inlining failed in
call to '__fls': call is unlikely and code size would grow [-Winline]
 static inline unsigned long __fls(unsigned long word)
                             ^~~~~
./arch/mips/include/asm/bitops.h:553:9: note: called from here
  return __fls(word & -word);
         ^~~~~~~~~~~~~~~~~~~
./arch/mips/include/asm/bitops.h:485:29: warning: inlining failed in
call to '__fls': call is unlikely and code size would grow [-Winline]
 static inline unsigned long __fls(unsigned long word)
                             ^~~~~
./arch/mips/include/asm/bitops.h:553:9: note: called from here
  return __fls(word & -word);
         ^~~~~~~~~~~~~~~~~~~
./arch/mips/include/asm/bitops.h:485:29: warning: inlining failed in
call to '__fls': call is unlikely and code size would grow [-Winline]
 static inline unsigned long __fls(unsigned long word)
                             ^~~~~
./arch/mips/include/asm/bitops.h:553:9: note: called from here
  return __fls(word & -word);
         ^~~~~~~~~~~~~~~~~~~
./arch/mips/include/asm/bitops.h:485:29: warning: inlining failed in
call to '__fls': call is unlikely and code size would grow [-Winline]
 static inline unsigned long __fls(unsigned long word)
                             ^~~~~
./arch/mips/include/asm/bitops.h:553:9: note: called from here
  return __fls(word & -word);
         ^~~~~~~~~~~~~~~~~~~
./arch/mips/include/asm/bitops.h:485:29: warning: inlining failed in
call to '__fls': call is unlikely and code size would grow [-Winline]
 static inline unsigned long __fls(unsigned long word)
                             ^~~~~
./arch/mips/include/asm/bitops.h:553:9: note: called from here
  return __fls(word & -word);
         ^~~~~~~~~~~~~~~~~~~
./arch/mips/include/asm/bitops.h:485:29: warning: inlining failed in
call to '__fls': call is unlikely and code size would grow [-Winline]
 static inline unsigned long __fls(unsigned long word)
                             ^~~~~
./arch/mips/include/asm/bitops.h:553:9: note: called from here
  return __fls(word & -word);
         ^~~~~~~~~~~~~~~~~~~
./arch/mips/include/asm/bitops.h:485:29: warning: inlining failed in
call to '__fls': call is unlikely and code size would grow [-Winline]
 static inline unsigned long __fls(unsigned long word)
                             ^~~~~
./arch/mips/include/asm/bitops.h:553:9: note: called from here
  return __fls(word & -word);
         ^~~~~~~~~~~~~~~~~~~



-- 
Best Regards
Masahiro Yamada
