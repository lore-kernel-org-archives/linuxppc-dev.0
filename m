Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-lb0-x22d.google.com (mail-lb0-x22d.google.com
 [IPv6:2a00:1450:4010:c04::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D3991A0032
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 05:17:16 +1100 (AEDT)
Received: by mail-lb0-f173.google.com with SMTP id 10so1486871lbg.32
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 11:17:11 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1413915046-32485-1-git-send-email-geert+renesas@glider.be>
References: <1413915046-32485-1-git-send-email-geert+renesas@glider.be>
Date: Tue, 21 Oct 2014 20:17:11 +0200
Message-ID: <CAMuHMdWTOzvDGjtkQkw5ZnF+6HmHppj7P6-BdkOhB=xwxn7f-w@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.18-rc1
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 21, 2014 at 8:10 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Below is the list of build error/warning regressions/improvements in
> v3.18-rc1[1] compared to v3.17[2].
>
> Summarized:
>   - build errors: +21/-15

> [1] http://kisskb.ellerman.id.au/kisskb/head/8002/ (all 119 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/7938/ (118 out of 119 configs)

>   + /scratch/kisskb/src/arch/powerpc/kernel/cacheinfo.c: error: 'size_kb' may be used uninitialized in this function [-Werror=uninitialized]:  => 525:2
>   + /scratch/kisskb/src/arch/powerpc/lib/rheap.c: error: 'be' may be used uninitialized in this function [-Werror=uninitialized]:  => 417:2
>   + /scratch/kisskb/src/arch/powerpc/lib/rheap.c: error: 'bs' may be used uninitialized in this function [-Werror=uninitialized]:  => 424:17
>   + /scratch/kisskb/src/arch/powerpc/lib/rheap.c: error: 'start' may be used uninitialized in this function [-Werror=uninitialized]:  => 497:22
>   + /scratch/kisskb/src/arch/powerpc/lib/sstep.c: error: 'do_lfd' undeclared (first use in this function):  => 1874:29
>   + /scratch/kisskb/src/arch/powerpc/lib/sstep.c: error: 'do_lfs' undeclared (first use in this function):  => 1872:29
>   + /scratch/kisskb/src/arch/powerpc/lib/sstep.c: error: 'do_stfd' undeclared (first use in this function):  => 1928:30
>   + /scratch/kisskb/src/arch/powerpc/lib/sstep.c: error: 'do_stfs' undeclared (first use in this function):  => 1926:30
>   + /scratch/kisskb/src/arch/powerpc/lib/sstep.c: error: implicit declaration of function 'do_fp_load' [-Werror=implicit-function-declaration]:  => 1872:4
>   + /scratch/kisskb/src/arch/powerpc/lib/sstep.c: error: implicit declaration of function 'do_fp_store' [-Werror=implicit-function-declaration]:  => 1926:4
>   + /scratch/kisskb/src/arch/powerpc/xmon/xmon.c: error: unused variable 'badaddr' [-Werror=unused-variable]:  => 1141:13
>   + /scratch/kisskb/src/arch/powerpc/xmon/xmon.c: error: unused variable 'mode' [-Werror=unused-variable]:  => 1139:6

powerpc-randconfig

sstep.c lacks some #ifdef CONFIG_PPC_FPU

>   + /scratch/kisskb/src/drivers/bcma/main.c: error: implicit declaration of function 'of_translate_address' [-Werror=implicit-function-declaration]:  => 150:3

sparc64-allmodconfig, sparc-allmodconfig

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
