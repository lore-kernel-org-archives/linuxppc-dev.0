Return-Path: <ivan@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ypJpq1NvBzDsMB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Dec 2017 02:58:42 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB1FnMA9010308
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Dec 2017 10:58:40 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ek80q00mj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Dec 2017 10:58:39 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ivan@de.ibm.com>;
 Fri, 1 Dec 2017 15:58:36 -0000
From: Ivan Mikhaylov <ivan@de.ibm.com>
To: Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 4/4] 44x/fsp2: add irq error handlers
Date: Fri, 1 Dec 2017 18:58:27 +0300
Message-Id: <20171201155827.57979-4-ivan@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

add irq error handlers for cmu, plb, opb, mcue, conf
with debug information output in case of problems.

Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
---
 arch/powerpc/platforms/44x/fsp2.c |  205 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 204 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/44x/fsp2.c b/arch/powerpc/platforms/44x/fsp2.c
index 7c9bc93..04f0c73 100644
--- a/arch/powerpc/platforms/44x/fsp2.c
+++ b/arch/powerpc/platforms/44x/fsp2.c
@@ -28,8 +28,17 @@
 #include <asm/uic.h>
 #include <asm/ppc4xx.h>
 #include <asm/dcr.h>
+#include <linux/interrupt.h>
+#include <linux/of_irq.h>
 #include "fsp2.h"
 
+#define FSP2_BUS_ERR	"ibm,bus-error-irq"
+#define FSP2_CMU_ERR	"ibm,cmu-error-irq"
+#define FSP2_CONF_ERR	"ibm,conf-error-irq"
+#define FSP2_OPBD_ERR	"ibm,opbd-error-irq"
+#define FSP2_MCUE	"ibm,mc-ue-irq"
+#define FSP2_RST_WRN	"ibm,reset-warning-irq"
+
 static __initdata struct of_device_id fsp2_of_bus[] = {
 	{ .compatible = "ibm,plb4", },
 	{ .compatible = "ibm,plb6", },
@@ -37,6 +46,194 @@
 	{},
 };
 
+static void l2regs(void)
+{
+	pr_err("L2 Controller:\n");
+	pr_err("MCK:      0x%08x\n", mfl2(L2MCK));
+	pr_err("INT:      0x%08x\n", mfl2(L2INT));
+	pr_err("PLBSTAT0: 0x%08x\n", mfl2(L2PLBSTAT0));
+	pr_err("PLBSTAT1: 0x%08x\n", mfl2(L2PLBSTAT1));
+	pr_err("ARRSTAT0: 0x%08x\n", mfl2(L2ARRSTAT0));
+	pr_err("ARRSTAT1: 0x%08x\n", mfl2(L2ARRSTAT1));
+	pr_err("ARRSTAT2: 0x%08x\n", mfl2(L2ARRSTAT2));
+	pr_err("CPUSTAT:  0x%08x\n", mfl2(L2CPUSTAT));
+	pr_err("RACSTAT0: 0x%08x\n", mfl2(L2RACSTAT0));
+	pr_err("WACSTAT0: 0x%08x\n", mfl2(L2WACSTAT0));
+	pr_err("WACSTAT1: 0x%08x\n", mfl2(L2WACSTAT1));
+	pr_err("WACSTAT2: 0x%08x\n", mfl2(L2WACSTAT2));
+	pr_err("WDFSTAT:  0x%08x\n", mfl2(L2WDFSTAT));
+	pr_err("LOG0:     0x%08x\n", mfl2(L2LOG0));
+	pr_err("LOG1:     0x%08x\n", mfl2(L2LOG1));
+	pr_err("LOG2:     0x%08x\n", mfl2(L2LOG2));
+	pr_err("LOG3:     0x%08x\n", mfl2(L2LOG3));
+	pr_err("LOG4:     0x%08x\n", mfl2(L2LOG4));
+	pr_err("LOG5:     0x%08x\n", mfl2(L2LOG5));
+}
+
+static void show_plbopb_regs(u32 base, int num)
+{
+	pr_err("\nPLBOPB Bridge %d:\n", num);
+	pr_err("GESR0: 0x%08x\n", mfdcr(base + PLB4OPB_GESR0));
+	pr_err("GESR1: 0x%08x\n", mfdcr(base + PLB4OPB_GESR1));
+	pr_err("GESR2: 0x%08x\n", mfdcr(base + PLB4OPB_GESR2));
+	pr_err("GEARU: 0x%08x\n", mfdcr(base + PLB4OPB_GEARU));
+	pr_err("GEAR:  0x%08x\n", mfdcr(base + PLB4OPB_GEAR));
+}
+
+static irqreturn_t bus_err_handler(int irq, void *data)
+{
+	pr_err("Bus Error\n");
+
+	l2regs();
+
+	pr_err("\nPLB6 Controller:\n");
+	pr_err("BC_SHD: 0x%08x\n", mfdcr(DCRN_PLB6_SHD));
+	pr_err("BC_ERR: 0x%08x\n", mfdcr(DCRN_PLB6_ERR));
+
+	pr_err("\nPLB6-to-PLB4 Bridge:\n");
+	pr_err("ESR:  0x%08x\n", mfdcr(DCRN_PLB6PLB4_ESR));
+	pr_err("EARH: 0x%08x\n", mfdcr(DCRN_PLB6PLB4_EARH));
+	pr_err("EARL: 0x%08x\n", mfdcr(DCRN_PLB6PLB4_EARL));
+
+	pr_err("\nPLB4-to-PLB6 Bridge:\n");
+	pr_err("ESR:  0x%08x\n", mfdcr(DCRN_PLB4PLB6_ESR));
+	pr_err("EARH: 0x%08x\n", mfdcr(DCRN_PLB4PLB6_EARH));
+	pr_err("EARL: 0x%08x\n", mfdcr(DCRN_PLB4PLB6_EARL));
+
+	pr_err("\nPLB6-to-MCIF Bridge:\n");
+	pr_err("BESR0: 0x%08x\n", mfdcr(DCRN_PLB6MCIF_BESR0));
+	pr_err("BESR1: 0x%08x\n", mfdcr(DCRN_PLB6MCIF_BESR1));
+	pr_err("BEARH: 0x%08x\n", mfdcr(DCRN_PLB6MCIF_BEARH));
+	pr_err("BEARL: 0x%08x\n", mfdcr(DCRN_PLB6MCIF_BEARL));
+
+	pr_err("\nPLB4 Arbiter:\n");
+	pr_err("P0ESRH 0x%08x\n", mfdcr(DCRN_PLB4_P0ESRH));
+	pr_err("P0ESRL 0x%08x\n", mfdcr(DCRN_PLB4_P0ESRL));
+	pr_err("P0EARH 0x%08x\n", mfdcr(DCRN_PLB4_P0EARH));
+	pr_err("P0EARH 0x%08x\n", mfdcr(DCRN_PLB4_P0EARH));
+	pr_err("P1ESRH 0x%08x\n", mfdcr(DCRN_PLB4_P1ESRH));
+	pr_err("P1ESRL 0x%08x\n", mfdcr(DCRN_PLB4_P1ESRL));
+	pr_err("P1EARH 0x%08x\n", mfdcr(DCRN_PLB4_P1EARH));
+	pr_err("P1EARH 0x%08x\n", mfdcr(DCRN_PLB4_P1EARH));
+
+	show_plbopb_regs(DCRN_PLB4OPB0_BASE, 0);
+	show_plbopb_regs(DCRN_PLB4OPB1_BASE, 1);
+	show_plbopb_regs(DCRN_PLB4OPB2_BASE, 2);
+	show_plbopb_regs(DCRN_PLB4OPB3_BASE, 3);
+
+	pr_err("\nPLB4-to-AHB Bridge:\n");
+	pr_err("ESR:   0x%08x\n", mfdcr(DCRN_PLB4AHB_ESR));
+	pr_err("SEUAR: 0x%08x\n", mfdcr(DCRN_PLB4AHB_SEUAR));
+	pr_err("SELAR: 0x%08x\n", mfdcr(DCRN_PLB4AHB_SELAR));
+
+	pr_err("\nAHB-to-PLB4 Bridge:\n");
+	pr_err("\nESR: 0x%08x\n", mfdcr(DCRN_AHBPLB4_ESR));
+	pr_err("\nEAR: 0x%08x\n", mfdcr(DCRN_AHBPLB4_EAR));
+	panic("Bus Error\n");
+}
+
+static irqreturn_t cmu_err_handler(int irq, void *data) {
+	pr_err("CMU Error\n");
+	pr_err("FIR0: 0x%08x\n", mfcmu(CMUN_FIR0));
+	panic("CMU Error\n");
+}
+
+static irqreturn_t conf_err_handler(int irq, void *data) {
+	pr_err("Configuration Logic Error\n");
+	pr_err("CONF_FIR: 0x%08x\n", mfdcr(DCRN_CONF_FIR_RWC));
+	pr_err("RPERR0:   0x%08x\n", mfdcr(DCRN_CONF_RPERR0));
+	pr_err("RPERR1:   0x%08x\n", mfdcr(DCRN_CONF_RPERR1));
+	panic("Configuration Logic Error\n");
+}
+
+static irqreturn_t opbd_err_handler(int irq, void *data) {
+	panic("OPBD Error\n");
+}
+
+static irqreturn_t mcue_handler(int irq, void *data) {
+	pr_err("DDR: Uncorrectable Error\n");
+	pr_err("MCSTAT:            0x%08x\n",
+		mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_MCSTAT));
+	pr_err("MCOPT1:            0x%08x\n",
+		mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_MCOPT1));
+	pr_err("MCOPT2:            0x%08x\n",
+		mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_MCOPT2));
+	pr_err("PHYSTAT:           0x%08x\n",
+		mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_PHYSTAT));
+	pr_err("CFGR0:             0x%08x\n",
+		mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_CFGR0));
+	pr_err("CFGR1:             0x%08x\n",
+		mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_CFGR1));
+	pr_err("CFGR2:             0x%08x\n",
+		mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_CFGR2));
+	pr_err("CFGR3:             0x%08x\n",
+		mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_CFGR3));
+	pr_err("SCRUB_CNTL:        0x%08x\n",
+		mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_SCRUB_CNTL));
+	pr_err("ECCERR_PORT0:      0x%08x\n",
+		mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_ECCERR_PORT0));
+	pr_err("ECCERR_ADDR_PORT0: 0x%08x\n",
+		mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_ECCERR_ADDR_PORT0));
+	pr_err("ECCERR_CNT_PORT0:  0x%08x\n",
+		mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_ECCERR_COUNT_PORT0));
+	pr_err("ECC_CHECK_PORT0:   0x%08x\n",
+		mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_ECC_CHECK_PORT0));
+	pr_err("MCER0:            0x%08x\n",
+		mfdcr(DCRN_CW_BASE + DCRN_CW_MCER0));
+	pr_err("MCER1:            0x%08x\n",
+		mfdcr(DCRN_CW_BASE + DCRN_CW_MCER1));
+	pr_err("BESR:             0x%08x\n",
+		mfdcr(DCRN_PLB6MCIF_BESR0));
+	pr_err("BEARL:            0x%08x\n",
+		mfdcr(DCRN_PLB6MCIF_BEARL));
+	pr_err("BEARH:            0x%08x\n",
+		mfdcr(DCRN_PLB6MCIF_BEARH));
+	panic("DDR: Uncorrectable Error\n");
+}
+
+static irqreturn_t rst_wrn_handler(int irq, void *data) {
+	u32 crcs = mfcmu(CMUN_CRCS);
+	switch (crcs & CRCS_STAT_MASK) {
+	case CRCS_STAT_CHIP_RST_B:
+		panic("Received chassis-initiated reset request");
+	default:
+		panic("Unknown external reset: CRCS=0x%x", crcs);
+	}
+}
+
+static void node_irq_request(const char *compat, irq_handler_t errirq_handler)
+{
+	struct device_node *np;
+	unsigned int irq;
+	int32_t rc;
+
+	for_each_compatible_node(np, NULL, compat) {
+		irq = irq_of_parse_and_map(np, 0);
+		if (irq == NO_IRQ) {
+			pr_err("device tree node %s is missing a interrupt",
+			      np->name);
+			return;
+		}
+
+		rc = request_irq(irq, errirq_handler, 0, np->name, np);
+		if (rc) {
+			pr_err("fsp_of_probe: request_irq failed: np=%s rc=%d",
+			      np->full_name, rc);
+			return;
+		}
+	}
+}
+
+static void critical_irq_setup(void)
+{
+	node_irq_request(FSP2_CMU_ERR, cmu_err_handler);
+	node_irq_request(FSP2_BUS_ERR, bus_err_handler);
+	node_irq_request(FSP2_CONF_ERR, conf_err_handler);
+	node_irq_request(FSP2_OPBD_ERR, opbd_err_handler);
+	node_irq_request(FSP2_MCUE, mcue_handler);
+	node_irq_request(FSP2_RST_WRN, rst_wrn_handler);
+}
+
 static int __init fsp2_device_probe(void)
 {
 	of_platform_bus_probe(NULL, fsp2_of_bus, NULL);
@@ -105,11 +302,17 @@ static int __init fsp2_probe(void)
 	return 1;
 }
 
+static void __init fsp2_irq_init(void)
+{
+	uic_init_tree();
+	critical_irq_setup();
+}
+
 define_machine(fsp2) {
 	.name			= "FSP-2",
 	.probe			= fsp2_probe,
 	.progress		= udbg_progress,
-	.init_IRQ		= uic_init_tree,
+	.init_IRQ		= fsp2_irq_init,
 	.get_irq		= uic_get_irq,
 	.restart		= ppc4xx_reset_system,
 	.calibrate_decr		= generic_calibrate_decr,
-- 
1.7.1
