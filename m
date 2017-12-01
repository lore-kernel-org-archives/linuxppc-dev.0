Return-Path: <ivan@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ypJpn0rWfzDsG1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Dec 2017 02:58:40 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB1FnLI2063960
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Dec 2017 10:58:38 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ek8wkc1vp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Dec 2017 10:58:38 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ivan@de.ibm.com>;
 Fri, 1 Dec 2017 15:58:35 -0000
From: Ivan Mikhaylov <ivan@de.ibm.com>
To: Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 2/4] 44x/fsp2: interrupt handling setup
Date: Fri, 1 Dec 2017 18:58:25 +0300
Message-Id: <20171201155827.57979-2-ivan@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* clear out any possible plb6 errors
* board interrupt handling setup within l2 reg set
* fsp2 parity error setup

All those points are needed for correct interrupt
handling on board level including error handling report.

Reviewed-by: Alistair Popple <alistair@popple.id.au>
Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
---
 arch/powerpc/platforms/44x/fsp2.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/44x/fsp2.c b/arch/powerpc/platforms/44x/fsp2.c
index 92e9804..baed409 100644
--- a/arch/powerpc/platforms/44x/fsp2.c
+++ b/arch/powerpc/platforms/44x/fsp2.c
@@ -27,6 +27,8 @@
 #include <asm/time.h>
 #include <asm/uic.h>
 #include <asm/ppc4xx.h>
+#include <asm/dcr.h>
+#include "fsp2.h"
 
 static __initdata struct of_device_id fsp2_of_bus[] = {
 	{ .compatible = "ibm,plb4", },
@@ -44,10 +46,45 @@ static int __init fsp2_device_probe(void)
 
 static int __init fsp2_probe(void)
 {
+	u32 val;
 	unsigned long root = of_get_flat_dt_root();
 
 	if (!of_flat_dt_is_compatible(root, "ibm,fsp2"))
 		return 0;
+
+	/* Clear BC_ERR and mask snoopable request plb errors. */
+	val = mfdcr(DCRN_PLB6_CR0);
+	val |= 0x20000000;
+	mtdcr(DCRN_PLB6_BASE, val);
+	mtdcr(DCRN_PLB6_HD, 0xffff0000);
+	mtdcr(DCRN_PLB6_SHD, 0xffff0000);
+
+	/* L2 machine checks */
+	mtl2(L2PLBMCKEN0, 0xffffffff);
+	mtl2(L2PLBMCKEN1, 0x0000ffff);
+	mtl2(L2ARRMCKEN0, 0xffffffff);
+	mtl2(L2ARRMCKEN1, 0xffffffff);
+	mtl2(L2ARRMCKEN2, 0xfffff000);
+	mtl2(L2CPUMCKEN,  0xffffffff);
+	mtl2(L2RACMCKEN0, 0xffffffff);
+	mtl2(L2WACMCKEN0, 0xffffffff);
+	mtl2(L2WACMCKEN1, 0xffffffff);
+	mtl2(L2WACMCKEN2, 0xffffffff);
+	mtl2(L2WDFMCKEN,  0xffffffff);
+
+	/* L2 interrupts */
+	mtl2(L2PLBINTEN1, 0xffff0000);
+
+	/*
+	 * At a global level, enable all L2 machine checks and interrupts
+	 * reported by the L2 subsystems, except for the external machine check
+	 * input (UIC0.1).
+	 */
+	mtl2(L2MCKEN, 0x000007ff);
+	mtl2(L2INTEN, 0x000004ff);
+
+	/* Enable FSP-2 configuration logic parity errors */
+	mtdcr(DCRN_CONF_EIR_RS, 0x80000000);
 	return 1;
 }
 
-- 
1.7.1
