Return-Path: <groeck7@gmail.com>
Received: from mail-pb0-x22f.google.com (mail-pb0-x22f.google.com
 [IPv6:2607:f8b0:400e:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EE1062C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2013 07:45:45 +1100 (EST)
Received: by mail-pb0-f47.google.com with SMTP id um1so21700072pbc.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Dec 2013 12:45:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 3 Dec 2013 12:45:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v3.13-rc2
Message-ID: <20131203204540.GA4796@roeck-us.net>
References: <1385891092-13266-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdV1hoUnYixPghCAy-LuTaB9JU-BFfBPH06gxhLRAqfp8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdV1hoUnYixPghCAy-LuTaB9JU-BFfBPH06gxhLRAqfp8Q@mail.gmail.com>
Cc: sparclinux <sparclinux@vger.kernel.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 01, 2013 at 10:50:16AM +0100, Geert Uytterhoeven wrote:
> On Sun, Dec 1, 2013 at 10:44 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v3.13-rc2[1] to v3.13-rc1[3], the summaries are:
> >   - build errors: +8/-8
> >   - build warnings: +147/-97
> 
>   + /scratch/kisskb/src/drivers/crypto/caam/jr.c: error: implicit
> declaration of function 'of_iomap'
> [-Werror=implicit-function-declaration]:  => 468:2
> 
> powerpc/mpc85xx_defconfig
> 
>   + /scratch/kisskb/src/arch/powerpc/kernel/swsusp_booke.S: Error:
> invalid sprg number:  => 161, 85, 165, 91, 167, 163, 87, 89
> 
> powerpc-randconfig
> 
>   + /scratch/kisskb/src/drivers/tty/ehv_bytechan.c: error: type
> defaults to 'int' in declaration of 'console_initcall'
> [-Werror=implicit-int]:  => 363:1
> 
> powerpc-allmodconfig
> 
>   + /scratch/kisskb/src/arch/sparc/kernel/kgdb_64.c: error: implicit
> declaration of function 'exception_enter'
> [-Werror=implicit-function-declaration]:  => 162:7
>   + /scratch/kisskb/src/arch/sparc/kernel/kgdb_64.c: error: implicit
> declaration of function 'exception_exit'
> [-Werror=implicit-function-declaration]:  => 176:2
> 
> sparc64-allmodconfig
> 
>   + error: drivers/built-in.o: undefined reference to
> `i2c_register_driver':  => .init.literal+0xd88)
>   + error: sram.c: undefined reference to `devm_regmap_init_i2c':  =>
> .text+0x590dc)
> 
> sparc-allmodconfig
> xtensa-allmodconfig
> 
>   + /scratch/kisskb/src/drivers/gpu/drm/drm_gem_cma_helper.c: error:
> implicit declaration of function 'dma_alloc_writecombine'
> [-Werror=implicit-function-declaration]:  => 91:2
>   + /scratch/kisskb/src/drivers/gpu/drm/drm_gem_cma_helper.c: error:
> implicit declaration of function 'dma_free_writecombine'
> [-Werror=implicit-function-declaration]:  => 176:3
> 
> sh-randconfig
> 
> > [1] http://kisskb.ellerman.id.au/kisskb/head/6939/ (119 out of 120 configs)
> > [3] http://kisskb.ellerman.id.au/kisskb/head/6919/ (119 out of 120 configs)
> 
Also:

ia64-defconfig:

arch/ia64/kernel/built-in.o: In function `skip_rbs_switch':
(.text+0xef2): undefined reference to `preempt_schedule_irq'

arm-allmodconfig:

drivers/isdn/hisax/telespci.c: In function 'setup_telespci':
drivers/isdn/hisax/telespci.c:294:2: error: #error "not running on big endian machines now"

mips64 (out of tree 64 bit configuration with MIPS32_O32 not set):

arch/mips/include/asm/syscall.h: In function 'mips_get_syscall_arg':
arch/mips/include/asm/syscall.h:32:16: error: unused variable 'usp' [-Werror=unused-variable]

Guenter
