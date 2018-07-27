Return-Path: <bharat.bhushan@nxp.com>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30087.outbound.protection.outlook.com [40.107.3.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cPQX2vSmzDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 19:52:36 +1000 (AEST)
From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 oss@buserror.net, galak@kernel.crashing.org, mark.rutland@arm.com,
 kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: robh@kernel.org, keescook@chromium.org, tyreld@linux.vnet.ibm.com,
 joe@perches.com, Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: [RFC 1/5] powerpc/mpic: move last irq logic to function
Date: Fri, 27 Jul 2018 15:17:57 +0530
Message-Id: <1532684881-19310-2-git-send-email-Bharat.Bhushan@nxp.com>
In-Reply-To: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This function just moves the last-irq calculation
logic to a function, while no change in logic.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
 arch/powerpc/sysdev/mpic.c | 52 +++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 353b439..b6803bc 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1210,6 +1210,36 @@ u32 fsl_mpic_primary_get_version(void)
 	return 0;
 }
 
+static int mpic_get_last_irq_source(struct mpic *mpic,
+				    unsigned int irq_count,
+				    unsigned int isu_size)
+{
+	u32 last_irq;
+	u32 greg_feature;
+
+	/*
+	 * Read feature register.  For non-ISU MPICs, num sources as well. On
+	 * ISU MPICs, sources are counted as ISUs are added
+	 */
+	greg_feature = mpic_read(mpic->gregs, MPIC_INFO(GREG_FEATURE_0));
+
+	/*
+	 * By default, the last source number comes from the MPIC, but the
+	 * device-tree and board support code can override it on buggy hw.
+	 * If we get passed an isu_size (multi-isu MPIC) then we use that
+	 * as a default instead of the value read from the HW.
+	 */
+	last_irq = (greg_feature & MPIC_GREG_FEATURE_LAST_SRC_MASK)
+				>> MPIC_GREG_FEATURE_LAST_SRC_SHIFT;
+	if (isu_size)
+		last_irq = isu_size  * MPIC_MAX_ISU - 1;
+	of_property_read_u32(mpic->node, "last-interrupt-source", &last_irq);
+	if (irq_count)
+		last_irq = irq_count - 1;
+
+	return last_irq;
+}
+
 struct mpic * __init mpic_alloc(struct device_node *node,
 				phys_addr_t phys_addr,
 				unsigned int flags,
@@ -1451,25 +1481,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 			 0x1000);
 	}
 
-	/*
-	 * Read feature register.  For non-ISU MPICs, num sources as well. On
-	 * ISU MPICs, sources are counted as ISUs are added
-	 */
-	greg_feature = mpic_read(mpic->gregs, MPIC_INFO(GREG_FEATURE_0));
-
-	/*
-	 * By default, the last source number comes from the MPIC, but the
-	 * device-tree and board support code can override it on buggy hw.
-	 * If we get passed an isu_size (multi-isu MPIC) then we use that
-	 * as a default instead of the value read from the HW.
-	 */
-	last_irq = (greg_feature & MPIC_GREG_FEATURE_LAST_SRC_MASK)
-				>> MPIC_GREG_FEATURE_LAST_SRC_SHIFT;
-	if (isu_size)
-		last_irq = isu_size  * MPIC_MAX_ISU - 1;
-	of_property_read_u32(mpic->node, "last-interrupt-source", &last_irq);
-	if (irq_count)
-		last_irq = irq_count - 1;
+	last_irq = mpic_get_last_irq_source(mpic, irq_count, isu_size);
 
 	/* Initialize main ISU if none provided */
 	if (!isu_size) {
@@ -1495,6 +1507,8 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	if (mpic->irqhost == NULL)
 		return NULL;
 
+	greg_feature = mpic_read(mpic->gregs, MPIC_INFO(GREG_FEATURE_0));
+
 	/* Display version */
 	switch (greg_feature & MPIC_GREG_FEATURE_VERSION_MASK) {
 	case 1:
-- 
1.9.3
