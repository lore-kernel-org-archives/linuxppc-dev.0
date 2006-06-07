Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6BCD167A70
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 12:04:27 +1000 (EST)
Subject: [PATCH] powerpc: Fix cell blade detection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 12:04:18 +1000
Message-Id: <1149645858.27572.93.camel@localhost.localdomain>
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

From: Arnd Bergmann <arnd@arndb.de>

The IBM Cell blade firmware might confuse the kernel to think it's a
pSeries machine. This fixes it for now. With a bit of luck, the firmware
will be updated to avoid that in the future but currently that patch is
needed.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/prom_init.c	2006-06-06 11:59:20.000000000 +1000
+++ linux-work/arch/powerpc/kernel/prom_init.c	2006-06-06 12:04:42.000000000 +1000
@@ -1623,6 +1623,15 @@ static int __init prom_find_machine_type
 			if (strstr(p, RELOC("Power Macintosh")) ||
 			    strstr(p, RELOC("MacRISC")))
 				return PLATFORM_POWERMAC;
+#ifdef CONFIG_PPC64
+			/* We must make sure we don't detect the IBM Cell
+			 * blades as pSeries due to some firmware issues,
+			 * so we do it here.
+			 */
+			if (strstr(p, RELOC("IBM,CBEA")) ||
+			    strstr(p, RELOC("IBM,CPBW-1.0")))
+				return PLATFORM_GENERIC;
+#endif /* CONFIG_PPC64 */
 			i += sl + 1;
 		}
 	}
Index: linux-work/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/setup.c	2006-05-11 11:45:08.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/setup.c	2006-06-06 12:03:03.000000000 +1000
@@ -125,14 +125,13 @@ static void __init cell_init_early(void)
 
 static int __init cell_probe(void)
 {
-	/* XXX This is temporary, the Cell maintainer will come up with
-	 * more appropriate detection logic
-	 */
 	unsigned long root = of_get_flat_dt_root();
-	if (!of_flat_dt_is_compatible(root, "IBM,CPBW-1.0"))
-		return 0;
 
-	return 1;
+	if (of_flat_dt_is_compatible(root, "IBM,CBEA") ||
+	    of_flat_dt_is_compatible(root, "IBM,CPBW-1.0"))
+		return 1;
+
+	return 0;
 }
 
 /*
Index: linux-work/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/setup.c	2006-06-05 17:55:31.000000000 +1000
+++ linux-work/arch/powerpc/platforms/pseries/setup.c	2006-06-06 13:05:21.000000000 +1000
@@ -399,6 +399,7 @@ static int __init pSeries_probe_hypertas
 
 static int __init pSeries_probe(void)
 {
+	unsigned long root = of_get_flat_dt_root();
  	char *dtype = of_get_flat_dt_prop(of_get_flat_dt_root(),
  					  "device_type", NULL);
  	if (dtype == NULL)
@@ -406,6 +407,13 @@ static int __init pSeries_probe(void)
  	if (strcmp(dtype, "chrp"))
 		return 0;
 
+	/* Cell blades firmware claims to be chrp while it's not. Until this
+	 * is fixed, we need to avoid those here.
+	 */
+	if (of_flat_dt_is_compatible(root, "IBM,CPBW-1.0") ||
+	    of_flat_dt_is_compatible(root, "IBM,CBEA"))
+		return 0;
+
 	DBG("pSeries detected, looking for LPAR capability...\n");
 
 	/* Now try to figure out if we are running on LPAR */
