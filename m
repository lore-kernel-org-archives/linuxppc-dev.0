Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ua0-f194.google.com (mail-ua0-f194.google.com
 [209.85.217.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Vw9H4gwmzF3Hb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 21:37:06 +1000 (AEST)
Received: by mail-ua0-f194.google.com with SMTP id g18-v6so2699013uam.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 04:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180619140229.3615110-1-arnd@arndb.de>
 <20180619140229.3615110-2-arnd@arndb.de>
In-Reply-To: <20180619140229.3615110-2-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Jul 2018 13:36:52 +0200
Message-ID: <CAMuHMdXHUwbD4ZBuQz-xYQO=QdYdPS=j=oLWBet6B7PrGEkT9Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] [v2] m68k: mac: use time64_t in RTC handling
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Joshua Thompson <funaho@jurai.org>, Mathieu Malaterre <malat@debian.org>,
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

On Tue, Jun 19, 2018 at 4:04 PM Arnd Bergmann <arnd@arndb.de> wrote:
> The real-time clock on m68k (and powerpc) mac systems uses an unsigned
> 32-bit value starting in 1904, which overflows in 2040, about two years
> later than everyone else, but this gets wrapped around in the Linux
> code in 2038 already because of the deprecated usage of time_t and/or
> long in the conversion.
>
> Getting rid of the deprecated interfaces makes it work until 2040 as
> documented, and it could be easily extended by reinterpreting
> the resulting time64_t as a positive number. For the moment, I'm
> adding a WARN_ON() that triggers if we encounter a time before 1970
> or after 2040 (the two are indistinguishable).
>
> This brings it in line with the corresponding code that we have on
> powerpc macintosh.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

Applied and queued for v4.19, with the WARN_ON() dropped.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
