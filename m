Return-Path: <joel.stan@gmail.com>
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BMRF1rXczF3T4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 14:07:04 +1000 (AEST)
Received: by mail-pg1-x533.google.com with SMTP id i190-v6so3737526pgc.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 21:07:04 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Cc: Anton Blanchard <anton@ozlabs.org>,
 Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 0/5] powerpc: Clang build fixes
Date: Fri, 14 Sep 2018 13:36:44 +0930
Message-Id: <20180914040649.1794-1-joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v2 rolls up all of the fixes I have into the one series, and adds a few
more fixes.

With a one patch[1] on top of clang master I can build and boot a
powernv kernel. Note that we can't build altivec code using clang
yet[2], hence disabling MD_RAID456.

$ make ARCH=powerpc powernv_defconfig
$ ./scripts/config -d BTRFS_FS -d MD_RAID456
$ make CC=clang-8 CLANG_TRIPLE=powerpc64le-linux-gnu -j128

The build is very noisy as the ftrace recordmcount build step is not
picking up -Qunused-arguments.

$ qemu-system-ppc64 -M powernv -m 3G -nographic -kernel zImage.epapr \
 -L ~/skiboot/ -initrd ~/rootfs.cpio.xz

Linux version 4.19.0-rc3-00005-g7f51dcdecc6b (joel@ozrom3) (clang version 8.0.0 (trunk 342199)) #5 SMP Fri Sep 14 13:28:57 ACST 2018

I have discovered Nick D's clangBuiltLinux issue tracker[3] and will be
updating that as we find and fix issues.

[1] https://reviews.llvm.org/D50965
[2] https://bugs.llvm.org/show_bug.cgi?id=38887
[3] https://github.com/clangBuiltLinux/linux/issues

Anton Blanchard (2):
  powerpc/Makefiles: Fix clang/llvm build
  powerpc: Fix duplicate const clang warning in user access code

Joel Stanley (3):
  powerpc/boot: Fix crt0.S syntax for clang
  powerpc/boot: Ensure _zimage_start is a weak symbol
  powerpc: Remove -mno-sched-epilog

 arch/powerpc/Makefile                    | 7 +------
 arch/powerpc/boot/crt0.S                 | 8 +++++---
 arch/powerpc/include/asm/uaccess.h       | 6 +++---
 arch/powerpc/kernel/Makefile             | 8 ++++----
 arch/powerpc/kernel/trace/Makefile       | 2 +-
 arch/powerpc/platforms/powermac/Makefile | 2 +-
 arch/powerpc/xmon/Makefile               | 2 +-
 7 files changed, 16 insertions(+), 19 deletions(-)

-- 
2.17.1
