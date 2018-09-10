Return-Path: <joel.stan@gmail.com>
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4282451bBJzF0Q6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 18:57:24 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id h69-v6so10141554pfd.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 01:57:24 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org,
	Anton Blanchard <anton@ozlabs.org>
Subject: [PATCH 0/2] powerpc: Clang build fixes
Date: Mon, 10 Sep 2018 18:57:12 +1000
Message-Id: <20180910085714.4834-1-joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Two fixes to get us closer to building with clang. With a one patch[1]
on top of clang master I can build and boot a powernv kernel:

$ make ARCH=powerpc powernv_defconfig
$ ./scripts/config -e PPC_DISABLE_WERROR -d FTRACE -d BTRFS_FS -d MD_RAID456
$ make CC=/scratch/joel/llvm-build/bin/clang-8 CLANG_TRIPLE=powerpc64le-linux-gnu -j128

$ qemu-system-ppc64 -M powernv -m 3G -nographic -kernel zImage.epapr \
 -L ~/skiboot/ -initrd ~/rootfs.cpio.xz

Linux version 4.19.0-rc3-00003-g728b25f26bce (joel@ozrom3) (clang version 8.0.0 (trunk 341773)) #12 SMP Mon Sep 10 17:32:05 ACST 2018

The DISABLE_WERROR is due to clang's -Wduplicate-decl-specifier. Some
macros we have in arch/powerpc/include/asm/uaccess.h warn on 'const
typeof(var)', where as the GCC version doesn't. Anton did fix this a
while ago, but the fix was 'reverted' to resolve some sparse warnings.
I think we should re-apply Anton's patch[2].

[1] https://reviews.llvm.org/D50965
[2] http://git.kernel.org/torvalds/c/b91c1e3e7a6f22a6b898e345b745b6a43273c973

Joel Stanley (2):
  powerpc/boot: Fix crt0.S syntax for clang
  powerpc/boot: Ensure _zimage_start is a weak symbol

 arch/powerpc/boot/crt0.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1
