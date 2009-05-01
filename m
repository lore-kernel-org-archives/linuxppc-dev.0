Return-Path: <why@r54964-12.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C482EDDDF6
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 05:40:46 +1000 (EST)
From: Haiying Wang <Haiying.Wang@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH 2/6 v2] powerpc/qe: update risc allocation for QE
Date: Fri,  1 May 2009 15:40:47 -0400
Message-Id: <1241206851-27749-1-git-send-email-Haiying.Wang@freescale.com>
Cc: Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change the RISC allocation to macros instead of enum, add function to read the
number of risc engines from the new property "fsl,qe-num-riscs" under qe node
in dts. Add new property "fsl,qe-num-riscs" description in qe.txt

Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
---
v2 change: rename the new property to "fsl,qe-num-riscs" and move this node to
Required section in qe.txt.
 .../powerpc/dts-bindings/fsl/cpm_qe/qe.txt         |    1 +
 arch/powerpc/include/asm/qe.h                      |   18 ++++++++----
 arch/powerpc/sysdev/qe_lib/qe.c                    |   28 ++++++++++++++++++++
 3 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
index 78790d5..39b5d1f 100644
--- a/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
@@ -17,6 +17,7 @@ Required properties:
 - model : precise model of the QE, Can be "QE", "CPM", or "CPM2"
 - reg : offset and length of the device registers.
 - bus-frequency : the clock frequency for QUICC Engine.
+- fsl,qe-num-riscs: define how many RISC engines the QE has.
 
 Recommended properties
 - brg-frequency : the internal clock source frequency for baud-rate
diff --git a/arch/powerpc/include/asm/qe.h b/arch/powerpc/include/asm/qe.h
index 2701753..60314ef 100644
--- a/arch/powerpc/include/asm/qe.h
+++ b/arch/powerpc/include/asm/qe.h
@@ -152,6 +152,8 @@ unsigned int qe_get_brg_clk(void);
 int qe_setbrg(enum qe_clock brg, unsigned int rate, unsigned int multiplier);
 int qe_get_snum(void);
 void qe_put_snum(u8 snum);
+unsigned int qe_get_num_of_risc(void);
+
 /* we actually use cpm_muram implementation, define this for convenience */
 #define qe_muram_init cpm_muram_init
 #define qe_muram_alloc cpm_muram_alloc
@@ -231,12 +233,16 @@ struct qe_bd {
 #define QE_ALIGNMENT_OF_PRAM	64
 
 /* RISC allocation */
-enum qe_risc_allocation {
-	QE_RISC_ALLOCATION_RISC1 = 1,	/* RISC 1 */
-	QE_RISC_ALLOCATION_RISC2 = 2,	/* RISC 2 */
-	QE_RISC_ALLOCATION_RISC1_AND_RISC2 = 3	/* Dynamically choose
-						   RISC 1 or RISC 2 */
-};
+#define QE_RISC_ALLOCATION_RISC1	0x1  /* RISC 1 */
+#define QE_RISC_ALLOCATION_RISC2	0x2  /* RISC 2 */
+#define QE_RISC_ALLOCATION_RISC3	0x4  /* RISC 3 */
+#define QE_RISC_ALLOCATION_RISC4	0x8  /* RISC 4 */
+#define QE_RISC_ALLOCATION_RISC1_AND_RISC2	(QE_RISC_ALLOCATION_RISC1 | \
+						 QE_RISC_ALLOCATION_RISC2)
+#define QE_RISC_ALLOCATION_FOUR_RISCS	(QE_RISC_ALLOCATION_RISC1 | \
+					 QE_RISC_ALLOCATION_RISC2 | \
+					 QE_RISC_ALLOCATION_RISC3 | \
+					 QE_RISC_ALLOCATION_RISC4)
 
 /* QE extended filtering Table Lookup Key Size */
 enum qe_fltr_tbl_lookup_key_size {
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 01bce37..2533677 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -575,3 +575,31 @@ struct qe_firmware_info *qe_get_firmware_info(void)
 }
 EXPORT_SYMBOL(qe_get_firmware_info);
 
+unsigned int qe_get_num_of_risc(void)
+{
+	struct device_node *qe;
+	int size;
+	unsigned int num_of_risc = 0;
+	const u32 *prop;
+
+	qe = of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (!qe) {
+		/* Older devices trees did not have an "fsl,qe"
+		 * compatible property, so we need to look for
+		 * the QE node by name.
+		 */
+		qe = of_find_node_by_type(NULL, "qe");
+		if (!qe)
+			return num_of_risc;
+	}
+
+	prop = of_get_property(qe, "fsl,qe-num-riscs", &size);
+	if (prop && size == sizeof(*prop))
+		num_of_risc = *prop;
+
+	of_node_put(qe);
+
+	return num_of_risc;
+}
+EXPORT_SYMBOL(qe_get_num_of_risc);
+
-- 
1.6.0.2
