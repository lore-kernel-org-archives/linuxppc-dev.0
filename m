Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBAE31A0BD1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 20:03:52 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: Build regressions/improvements in v4.0-rc1
Date: Mon, 23 Feb 2015 10:03:10 +0100
Message-ID: <5900255.NhXvduRnha@wuerfel>
In-Reply-To: <CAMuHMdXnVLtiSxqwz7ah5faPUx_8piN5eOdNKQtKNwOgT73FqA@mail.gmail.com>
References: <1424680402-3477-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdXnVLtiSxqwz7ah5faPUx_8piN5eOdNKQtKNwOgT73FqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 23 February 2015 09:45:43 Geert Uytterhoeven wrote:
> On Mon, Feb 23, 2015 at 9:33 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v4.0-rc1[1] compared to v3.19[2].
> >
> > Summarized:
> >   - build errors: +11/-10
> 
> > [1] http://kisskb.ellerman.id.au/kisskb/head/8494/ (256 out of 257 configs)
> > [2] http://kisskb.ellerman.id.au/kisskb/head/8427/ (255 out of 257 configs)
> >
> >
> > *** ERRORS ***
> >
> > 11 regressions:
> >   + /home/kisskb/slave/src/arch/arm/include/asm/atomic.h: error: #error SMP not supported on pre-ARMv6 CPUs:  => 137:2
> >   + /home/kisskb/slave/src/arch/arm/include/asm/cmpxchg.h: error: #error "SMP is not supported on this platform":  => 114:2
> 
> arm-randconfig
> 
> SMP does depend on CPU_V6K || CPU_V7 and on HAVE_SMP... strange...

V6/V7 and  the earlier V4/V5 are normally mutually exclusive, but we sometimes
screw up the dependencies for some platform, in which case you can end up
with a config that includes both and gives the above error. I'll have a look.

I thought I'd fixed all the bugs we introduced in the merge window in yesterday's
fixes branch.

There is one known problem for mach-realview in this area, for which
I have a fix.

> >   + /home/kisskb/slave/src/fs/dax.c: error: implicit declaration of function 'copy_user_page' [-Werror=implicit-function-declaration]:  => 266:2

DAX support was merged with 'depends on !(ARM || MIPS || SPARC)', so I don't
see how this could happen.

> sh-randconfig
> 
> >   + /home/kisskb/slave/src/sound/soc/codecs/max98357a.c: error: implicit declaration of function 'devm_gpiod_get' [-Werror=implicit-function-declaration]:  => 55:2
> >   + /home/kisskb/slave/src/sound/soc/codecs/max98357a.c: error: implicit declaration of function 'gpiod_direction_output' [-Werror=implicit-function-declaration]:  => 61:2
> >   + /home/kisskb/slave/src/sound/soc/codecs/max98357a.c: error: implicit declaration of function 'gpiod_set_value' [-Werror=implicit-function-declaration]:  => 30:3

Something wrong in arch/sh/include/asm/gpio.h? the codec is only
selectable when gpiolib is enabled, but the consumer.h header
apparently does not get included here.

> s390-allyesconfig
> s390-allmodconfig
> parisc-allmodconfig
> sh-allmodconfig
> sh-allyesconfig
> cris-allyesconfig
> cris-allmodconfig
> mips-allmodconfig
> 
> >   + error: asm9260_timer.c: undefined reference to `of_io_request_and_map':  => .init.text+0x4014), .init.text+0x5c84)

asm9260 is arm-specific, we probably need to refine the dependencies here
to ensure that OF_ADDRESS is set. Need to think about what the best set of
dependencies is.

	Arnd
