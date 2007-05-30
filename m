Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 3AE5DDE084
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 01:29:24 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <20070525081459.GA30239@aepfle.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7cd1bd62cf3304f0ab57cadac1d26f8e@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: [PATCH] fix zImage.coff generation for pmac
Date: Wed, 30 May 2007 10:29:01 -0500
To: Paul Mackerras <paulus@samba.org>,
 Olaf Hering <olaf@aepfle.de>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 9da82a6dee9db4cd5ae7a74ab4f51afb52b6efb9 inadvertently
removed the platform override for zImage.coff to be generated
with pmaccoff.   Rather than add a special makefile rule,
change the platform for which the wrapper platform uses
the special rules.

Signed-off-by: Milton Miller <miltonm@bga.com>

---
Untested, and hopefully not too whitespace damaged.
Against upstream after 2.6.22-rc3.

We could look for both coff and pmaccoff if someone
has an external script calling wrapper with platform
pmaccoff (change to coff|pmaccoff).

Olof Hering wrote:
> Does anyone happen to know where the arch/powerpc/boot/coff.o is
> supposed to come from? Current Linus tree fails since a while with the
> following commands.
>
> tar xfz /mounts/mirror/kernel/v2.6/testing/linux-2.6.22-rc2.tar.gz
> cd linux-2.6.22-rc2/
> mkdir ../O
> cp arch/powerpc/configs/pmac32_defconfig ../O/.config
> make -kj42 O=../O menuconfig
> make -kj42 O=../O
>
>   WRAP    arch/powerpc/boot/zImage.coff
> ld: arch/powerpc/boot/coff.o: No such file: No such file or directory
> nm: 'arch/powerpc/boot/zImage.coff': No such file
> objdump: 'arch/powerpc/boot/zImage.coff': No such file


diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 5cedd90..b28161c 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -129,7 +129,7 @@ case "$platform" in
  pmac|pseries|chrp)
      platformo=$object/of.o
      ;;
-pmaccoff)
+coff)
      platformo=$object/of.o
      lds=$object/zImage.coff.lds
      ;;
@@ -217,7 +217,7 @@ case "$platform" in
  pseries|chrp)
      $object/addnote "$ofile"
      ;;
-pmaccoff)
+coff)
      entry=`objdump -f "$ofile" | grep '^start address ' | \
  	cut -d' ' -f3`
      ${CROSS}objcopy -O aixcoff-rs6000 --set-start "$entry" "$ofile"
