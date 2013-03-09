Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4BB972C007E
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Mar 2013 15:01:34 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 8 Mar 2013 23:01:32 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id E6B9EC9001A
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Mar 2013 23:01:28 -0500 (EST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2941S3V294780
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 23:01:28 -0500
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2941S3g013421
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:01:28 -0700
Received: from [9.76.31.13] (sig-9-76-31-13.mts.ibm.com [9.76.31.13])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r2941PG9013292
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:01:26 -0700
Message-ID: <513AB415.2040006@linux.vnet.ibm.com>
Date: Fri, 08 Mar 2013 22:01:25 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/11] Move architecture vector definitions to prom.h
References: <513AB2E3.6090209@linux.vnet.ibm.com>
In-Reply-To: <513AB2E3.6090209@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As part of handling of handling PRRN events we will need to check the
vector 5 portion of the architecture bits reported in the device tree
to ensure that PRRN event handling is enabled. In order to do this a
new platform_has_feature call is introduced (in a subsequent patch) to
make this check.  To avoid having to re-define bits in the architecture
vector the bits are moved to prom.h.

This patch is the first step in implementing the platform_has_feature
call by simply moving the bit definitions from prom_init.c to asm/prom.h.
There are no functional.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

---
 arch/powerpc/include/asm/prom.h |   73 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/prom_init.c |   75 +++-------------------------------------
 2 files changed, 79 insertions(+), 69 deletions(-)

Index: powerpc/arch/powerpc/include/asm/prom.h
===================================================================
--- powerpc.orig/arch/powerpc/include/asm/prom.h	2013-03-08 19:23:06.000000000 -0600
+++ powerpc/arch/powerpc/include/asm/prom.h	2013-03-08 19:57:05.000000000 -0600
@@ -74,6 +74,79 @@
 #define DRCONF_MEM_AI_INVALID	0x00000040
 #define DRCONF_MEM_RESERVED	0x00000080
 
+#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
+/*
+ * There are two methods for telling firmware what our capabilities are.
+ * Newer machines have an "ibm,client-architecture-support" method on the
+ * root node.  For older machines, we have to call the "process-elf-header"
+ * method in the /packages/elf-loader node, passing it a fake 32-bit
+ * ELF header containing a couple of PT_NOTE sections that contain
+ * structures that contain various information.
+ */
+
+/* New method - extensible architecture description vector. */
+
+/* Option vector bits - generic bits in byte 1 */
+#define OV_IGNORE		0x80	/* ignore this vector */
+#define OV_CESSATION_POLICY	0x40	/* halt if unsupported option present*/
+
+/* Option vector 1: processor architectures supported */
+#define OV1_PPC_2_00		0x80	/* set if we support PowerPC 2.00 */
+#define OV1_PPC_2_01		0x40	/* set if we support PowerPC 2.01 */
+#define OV1_PPC_2_02		0x20	/* set if we support PowerPC 2.02 */
+#define OV1_PPC_2_03		0x10	/* set if we support PowerPC 2.03 */
+#define OV1_PPC_2_04		0x08	/* set if we support PowerPC 2.04 */
+#define OV1_PPC_2_05		0x04	/* set if we support PowerPC 2.05 */
+#define OV1_PPC_2_06		0x02	/* set if we support PowerPC 2.06 */
+#define OV1_PPC_2_07		0x01	/* set if we support PowerPC 2.07 */
+
+/* Option vector 2: Open Firmware options supported */
+#define OV2_REAL_MODE		0x20	/* set if we want OF in real mode */
+
+/* Option vector 3: processor options supported */
+#define OV3_FP			0x80	/* floating point */
+#define OV3_VMX			0x40	/* VMX/Altivec */
+#define OV3_DFP			0x20	/* decimal FP */
+
+/* Option vector 4: IBM PAPR implementation */
+#define OV4_MIN_ENT_CAP		0x01	/* minimum VP entitled capacity */
+
+/* Option vector 5: PAPR/OF options supported */
+#define OV5_LPAR		0x80	/* logical partitioning supported */
+#define OV5_SPLPAR		0x40	/* shared-processor LPAR supported */
+/* ibm,dynamic-reconfiguration-memory property supported */
+#define OV5_DRCONF_MEMORY	0x20
+#define OV5_LARGE_PAGES		0x10	/* large pages supported */
+#define OV5_DONATE_DEDICATE_CPU	0x02	/* donate dedicated CPU support */
+/* PCIe/MSI support.  Without MSI full PCIe is not supported */
+#ifdef CONFIG_PCI_MSI
+#define OV5_MSI			0x01	/* PCIe/MSI support */
+#else
+#define OV5_MSI			0x00
+#endif /* CONFIG_PCI_MSI */
+#ifdef CONFIG_PPC_SMLPAR
+#define OV5_CMO			0x80	/* Cooperative Memory Overcommitment */
+#define OV5_XCMO		0x40	/* Page Coalescing */
+#else
+#define OV5_CMO			0x00
+#define OV5_XCMO		0x00
+#endif
+#define OV5_TYPE1_AFFINITY	0x80	/* Type 1 NUMA affinity */
+#define OV5_PFO_HW_RNG		0x80	/* PFO Random Number Generator */
+#define OV5_PFO_HW_842		0x40	/* PFO Compression Accelerator */
+#define OV5_PFO_HW_ENCR		0x20	/* PFO Encryption Accelerator */
+#define OV5_SUB_PROCESSORS	0x01	/* 1,2,or 4 Sub-Processors supported */
+
+/* Option Vector 6: IBM PAPR hints */
+#define OV6_LINUX		0x02	/* Linux is our OS */
+
+/*
+ * The architecture vector has an array of PVR mask/value pairs,
+ * followed by # option vectors - 1, followed by the option vectors.
+ */
+extern unsigned char ibm_architecture_vec[];
+#endif
+
 /* These includes are put at the bottom because they may contain things
  * that are overridden by this file.  Ideally they shouldn't be included
  * by this file, but there are a bunch of .c files that currently depend
Index: powerpc/arch/powerpc/kernel/prom_init.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/prom_init.c	2013-03-08 19:23:06.000000000 -0600
+++ powerpc/arch/powerpc/kernel/prom_init.c	2013-03-08 19:57:05.000000000 -0600
@@ -627,16 +627,11 @@
 
 #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
 /*
- * There are two methods for telling firmware what our capabilities are.
- * Newer machines have an "ibm,client-architecture-support" method on the
- * root node.  For older machines, we have to call the "process-elf-header"
- * method in the /packages/elf-loader node, passing it a fake 32-bit
- * ELF header containing a couple of PT_NOTE sections that contain
- * structures that contain various information.
- */
-
-/*
- * New method - extensible architecture description vector.
+ * The architecture vector has an array of PVR mask/value pairs,
+ * followed by # option vectors - 1, followed by the option vectors.
+ *
+ * See prom.h for the definition of the bits specified in the
+ * architecture vector.
  *
  * Because the description vector contains a mix of byte and word
  * values, we declare it as an unsigned char array, and use this
@@ -645,65 +640,7 @@
 #define W(x)	((x) >> 24) & 0xff, ((x) >> 16) & 0xff, \
 		((x) >> 8) & 0xff, (x) & 0xff
 
-/* Option vector bits - generic bits in byte 1 */
-#define OV_IGNORE		0x80	/* ignore this vector */
-#define OV_CESSATION_POLICY	0x40	/* halt if unsupported option present*/
-
-/* Option vector 1: processor architectures supported */
-#define OV1_PPC_2_00		0x80	/* set if we support PowerPC 2.00 */
-#define OV1_PPC_2_01		0x40	/* set if we support PowerPC 2.01 */
-#define OV1_PPC_2_02		0x20	/* set if we support PowerPC 2.02 */
-#define OV1_PPC_2_03		0x10	/* set if we support PowerPC 2.03 */
-#define OV1_PPC_2_04		0x08	/* set if we support PowerPC 2.04 */
-#define OV1_PPC_2_05		0x04	/* set if we support PowerPC 2.05 */
-#define OV1_PPC_2_06		0x02	/* set if we support PowerPC 2.06 */
-#define OV1_PPC_2_07		0x01	/* set if we support PowerPC 2.07 */
-
-/* Option vector 2: Open Firmware options supported */
-#define OV2_REAL_MODE		0x20	/* set if we want OF in real mode */
-
-/* Option vector 3: processor options supported */
-#define OV3_FP			0x80	/* floating point */
-#define OV3_VMX			0x40	/* VMX/Altivec */
-#define OV3_DFP			0x20	/* decimal FP */
-
-/* Option vector 4: IBM PAPR implementation */
-#define OV4_MIN_ENT_CAP		0x01	/* minimum VP entitled capacity */
-
-/* Option vector 5: PAPR/OF options supported */
-#define OV5_LPAR		0x80	/* logical partitioning supported */
-#define OV5_SPLPAR		0x40	/* shared-processor LPAR supported */
-/* ibm,dynamic-reconfiguration-memory property supported */
-#define OV5_DRCONF_MEMORY	0x20
-#define OV5_LARGE_PAGES		0x10	/* large pages supported */
-#define OV5_DONATE_DEDICATE_CPU 0x02	/* donate dedicated CPU support */
-/* PCIe/MSI support.  Without MSI full PCIe is not supported */
-#ifdef CONFIG_PCI_MSI
-#define OV5_MSI			0x01	/* PCIe/MSI support */
-#else
-#define OV5_MSI			0x00
-#endif /* CONFIG_PCI_MSI */
-#ifdef CONFIG_PPC_SMLPAR
-#define OV5_CMO			0x80	/* Cooperative Memory Overcommitment */
-#define OV5_XCMO			0x40	/* Page Coalescing */
-#else
-#define OV5_CMO			0x00
-#define OV5_XCMO			0x00
-#endif
-#define OV5_TYPE1_AFFINITY	0x80	/* Type 1 NUMA affinity */
-#define OV5_PFO_HW_RNG		0x80	/* PFO Random Number Generator */
-#define OV5_PFO_HW_842		0x40	/* PFO Compression Accelerator */
-#define OV5_PFO_HW_ENCR		0x20	/* PFO Encryption Accelerator */
-#define OV5_SUB_PROCESSORS	0x01    /* 1,2,or 4 Sub-Processors supported */
-
-/* Option Vector 6: IBM PAPR hints */
-#define OV6_LINUX		0x02	/* Linux is our OS */
-
-/*
- * The architecture vector has an array of PVR mask/value pairs,
- * followed by # option vectors - 1, followed by the option vectors.
- */
-static unsigned char ibm_architecture_vec[] = {
+unsigned char ibm_architecture_vec[] = {
 	W(0xfffe0000), W(0x003a0000),	/* POWER5/POWER5+ */
 	W(0xffff0000), W(0x003e0000),	/* POWER6 */
 	W(0xffff0000), W(0x003f0000),	/* POWER7 */
