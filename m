Return-Path: <mmarek@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 032AFB6FA3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Apr 2011 00:59:35 +1000 (EST)
From: Michal Marek <mmarek@suse.cz>
To: linux-kbuild@vger.kernel.org
Subject: [PATCH 03/34] powerpc: Call gzip with -n
Date: Tue,  5 Apr 2011 16:58:50 +0200
Message-Id: <1302015561-21047-4-git-send-email-mmarek@suse.cz>
In-Reply-To: <1302015561-21047-1-git-send-email-mmarek@suse.cz>
References: <1302015561-21047-1-git-send-email-mmarek@suse.cz>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The timestamps recorded in the .gz files add no value.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Michal Marek <mmarek@suse.cz>
---
 arch/powerpc/boot/wrapper |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index cb97e75..854797b 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -251,7 +251,7 @@ if [ -z "$cacheit" -o ! -f "$vmz$gzip" -o "$vmz$gzip" -ot "$kernel" ]; then
     ${CROSS}objcopy $objflags "$kernel" "$vmz.$$"
 
     if [ -n "$gzip" ]; then
-        gzip -f -9 "$vmz.$$"
+        gzip -n -f -9 "$vmz.$$"
     fi
 
     if [ -n "$cacheit" ]; then
@@ -336,7 +336,7 @@ coff)
     $objbin/hack-coff "$ofile"
     ;;
 cuboot*)
-    gzip -f -9 "$ofile"
+    gzip -n -f -9 "$ofile"
     ${MKIMAGE} -A ppc -O linux -T kernel -C gzip -a "$base" -e "$entry" \
             $uboot_version -d "$ofile".gz "$ofile"
     ;;
@@ -383,6 +383,6 @@ ps3)
 
     odir="$(dirname "$ofile.bin")"
     rm -f "$odir/otheros.bld"
-    gzip --force -9 --stdout "$ofile.bin" > "$odir/otheros.bld"
+    gzip -n --force -9 --stdout "$ofile.bin" > "$odir/otheros.bld"
     ;;
 esac
-- 
1.7.4.1
