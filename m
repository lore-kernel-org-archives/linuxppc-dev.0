Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tRqDy0h0gzDrHj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 12:42:42 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 3so11554293pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Nov 2016 17:42:42 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>, Alan Modra <amodra@gmail.com>
Subject: [PATCH] powerpc/boot: request no dynamic linker for boot wrapper
Date: Mon, 28 Nov 2016 12:42:26 +1100
Message-Id: <20161128014226.7656-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The boot wrapper performs its own relocations and does not require
PT_INTERP segment.

Without this option, binutils 2.28 and newer tries to create a program
header segment due to PT_INTERP, and the link fails because there is no
space for it.

   A recent binutils commit:
   https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=1a9ccd70f9a75dc6b48d340059f28ef3550c107b
   has broken kernel builds:

     ld: arch/powerpc/boot/zImage.pseries: Not enough room for program headers, try linking with -N
     ld: final link failed: Bad value

Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

Hi,

I think this should do the trick (zImage.pseries compiles and boots
mambo here, haven't tested zImage.epapr). Cc'ing Alan just in case :)

Thanks,
Nick

 arch/powerpc/boot/wrapper | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 404b3aa..cd941a8 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -181,6 +181,13 @@ case "$elfformat" in
     elf32-powerpc)	format=elf32ppc	;;
 esac
 
+# Do not include PT_INTERP segment when linking pie. Non-pie linking
+# just ignores this option.
+LD_VERSION=$(${CROSS}ld --version | $srctree/scripts/ld-version.sh)
+LD_NO_DL_MIN_VERSION=$(echo 2.26 | $srctree/scripts/ld-version.sh)
+if [ "$LD_VERSION" -ge "$LD_NO_DL_MIN_VERSION" ] ; then
+	nodl="--no-dynamic-linker"
+fi
 
 platformo=$object/"$platform".o
 lds=$object/zImage.lds
@@ -446,7 +453,7 @@ if [ "$platform" != "miboot" ]; then
         text_start="-Ttext $link_address"
     fi
 #link everything
-    ${CROSS}ld -m $format -T $lds $text_start $pie -o "$ofile" \
+    ${CROSS}ld -m $format -T $lds $text_start $pie $nodl -o "$ofile" \
 	$platformo $tmp $object/wrapper.a
     rm $tmp
 fi
-- 
2.10.2
