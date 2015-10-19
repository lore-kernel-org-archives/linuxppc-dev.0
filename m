Return-Path: <geoff@infradead.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC0D81A08A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2015 04:53:33 +1100 (AEDT)
Message-ID: <1445277206.30908.6.camel@infradead.org>
Subject: [PATCH] powerpc: Add run_cmd function to boot wrapper
From: Geoff Levand <geoff@infradead.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Date: Mon, 19 Oct 2015 10:53:26 -0700
In-Reply-To: <1445230402-18087-1-git-send-email-mpe@ellerman.id.au>
References: <1445230402-18087-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a boot wrapper script function run_cmd which will run a shell command
quietly and only print the output if either V=1 or an error occurs.

Also, run the ps3 dd commands with run_cmd to clean up the build output.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
Hi Michael,

How about something like this?  It seems a little cleaner.

-Geoff

 arch/powerpc/boot/wrapper | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 3f50c27..ceaa75d 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -63,6 +63,23 @@ usage() {
     exit 1
 }
 
+run_cmd() {
+    if [ "$V" = 1 ]; then
+        $* 2>&1
+    else
+        local msg
+
+        set +e
+        msg=$($* 2>&1)
+
+        if [ $? -ne "0" ]; then
+                echo $msg
+                exit 1
+        fi
+        set -e
+    fi
+}
+
 while [ "$#" -gt 0 ]; do
     case "$1" in
     -o)
@@ -456,12 +473,12 @@ ps3)
 
     ${CROSS}objcopy -O binary "$ofile" "$ofile.bin"
 
-    dd if="$ofile.bin" of="$ofile.bin" conv=notrunc   \
-        skip=$overlay_dest seek=$system_reset_kernel  \
+    run_cmd dd if="$ofile.bin" of="$ofile.bin" conv=notrunc   \
+        skip=$overlay_dest seek=$system_reset_kernel          \
         count=$overlay_size bs=1
 
-    dd if="$ofile.bin" of="$ofile.bin" conv=notrunc   \
-        skip=$system_reset_overlay seek=$overlay_dest \
+    run_cmd dd if="$ofile.bin" of="$ofile.bin" conv=notrunc   \
+        skip=$system_reset_overlay seek=$overlay_dest         \
         count=$overlay_size bs=1
 
     odir="$(dirname "$ofile.bin")"
-- 
2.5.0
