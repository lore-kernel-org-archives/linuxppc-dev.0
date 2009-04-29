Return-Path: <why@r54964-12.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6693DDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 04:14:28 +1000 (EST)
From: Haiying Wang <Haiying.Wang@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH 4/6] powerpc/qe: update QE Serial Number
Date: Wed, 29 Apr 2009 14:14:36 -0400
Message-Id: <1241028883630-git-send-email-Haiying.Wang@freescale.com>
In-Reply-To: <12410288811793-git-send-email-Haiying.Wang@freescale.com>
References: <1241028878175-git-send-email-Haiying.Wang@freescale.com>
	<12410288792524-git-send-email-Haiying.Wang@freescale.com>
	<12410288811793-git-send-email-Haiying.Wang@freescale.com>
Cc: Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The latest QE chip may have more Serial Number(SNUM)s of thread to use. We will
get the number of SNUMs from device tree by reading the new property "num-snums"
, and set 28 as the default number of SNUMs so that it is compatible with the
old QE chips' device trees  which don't have this new property.
The macro QE_NUM_OF_SNUM is defined as the maximum number in QE snum table which
is 256.
Also we update the snum_init[] array with 18 more new SNUMs which are
confirmed to be useful on new chip.

Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
---
 .../powerpc/dts-bindings/fsl/cpm_qe/qe.txt         |    1 +
 arch/powerpc/include/asm/qe.h                      |    3 +-
 arch/powerpc/sysdev/qe_lib/qe.c                    |   47 ++++++++++++++++++--
 3 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
index b6ea613..9f7df90 100644
--- a/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
@@ -22,6 +22,7 @@ Recommended properties
 - brg-frequency : the internal clock source frequency for baud-rate
   generators in Hz.
 - num-riscs: define how many RISC engines the QE has.
+- num-snums: define how many serial number(SNUM) the QE can use for the threads.
 
 Example:
      qe@e0100000 {
diff --git a/arch/powerpc/include/asm/qe.h b/arch/powerpc/include/asm/qe.h
index 60314ef..e0faf33 100644
--- a/arch/powerpc/include/asm/qe.h
+++ b/arch/powerpc/include/asm/qe.h
@@ -22,7 +22,7 @@
 #include <asm/cpm.h>
 #include <asm/immap_qe.h>
 
-#define QE_NUM_OF_SNUM	28
+#define QE_NUM_OF_SNUM	256	/* There are 256 serial number in QE */
 #define QE_NUM_OF_BRGS	16
 #define QE_NUM_OF_PORTS	1024
 
@@ -153,6 +153,7 @@ int qe_setbrg(enum qe_clock brg, unsigned int rate, unsigned int multiplier);
 int qe_get_snum(void);
 void qe_put_snum(u8 snum);
 unsigned int qe_get_num_of_risc(void);
+unsigned int qe_get_num_of_snums(void);
 
 /* we actually use cpm_muram implementation, define this for convenience */
 #define qe_muram_init cpm_muram_init
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 31a3bb1..69116d9 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -61,6 +61,7 @@ struct qe_immap __iomem *qe_immr;
 EXPORT_SYMBOL(qe_immr);
 
 static struct qe_snum snums[QE_NUM_OF_SNUM];	/* Dynamically allocated SNUMs */
+static unsigned int qe_num_of_snum;
 
 static phys_addr_t qebase = -1;
 
@@ -264,10 +265,14 @@ static void qe_snums_init(void)
 		0x04, 0x05, 0x0C, 0x0D, 0x14, 0x15, 0x1C, 0x1D,
 		0x24, 0x25, 0x2C, 0x2D, 0x34, 0x35, 0x88, 0x89,
 		0x98, 0x99, 0xA8, 0xA9, 0xB8, 0xB9, 0xC8, 0xC9,
-		0xD8, 0xD9, 0xE8, 0xE9,
+		0xD8, 0xD9, 0xE8, 0xE9, 0x08, 0x09, 0x18, 0x19,
+		0x28, 0x29, 0x38, 0x39, 0x48, 0x49, 0x58, 0x59,
+		0x68, 0x69, 0x78, 0x79, 0x80, 0x81,
 	};
 
-	for (i = 0; i < QE_NUM_OF_SNUM; i++) {
+	qe_num_of_snum = qe_get_num_of_snums();
+
+	for (i = 0; i < qe_num_of_snum; i++) {
 		snums[i].num = snum_init[i];
 		snums[i].state = QE_SNUM_STATE_FREE;
 	}
@@ -280,7 +285,7 @@ int qe_get_snum(void)
 	int i;
 
 	spin_lock_irqsave(&qe_lock, flags);
-	for (i = 0; i < QE_NUM_OF_SNUM; i++) {
+	for (i = 0; i < qe_num_of_snum; i++) {
 		if (snums[i].state == QE_SNUM_STATE_FREE) {
 			snums[i].state = QE_SNUM_STATE_USED;
 			snum = snums[i].num;
@@ -297,7 +302,7 @@ void qe_put_snum(u8 snum)
 {
 	int i;
 
-	for (i = 0; i < QE_NUM_OF_SNUM; i++) {
+	for (i = 0; i < qe_num_of_snum; i++) {
 		if (snums[i].num == snum) {
 			snums[i].state = QE_SNUM_STATE_FREE;
 			break;
@@ -603,3 +608,37 @@ unsigned int qe_get_num_of_risc(void)
 }
 EXPORT_SYMBOL(qe_get_num_of_risc);
 
+unsigned int qe_get_num_of_snums(void)
+{
+	struct device_node *qe;
+	int size;
+	unsigned int num_of_snums;
+	const u32 *prop;
+
+	num_of_snums = 28; /* The default number of snum for threads is 28 */
+	qe = of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (!qe) {
+		/* Older devices trees did not have an "fsl,qe"
+		 * compatible property, so we need to look for
+		 * the QE node by name.
+		 */
+		qe = of_find_node_by_type(NULL, "qe");
+		if (!qe)
+			return num_of_snums;
+	}
+
+	prop = of_get_property(qe, "num-snums", &size);
+	if (prop && size == sizeof(*prop)) {
+		num_of_snums = *prop;
+		if ((num_of_snums < 28) || (num_of_snums > QE_NUM_OF_SNUM)) {
+			/* No QE ever has fewer than 28 SNUMs */
+			pr_err("QE: number of snum is invalid\n");
+			return -EINVAL;
+		}
+	}
+
+	of_node_put(qe);
+
+	return num_of_snums;
+}
+EXPORT_SYMBOL(qe_get_num_of_snums);
-- 
1.6.0.2
