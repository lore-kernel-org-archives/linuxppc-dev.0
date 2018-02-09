Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ua0-x236.google.com (mail-ua0-x236.google.com
 [IPv6:2607:f8b0:400c:c08::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdKR40kzlzF0hK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 02:55:43 +1100 (AEDT)
Received: by mail-ua0-x236.google.com with SMTP id t6so5431920ual.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Feb 2018 07:55:43 -0800 (PST)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <20180209144829.GP21977@gate.crashing.org>
References: <CA+7wUswUir9cHEyvdT8vc+tvSxrcsoY8da+CpqG6kpc4oMj9Wg@mail.gmail.com>
 <20180209144829.GP21977@gate.crashing.org>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 9 Feb 2018 16:55:20 +0100
Message-ID: <CA+7wUsybiroxTP8tuvANuAKYKQjNQ8ayNtQDL=1jBV3uZJe-ow@mail.gmail.com>
Subject: Re: powerpc-linux-gnu-ld: cannot open linker script file
 arch/powerpc/boot/zImage.coff.lds: No such file or directory
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher,

On Fri, Feb 9, 2018 at 3:48 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> Hi!
>
> On Fri, Feb 09, 2018 at 12:52:03PM +0100, Mathieu Malaterre wrote:
>> Is anyone using O= output directory option ?
>
> Yes, always.

Great !

>> It seems that git/master is failing:
>>
>> $ make O=ppc6xx ARCH=powerpc ppc6xx_defconfig
>> $ make O=ppc6xx ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- zImage
>
> Works fine for me (exact same arch and defconfig).  Two differences:
> 1) I also set CROSS_COMPILE during the config step;
> 2) I don't build zImage, just the default (but manual "make zImage"
> afterwards works fine).

Could you run command (2) a second time on your system.

>>   WRAP    arch/powerpc/boot/zImage.coff
>> powerpc-linux-gnu-ld: cannot open linker script file
>> arch/powerpc/boot/zImage.coff.lds: No such file or directory
>> ../arch/powerpc/boot/Makefile:375: recipe for target
>> 'arch/powerpc/boot/zImage.coff' failed
>> make[2]: *** [arch/powerpc/boot/zImage.coff] Error 1
>
> Add V=1?

Full steps:

$ make O=ppc6xx ARCH=powerpc ppc6xx_defconfig
$ make O=ppc6xx ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- zImage
-> ok so far
$ make O=ppc6xx -j4 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-
make[1]: Entering directory '/home/mathieu/tmp/linux/ppc6xx'
  CHK     include/config/kernel.release
  GEN     ./Makefile
  CHK     include/generated/uapi/linux/version.h
  Using .. as source for kernel
  .. is not clean, please run 'make mrproper'
  in the '..' directory.
/home/mathieu/tmp/linux/Makefile:1074: recipe for target 'prepare3' failed
make[1]: *** [prepare3] Error 1
make[1]: Leaving directory '/home/mathieu/tmp/linux/ppc6xx'
Makefile:146: recipe for target 'sub-make' failed
make: *** [sub-make] Error 2

Then even after a mrproper I enter in an odd state:

$ make O=ppc6xx -j4 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- mrproper
make[1]: Entering directory '/home/mathieu/tmp/linux/ppc6xx'
rm -f .tmp_symbols.txt
  CLEAN   scripts/basic
  CLEAN   scripts/kconfig
  CLEAN   include/config include/generated arch/powerpc/include/generated
  CLEAN   .config
make[1]: Leaving directory '/home/mathieu/tmp/linux/ppc6xx'
mathieu@vostrodell:~/tmp/linux$ make O=ppc6xx ARCH=powerpc ppc6xx_defconfig
make[1]: Entering directory '/home/mathieu/tmp/linux/ppc6xx'
  HOSTCC  scripts/basic/fixdep
  GEN     ./Makefile
  HOSTCC  scripts/kconfig/conf.o
  YACC    scripts/kconfig/zconf.tab.c
  LEX     scripts/kconfig/zconf.lex.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
#
# configuration written to .config
#
make[1]: Leaving directory '/home/mathieu/tmp/linux/ppc6xx'
$ make O=ppc6xx -j4 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- V=1
make -C /home/mathieu/tmp/linux/ppc6xx KBUILD_SRC=/home/mathieu/tmp/linux \
-f /home/mathieu/tmp/linux/Makefile
make[1]: Entering directory '/home/mathieu/tmp/linux/ppc6xx'
set -e; : '  CHK     include/config/kernel.release'; mkdir -p
include/config/; echo "4.15.0$(/bin/bash ../scripts/setlocalversion
..)" < include/config/auto.conf > include/config/kernel.release.tmp;
if [ -r include/config/kernel.release ] && cmp -s
include/config/kernel.release include/config/kernel.release.tmp; then
rm -f include/config/kernel.release.tmp; else : '  UPD
include/config/kernel.release'; mv -f
include/config/kernel.release.tmp include/config/kernel.release; fi
ln -fsn .. source
make -f ../scripts/Makefile.asm-generic \
            src=uapi/asm obj=arch/powerpc/include/generated/uapi/asm
/bin/bash ../scripts/mkmakefile \
    .. . 4 15
  GEN     ./Makefile
set -e; : '  CHK     include/generated/uapi/linux/version.h'; mkdir -p
include/generated/uapi/linux/; (echo \#define LINUX_VERSION_CODE
265984; echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8)
+ (c))';) < ../Makefile > include/generated/uapi/linux/version.h.tmp;
if [ -r include/generated/uapi/linux/version.h ] && cmp -s
include/generated/uapi/linux/version.h
include/generated/uapi/linux/version.h.tmp; then rm -f
include/generated/uapi/linux/version.h.tmp; else : '  UPD
include/generated/uapi/linux/version.h'; mv -f
include/generated/uapi/linux/version.h.tmp
include/generated/uapi/linux/version.h; fi
make -f ../scripts/Makefile.build obj=scripts/basic
rm -f include/linux/version.h
awk '!x[$0]++' init/modules.builtin usr/modules.builtin
arch/powerpc/kernel/modules.builtin arch/powerpc/mm/modules.builtin
arch/powerpc/lib/modules.builtin arch/powerpc/sysdev/modules.builtin
arch/powerpc/platforms/modules.builtin
arch/powerpc/math-emu/modules.builtin
arch/powerpc/crypto/modules.builtin arch/powerpc/net/modules.builtin
arch/powerpc/xmon/modules.builtin arch/powerpc/perf/modules.builtin
kernel/modules.builtin certs/modules.builtin mm/modules.builtin
fs/modules.builtin ipc/modules.builtin security/modules.builtin
crypto/modules.builtin block/modules.builtin drivers/modules.builtin
sound/modules.builtin firmware/modules.builtin
arch/powerpc/oprofile/modules.builtin net/modules.builtin
lib/modules.builtin virt/modules.builtin > ./modules.builtin
(cat /dev/null; ) > scripts/basic/modules.order
rm -f .tmp_quiet_recordmcount
make -f ../scripts/Makefile.asm-generic \
            src=asm obj=arch/powerpc/include/generated/asm
if [ -f ../.config -o -d ../include/config ]; then \
echo >&2 "  .. is not clean, please run 'make mrproper'"; \
echo >&2 "  in the '..' directory.";\
/bin/false; \
fi;
  .. is not clean, please run 'make mrproper'
  in the '..' directory.
/home/mathieu/tmp/linux/Makefile:1074: recipe for target 'prepare3' failed
make[1]: *** [prepare3] Error 1
make[1]: Leaving directory '/home/mathieu/tmp/linux/ppc6xx'
Makefile:146: recipe for target 'sub-make' failed
make: *** [sub-make] Error 2


Current commit is f1517df8701c9f12dae9ce7f43a5d300a6917619 on my side,
no local change.
