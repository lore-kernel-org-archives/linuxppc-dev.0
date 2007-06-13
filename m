Return-Path: <dgibson@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 9/13] Factor zImage's 44x reset code out of ebony.c
In-Reply-To: <20070613045031.GD16148@localhost.localdomain>
Message-Id: <20070613045259.56CF4DDF12@ozlabs.org>
Date: Wed, 13 Jun 2007 14:52:58 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The ebony_exit() function which resets the Ebony board should in fact
be common to most if not all 44x boards.  This patch moves the
function out into 44x.c, renaming it, so it can be used by other 44x
platforms.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

 arch/powerpc/boot/44x.c   |   16 ++++++++++++++++
 arch/powerpc/boot/44x.h   |    2 ++
 arch/powerpc/boot/ebony.c |   18 +-----------------
 3 files changed, 19 insertions(+), 17 deletions(-)

Index: working-2.6/arch/powerpc/boot/44x.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/44x.c	2007-05-08 15:07:45.000000000 +1000
+++ working-2.6/arch/powerpc/boot/44x.c	2007-05-16 16:45:01.000000000 +1000
@@ -38,3 +38,19 @@ void ibm44x_fixup_memsize(void)
 
 	dt_fixup_memory(0, memsize);
 }
+
+#define SPRN_DBCR0		0x134
+#define   DBCR0_RST_SYSTEM	0x30000000
+
+void ibm44x_dbcr_reset(void)
+{
+	unsigned long tmp;
+
+	asm volatile (
+		"mfspr	%0,%1\n"
+		"oris	%0,%0,%2@h\n"
+		"mtspr	%1,%0"
+		: "=&r"(tmp) : "i"(SPRN_DBCR0), "i"(DBCR0_RST_SYSTEM)
+		);
+
+}
Index: working-2.6/arch/powerpc/boot/44x.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/44x.h	2007-05-08 15:07:45.000000000 +1000
+++ working-2.6/arch/powerpc/boot/44x.h	2007-05-16 16:45:01.000000000 +1000
@@ -11,6 +11,8 @@
 #define _PPC_BOOT_44X_H_
 
 void ibm44x_fixup_memsize(void);
+
+void ibm44x_dbcr_reset(void);
 void ebony_init(void *mac0, void *mac1);
 
 #endif /* _PPC_BOOT_44X_H_ */
Index: working-2.6/arch/powerpc/boot/ebony.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ebony.c	2007-05-08 15:07:45.000000000 +1000
+++ working-2.6/arch/powerpc/boot/ebony.c	2007-05-16 16:45:00.000000000 +1000
@@ -102,26 +102,10 @@ static void ebony_fixups(void)
 	dt_fixup_mac_addresses(ebony_mac0, ebony_mac1);
 }
 
-#define SPRN_DBCR0		0x134
-#define   DBCR0_RST_SYSTEM	0x30000000
-
-static void ebony_exit(void)
-{
-	unsigned long tmp;
-
-	asm volatile (
-		"mfspr	%0,%1\n"
-		"oris	%0,%0,%2@h\n"
-		"mtspr	%1,%0"
-		: "=&r"(tmp) : "i"(SPRN_DBCR0), "i"(DBCR0_RST_SYSTEM)
-		);
-
-}
-
 void ebony_init(void *mac0, void *mac1)
 {
 	platform_ops.fixups = ebony_fixups;
-	platform_ops.exit = ebony_exit;
+	platform_ops.exit = ibm44x_dbcr_reset;
 	ebony_mac0 = mac0;
 	ebony_mac1 = mac1;
 	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
