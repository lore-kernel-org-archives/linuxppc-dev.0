Return-Path: <bharat.bhushan@nxp.com>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30087.outbound.protection.outlook.com [40.107.3.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cPQZ0153zF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 19:52:37 +1000 (AEST)
From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 oss@buserror.net, galak@kernel.crashing.org, mark.rutland@arm.com,
 kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: robh@kernel.org, keescook@chromium.org, tyreld@linux.vnet.ibm.com,
 joe@perches.com, Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: [RFC 2/5] powerpc/mpic: Rework last source irq calculation logic
Date: Fri, 27 Jul 2018 15:17:58 +0530
Message-Id: <1532684881-19310-3-git-send-email-Bharat.Bhushan@nxp.com>
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

Last irq calculation logic uses below priority order:
  1) irq_count from platform
  2) "last-interrupt-source" from device tree
  3) isu_size from platform
  4) MPIC h/w GREG_FEATURE_0 register

This patch reworks the last irq calculation logic but
functionality and priority order are same as before.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
 arch/powerpc/sysdev/mpic.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index b6803bc..d503887 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1217,25 +1217,32 @@ static int mpic_get_last_irq_source(struct mpic *mpic,
 	u32 last_irq;
 	u32 greg_feature;
 
+	/* Current priority order for getting last irq:
+	 *  1) irq_count from platform
+	 *  2) "last-interrupt-source" from device tree
+	 *  3) isu_size from platform
+	 *  4) MPIC h/w GREG_FEATURE_0 register
+	 */
+
+	if (irq_count)
+		return (irq_count - 1);
+
+	if (!of_property_read_u32(mpic->node, "last-interrupt-source",
+				  &last_irq)) {
+		return last_irq;
+	}
+
+	if (isu_size)
+		return (isu_size  * MPIC_MAX_ISU - 1);
+
 	/*
-	 * Read feature register.  For non-ISU MPICs, num sources as well. On
+	 * Read feature register. For non-ISU MPICs, num sources as well. On
 	 * ISU MPICs, sources are counted as ISUs are added
 	 */
 	greg_feature = mpic_read(mpic->gregs, MPIC_INFO(GREG_FEATURE_0));
 
-	/*
-	 * By default, the last source number comes from the MPIC, but the
-	 * device-tree and board support code can override it on buggy hw.
-	 * If we get passed an isu_size (multi-isu MPIC) then we use that
-	 * as a default instead of the value read from the HW.
-	 */
 	last_irq = (greg_feature & MPIC_GREG_FEATURE_LAST_SRC_MASK)
 				>> MPIC_GREG_FEATURE_LAST_SRC_SHIFT;
-	if (isu_size)
-		last_irq = isu_size  * MPIC_MAX_ISU - 1;
-	of_property_read_u32(mpic->node, "last-interrupt-source", &last_irq);
-	if (irq_count)
-		last_irq = irq_count - 1;
 
 	return last_irq;
 }
-- 
1.9.3
