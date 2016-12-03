Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tW7WD6vkdzDw1q
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2016 22:06:32 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: npiggin@gmail.com
Cc: linuxppc-dev@ozlabs.org, anton@samba.org, amodra@gmail.com,
 nickc@redhat.com
Subject: [PATCH v2] powerpc/boot: Request no dynamic linker for boot wrapper
Date: Sat,  3 Dec 2016 22:06:28 +1100
Message-Id: <1480763188-20224-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

The boot wrapper performs its own relocations and does not require
PT_INTERP segment. However currently we don't tell the linker that.

Prior to binutils 2.28 that works OK. But since binutils commit
1a9ccd70f9a7 ("Fix the linker so that it will not silently generate ELF
binaries with invalid program headers. Fix readelf to report such
invalid binaries.") binutils tries to create a program header segment
due to PT_INTERP, and the link fails because there is no space for it:

  ld: arch/powerpc/boot/zImage.pseries: Not enough room for program headers, try linking with -N
  ld: final link failed: Bad value

So tell the linker not to do that, by passing --no-dynamic-linker.

Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[mpe: Drop dependency on ld-version.sh and massage change log]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/boot/wrapper | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

v2: Drop dependency on ld-version.sh.

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 404b3aabdb4d..76fe3ccfd381 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -181,6 +181,28 @@ case "$elfformat" in
     elf32-powerpc)	format=elf32ppc	;;
 esac
 
+ld_version()
+{
+    # Poached from scripts/ld-version.sh, but we don't want to call that because
+    # this script (wrapper) is distributed separately from the kernel source.
+    # Extract linker version number from stdin and turn into single number.
+    awk '{
+	gsub(".*\\)", "");
+	gsub(".*version ", "");
+	gsub("-.*", "");
+	split($1,a, ".");
+	print a[1]*100000000 + a[2]*1000000 + a[3]*10000;
+	exit
+    }'
+}
+
+# Do not include PT_INTERP segment when linking pie. Non-pie linking
+# just ignores this option.
+LD_VERSION=$(${CROSS}ld --version | ld_version)
+LD_NO_DL_MIN_VERSION=$(echo 2.26 | ld_version)
+if [ "$LD_VERSION" -ge "$LD_NO_DL_MIN_VERSION" ] ; then
+	nodl="--no-dynamic-linker"
+fi
 
 platformo=$object/"$platform".o
 lds=$object/zImage.lds
@@ -446,7 +468,7 @@ if [ "$platform" != "miboot" ]; then
         text_start="-Ttext $link_address"
     fi
 #link everything
-    ${CROSS}ld -m $format -T $lds $text_start $pie -o "$ofile" \
+    ${CROSS}ld -m $format -T $lds $text_start $pie $nodl -o "$ofile" \
 	$platformo $tmp $object/wrapper.a
     rm $tmp
 fi
-- 
2.7.4
