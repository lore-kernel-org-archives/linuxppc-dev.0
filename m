Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2E75F2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Feb 2014 06:51:56 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Subject: [PATCH] powerpc: fix build failure in sysdev/mpic.c for MPIC_WEIRD=y
Date: Fri, 7 Feb 2014 14:50:58 -0500
Message-ID: <1391802658-30951-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 446f6d06fab0b49c61887ecbe8286d6aaa796637 ("powerpc/mpic: Properly
set default triggers") breaks the mpc7447_hpc_defconfig as follows:

  CC      arch/powerpc/sysdev/mpic.o
arch/powerpc/sysdev/mpic.c: In function 'mpic_set_irq_type':
arch/powerpc/sysdev/mpic.c:886:9: error: case label does not reduce to an integer constant
arch/powerpc/sysdev/mpic.c:890:9: error: case label does not reduce to an integer constant
arch/powerpc/sysdev/mpic.c:894:9: error: case label does not reduce to an integer constant
arch/powerpc/sysdev/mpic.c:898:9: error: case label does not reduce to an integer constant

Looking at the cpp output (gcc 4.7.3), I see:

   case mpic->hw_set[MPIC_IDX_VECPRI_SENSE_EDGE] |
        mpic->hw_set[MPIC_IDX_VECPRI_POLARITY_POSITIVE]:

The pointer into an array appears because CONFIG_MPIC_WEIRD=y is set
for this platform, thus enabling the following:

  -------------------
  #ifdef CONFIG_MPIC_WEIRD
  static u32 mpic_infos[][MPIC_IDX_END] = {
        [0] = { /* Original OpenPIC compatible MPIC */

  [...]

  #define MPIC_INFO(name) mpic->hw_set[MPIC_IDX_##name]

  #else /* CONFIG_MPIC_WEIRD */

  #define MPIC_INFO(name) MPIC_##name

  #endif /* CONFIG_MPIC_WEIRD */
  -------------------

Here we convert the case section to if/else if, and also add
the equivalent of a default case to warn about unknown types.
Boot tested on sbc8548, build tested on all defconfigs.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/sysdev/mpic.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 0e166ed4cd16..8209744b2829 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -886,25 +886,25 @@ int mpic_set_irq_type(struct irq_data *d, unsigned int flow_type)
 
 	/* Default: read HW settings */
 	if (flow_type == IRQ_TYPE_DEFAULT) {
-		switch(vold & (MPIC_INFO(VECPRI_POLARITY_MASK) |
-			       MPIC_INFO(VECPRI_SENSE_MASK))) {
-			case MPIC_INFO(VECPRI_SENSE_EDGE) |
-			     MPIC_INFO(VECPRI_POLARITY_POSITIVE):
-				flow_type = IRQ_TYPE_EDGE_RISING;
-				break;
-			case MPIC_INFO(VECPRI_SENSE_EDGE) |
-			     MPIC_INFO(VECPRI_POLARITY_NEGATIVE):
-				flow_type = IRQ_TYPE_EDGE_FALLING;
-				break;
-			case MPIC_INFO(VECPRI_SENSE_LEVEL) |
-			     MPIC_INFO(VECPRI_POLARITY_POSITIVE):
-				flow_type = IRQ_TYPE_LEVEL_HIGH;
-				break;
-			case MPIC_INFO(VECPRI_SENSE_LEVEL) |
-			     MPIC_INFO(VECPRI_POLARITY_NEGATIVE):
-				flow_type = IRQ_TYPE_LEVEL_LOW;
-				break;
-		}
+		int vold_ps;
+
+		vold_ps = vold & (MPIC_INFO(VECPRI_POLARITY_MASK) |
+				  MPIC_INFO(VECPRI_SENSE_MASK));
+
+		if (vold_ps == (MPIC_INFO(VECPRI_SENSE_EDGE) |
+				MPIC_INFO(VECPRI_POLARITY_POSITIVE)))
+			flow_type = IRQ_TYPE_EDGE_RISING;
+		else if	(vold_ps == (MPIC_INFO(VECPRI_SENSE_EDGE) |
+				     MPIC_INFO(VECPRI_POLARITY_NEGATIVE)))
+			flow_type = IRQ_TYPE_EDGE_FALLING;
+		else if (vold_ps == (MPIC_INFO(VECPRI_SENSE_LEVEL) |
+				     MPIC_INFO(VECPRI_POLARITY_POSITIVE)))
+			flow_type = IRQ_TYPE_LEVEL_HIGH;
+		else if (vold_ps == (MPIC_INFO(VECPRI_SENSE_LEVEL) |
+				     MPIC_INFO(VECPRI_POLARITY_NEGATIVE)))
+			flow_type = IRQ_TYPE_LEVEL_LOW;
+		else
+			WARN_ONCE(1, "mpic: unknown IRQ type %d\n", vold);
 	}
 
 	/* Apply to irq desc */
-- 
1.8.5.2
