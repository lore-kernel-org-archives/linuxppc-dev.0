Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-yw0-f44.google.com (mail-yw0-f44.google.com
 [209.85.213.44])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AC313B6FAB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 02:36:57 +1000 (EST)
Received: by yhq56 with SMTP id 56so4037130yhq.17
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2012 09:36:54 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20120628082009.GC21764@linux-sh.org>
References: <1340740795-19603-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdXY1DFNV+jTiJkT99TbX7ZL5eEiKcG0iqZkUa8T7YZG4g@mail.gmail.com>
 <20120628082009.GC21764@linux-sh.org>
Date: Fri, 29 Jun 2012 18:36:53 +0200
Message-ID: <CAMuHMdX_C1u_FsG4ZTrK8T2HNb7Tu84u6xOL4Z5Z5txpkNnZdQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.5-rc4
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mundt <lethal@linux-sh.org>
Content-Type: text/plain; charset=UTF-8
Cc: the arch/x86 maintainers <x86@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,

On Thu, Jun 28, 2012 at 10:20 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Tue, Jun 26, 2012 at 10:06:27PM +0200, Geert Uytterhoeven wrote:
>> On Tue, Jun 26, 2012 at 9:59 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> > JFYI, when comparing v3.5-rc4 to v3.5-rc3[3], the summaries are:
>> > ??- build errors: +11/-219
>>
>> 11 regressions:
>> =C2=A0 + arch/sh/include/asm/fixmap.h: error: implicit declaration of
>> function 'BUG_ON' [-Werror=3Dimplicit-function-declaration]: =C2=A0=3D> =
133:2
>> =C2=A0 + arch/sh/include/asm/thread_info.h: error: implicit declaration =
of
>> function 'WARN_ON' [-Werror=3Dimplicit-function-declaration]: =C2=A0=3D>=
 172:2
>> =C2=A0 + include/linux/huge_mm.h: error: implicit declaration of functio=
n
>> 'BUG' [-Werror=3Dimplicit-function-declaration]: =C2=A0=3D> 185:2
>>
>> shmin_defconfig, se7712_defconfig, se7721_defconfig, sh-allnoconfig
>>
> I'm unable to reproduce any of these, is there some specific compiler
> version or warning flag configuration I'm supposed to be using? I'm
> building with 4.5.1 at the moment.

Mine (from Tony) is:

sh4-linux-gcc -v
Using built-in specs.
COLLECT_GCC=3D/usr/local/gcc-4.6.3-nolibc/sh4-linux/bin/sh4-linux-gcc
COLLECT_LTO_WRAPPER=3D/usr/local/gcc-4.6.3-nolibc/sh4-linux/bin/../libexec/=
gcc/sh4-linux/4.6.3/lto-wrapper
Target: sh4-linux
Configured with: /home/tony/buildall/src/gcc/configure
--target=3Dsh4-linux --host=3Dx86_64-linux-gnu --build=3Dx86_64-linux-gnu
--enable-targets=3Dall --prefix=3D/opt/cross/gcc-4.6.3-nolibc/sh4-linux/
--enable-languages=3Dc --with-newlib --without-headers --disable-nls
--disable-threads --disable-shared --disable-libmudflap
--disable-libssp --disable-libgomp --disable-decimal-float
--enable-checking=3Drelease --with-multilib-list=3Dm4,m4-nofpu
--with-mpfr=3D/home/tony/buildall/src/sys-x86_64
--with-gmp=3D/home/tony/buildall/src/sys-x86_64 --disable-bootstrap
--disable-libquadmath
Thread model: single
gcc version 4.6.3 (GCC)

Using v3.5-rc4:

se7721_defconfig:

sh4-linux-gcc -Wp,-MD,arch/sh/kernel/.asm-offsets.s.d  -nostdinc
-isystem /usr/local/gcc-4.6.3-nolibc/sh4-linux/bin/../lib/gcc/sh4-linux/4.6=
.3/include
-Iarch/sh/include -Iarch/sh/include/generated -Iinclude  -include
include/linux/kconfig.h -D__KERNEL__ -m4-nofpu -ml -Wa,-isa=3Dany
-ffreestanding -Iarch/sh/include/cpu-sh3 -Iarch/sh/include/cpu-common
-Iarch/sh/include/mach-se -Iarch/sh/include/mach-common -Wall -Wundef
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
-Werror-implicit-function-declaration -Wno-format-security
-fno-delete-null-pointer-checks -O2 -pipe -m4-nofpu -ml -Wa,-isa=3Dany
-ffreestanding -Iarch/sh/include/cpu-sh3 -Iarch/sh/include/cpu-common
-Iarch/sh/include/mach-se -Iarch/sh/include/mach-common
-Wframe-larger-than=3D1024 -fno-stack-protector
-Wno-unused-but-set-variable -fno-omit-frame-pointer
-fno-optimize-sibling-calls -g -Wdeclaration-after-statement
-Wno-pointer-sign -fno-strict-overflow -fconserve-stack
-DCC_HAVE_ASM_GOTO    -D"KBUILD_STR(s)=3D#s"
-D"KBUILD_BASENAME=3DKBUILD_STR(asm_offsets)"
-D"KBUILD_MODNAME=3DKBUILD_STR(asm_offsets)" -fverbose-asm -S -o
arch/sh/kernel/asm-offsets.s arch/sh/kernel/asm-offsets.c
In file included from include/linux/thread_info.h:54:0,
                 from include/linux/preempt.h:9,
                 from include/linux/spinlock.h:50,
                 from include/linux/mmzone.h:7,
                 from include/linux/gfp.h:4,
                 from include/linux/mm.h:8,
                 from arch/sh/kernel/asm-offsets.c:13:
arch/sh/include/asm/thread_info.h: In function 'set_restore_sigmask':
arch/sh/include/asm/thread_info.h:172:2: error: implicit declaration
of function 'WARN_ON' [-Werror=3Dimplicit-function-declaration]
In file included from arch/sh/include/asm/pgtable.h:25:0,
                 from include/linux/mm.h:44,
                 from arch/sh/kernel/asm-offsets.c:13:
arch/sh/include/asm/fixmap.h: In function 'virt_to_fix':
arch/sh/include/asm/fixmap.h:133:2: error: implicit declaration of
function 'BUG_ON' [-Werror=3Dimplicit-function-declaration]
In file included from arch/sh/include/asm/pgtable.h:164:0,
                 from include/linux/mm.h:44,
                 from arch/sh/kernel/asm-offsets.c:13:
include/asm-generic/pgtable.h: In function 'pmdp_test_and_clear_young':
include/asm-generic/pgtable.h:56:2: error: implicit declaration of
function 'BUG' [-Werror=3Dimplicit-function-declaration]
cc1: some warnings being treated as errors
make[1]: *** [arch/sh/kernel/asm-offsets.s] Error 1


allnoconfig:

sh4-linux-gcc -Wp,-MD,arch/sh/kernel/.asm-offsets.s.d  -nostdinc
-isystem /usr/local/gcc-4.6.3-nolibc/sh4-linux/bin/../lib/gcc/sh4-linux/4.6=
.3/include
-Iarch/sh/include -Iarch/sh/include/generated -Iinclude  -include
include/linux/kconfig.h -D__KERNEL__ -m4-nofpu -ml -Wa,-isa=3Dany
-ffreestanding -Iarch/sh/include/cpu-sh2 -Iarch/sh/include/cpu-common
-Iarch/sh/include/mach-common -Wall -Wundef -Wstrict-prototypes
-Wno-trigraphs -fno-strict-aliasing -fno-common
-Werror-implicit-function-declaration -Wno-format-security
-fno-delete-null-pointer-checks -O2 -pipe -m4-nofpu -ml -Wa,-isa=3Dany
-ffreestanding -Iarch/sh/include/cpu-sh2 -Iarch/sh/include/cpu-common
-Iarch/sh/include/mach-common -Wframe-larger-than=3D1024
-fno-stack-protector -Wno-unused-but-set-variable -fomit-frame-pointer
-Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow
-fconserve-stack -DCC_HAVE_ASM_GOTO    -D"KBUILD_STR(s)=3D#s"
-D"KBUILD_BASENAME=3DKBUILD_STR(asm_offsets)"
-D"KBUILD_MODNAME=3DKBUILD_STR(asm_offsets)" -fverbose-asm -S -o
arch/sh/kernel/asm-offsets.s arch/sh/kernel/asm-offsets.c
In file included from include/linux/thread_info.h:54:0,
                 from include/linux/preempt.h:9,
                 from include/linux/spinlock.h:50,
                 from include/linux/mmzone.h:7,
                 from include/linux/gfp.h:4,
                 from include/linux/mm.h:8,
                 from arch/sh/kernel/asm-offsets.c:13:
arch/sh/include/asm/thread_info.h: In function 'set_restore_sigmask':
arch/sh/include/asm/thread_info.h:172:2: error: implicit declaration
of function 'WARN_ON' [-Werror=3Dimplicit-function-declaration]
In file included from arch/sh/include/asm/pgtable.h:25:0,
                 from include/linux/mm.h:44,
                 from arch/sh/kernel/asm-offsets.c:13:
arch/sh/include/asm/fixmap.h: In function 'virt_to_fix':
arch/sh/include/asm/fixmap.h:133:2: error: implicit declaration of
function 'BUG_ON' [-Werror=3Dimplicit-function-declaration]
In file included from include/linux/mm.h:257:0,
                 from arch/sh/kernel/asm-offsets.c:13:
include/linux/huge_mm.h: In function 'hugepage_madvise':
include/linux/huge_mm.h:185:2: error: implicit declaration of function
'BUG' [-Werror=3Dimplicit-function-declaration]
cc1: some warnings being treated as errors
make[1]: *** [arch/sh/kernel/asm-offsets.s] Error 1

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
