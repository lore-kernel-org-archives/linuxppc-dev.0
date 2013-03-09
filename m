Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 578FC2C0319
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Mar 2013 15:02:38 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 8 Mar 2013 21:02:36 -0700
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id CEBDC3E4003E
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Mar 2013 21:02:23 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2942XCf126664
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:02:33 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2942XiS016571
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:02:33 -0700
Received: from [9.76.31.13] (sig-9-76-31-13.mts.ibm.com [9.76.31.13])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r2942V3s016509
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:02:32 -0700
Message-ID: <513AB457.9000409@linux.vnet.ibm.com>
Date: Fri, 08 Mar 2013 22:02:31 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/11] Add platform_has_feature()
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

The firmware_has_feature() function makes it easy to check for supported
features of the hardware. There is not corresponding function to check for
features supported by the client architecture.

This patch adds a platform_has_feature() function to check features selected
by firmware and reported via the device tree 'ibm,architecture-vec5'
property. As part of this the #defines used for the architecture vector are
moved to prom.h and re-defined such that the vector 5 options have the vector
index and the feature bits encoded into them. This allows for callers of
platform_has_feature() to pass in a single pre-defined value.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/prom.h |   41 +++++++++++++++++++++++-----------------
 arch/powerpc/kernel/prom.c      |   19 ++++++++++++++++++
 arch/powerpc/kernel/prom_init.c |   14 +++++++------
 3 files changed, 51 insertions(+), 23 deletions(-)

Index: powerpc/arch/powerpc/include/asm/prom.h
===================================================================
--- powerpc.orig/arch/powerpc/include/asm/prom.h	2013-03-08 19:57:05.000000000 -0600
+++ powerpc/arch/powerpc/include/asm/prom.h	2013-03-08 19:57:14.000000000 -0600
@@ -111,31 +111,37 @@
 /* Option vector 4: IBM PAPR implementation */
 #define OV4_MIN_ENT_CAP		0x01	/* minimum VP entitled capacity */
 
-/* Option vector 5: PAPR/OF options supported */
-#define OV5_LPAR		0x80	/* logical partitioning supported */
-#define OV5_SPLPAR		0x40	/* shared-processor LPAR supported */
+/* Option vector 5: PAPR/OF options supported
+ * These bits are also used for the platform_has_feature() call so
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
+#define OV5_DRCONF_MEMORY	0x0220
+#define OV5_LARGE_PAGES		0x0210	/* large pages supported */
+#define OV5_DONATE_DEDICATE_CPU	0x0202	/* donate dedicated CPU support */
 /* PCIe/MSI support.  Without MSI full PCIe is not supported */
 #ifdef CONFIG_PCI_MSI
-#define OV5_MSI			0x01	/* PCIe/MSI support */
+#define OV5_MSI			0x0201	/* PCIe/MSI support */
 #else
-#define OV5_MSI			0x00
+#define OV5_MSI			0x0200
 #endif /* CONFIG_PCI_MSI */
 #ifdef CONFIG_PPC_SMLPAR
-#define OV5_CMO			0x80	/* Cooperative Memory Overcommitment */
-#define OV5_XCMO		0x40	/* Page Coalescing */
+#define OV5_CMO			0x0480	/* Cooperative Memory Overcommitment */
+#define OV5_XCMO		0x0440	/* Page Coalescing */
 #else
-#define OV5_CMO			0x00
-#define OV5_XCMO		0x00
+#define OV5_CMO			0x0400
+#define OV5_XCMO		0x0400
 #endif
-#define OV5_TYPE1_AFFINITY	0x80	/* Type 1 NUMA affinity */
-#define OV5_PFO_HW_RNG		0x80	/* PFO Random Number Generator */
-#define OV5_PFO_HW_842		0x40	/* PFO Compression Accelerator */
-#define OV5_PFO_HW_ENCR		0x20	/* PFO Encryption Accelerator */
-#define OV5_SUB_PROCESSORS	0x01	/* 1,2,or 4 Sub-Processors supported */
+#define OV5_TYPE1_AFFINITY	0x0580	/* Type 1 NUMA affinity */
+#define OV5_PFO_HW_RNG		0x0E80	/* PFO Random Number Generator */
+#define OV5_PFO_HW_842		0x0E40	/* PFO Compression Accelerator */
+#define OV5_PFO_HW_ENCR		0x0E20	/* PFO Encryption Accelerator */
+#define OV5_SUB_PROCESSORS	0x0F01	/* 1,2,or 4 Sub-Processors supported */
 
 /* Option Vector 6: IBM PAPR hints */
 #define OV6_LINUX		0x02	/* Linux is our OS */
@@ -145,6 +151,7 @@
  * followed by # option vectors - 1, followed by the option vectors.
  */
 extern unsigned char ibm_architecture_vec[];
+bool platform_has_feature(unsigned int);
 #endif
 
 /* These includes are put at the bottom because they may contain things
Index: powerpc/arch/powerpc/kernel/prom_init.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/prom_init.c	2013-03-08 19:57:05.000000000 -0600
+++ powerpc/arch/powerpc/kernel/prom_init.c	2013-03-08 19:57:14.000000000 -0600
@@ -684,11 +684,12 @@
 	/* option vector 5: PAPR/OF options */
 	19 - 2,				/* length */
 	0,				/* don't ignore, don't halt */
-	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES | OV5_DRCONF_MEMORY |
-	OV5_DONATE_DEDICATE_CPU | OV5_MSI,
+	OV5_FEAT(OV5_LPAR) | OV5_FEAT(OV5_SPLPAR) | OV5_FEAT(OV5_LARGE_PAGES) |
+	OV5_FEAT(OV5_DRCONF_MEMORY) | OV5_FEAT(OV5_DONATE_DEDICATE_CPU) |
+	OV5_FEAT(OV5_MSI),
 	0,
-	OV5_CMO | OV5_XCMO,
-	OV5_TYPE1_AFFINITY,
+	OV5_FEAT(OV5_CMO) | OV5_FEAT(OV5_XCMO),
+	OV5_FEAT(OV5_TYPE1_AFFINITY),
 	0,
 	0,
 	0,
@@ -702,8 +703,9 @@
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
Index: powerpc/arch/powerpc/kernel/prom.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/prom.c	2013-03-08 19:23:06.000000000 -0600
+++ powerpc/arch/powerpc/kernel/prom.c	2013-03-08 19:57:14.000000000 -0600
@@ -871,6 +871,25 @@
 }
 EXPORT_SYMBOL(of_get_cpu_node);
 
+#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
+bool platform_has_feature(unsigned int feature)
+{
+	struct device_node *chosen;
+	const char *vec5;
+	bool has_option;
+
+	chosen = of_find_node_by_path("/chosen");
+	if (!chosen)
+		return false;
+
+	vec5 = of_get_property(chosen, "ibm,architecture-vec-5", NULL);
+	has_option = vec5 && (vec5[OV5_INDX(feature)] & OV5_FEAT(feature));
+	of_node_put(chosen);
+
+	return has_option;
+}
+#endif
+
 #if defined(CONFIG_DEBUG_FS) && defined(DEBUG)
 static struct debugfs_blob_wrapper flat_dt_blob;
 
