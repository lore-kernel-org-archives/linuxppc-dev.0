Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC69E67C04
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 14:30:17 +1000 (EST)
Subject: [PATCH] powerpc: Fix zImage.coff on oldworld PowerMac
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 14:27:16 +1000
Message-Id: <1159849637.5482.30.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Recent changes to the PowerPC zImage wrapper broke zImage.coff due to
the addition of new ELF sections that aren't very well converted to
xcoff and not supported by old OpenFirmware. This fixes it by putting
those sections in the xcoff .data.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/boot/zImage.coff.lds
===================================================================
--- linux-work.orig/arch/powerpc/boot/zImage.coff.lds	2006-03-10 15:58:17.000000000 +1100
+++ linux-work/arch/powerpc/boot/zImage.coff.lds	2006-10-03 13:56:35.000000000 +1000
@@ -15,6 +15,7 @@ SECTIONS
   {
     *(.rodata*)
     *(.data*)
+    *(__builtin_*)
     *(.sdata*)
     __got2_start = .;
     *(.got2)
