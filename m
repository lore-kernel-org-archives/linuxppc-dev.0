Return-Path: <qiang.zhao@nxp.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0067.outbound.protection.outlook.com [157.56.110.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 592D01A0E9C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 12:14:33 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@linutronix.de>, <leoyang.li@nxp.com>, <oss@buserror.net>,
 <xiaobo.xie@nxp.com>, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH] qe_ic: fix a buffer overflow error and add check elsewhere
Date: Thu, 21 Jan 2016 09:06:04 +0800
Message-ID: <1453338364-45129-1-git-send-email-qiang.zhao@nxp.com>
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

127 is the theoretical up boundary of QEIC number,
in fact there only be 44 qe_ic_info now.
add check to overflow for qe_ic_info

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 drivers/soc/fsl/qe/qe_ic.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 5419527..90c00b7 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -261,6 +261,11 @@ static int qe_ic_host_map(struct irq_domain *h, unsigned int virq,
 	struct qe_ic *qe_ic = h->host_data;
 	struct irq_chip *chip;
 
+	if (hw >= ARRAY_SIZE(qe_ic_info)) {
+		pr_err("%s: Invalid hw irq number for QEIC\n", __func__);
+		return -EINVAL;
+	}
+
 	if (qe_ic_info[hw].mask == 0) {
 		printk(KERN_ERR "Can't map reserved IRQ\n");
 		return -EINVAL;
@@ -409,7 +414,8 @@ int qe_ic_set_priority(unsigned int virq, unsigned int priority)
 
 	if (priority > 8 || priority == 0)
 		return -EINVAL;
-	if (src > 127)
+	if (WARN_ONCE(src >= ARRAY_SIZE(qe_ic_info),
+		      "%s: Invalid hw irq number for QEIC\n", __func__))
 		return -EINVAL;
 	if (qe_ic_info[src].pri_reg == 0)
 		return -EINVAL;
@@ -438,6 +444,9 @@ int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high)
 
 	if (priority > 2 || priority == 0)
 		return -EINVAL;
+	if (WARN_ONCE(src >= ARRAY_SIZE(qe_ic_info),
+		      "%s: Invalid hw irq number for QEIC\n", __func__))
+		return -EINVAL;
 
 	switch (qe_ic_info[src].pri_reg) {
 	case QEIC_CIPZCC:
-- 
2.1.0.27.g96db324
