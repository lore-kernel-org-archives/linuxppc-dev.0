Return-Path: <michael@ozlabs.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 13 Jul 2006 17:52:04 +1000
Subject: [PATCH 2/7] iseries: Move e2a()/strne2a() into their only caller
In-Reply-To: <1152777121.430402.3949688126.qpush@concordia>
Message-Id: <20060713075205.9C7E367B8C@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The ASCII -> EBCDIC functions, e2a() and strne2a() are now only used in
dt.c, so move them in there.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/lib/Makefile           |    1 
 arch/powerpc/lib/e2a.c              |  116 ------------------------------------
 arch/powerpc/platforms/iseries/dt.c |   98 ++++++++++++++++++++++++++++++
 include/asm-powerpc/system.h        |    5 -
 4 files changed, 97 insertions(+), 123 deletions(-)

Index: to-merge/arch/powerpc/lib/Makefile
===================================================================
--- to-merge.orig/arch/powerpc/lib/Makefile
+++ to-merge/arch/powerpc/lib/Makefile
@@ -14,7 +14,6 @@ endif
 obj-$(CONFIG_PPC64)	+= checksum_64.o copypage_64.o copyuser_64.o \
 			   memcpy_64.o usercopy_64.o mem_64.o string.o \
 			   strcase.o
-obj-$(CONFIG_PPC_ISERIES) += e2a.o
 obj-$(CONFIG_XMON)	+= sstep.o
 
 ifeq ($(CONFIG_PPC64),y)
Index: to-merge/arch/powerpc/lib/e2a.c
===================================================================
--- to-merge.orig/arch/powerpc/lib/e2a.c
+++ /dev/null
@@ -1,116 +0,0 @@
-/*
- *  EBCDIC to ASCII conversion
- *
- * This function moved here from arch/powerpc/platforms/iseries/viopath.c 
- *
- * (C) Copyright 2000-2004 IBM Corporation
- *
- * This program is free software;  you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) anyu later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software Foundation,
- * Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- */
-
-#include <linux/module.h>
-
-unsigned char e2a(unsigned char x)
-{
-	switch (x) {
-	case 0xF0:
-		return '0';
-	case 0xF1:
-		return '1';
-	case 0xF2:
-		return '2';
-	case 0xF3:
-		return '3';
-	case 0xF4:
-		return '4';
-	case 0xF5:
-		return '5';
-	case 0xF6:
-		return '6';
-	case 0xF7:
-		return '7';
-	case 0xF8:
-		return '8';
-	case 0xF9:
-		return '9';
-	case 0xC1:
-		return 'A';
-	case 0xC2:
-		return 'B';
-	case 0xC3:
-		return 'C';
-	case 0xC4:
-		return 'D';
-	case 0xC5:
-		return 'E';
-	case 0xC6:
-		return 'F';
-	case 0xC7:
-		return 'G';
-	case 0xC8:
-		return 'H';
-	case 0xC9:
-		return 'I';
-	case 0xD1:
-		return 'J';
-	case 0xD2:
-		return 'K';
-	case 0xD3:
-		return 'L';
-	case 0xD4:
-		return 'M';
-	case 0xD5:
-		return 'N';
-	case 0xD6:
-		return 'O';
-	case 0xD7:
-		return 'P';
-	case 0xD8:
-		return 'Q';
-	case 0xD9:
-		return 'R';
-	case 0xE2:
-		return 'S';
-	case 0xE3:
-		return 'T';
-	case 0xE4:
-		return 'U';
-	case 0xE5:
-		return 'V';
-	case 0xE6:
-		return 'W';
-	case 0xE7:
-		return 'X';
-	case 0xE8:
-		return 'Y';
-	case 0xE9:
-		return 'Z';
-	}
-	return ' ';
-}
-EXPORT_SYMBOL(e2a);
-
-unsigned char* strne2a(unsigned char *dest, const unsigned char *src, size_t n)
-{
-	int i;
-
-	n = strnlen(src, n);
-
-	for (i = 0; i < n; i++)
-		dest[i] = e2a(src[i]);
-
-	return dest;
-}
Index: to-merge/arch/powerpc/platforms/iseries/dt.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/dt.c
+++ to-merge/arch/powerpc/platforms/iseries/dt.c
@@ -1,5 +1,6 @@
 /*
- *    Copyright (c) 2005-2006 Michael Ellerman, IBM Corporation
+ *    Copyright (C) 2005-2006 Michael Ellerman, IBM Corporation
+ *    Copyright (C) 2000-2004, IBM Corporation
  *
  *    Description:
  *      This file contains all the routines to build a flattened device
@@ -76,6 +77,101 @@ static char __initdata device_type_pci[]
 static char __initdata device_type_vdevice[] = "vdevice";
 static char __initdata device_type_vscsi[] = "vscsi";
 
+
+/* EBCDIC to ASCII conversion routines */
+
+unsigned char e2a(unsigned char x)
+{
+	switch (x) {
+	case 0xF0:
+		return '0';
+	case 0xF1:
+		return '1';
+	case 0xF2:
+		return '2';
+	case 0xF3:
+		return '3';
+	case 0xF4:
+		return '4';
+	case 0xF5:
+		return '5';
+	case 0xF6:
+		return '6';
+	case 0xF7:
+		return '7';
+	case 0xF8:
+		return '8';
+	case 0xF9:
+		return '9';
+	case 0xC1:
+		return 'A';
+	case 0xC2:
+		return 'B';
+	case 0xC3:
+		return 'C';
+	case 0xC4:
+		return 'D';
+	case 0xC5:
+		return 'E';
+	case 0xC6:
+		return 'F';
+	case 0xC7:
+		return 'G';
+	case 0xC8:
+		return 'H';
+	case 0xC9:
+		return 'I';
+	case 0xD1:
+		return 'J';
+	case 0xD2:
+		return 'K';
+	case 0xD3:
+		return 'L';
+	case 0xD4:
+		return 'M';
+	case 0xD5:
+		return 'N';
+	case 0xD6:
+		return 'O';
+	case 0xD7:
+		return 'P';
+	case 0xD8:
+		return 'Q';
+	case 0xD9:
+		return 'R';
+	case 0xE2:
+		return 'S';
+	case 0xE3:
+		return 'T';
+	case 0xE4:
+		return 'U';
+	case 0xE5:
+		return 'V';
+	case 0xE6:
+		return 'W';
+	case 0xE7:
+		return 'X';
+	case 0xE8:
+		return 'Y';
+	case 0xE9:
+		return 'Z';
+	}
+	return ' ';
+}
+EXPORT_SYMBOL(e2a);
+
+unsigned char* strne2a(unsigned char *dest, const unsigned char *src, size_t n)
+{
+	int i;
+
+	n = strnlen(src, n);
+
+	for (i = 0; i < n; i++)
+		dest[i] = e2a(src[i]);
+
+	return dest;
+}
+
 static struct iseries_flat_dt * __init dt_init(void)
 {
 	struct iseries_flat_dt *dt;
Index: to-merge/include/asm-powerpc/system.h
===================================================================
--- to-merge.orig/include/asm-powerpc/system.h
+++ to-merge/include/asm-powerpc/system.h
@@ -169,11 +169,6 @@ extern u32 booke_wdt_enabled;
 extern u32 booke_wdt_period;
 #endif /* CONFIG_BOOKE_WDT */
 
-/* EBCDIC -> ASCII conversion for [0-9A-Z] on iSeries */
-extern unsigned char e2a(unsigned char);
-extern unsigned char* strne2a(unsigned char *dest,
-		const unsigned char *src, size_t n);
-
 struct device_node;
 extern void note_scsi_host(struct device_node *, void *);
 
