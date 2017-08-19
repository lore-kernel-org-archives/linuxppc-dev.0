Return-Path: <bhumirks@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xZJx655SSzDqgy
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Aug 2017 22:22:18 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id j68so2909127pfc.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Aug 2017 05:22:18 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, linux-kernel@vger.kernel.org, qiang.zhao@nxp.com,
 leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] qe/ic: make irq_chip const
Date: Sat, 19 Aug 2017 17:52:01 +0530
Message-Id: <1503145321-13202-1-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make this const as it is only used in a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/soc/fsl/qe/qe_ic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index ec2ca86..00f48d5 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -238,7 +238,7 @@ static void qe_ic_mask_irq(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&qe_ic_lock, flags);
 }
 
-static struct irq_chip qe_ic_irq_chip = {
+static const struct irq_chip qe_ic_irq_chip = {
 	.name = "QEIC",
 	.irq_unmask = qe_ic_unmask_irq,
 	.irq_mask = qe_ic_mask_irq,
-- 
1.9.1
