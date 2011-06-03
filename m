Return-Path: <B21989@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BE7CAB6FAA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jun 2011 13:35:52 +1000 (EST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: fix race bug of calling request_irq after
	enable elbc interrupts
Date: Fri, 3 Jun 2011 10:45:11 +0800
Message-ID: <1307069111-24459-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B07421@freescale.com, kumar.gala@freescale.com,
	Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/fsl_lbc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
index e0292c3..9e7cb19 100644
--- a/arch/powerpc/sysdev/fsl_lbc.c
+++ b/arch/powerpc/sysdev/fsl_lbc.c
@@ -200,9 +200,6 @@ static int __devinit fsl_lbc_ctrl_init(struct fsl_lbc_ctrl *ctrl,
 	out_be32(&lbc->lteccr, LTECCR_CLEAR);
 	out_be32(&lbc->ltedr, LTEDR_ENABLE);
 
-	/* Enable interrupts for any detected events */
-	out_be32(&lbc->lteir, LTEIR_ENABLE);
-
 	/* Set the monitor timeout value to the maximum for erratum A001 */
 	if (of_device_is_compatible(node, "fsl,elbc"))
 		clrsetbits_be32(&lbc->lbcr, LBCR_BMT, LBCR_BMTPS);
@@ -340,6 +337,9 @@ static int __devinit fsl_lbc_ctrl_probe(struct of_device *ofdev,
 		goto err;
 	}
 
+	/* Enable interrupts for any detected events */
+	out_be32(&fsl_lbc_ctrl_dev->regs->lteir, LTEIR_ENABLE);
+
 	return 0;
 
 err:
-- 
1.6.4
