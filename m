Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84AAC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D75720873
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D75720873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fGHT28lbzDqc1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 03:38:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.68; helo=mail-ua1-f68.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-ua1-f68.google.com (mail-ua1-f68.google.com
 [209.85.222.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fGDp5tpNzDqXg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 03:36:10 +1100 (AEDT)
Received: by mail-ua1-f68.google.com with SMTP id e16so1125953uam.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 08:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=adm1Mw3mLDDQkb5Mftiy3lAZ198qNeHBJOL4SrY1tf8=;
 b=qjkneT14OuyhPQds2sTwADIlzNvZbxchjDE2ZLx4D3AIsfdp5HR2N/G/uMPgaplB3b
 cHqylmVP6cqwfyxC/0e3UK0uhgYy3Y/FCRBwpELkxLxkTgDWNLZ2jI3Sc+/cLTVOv0pp
 uydZUjJSH7nzj1ib3g1os8jqD0SanBNYuWMu+Aqrp3WH06pCCF699mk90o2lWniFt7y+
 /YF9yk4rEvOFEsLIrN565WycWLV5/zGQoffB50rs6T3cTmCsBl/L2EpkDRtUAH9SOBFi
 UJZ2te48AZQAryj0LkCNgLv/O/5dHiZbq0jHUglO8hvc48XfPvSRjCnlA1WcSbvuD1Fh
 +Buw==
X-Gm-Message-State: AJcUukfh9TBWSZHyJsYh94dqLy24LwrGQQMYO07g6r8iHyyxz9pxlXd0
 xCn0vFvm5jlv9EHFVdrRFHtZh/Mlr7skFGl3/zU=
X-Google-Smtp-Source: ALg8bN5nyuahVho846ktl4afIc2BkzN7/rQ1M7vxhSJ6rgU6eyfffsa43/9sALd1FvtSGdvtLkpiFjHkbityoUbDtSg=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr1882691ual.20.1547570168071; 
 Tue, 15 Jan 2019 08:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-15-arnd@arndb.de>
 <87pnsz28k2.fsf@concordia.ellerman.id.au>
 <CAK8P3a0uas76i2W1yjFvxHT-2=A8_egUZeAUM-Vya6386+87Xg@mail.gmail.com>
 <CAK8P3a3eUzGDrJtV2ySpgHwjKHwZYr+1xHp6tChCt1gWi=mJ+g@mail.gmail.com>
In-Reply-To: <CAK8P3a3eUzGDrJtV2ySpgHwjKHwZYr+1xHp6tChCt1gWi=mJ+g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 Jan 2019 17:35:55 +0100
Message-ID: <CAMuHMdVw1mBLGdn4hkiNVyoJ_oxMwi3d=_e7WL5ru+ALA4MKbw@mail.gmail.com>
Subject: Re: [PATCH 14/15] arch: add split IPC system calls where needed
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
Cc: Rich Felker <dalias@libc.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Deepa Dinamani <deepa.kernel@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Firoz Khan <firoz.khan@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Will Deacon <will.deacon@arm.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 alpha <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Arnd,

On Tue, Jan 15, 2019 at 4:19 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Jan 15, 2019 at 4:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Jan 14, 2019 at 4:59 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> > > Arnd Bergmann <arnd@arndb.de> writes:
> > > >  arch/m68k/kernel/syscalls/syscall.tbl     | 11 +++++++++++
> > > >  arch/mips/kernel/syscalls/syscall_o32.tbl | 11 +++++++++++
> > > >  arch/powerpc/kernel/syscalls/syscall.tbl  | 12 ++++++++++++
> > >
> > > I have some changes I'd like to make to our syscall table that will
> > > clash with this.
> > >
> > > I'll try and send them today.
> >
> > Ok. Are those for 5.0 or 5.1? If they are intended for 5.0, it would be
> > nice for me to have a branch based on 5.0-rc1 that I can put
> > the other patches on top of.
>
> There is also another change that I considered:
>
> At the end of my series, we have a lot of entries like
>
> 245     32      clock_settime                   sys_clock_settime32
> 245     64      clock_settime                   sys_clock_settime
> 245     spu     clock_settime                   sys_clock_settime
>
> which could be folded into
>
> 245     32      clock_settime                   sys_clock_settime32
> 245     spu64 clock_settime                   sys_clock_settime
>
> if we just add another option to the ABI field. Any thoughts on
> that?

So "spu64" would mean "spu + 64"?
That makes it more difficult to read, and to grep.
What about allowing multiple ABIs, separated by commas?
So that line would become:

    245     spu,64 clock_settime                   sys_clock_settime

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
