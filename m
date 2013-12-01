Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pd0-x230.google.com (mail-pd0-x230.google.com
 [IPv6:2607:f8b0:400e:c02::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9C71A2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Dec 2013 20:50:21 +1100 (EST)
Received: by mail-pd0-f176.google.com with SMTP id w10so15976798pde.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Dec 2013 01:50:16 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1385891092-13266-1-git-send-email-geert@linux-m68k.org>
References: <1385891092-13266-1-git-send-email-geert@linux-m68k.org>
Date: Sun, 1 Dec 2013 10:50:16 +0100
Message-ID: <CAMuHMdV1hoUnYixPghCAy-LuTaB9JU-BFfBPH06gxhLRAqfp8Q@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.13-rc2
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: sparclinux <sparclinux@vger.kernel.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 1, 2013 at 10:44 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.13-rc2[1] to v3.13-rc1[3], the summaries are:
>   - build errors: +8/-8
>   - build warnings: +147/-97

  + /scratch/kisskb/src/drivers/crypto/caam/jr.c: error: implicit
declaration of function 'of_iomap'
[-Werror=implicit-function-declaration]:  => 468:2

powerpc/mpc85xx_defconfig

  + /scratch/kisskb/src/arch/powerpc/kernel/swsusp_booke.S: Error:
invalid sprg number:  => 161, 85, 165, 91, 167, 163, 87, 89

powerpc-randconfig

  + /scratch/kisskb/src/drivers/tty/ehv_bytechan.c: error: type
defaults to 'int' in declaration of 'console_initcall'
[-Werror=implicit-int]:  => 363:1

powerpc-allmodconfig

  + /scratch/kisskb/src/arch/sparc/kernel/kgdb_64.c: error: implicit
declaration of function 'exception_enter'
[-Werror=implicit-function-declaration]:  => 162:7
  + /scratch/kisskb/src/arch/sparc/kernel/kgdb_64.c: error: implicit
declaration of function 'exception_exit'
[-Werror=implicit-function-declaration]:  => 176:2

sparc64-allmodconfig

  + error: drivers/built-in.o: undefined reference to
`i2c_register_driver':  => .init.literal+0xd88)
  + error: sram.c: undefined reference to `devm_regmap_init_i2c':  =>
.text+0x590dc)

sparc-allmodconfig
xtensa-allmodconfig

  + /scratch/kisskb/src/drivers/gpu/drm/drm_gem_cma_helper.c: error:
implicit declaration of function 'dma_alloc_writecombine'
[-Werror=implicit-function-declaration]:  => 91:2
  + /scratch/kisskb/src/drivers/gpu/drm/drm_gem_cma_helper.c: error:
implicit declaration of function 'dma_free_writecombine'
[-Werror=implicit-function-declaration]:  => 176:3

sh-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/6939/ (119 out of 120 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/6919/ (119 out of 120 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
