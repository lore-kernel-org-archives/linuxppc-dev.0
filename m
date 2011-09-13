Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0FA28B71C2
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Sep 2011 07:18:53 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <scottwood@freescale.com>,
	<benh@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/fsl_msi: fix support for multiple MSI ranges
Date: Tue, 13 Sep 2011 16:17:00 -0500
Message-ID: <1315948620-12402-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 6820fead ("powerpc/fsl_msi: Handle msi-available-ranges better") added
support for multiple ranges in the msi-available-ranges property, but it
miscalculated the MSIR index when multiple ranges are used.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/sysdev/fsl_msi.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 419a772..1cca251 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -296,7 +296,7 @@ static int __devinit fsl_msi_setup_hwirq(struct fsl_msi *msi,
 	}
 
 	msi->msi_virqs[irq_index] = virt_msir;
-	cascade_data->index = offset + irq_index;
+	cascade_data->index = offset;
 	cascade_data->msi_data = msi;
 	irq_set_handler_data(virt_msir, cascade_data);
 	irq_set_chained_handler(virt_msir, fsl_msi_cascade);
@@ -376,8 +376,10 @@ static int __devinit fsl_of_msi_probe(struct platform_device *dev)
 		goto error_out;
 	}
 
-	if (!p)
+	if (!p) {
 		p = all_avail;
+		len = sizeof(all_avail);
+	}
 
 	for (irq_index = 0, i = 0; i < len / (2 * sizeof(u32)); i++) {
 		if (p[i * 2] % IRQS_PER_MSI_REG ||
@@ -393,7 +395,7 @@ static int __devinit fsl_of_msi_probe(struct platform_device *dev)
 		count = p[i * 2 + 1] / IRQS_PER_MSI_REG;
 
 		for (j = 0; j < count; j++, irq_index++) {
-			err = fsl_msi_setup_hwirq(msi, dev, offset, irq_index);
+			err = fsl_msi_setup_hwirq(msi, dev, offset + j, irq_index);
 			if (err)
 				goto error_out;
 		}
-- 
1.7.3.4
