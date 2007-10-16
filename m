Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 9FE2ADDEFA
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 07:32:16 +1000 (EST)
Received: from pd2mr5so.prod.shaw.ca (pd2mr5so-qfe3.prod.shaw.ca [10.0.141.8])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JQ000ASHX3UO680@l-daemon> for linuxppc-dev@ozlabs.org;
	Tue, 16 Oct 2007 15:31:06 -0600 (MDT)
Received: from pn2ml8so.prod.shaw.ca ([10.0.121.152])
	by pd2mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JQ0009Y5X3UPB70@pd2mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Tue, 16 Oct 2007 15:31:07 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JQ000LSYX3T8K90@l-daemon> for linuxppc-dev@ozlabs.org;
	Tue, 16 Oct 2007 15:31:06 -0600 (MDT)
Date: Tue, 16 Oct 2007 15:31:07 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/2] bootwrapper: Bail from script if any command fails
In-reply-to: <20071016213101.14117.43657.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Gibson <david@gibson.dropbear.id.au>,
	Scott Wood <scottwood@freescale.com>
Message-id: <20071016213107.14117.3858.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071016213101.14117.43657.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Add the 'set -e' command to the wrapper script so that if any command
fails then the script will automatically exit

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/boot/wrapper |   27 ++++++++++-----------------
 1 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 8323ea4..da5fcfa 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -21,6 +21,9 @@
 #		(default ./arch/powerpc/boot)
 # -W dir	specify working directory for temporary files (default .)
 
+# Stop execution if any command fails
+set -e
+
 # Allow for verbose output
 if [ "$V" == "1" ]; then
     set -x
@@ -116,7 +119,7 @@ if [ -n "$dts" ]; then
     if [ -z "$dtb" ]; then
 	dtb="$platform.dtb"
     fi
-    dtc -O dtb -o "$dtb" -b 0 -V 16 "$dts" || exit 1
+    dtc -O dtb -o "$dtb" -b 0 -V 16 "$dts"
 fi
 
 if [ -z "$kernel" ]; then
@@ -287,23 +290,13 @@ ps3)
 
     rm -f "$object/otheros.bld"
 
-    msg=$(dd if="$ofile.bin" of="$ofile.bin" conv=notrunc \
-        skip=$overlay_dest seek=$system_reset_kernel      \
-        count=$overlay_size bs=1 2>&1)
-
-    if [ $? -ne "0" ]; then
-       echo $msg
-       exit 1
-    fi
+    dd if="$ofile.bin" of="$ofile.bin" conv=notrunc   \
+        skip=$overlay_dest seek=$system_reset_kernel  \
+        count=$overlay_size bs=1
 
-    msg=$(dd if="$ofile.bin" of="$ofile.bin" conv=notrunc \
-        skip=$system_reset_overlay seek=$overlay_dest     \
-        count=$overlay_size bs=1 2>&1)
-
-    if [ $? -ne "0" ]; then
-       echo $msg
-       exit 2
-    fi
+    dd if="$ofile.bin" of="$ofile.bin" conv=notrunc   \
+        skip=$system_reset_overlay seek=$overlay_dest \
+        count=$overlay_size bs=1
 
     gzip --force -9 --stdout "$ofile.bin" > "$object/otheros.bld"
     ;;
