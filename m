Return-Path: <benjamin.heyne@uni-dortmund.de>
Received: from unimail.uni-dortmund.de (mx1.HRZ.Uni-Dortmund.DE
	[129.217.128.51]) by ozlabs.org (Postfix) with ESMTP id ED12D679E2
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 20:14:40 +1000 (EST)
Date: Wed, 16 Aug 2006 11:31:37 +0200
From: Benjamin Heyne <benjamin.heyne@uni-dortmund.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Gunzip call fix for PPC kernel images >4MB
Message-ID: <20060816113137.7a8e5608@bob.dt.e-technik.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Tom Rini <trini@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If Kernel images for PPC grow >4MB inflating of the kernel fails.
Increasing the link/load address doesn't help. Problem is 
solved by replacing the fixed address of the gunzip() call in
misc-embedded.c with CONFIG_BOOT_LOAD.

Signed-off-by: Benjamin Heyne <benjamin.heyne@uni-dortmund.de>
---

--- arch/ppc/boot/simple/misc-embedded.c.orig 2006-08-16 10:56:10.000000000 +0200 
+++ arch/ppc/boot/simple/misc-embedded.c 2006-08-16 10:56:55.000000000 +0200 
@@ -213,7 +213,7 @@ load_kernel(unsigned long load_addr, int 
	*cp = 0;
 	puts("\nUncompressing Linux...");
 
-	gunzip(0, 0x400000, zimage_start, &zimage_size);
+	gunzip(0, CONFIG_BOOT_LOAD, zimage_start, &zimage_size);
 	flush_instruction_cache();
 	puts("done.\n");
 	{

-- 
Benjamin Heyne
=======================================================
 Arbeitsgebiet Datentechnik, Universitaet Dortmund
 Information Processing Lab, University of Dortmund

 Otto-Hahn-Strasse 4, 44227 Dortmund, Germany
 Fon: +49 231 755 7017, Fax: +49 231 755 7019
 www.dt.e-technik.uni-dortmund.de, Raum/Room P1-04-217
