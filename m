Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ua0-f193.google.com (mail-ua0-f193.google.com
 [209.85.217.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41NlbF18qzzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Jul 2018 20:49:44 +1000 (AEST)
Received: by mail-ua0-f193.google.com with SMTP id r18-v6so10067648ual.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Jul 2018 03:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180619140229.3615110-1-arnd@arndb.de>
 <20180619140229.3615110-2-arnd@arndb.de>
 <alpine.LNX.2.21.1806221455570.14@nippy.intranet>
 <CAK8P3a2chXVhz+UJ+ujg8QMqyMmJ4zGj9XKuFZ+MsJ=dGqb3eg@mail.gmail.com>
In-Reply-To: <CAK8P3a2chXVhz+UJ+ujg8QMqyMmJ4zGj9XKuFZ+MsJ=dGqb3eg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 8 Jul 2018 12:49:29 +0200
Message-ID: <CAMuHMdWzO1jzd=8SN5G_eoFObEAJR4-5u7JDExMefR__30QauA@mail.gmail.com>
Subject: Re: [PATCH 2/3] [v2] m68k: mac: use time64_t in RTC handling
To: Arnd Bergmann <arnd@arndb.de>
Cc: Finn Thain <fthain@telegraphics.com.au>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Joshua Thompson <funaho@jurai.org>,
 Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Ungerer <gerg@linux-m68k.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Meelis Roos <mroos@linux.ee>, Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnd, Finn,

On Fri, Jun 22, 2018 at 10:55 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Jun 22, 2018 at 7:26 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> > On Tue, 19 Jun 2018, Arnd Bergmann wrote:
> >
> >> The real-time clock on m68k (and powerpc) mac systems uses an unsigned
> >> 32-bit value starting in 1904, which overflows in 2040, about two years
> >> later than everyone else, but this gets wrapped around in the Linux code
> >> in 2038 already because of the deprecated usage of time_t and/or long in
> >> the conversion.
> >>
> >> Getting rid of the deprecated interfaces makes it work until 2040 as
> >> documented, and it could be easily extended by reinterpreting the
> >> resulting time64_t as a positive number. For the moment, I'm adding a
> >> WARN_ON() that triggers if we encounter a time before 1970 or after 2040
> >> (the two are indistinguishable).
> >>
> >
> > I really don't like the WARN_ON(), but I'd prefer to address that in a
> > separate patch rather than impede the progress of this patch (or of this
> > series, since 3/3 seems to be unrelated).
> >
> > BTW, have you considered using the same wrap-around test (i.e. YY < 70)
> > that we use for the year register in the other RTC chips?
>
> That wrap-around test would have the same effect as the my original
> version (aside from the two bugs I now fixed), doing rougly
>
> -        return time - RTC_OFFSET;
> +        return (u32)(time - RTC_OFFSET);
>
> or some other variation of that will give us an RTC that supports all dates
> between 1970 and 2106. I don't think anyone so far had a strong
> preference here, so I went with what Mathieu suggested and kept the
> original Mac behavior, but added the WARN_ON().

So, is this safe to apply?
Especially in light of the warnings seen by Meelis with the PPC version.

Thanks!


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
