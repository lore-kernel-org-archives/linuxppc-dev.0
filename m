Return-Path: <SRS0+0172f75cf8e7244956cd+1562+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 34559DDE44
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 13:48:13 +1100 (EST)
Received: from pmac.infradead.org ([2001:8b0:10b:1:20d:93ff:fe7a:3f2c])
	by pentafluge.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1Iz1Lt-0006Pz-NP
	for linuxppc-dev@ozlabs.org; Mon, 03 Dec 2007 02:48:09 +0000
Subject: [PPC BOOT] Create otheros.bld next to specified output file, not
	in $object directory.
From: David Woodhouse <dwmw2@infradead.org>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Mon, 03 Dec 2007 02:48:03 +0000
Message-Id: <1196650083.13978.113.camel@pmac.infradead.org>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The bootwrapper script currently generates an 'otheros.bld' file in
addition to the file specified by the -o option, when asked to build a
wrapper for PS3.

It should do that in the same directory as the output, not the directory
where the wrapper objects are kept (which might potentially not be
writable when the script runs).

Arguably, the 'otheros.bld' ought to be created with the filename
specified as the -o argument. But that's a more intrusive change.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -287,8 +289,6 @@ ps3)
     overlay_dest="256"
     overlay_size="256"
 
-    rm -f "$object/otheros.bld"
-
     ${CROSS}objcopy -O binary "$ofile" "$ofile.bin"
 
     dd if="$ofile.bin" of="$ofile.bin" conv=notrunc   \
@@ -299,6 +299,8 @@ ps3)
         skip=$system_reset_overlay seek=$overlay_dest \
         count=$overlay_size bs=1
 
-    gzip --force -9 --stdout "$ofile.bin" > "$object/otheros.bld"
+    odir="$(dirname "$ofile.bin")"
+    rm -f "$odir/otheros.bld"
+    gzip --force -9 --stdout "$ofile.bin" > "$odir/otheros.bld"
     ;;
 esac

-- 
dwmw2
