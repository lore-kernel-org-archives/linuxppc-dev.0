Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-x232.google.com (mail-ob0-x232.google.com
 [IPv6:2607:f8b0:4003:c01::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424121A0A0E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 19:45:46 +1100 (AEDT)
Received: by mail-ob0-f178.google.com with SMTP id uz6so35016536obc.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 00:45:43 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1424680402-3477-1-git-send-email-geert@linux-m68k.org>
References: <1424680402-3477-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 23 Feb 2015 09:45:43 +0100
Message-ID: <CAMuHMdXnVLtiSxqwz7ah5faPUx_8piN5eOdNKQtKNwOgT73FqA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.0-rc1
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 23, 2015 at 9:33 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.0-rc1[1] compared to v3.19[2].
>
> Summarized:
>   - build errors: +11/-10

> [1] http://kisskb.ellerman.id.au/kisskb/head/8494/ (256 out of 257 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/8427/ (255 out of 257 configs)
>
>
> *** ERRORS ***
>
> 11 regressions:
>   + /home/kisskb/slave/src/arch/arm/include/asm/atomic.h: error: #error SMP not supported on pre-ARMv6 CPUs:  => 137:2
>   + /home/kisskb/slave/src/arch/arm/include/asm/cmpxchg.h: error: #error "SMP is not supported on this platform":  => 114:2

arm-randconfig

SMP does depend on CPU_V6K || CPU_V7 and on HAVE_SMP... strange...

>   + /home/kisskb/slave/src/fs/dax.c: error: implicit declaration of function 'copy_user_page' [-Werror=implicit-function-declaration]:  => 266:2

sh-randconfig

>   + /home/kisskb/slave/src/sound/soc/codecs/max98357a.c: error: implicit declaration of function 'devm_gpiod_get' [-Werror=implicit-function-declaration]:  => 55:2
>   + /home/kisskb/slave/src/sound/soc/codecs/max98357a.c: error: implicit declaration of function 'gpiod_direction_output' [-Werror=implicit-function-declaration]:  => 61:2
>   + /home/kisskb/slave/src/sound/soc/codecs/max98357a.c: error: implicit declaration of function 'gpiod_set_value' [-Werror=implicit-function-declaration]:  => 30:3

s390-allyesconfig
s390-allmodconfig
parisc-allmodconfig
sh-allmodconfig
sh-allyesconfig
cris-allyesconfig
cris-allmodconfig
mips-allmodconfig

>   + error: asm9260_timer.c: undefined reference to `of_io_request_and_map':  => .init.text+0x4014), .init.text+0x5c84)

sparc64-allmodconfig
sparc-allmodconfig

>   + error: book3s_64_vio_hv.c: undefined reference to `power7_wakeup_loss':  => .text+0x408)

pseries_defconfig

>   + error: smp.c: undefined reference to `.__flush_disable_L1':  => .text+0xb24)

powerpc-randconfig

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
