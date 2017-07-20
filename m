Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xClCx07rfzDrD9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 17:00:45 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id p185so919417iof.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 00:00:44 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20170720062850.2195-1-matthew.brown.dev@gmail.com>
References: <20170720062850.2195-1-matthew.brown.dev@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Jul 2017 09:00:41 +0200
Message-ID: <CAMuHMdVxnqD-90fDH+dqo8iJ94etcLHih27cqdVppi_AbFzbbw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/asm/cacheflush: Cleanup cacheflush function params
To: Matt Brown <matthew.brown.dev@gmail.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 MTD Maling List <linux-mtd@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linux-spi <linux-spi@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 20, 2017 at 8:28 AM, Matt Brown <matthew.brown.dev@gmail.com> wrote:
> The cacheflush prototypes currently use start and stop values and each
> call requires typecasting the address to an unsigned long.
> This patch changes the cacheflush prototypes to follow the x86 style of
> using a base and size values, with base being a void pointer.
>
> All callers of the cacheflush functions, including drivers, have been
> modified to conform to the new prototypes.
>
> The 64 bit cacheflush functions which were implemented in assembly code
> (flush_dcache_range, flush_inval_dcache_range) have been translated into
> C for readability and coherence.
>
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>

>  drivers/spi/spi-bfin5xx.c                    | 10 +++---
>  drivers/usb/musb/blackfin.c                  |  6 ++--

These are used on blackfin, so changing them without changing the blackfin
cache ops will break the build.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
