Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 76E61B6FC8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 22:52:21 +1000 (EST)
Received: by mail-ww0-f45.google.com with SMTP id 36so1976565wwi.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 05:52:20 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V3 2/2] cpc925_edac: support single-processor configurations
Date: Fri, 17 Jun 2011 16:51:47 +0400
Message-Id: <1308315107-29182-3-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1308315107-29182-1-git-send-email-dbaryshkov@gmail.com>
References: <1308315107-29182-1-git-send-email-dbaryshkov@gmail.com>
Cc: Harry Ciao <qingtao.cao@windriver.com>, Paul Mackerras <paulus@samba.org>,
	Doug Thompson <dougthompson@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If second CPU is not enabled, CPC925 EDAC driver will spill out warnings
about errors on second Processor Interface. Support masking that out,
by detecting at runtime which CPUs are present in device tree.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Harry Ciao <qingtao.cao@windriver.com>
Cc: Doug Thompson <dougthompson@xmission.com>
Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/edac/cpc925_edac.c |   67 ++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/cpc925_edac.c b/drivers/edac/cpc925_edac.c
index a687a0d..a774c0d 100644
--- a/drivers/edac/cpc925_edac.c
+++ b/drivers/edac/cpc925_edac.c
@@ -90,6 +90,7 @@ enum apimask_bits {
 	ECC_MASK_ENABLE = (APIMASK_ECC_UE_H | APIMASK_ECC_CE_H |
 			   APIMASK_ECC_UE_L | APIMASK_ECC_CE_L),
 };
+#define APIMASK_ADI(n)		CPC925_BIT(((n)+1))
 
 /************************************************************
  *	Processor Interface Exception Register (APIEXCP)
@@ -581,16 +582,73 @@ static void cpc925_mc_check(struct mem_ctl_info *mci)
 }
 
 /******************** CPU err device********************************/
+static u32 cpc925_cpu_mask_disabled(void)
+{
+	struct device_node *cpus;
+	struct device_node *cpunode = NULL;
+	static u32 mask = 0;
+
+	/* use cached value if available */
+	if (mask != 0)
+		return mask;
+
+	mask = APIMASK_ADI0 | APIMASK_ADI1;
+
+	cpus = of_find_node_by_path("/cpus");
+	if (cpus == NULL) {
+		cpc925_printk(KERN_DEBUG, "No /cpus node !\n");
+		return 0;
+	}
+
+	while ((cpunode = of_get_next_child(cpus, cpunode)) != NULL) {
+		const u32 *reg = of_get_property(cpunode, "reg", NULL);
+
+		if (strcmp(cpunode->type, "cpu")) {
+			cpc925_printk(KERN_ERR, "Not a cpu node in /cpus: %s\n", cpunode->name);
+			continue;
+		}
+
+		if (reg == NULL || *reg > 2) {
+			cpc925_printk(KERN_ERR, "Bad reg value at %s\n", cpunode->full_name);
+			continue;
+		}
+
+		mask &= ~APIMASK_ADI(*reg);
+	}
+
+	if (mask != (APIMASK_ADI0 | APIMASK_ADI1)) {
+		/* We assume that each CPU sits on it's own PI and that
+		 * for present CPUs the reg property equals to the PI
+		 * interface id */
+		cpc925_printk(KERN_WARNING,
+				"Assuming PI id is equal to CPU MPIC id!\n");
+	}
+
+	of_node_put(cpunode);
+	of_node_put(cpus);
+
+	return mask;
+}
+
 /* Enable CPU Errors detection */
 static void cpc925_cpu_init(struct cpc925_dev_info *dev_info)
 {
 	u32 apimask;
+	u32 cpumask;
 
 	apimask = __raw_readl(dev_info->vbase + REG_APIMASK_OFFSET);
-	if ((apimask & CPU_MASK_ENABLE) == 0) {
-		apimask |= CPU_MASK_ENABLE;
-		__raw_writel(apimask, dev_info->vbase + REG_APIMASK_OFFSET);
+
+	cpumask = cpc925_cpu_mask_disabled();
+	if (apimask & cpumask) {
+		cpc925_printk(KERN_WARNING, "CPU(s) not present, "
+				"but enabled in APIMASK, disabling\n");
+		apimask &= ~cpumask;
 	}
+
+	if ((apimask & CPU_MASK_ENABLE) == 0)
+		apimask |= CPU_MASK_ENABLE;
+
+	__raw_writel(apimask, dev_info->vbase + REG_APIMASK_OFFSET);
 }
 
 /* Disable CPU Errors detection */
@@ -622,6 +680,9 @@ static void cpc925_cpu_check(struct edac_device_ctl_info *edac_dev)
 	if ((apiexcp & CPU_EXCP_DETECTED) == 0)
 		return;
 
+	if ((apiexcp & ~cpc925_cpu_mask_disabled()) == 0)
+		return;
+
 	apimask = __raw_readl(dev_info->vbase + REG_APIMASK_OFFSET);
 	cpc925_printk(KERN_INFO, "Processor Interface Fault\n"
 				 "Processor Interface register dump:\n");
-- 
1.7.5.3
