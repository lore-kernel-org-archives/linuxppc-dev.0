Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ua0-x22f.google.com (mail-ua0-x22f.google.com
 [IPv6:2607:f8b0:400c:c08::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yz1JG2W0WzDsFf
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 06:50:53 +1100 (AEDT)
Received: by mail-ua0-x22f.google.com with SMTP id i20so6950193uak.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 11:50:53 -0800 (PST)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 15 Dec 2017 20:50:29 +0100
Message-ID: <CA+7wUszecRH7p5iHNXNqmb956PnhZa=4zCx+E4c2ur8Jzf6c4w@mail.gmail.com>
Subject: Mac Mini G4 defconfig ?
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi there,

Does anyone has working defconfig for a Mac Mini G4 ?

Here is what I tried:

$ cat ./arch/powerpc/configs/g4_defconfig
CONFIG_PPC_FPU=y
CONFIG_ALTIVEC=y
$ make ARCH=powerpc g4_defconfig
$ make -j8 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- V=1
set -e; : '  CHK     include/config/kernel.release'; mkdir -p
include/config/; echo "4.15.0-rc3$(/bin/sh ./scripts/setlocalversion
.)" < include/config/auto.conf > include/config/kernel.release.tmp; if
[ -r include/config/kernel.release ] && cmp -s
include/config/kernel.release include/config/kernel.release.tmp; then
rm -f include/config/kernel.release.tmp; else : '  UPD
include/config/kernel.release'; mv -f
include/config/kernel.release.tmp include/config/kernel.release; fi
make -f ./scripts/Makefile.asm-generic \
            src=uapi/asm obj=arch/powerpc/include/generated/uapi/asm
set -e; : '  CHK     include/generated/uapi/linux/version.h'; mkdir -p
include/generated/uapi/linux/; (echo \#define LINUX_VERSION_CODE
265984; echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8)
+ (c))';) < Makefile > include/generated/uapi/linux/version.h.tmp; if
[ -r include/generated/uapi/linux/version.h ] && cmp -s
include/generated/uapi/linux/version.h
include/generated/uapi/linux/version.h.tmp; then rm -f
include/generated/uapi/linux/version.h.tmp; else : '  UPD
include/generated/uapi/linux/version.h'; mv -f
include/generated/uapi/linux/version.h.tmp
include/generated/uapi/linux/version.h; fi
make -f ./scripts/Makefile.build obj=scripts/basic
rm -f include/linux/version.h
make -f ./scripts/Makefile.asm-generic \
            src=asm obj=arch/powerpc/include/generated/asm
(cat /dev/null; ) > scripts/basic/modules.order
rm -f .tmp_quiet_recordmcount
make -f ./scripts/Makefile.build obj=scripts
make -f ./scripts/Makefile.build obj=scripts/dtc need-builtin=
make -f ./scripts/Makefile.build obj=scripts/mod need-builtin=
(cat /dev/null; ) > scripts/mod/modules.order
(cat /dev/null; ) > scripts/dtc/modules.order
  powerpc-linux-gnu-gcc -Wp,-MD,scripts/mod/.devicetable-offsets.s.d
-nostdinc -isystem  -I./arch/powerpc/include
-I./arch/powerpc/include/generated  -I./include
-I./arch/powerpc/include/uapi -I./arch/powerpc/include/generated/uapi
-I./include/uapi -I./include/generated/uapi -include
./include/linux/kconfig.h -D__KERNEL__ -Iarch/powerpc -Wall -Wundef
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
-fshort-wchar -Werror-implicit-function-declaration
-Wno-format-security -std=gnu89 -pipe -Iarch/powerpc -ffixed-r2
-mmultiple -mcpu=powerpc -O2 -fomit-frame-pointer
-DKBUILD_BASENAME='"devicetable_offsets"'
-DKBUILD_MODNAME='"devicetable_offsets"'  -fverbose-asm -S -o
scripts/mod/devicetable-offsets.s scripts/mod/devicetable-offsets.c
In file included from ./include/linux/string.h:6:0,
                 from ./include/uapi/linux/uuid.h:22,
                 from ./include/linux/uuid.h:19,
                 from ./include/linux/mod_devicetable.h:13,
                 from scripts/mod/devicetable-offsets.c:3:
./include/linux/compiler.h:242:25: fatal error: asm/barrier.h: No such
file or directory
 #include <asm/barrier.h>
                         ^
compilation terminated.
scripts/Makefile.build:150: recipe for target
'scripts/mod/devicetable-offsets.s' failed
make[2]: *** [scripts/mod/devicetable-offsets.s] Error 1
scripts/Makefile.build:569: recipe for target 'scripts/mod' failed
make[1]: *** [scripts/mod] Error 2
Makefile:576: recipe for target 'scripts' failed
make: *** [scripts] Error 2
make: *** Waiting for unfinished jobs....
