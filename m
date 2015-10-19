Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D6EE1A01DC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2015 15:53:23 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: geoff@infradead.org
Subject: [PATCH] powerpc/ps3: Quieten the build when building ps3
Date: Mon, 19 Oct 2015 15:53:22 +1100
Message-Id: <1445230402-18087-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The boot wrapper uses dd when building for ps3, which annoyingly tells
us in great detail what it's doing, eg:

  512+0 records in
  512+0 records out
  512 bytes (512 B) copied, 0.000802129 s, 638 kB/s
  512+0 records in
  512+0 records out
  512 bytes (512 B) copied, 0.000745101 s, 687 kB/s

Also annoyingly, there is no "quiet" flag to dd, so our only option is
to grab all the output from dd, and iff there is an error print it out.

As it turns out we used to do this, so this is actually a partial revert
of commit d47403733403 ("[POWERPC] bootwrapper: Bail from script if any
command fails").

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/boot/wrapper | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 3f50c27ed8f8..b7d353b88029 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -456,13 +456,27 @@ ps3)
 
     ${CROSS}objcopy -O binary "$ofile" "$ofile.bin"
 
-    dd if="$ofile.bin" of="$ofile.bin" conv=notrunc   \
-        skip=$overlay_dest seek=$system_reset_kernel  \
-        count=$overlay_size bs=1
+    set +e
 
-    dd if="$ofile.bin" of="$ofile.bin" conv=notrunc   \
-        skip=$system_reset_overlay seek=$overlay_dest \
-        count=$overlay_size bs=1
+    msg=$(dd if="$ofile.bin" of="$ofile.bin" conv=notrunc   \
+          skip=$overlay_dest seek=$system_reset_kernel  \
+          count=$overlay_size bs=1 2>&1)
+
+    if [ $? -ne "0" ]; then
+        echo $msg
+        exit 1
+    fi
+
+    msg=$(dd if="$ofile.bin" of="$ofile.bin" conv=notrunc   \
+          skip=$system_reset_overlay seek=$overlay_dest \
+          count=$overlay_size bs=1 2>&1)
+
+    if [ $? -ne "0" ]; then
+        echo $msg
+        exit 2
+    fi
+
+    set -e
 
     odir="$(dirname "$ofile.bin")"
     rm -f "$odir/otheros.bld"
-- 
2.5.0
