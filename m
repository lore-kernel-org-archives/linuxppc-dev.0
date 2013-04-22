Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AD3D72C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 04:39:20 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 22 Apr 2013 12:39:13 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 4CD7F19D8041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 12:38:53 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3MIcp2m068226
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 12:38:52 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3MIfdqf015094
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 12:41:39 -0600
Received: from [9.41.105.123] ([9.41.105.123])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r3MIfd1U015051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 12:41:39 -0600
Message-ID: <517583B7.1070300@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 13:38:47 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 5/12] Update firmware_has_feature() to check architecture
 bits
References: <51757951.2080007@linux.vnet.ibm.com>
In-Reply-To: <51757951.2080007@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The firmware_has_feature() function makes it easy to check for supported
features of the hypervisor. This patch extends the capability of the
firmware_has_feature() function to include checking for specified bits
in vector 5 of the architecture vector as is reported in the device tree.

As part of this the #defines used for the architecture vector are
re-defined such that the vector 5 options have the vector
index and the feature bits encoded into them. This makes for a much
simpler design to update firmware_has_feature() to check for bits
in the architecture vector.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/firmware.h       |    4 +-
 arch/powerpc/include/asm/prom.h           |   45 ++++++++++++---------------
 arch/powerpc/kernel/prom_init.c           |   23 ++++++++++----
 arch/powerpc/platforms/pseries/firmware.c |   49 +++++++++++++++++++++++++-----
 arch/powerpc/platforms/pseries/pseries.h  |    5 ++-
 arch/powerpc/platforms/pseries/setup.c    |   40 ++++++++++++++++--------
 6 files changed, 113 insertions(+), 53 deletions(-)

Index: powerpc/arch/powerpc/include/asm/prom.h
===================================================================
--- powerpc.orig/arch/powerpc/include/asm/prom.h	2013-04-17 13:43:13.000000000 -0500
+++ powerpc/arch/powerpc/include/asm/prom.h	2013-04-17 13:51:46.000000000 -0500
@@ -111,31 +111,27 @@
 /* Option vector 4: IBM PAPR implementation */
 #define OV4_MIN_ENT_CAP		0x01	/* minimum VP entitled capacity */
 
-/* Option vector 5: PAPR/OF options supported */
-#define OV5_LPAR		0x80	/* logical partitioning supported */
-#define OV5_SPLPAR		0x40	/* shared-processor LPAR supported */
+/* Option vector 5: PAPR/OF options supported
+ * Thses bits are also used for the platform_has_feature() call so
+ * we encode the vector index in the define and use the OV5_FEAT()
+ * and OV5_INDX() macros to extract the desired information.
+ */
+#define OV5_FEAT(x)	((x) & 0xff)
+#define OV5_INDX(x)	((x) >> 8)
+#define OV5_LPAR		0x0280	/* logical partitioning supported */
+#define OV5_SPLPAR		0x0240	/* shared-processor LPAR supported */
 /* ibm,dynamic-reconfiguration-memory property supported */
-#define OV5_DRCONF_MEMORY	0x20
-#define OV5_LARGE_PAGES		0x10	/* large pages supported */
-#define OV5_DONATE_DEDICATE_CPU	0x02	/* donate dedicated CPU support */
-/* PCIe/MSI support.  Without MSI full PCIe is not supported */
-#ifdef CONFIG_PCI_MSI
-#define OV5_MSI			0x01	/* PCIe/MSI support */
-#else
-#define OV5_MSI			0x00
-#endif /* CONFIG_PCI_MSI */
-#ifdef CONFIG_PPC_SMLPAR
-#define OV5_CMO			0x80	/* Cooperative Memory Overcommitment */
-#define OV5_XCMO		0x40	/* Page Coalescing */
-#else
-#define OV5_CMO			0x00
-#define OV5_XCMO		0x00
-#endif
-#define OV5_TYPE1_AFFINITY	0x80	/* Type 1 NUMA affinity */
-#define OV5_PFO_HW_RNG		0x80	/* PFO Random Number Generator */
-#define OV5_PFO_HW_842		0x40	/* PFO Compression Accelerator */
-#define OV5_PFO_HW_ENCR		0x20	/* PFO Encryption Accelerator */
-#define OV5_SUB_PROCESSORS	0x01	/* 1,2,or 4 Sub-Processors supported */
+#define OV5_DRCONF_MEMORY	0x0220
+#define OV5_LARGE_PAGES		0x0210	/* large pages supported */
+#define OV5_DONATE_DEDICATE_CPU	0x0202	/* donate dedicated CPU support */
+#define OV5_MSI			0x0201	/* PCIe/MSI support */
+#define OV5_CMO			0x0480	/* Cooperative Memory Overcommitment */
+#define OV5_XCMO		0x0440	/* Page Coalescing */
+#define OV5_TYPE1_AFFINITY	0x0580	/* Type 1 NUMA affinity */
+#define OV5_PFO_HW_RNG		0x0E80	/* PFO Random Number Generator */
+#define OV5_PFO_HW_842		0x0E40	/* PFO Compression Accelerator */
+#define OV5_PFO_HW_ENCR		0x0E20	/* PFO Encryption Accelerator */
+#define OV5_SUB_PROCESSORS	0x0F01	/* 1,2,or 4 Sub-Processors supported */
 
 /* Option Vector 6: IBM PAPR hints */
 #define OV6_LINUX		0x02	/* Linux is our OS */
@@ -145,6 +141,7 @@
  * followed by # option vectors - 1, followed by the option vectors.
  */
 extern unsigned char ibm_architecture_vec[];
+bool platform_has_feature(unsigned int);
 #endif
 
 /* These includes are put at the bottom because they may contain things
Index: powerpc/arch/powerpc/kernel/prom_init.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/prom_init.c	2013-04-17 13:43:13.000000000 -0500
+++ powerpc/arch/powerpc/kernel/prom_init.c	2013-04-17 13:51:46.000000000 -0500
@@ -684,11 +684,21 @@
 	/* option vector 5: PAPR/OF options */
 	19 - 2,				/* length */
 	0,				/* don't ignore, don't halt */
-	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES | OV5_DRCONF_MEMORY |
-	OV5_DONATE_DEDICATE_CPU | OV5_MSI,
+	OV5_FEAT(OV5_LPAR) | OV5_FEAT(OV5_SPLPAR) | OV5_FEAT(OV5_LARGE_PAGES) |
+	OV5_FEAT(OV5_DRCONF_MEMORY) | OV5_FEAT(OV5_DONATE_DEDICATE_CPU) |
+#ifdef CONFIG_PCI_MSI
+	/* PCIe/MSI support.  Without MSI full PCIe is not supported */
+	OV5_FEAT(OV5_MSI),
+#else
+	0,
+#endif
+	0,
+#ifdef CONFIG_PPC_SMLPAR
+	OV5_FEAT(OV5_CMO) | OV5_FEAT(OV5_XCMO),
+#else
 	0,
-	OV5_CMO | OV5_XCMO,
-	OV5_TYPE1_AFFINITY,
+#endif
+	OV5_FEAT(OV5_TYPE1_AFFINITY),
 	0,
 	0,
 	0,
@@ -702,8 +712,9 @@
 	0,
 	0,
 	0,
-	OV5_PFO_HW_RNG | OV5_PFO_HW_ENCR | OV5_PFO_HW_842,
-	OV5_SUB_PROCESSORS,
+	OV5_FEAT(OV5_PFO_HW_RNG) | OV5_FEAT(OV5_PFO_HW_ENCR) |
+	OV5_FEAT(OV5_PFO_HW_842),
+	OV5_FEAT(OV5_SUB_PROCESSORS),
 	/* option vector 6: IBM PAPR hints */
 	4 - 2,				/* length */
 	0,
Index: powerpc/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/setup.c	2013-04-16 21:25:15.000000000 -0500
+++ powerpc/arch/powerpc/platforms/pseries/setup.c	2013-04-17 13:51:46.000000000 -0500
@@ -628,25 +628,39 @@
  * Called very early, MMU is off, device-tree isn't unflattened
  */
 
-static int __init pSeries_probe_hypertas(unsigned long node,
-					 const char *uname, int depth,
-					 void *data)
+static int __init pseries_probe_fw_features(unsigned long node,
+					    const char *uname, int depth,
+					    void *data)
 {
-	const char *hypertas;
+	const char *prop;
 	unsigned long len;
+	static int hypertas_found;
+	static int vec5_found;
 
-	if (depth != 1 ||
-	    (strcmp(uname, "rtas") != 0 && strcmp(uname, "rtas@0") != 0))
+	if (depth != 1)
 		return 0;
 
-	hypertas = of_get_flat_dt_prop(node, "ibm,hypertas-functions", &len);
-	if (!hypertas)
-		return 1;
+	if (!strcmp(uname, "rtas") || !strcmp(uname, "rtas@0")) {
+		prop = of_get_flat_dt_prop(node, "ibm,hypertas-functions",
+					   &len);
+		if (prop) {
+			powerpc_firmware_features |= FW_FEATURE_LPAR;
+			fw_hypertas_feature_init(prop, len);
+		}
+
+		hypertas_found = 1;
+	}
+
+	if (!strcmp(uname, "chosen")) {
+		prop = of_get_flat_dt_prop(node, "ibm,architecture-vec-5",
+					   &len);
+		if (prop)
+			fw_vec5_feature_init(prop, len);
 
-	powerpc_firmware_features |= FW_FEATURE_LPAR;
-	fw_feature_init(hypertas, len);
+		vec5_found = 1;
+	}
 
-	return 1;
+	return hypertas_found && vec5_found;
 }
 
 static int __init pSeries_probe(void)
@@ -669,7 +683,7 @@
 	pr_debug("pSeries detected, looking for LPAR capability...\n");
 
 	/* Now try to figure out if we are running on LPAR */
-	of_scan_flat_dt(pSeries_probe_hypertas, NULL);
+	of_scan_flat_dt(pseries_probe_fw_features, NULL);
 
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		hpte_init_lpar();
Index: powerpc/arch/powerpc/platforms/pseries/firmware.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/firmware.c	2013-04-16 21:25:15.000000000 -0500
+++ powerpc/arch/powerpc/platforms/pseries/firmware.c	2013-04-17 13:51:46.000000000 -0500
@@ -31,15 +31,15 @@
 typedef struct {
     unsigned long val;
     char * name;
-} firmware_feature_t;
+} hypertas_fw_feature_t;
 
 /*
  * The names in this table match names in rtas/ibm,hypertas-functions.  If the
  * entry ends in a '*', only upto the '*' is matched.  Otherwise the entire
  * string must match.
  */
-static __initdata firmware_feature_t
-firmware_features_table[FIRMWARE_MAX_FEATURES] = {
+static __initdata hypertas_fw_feature_t
+hypertas_fw_features_table[FIRMWARE_MAX_FEATURES] = {
 	{FW_FEATURE_PFT,		"hcall-pft"},
 	{FW_FEATURE_TCE,		"hcall-tce"},
 	{FW_FEATURE_SPRG0,		"hcall-sprg0"},
@@ -69,16 +69,16 @@
  * device-tree/ibm,hypertas-functions.  Ultimately this functionality may
  * be moved into prom.c prom_init().
  */
-void __init fw_feature_init(const char *hypertas, unsigned long len)
+void __init fw_hypertas_feature_init(const char *hypertas, unsigned long len)
 {
 	const char *s;
 	int i;
 
-	pr_debug(" -> fw_feature_init()\n");
+	pr_debug(" -> fw_hypertas_feature_init()\n");
 
 	for (s = hypertas; s < hypertas + len; s += strlen(s) + 1) {
 		for (i = 0; i < FIRMWARE_MAX_FEATURES; i++) {
-			const char *name = firmware_features_table[i].name;
+			const char *name = hypertas_fw_features_table[i].name;
 			size_t size;
 			/* check value against table of strings */
 			if (!name)
@@ -96,10 +96,43 @@
 
 			/* we have a match */
 			powerpc_firmware_features |=
-				firmware_features_table[i].val;
+				hypertas_fw_features_table[i].val;
 			break;
 		}
 	}
 
-	pr_debug(" <- fw_feature_init()\n");
+	pr_debug(" <- fw_hypertas_feature_init()\n");
+}
+
+struct vec5_fw_feature {
+	unsigned long	val;
+	unsigned int	feature;
+
+};
+
+static __initdata struct vec5_fw_feature
+vec5_fw_features_table[FIRMWARE_MAX_FEATURES] = {
+	{FW_FEATURE_TYPE1_AFFINITY,	OV5_TYPE1_AFFINITY},
+};
+
+void __init fw_vec5_feature_init(const char *vec5, unsigned long len)
+{
+	unsigned int index, feat;
+	int i;
+
+	pr_debug(" -> fw_vec5_feature_init()\n");
+
+	for (i = 0; i < FIRMWARE_MAX_FEATURES; i++) {
+		if (!vec5_fw_features_table[i].feature)
+			continue;
+
+		index = OV5_INDX(vec5_fw_features_table[i].feature);
+		feat = OV5_FEAT(vec5_fw_features_table[i].feature);
+
+		if (vec5[index] & feat)
+			powerpc_firmware_features |=
+				vec5_fw_features_table[i].val;
+	}
+
+	pr_debug(" <- fw_vec5_feature_init()\n");
 }
Index: powerpc/arch/powerpc/include/asm/firmware.h
===================================================================
--- powerpc.orig/arch/powerpc/include/asm/firmware.h	2013-04-16 21:25:15.000000000 -0500
+++ powerpc/arch/powerpc/include/asm/firmware.h	2013-04-17 13:51:46.000000000 -0500
@@ -51,6 +51,7 @@
 #define FW_FEATURE_OPALv2	ASM_CONST(0x0000000020000000)
 #define FW_FEATURE_SET_MODE	ASM_CONST(0x0000000040000000)
 #define FW_FEATURE_BEST_ENERGY	ASM_CONST(0x0000000080000000)
+#define FW_FEATURE_TYPE1_AFFINITY ASM_CONST(0x0000000100000000)
 
 #ifndef __ASSEMBLY__
 
@@ -65,7 +66,8 @@
 		FW_FEATURE_BULK_REMOVE | FW_FEATURE_XDABR |
 		FW_FEATURE_MULTITCE | FW_FEATURE_SPLPAR | FW_FEATURE_LPAR |
 		FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO |
-		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY,
+		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
+		FW_FEATURE_TYPE1_AFFINITY,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
 	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL | FW_FEATURE_OPALv2,
 	FW_FEATURE_POWERNV_ALWAYS = 0,
Index: powerpc/arch/powerpc/platforms/pseries/pseries.h
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/pseries.h	2013-04-16 21:25:15.000000000 -0500
+++ powerpc/arch/powerpc/platforms/pseries/pseries.h	2013-04-17 13:51:46.000000000 -0500
@@ -19,7 +19,10 @@
 
 #include <linux/of.h>
 
-extern void __init fw_feature_init(const char *hypertas, unsigned long len);
+extern void __init fw_hypertas_feature_init(const char *hypertas,
+					    unsigned long len);
+extern void __init fw_vec5_feature_init(const char *hypertas,
+					unsigned long len);
 
 struct pt_regs;
 
