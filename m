Return-Path: <joel.stan@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G75L3LSlzF31N
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 17:04:38 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id h4-v6so7538565qtj.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 00:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180914040649.1794-1-joel@jms.id.au>
 <20180914040649.1794-2-joel@jms.id.au>
 <CAKwvOd=imPGj6=en2uFAW6fa8jRo9siAEwMZzoj023HUa3ihOw@mail.gmail.com>
In-Reply-To: <CAKwvOd=imPGj6=en2uFAW6fa8jRo9siAEwMZzoj023HUa3ihOw@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 20 Sep 2018 16:34:23 +0930
Message-ID: <CACPK8XcE=3vTR9JDTJBiZzWiKu__nLd95L4hNJzaZaycX6rONA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] powerpc/Makefiles: Fix clang/llvm build
To: Nick Desaulniers <ndesaulniers@google.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Anton Blanchard <anton@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 15 Sep 2018 at 03:11, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Thu, Sep 13, 2018 at 9:07 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > From: Anton Blanchard <anton@samba.org>
> >
> > Commit 15a3204d24a3 ("powerpc/64s: Set assembler machine type to POWER4")
> > passes -mpower4 to the assembler. We have more recent instructions in our
> > assembly files, but gas permits them. The clang/llvm integrated assembler
> > is more strict, and we get a build failure.
>
> Note that we disable clang's integrated assembler in the top level
> Makefile for now, but it will still validate constraints for inline
> assembly.  Do you know which case is meant by "build failure?"

An example of a failure is:

  CC      init/do_mounts.o
/tmp/do_mounts-58cd1d.s: Assembler messages:
/tmp/do_mounts-58cd1d.s:251: Error: unrecognized opcode: `isel'
/tmp/do_mounts-58cd1d.s:748: Error: unrecognized opcode: `isel'
/tmp/do_mounts-58cd1d.s:759: Error: unrecognized opcode: `isel'
/tmp/do_mounts-58cd1d.s:1373: Error: unrecognized opcode: `isel'

The full build line at the bottom of this email. The m flags:

 -mlittle-endian -m64 -msoft-float -mabi=elfv2 -mcmodel=medium
-mcpu=power8 -mtune=power9 -mno-altivec -mno-vsx -Wa,-maltivec
-Wa,-mpower4 -mlittle-endian

If we remove the -Wa,-mpower4 it works. This is because isel is not
available on power4.

Digging deeper, clang drives gas like this:

"/usr/bin/as" -a64 -mppc64 -mlittle-endian -mpower8 -I
./arch/powerpc/include -I ./arch/powerpc/include/generated -I
./include -I ./arch/powerpc/include/uapi -I
./arch/powerpc/include/generated/uapi -I ./include/uapi -I
./include/generated/uapi -I arch/powerpc -I arch/powerpc -maltivec
-mpower4 -o init/do_mounts.o /tmp/do_mounts-3b0a3d.s

GCC drives it:

as -v -I ./arch/powerpc/include -I ./arch/powerpc/include/generated -I
./include -I ./arch/powerpc/include/uapi -I
./arch/powerpc/include/generated/uapi -I ./include/uapi -I
./include/generated/uapi -I arch/powerpc -I arch/powerpc -a64 -mpower8
-many -mlittle -maltivec -mpower4 -o init/do_mounts.o

I think the important difference is GCC adds -many:

        -many
           Generate code for any architecture (PWR/PWRX/PPC).

This is probably what we mean when building the kernel. I will get
some advice from our toolchain people first to understand what -many
does.

> Is there a link to the Clang bug?  It would be good to have that
> context in the commit message.

I haven't opened a clang bug. I'm not sure that we need one, unless we
want it to add -many to the assembler call like gcc does.

Cheers,

Joel

--
  /scratch/joel/llvm-build/bin/clang-8 -Wp,-MD,init/.do_mounts.o.d
-nostdinc -isystem /scratch/joel/llvm-build/lib/clang/8.0.0/include
-I./arch/powerpc/include -I./arch/powerpc/include/generated
-I./include -I./arch/powerpc/include/uapi
-I./arch/powerpc/include/generated/uapi -I./include/uapi
-I./include/generated/uapi -include ./include/linux/kconfig.h -include
./include/linux/compiler_types.h -D__KERNEL__ -Iarch/powerpc
-DHAVE_AS_ATHIGH=1 -Qunused-arguments -Wall -Wundef
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
-fshort-wchar -Werror-implicit-function-declaration
-Wno-format-security -std=gnu89 -no-integrated-as -fno-PIE
-mlittle-endian -m64 -msoft-float -pipe -Iarch/powerpc -mabi=elfv2
-mcmodel=medium -mcpu=power8 -mtune=power9 -mno-altivec -mno-vsx
-funit-at-a-time -fno-dwarf2-cfi-asm -Wa,-maltivec -Wa,-mpower4
-mlittle-endian -fno-delete-null-pointer-checks -Oz
-Wframe-larger-than=2048 -fno-stack-protector
-Wno-format-invalid-specifier -Wno-gnu -Wno-address-of-packed-member
-Wno-tautological-compare -mno-global-merge -Wno-unused-const-variable
-fomit-frame-pointer -Wdeclaration-after-statement -Wno-pointer-sign
-fno-strict-overflow -fno-merge-all-constants -fno-stack-check
-Werror=implicit-int -Werror=strict-prototypes -Werror=date-time
-Werror=incompatible-pointer-types -Wno-initializer-overrides
-Wno-unused-value -Wno-format -Wno-sign-compare
-Wno-format-zero-length -Wno-uninitialized -fno-function-sections
-fno-data-sections    -DKBUILD_BASENAME='"do_mounts"'
-DKBUILD_MODNAME='"mounts"' -c -o init/do_mounts.o init/do_mounts.c
