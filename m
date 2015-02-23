Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-x22c.google.com (mail-ob0-x22c.google.com
 [IPv6:2607:f8b0:4003:c01::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C97B01A0C12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 20:14:58 +1100 (AEDT)
Received: by mail-ob0-f172.google.com with SMTP id nt9so35277164obb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 01:14:55 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <5900255.NhXvduRnha@wuerfel>
References: <1424680402-3477-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdXnVLtiSxqwz7ah5faPUx_8piN5eOdNKQtKNwOgT73FqA@mail.gmail.com>
 <5900255.NhXvduRnha@wuerfel>
Date: Mon, 23 Feb 2015 10:14:55 +0100
Message-ID: <CAMuHMdVMCvw1euM0c2AYrYibO4ObZLV6F_-CDPZZ6x44D6Hwug@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.0-rc1
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 23, 2015 at 10:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> >   + /home/kisskb/slave/src/fs/dax.c: error: implicit declaration of function 'copy_user_page' [-Werror=implicit-function-declaration]:  => 266:2
>
> DAX support was merged with 'depends on !(ARM || MIPS || SPARC)', so I don't
> see how this could happen.

sh is not ARM, not MIPS, not SPARC, so...?

>> sh-randconfig

>> >   + /home/kisskb/slave/src/sound/soc/codecs/max98357a.c: error: implicit declaration of function 'devm_gpiod_get' [-Werror=implicit-function-declaration]:  => 55:2
>> >   + /home/kisskb/slave/src/sound/soc/codecs/max98357a.c: error: implicit declaration of function 'gpiod_direction_output' [-Werror=implicit-function-declaration]:  => 61:2
>> >   + /home/kisskb/slave/src/sound/soc/codecs/max98357a.c: error: implicit declaration of function 'gpiod_set_value' [-Werror=implicit-function-declaration]:  => 30:3
>
> Something wrong in arch/sh/include/asm/gpio.h? the codec is only
> selectable when gpiolib is enabled, but the consumer.h header
> apparently does not get included here.

I think it's an bad select, for which a patch has been available since
about 2 weeks.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
