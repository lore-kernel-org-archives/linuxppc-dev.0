Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE0661A0023
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Nov 2014 16:51:39 +1100 (AEDT)
Received: by mail-pa0-f47.google.com with SMTP id kx10so16861039pab.20
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 21:51:37 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/fsl_msi: mark the msi cascade handler IRQF_NO_THREAD
Date: Fri, 14 Nov 2014 13:51:22 +0800
Message-Id: <1415944282-1827-1-git-send-email-haokexin@gmail.com>
Cc: Scott Wood <scottwood@freescale.com>,
 Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The commit 543c043cbae7 ("powerpc/fsl_msi: change the irq handler from
chained to normal") changes the msi cascade handler from chained to
normal. Since cascade handler must run in hard interrupt context, this
will cause kernel panic if we force threading of all the interrupt
handler via kernel command parameter 'threadirqs'. So mark the irq
handler IRQF_NO_THREAD explicitly.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/sysdev/fsl_msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index a5a6c24577fe..5997c5378c84 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -360,7 +360,7 @@ static int fsl_msi_setup_hwirq(struct fsl_msi *msi, struct platform_device *dev,
 	cascade_data->virq = virt_msir;
 	msi->cascade_array[irq_index] = cascade_data;
 
-	ret = request_irq(virt_msir, fsl_msi_cascade, 0,
+	ret = request_irq(virt_msir, fsl_msi_cascade, IRQF_NO_THREAD,
 			  "fsl-msi-cascade", cascade_data);
 	if (ret) {
 		dev_err(&dev->dev, "failed to request_irq(%d), ret = %d\n",
-- 
1.9.3
