Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AFFC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 18:12:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC9E02054F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 18:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9E02054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bDcl2rNfzDqtp
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 05:12:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.217.66; helo=mail-vs1-f66.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vs1-f66.google.com (mail-vs1-f66.google.com
 [209.85.217.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bDZq6JWqzDqv4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 05:11:15 +1100 (AEDT)
Received: by mail-vs1-f66.google.com with SMTP id y27so7619446vsi.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 10:11:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EUuZ5Krtu82auHRun9veeZBKChDTVOpn44W3kwgqDtY=;
 b=gnXJeEua66axQ4bwHlghUkjGuSxRZNpI9MsiW9XgXsNwEHv0oXZJ//5BMfifP8S/uh
 yo4oVbaCWg8FKuJ4xJ8JnQoKC3YKSH6Bwj14kltGv2VLnlMn6Lc7jXreAyVw5FgXcSbI
 Ld/kO7yd5H61dkqOteQuV9wG0+y075vvyO/4qUbz+b8ePCOhkTvAcaTYBXstt4lJJpWG
 NBMa/w9skxPEpdamI/BW28QWaMofgb1skneIfURLhPfywPnjhqedpWHXO0Pbvtewlg+M
 r9r00DuaSFqW7uEQuxumg4q7YrLkj1XTMQqWq8weCxJvRz4CCxTRDYfrfoF3nfu/rsFY
 6kug==
X-Gm-Message-State: AJcUukcevdgRznPkSAJedi6xtAl3vDJ/QQPWko5NcgR6dqYCQneJCE1W
 RJNOAWa8M+68u0o7wt8jl16cAH7+U9ooSdI1HiQ=
X-Google-Smtp-Source: ALg8bN6aokmnpf1j0NX2Ej8BYTOm8/6RZGNDOHHw2gQ7ocUs2TauDUatTN8cLeSj84eryGhe6FE/dq+5R1mIXqFPJxk=
X-Received: by 2002:a67:c202:: with SMTP id i2mr4350248vsj.11.1547143873299;
 Thu, 10 Jan 2019 10:11:13 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <CAMuHMdXYP3=TRHYqddVRfbRRaj_Ou=wfoX6ohKM7XNAx-c2RXw@mail.gmail.com>
 <CAK8P3a0kmr2ju+sZE+f-+=-2t5Eu+t-DS-+r6OKrPVTAxHwf8w@mail.gmail.com>
In-Reply-To: <CAK8P3a0kmr2ju+sZE+f-+=-2t5Eu+t-DS-+r6OKrPVTAxHwf8w@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 10 Jan 2019 19:11:00 +0100
Message-ID: <CAMuHMdVpUNUx-wdDYChYNzMYqYi79w5tzjk5x3JskdS88VQCQw@mail.gmail.com>
Subject: Re: [PATCH 00/15] arch: synchronize syscall tables in preparation for
 y2038
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
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Will Deacon <will.deacon@arm.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 alpha <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Arnd,

On Thu, Jan 10, 2019 at 6:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Jan 10, 2019 at 5:59 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Jan 10, 2019 at 5:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > The system call tables have diverged a bit over the years, and a number
> > > of the recent additions never made it into all architectures, for one
> > > reason or another.
> > >
> > > This is an attempt to clean it up as far as we can without breaking
> > > compatibility, doing a number of steps:
> >
> > Thanks a lot!
> >
> > > - Add system calls that have not yet been integrated into all
> > >   architectures but that we definitely want there.
> >
> > It looks like you missed wiring up io_pgetevents() on m68k.
> > Is that intentional?
>
> Yes, I thought I had described that somewhere but maybe I
> forgot: semtimedop() and io_pgetevents() get replaced with
> time64 versions in the follow-up, so I only added them in
> 64-bit architectures. If you think we should have both
> io_pgetevents() and io_pgetevents_time32() on all 32-bit
> architectures, I can add that as well.

Thanks, sounds fine to me.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
