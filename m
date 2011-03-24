Return-Path: <B07421@freescale.com>
Date: Thu, 24 Mar 2011 16:43:54 -0500
From: Scott Wood <scottwood@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 3/4] powerpc/mpic: parse 4-cell intspec types other than zero
Message-ID: <20110324214354.GB9524@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20110324214315.GA9502@schlenkerla.am.freescale.net>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/mpic.h |    2 ++
 arch/powerpc/sysdev/mpic.c      |   37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index 7005ee0..25a0cb3 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -371,6 +371,8 @@ struct mpic
  * NOTE: This flag trumps MPIC_WANTS_RESET.
  */
 #define MPIC_NO_RESET			0x00004000
+/* Freescale MPIC (compatible includes "fsl,mpic") */
+#define MPIC_FSL			0x00008000
 
 /* MPIC HW modification ID */
 #define MPIC_REGSET_MASK		0xf0000000
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 0f7c671..69f96ec 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -6,6 +6,7 @@
  *  with various broken implementations of this HW.
  *
  *  Copyright (C) 2004 Benjamin Herrenschmidt, IBM Corp.
+ *  Copyright 2010-2011 Freescale Semiconductor, Inc.
  *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License.  See the file COPYING in the main directory of this archive
@@ -1030,6 +1031,7 @@ static int mpic_host_xlate(struct irq_host *h, struct device_node *ct,
 			   irq_hw_number_t *out_hwirq, unsigned int *out_flags)
 
 {
+	struct mpic *mpic = h->host_data;
 	static unsigned char map_mpic_senses[4] = {
 		IRQ_TYPE_EDGE_RISING,
 		IRQ_TYPE_LEVEL_LOW,
@@ -1038,7 +1040,38 @@ static int mpic_host_xlate(struct irq_host *h, struct device_node *ct,
 	};
 
 	*out_hwirq = intspec[0];
-	if (intsize > 1) {
+	if (intsize >= 4 && (mpic->flags & MPIC_FSL)) {
+		/*
+		 * Freescale MPIC with extended intspec:
+		 * First two cells are as usual.  Third specifies
+		 * an "interrupt type".  Fourth is type-specific data.
+		 *
+		 * See Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
+		 */
+		switch (intspec[2]) {
+		case 0:
+		case 1: /* no EISR/EIMR support for now, treat as shared IRQ */
+			break;
+		case 2:
+			if (intspec[0] >= ARRAY_SIZE(mpic->ipi_vecs))
+				return -EINVAL;
+
+			*out_hwirq = mpic->ipi_vecs[intspec[0]];
+			break;
+		case 3:
+			if (intspec[0] >= ARRAY_SIZE(mpic->timer_vecs))
+				return -EINVAL;
+
+			*out_hwirq = mpic->timer_vecs[intspec[0]];
+			break;
+		default:
+			pr_debug("%s: unknown irq type %u\n",
+				 __func__, intspec[2]);
+			return -EINVAL;
+		}
+
+		*out_flags = map_mpic_senses[intspec[1] & 3];
+	} else if (intsize > 1) {
 		u32 mask = 0x3;
 
 		/* Apple invented a new race of encoding on machines with
@@ -1137,6 +1170,8 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	/* Check for "big-endian" in device-tree */
 	if (node && of_get_property(node, "big-endian", NULL) != NULL)
 		mpic->flags |= MPIC_BIG_ENDIAN;
+	if (node && of_device_is_compatible(node, "fsl,mpic"))
+		mpic->flags |= MPIC_FSL;
 
 	/* Look for protected sources */
 	if (node) {
-- 
1.7.1
