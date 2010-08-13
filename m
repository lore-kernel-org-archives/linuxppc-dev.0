Return-Path: <abounine@tundra.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0CB03B7208
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Aug 2010 01:20:13 +1000 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 2/9] RapidIO,
	powerpc/85xx: modify RIO port-write interrupt handler
Date: Fri, 13 Aug 2010 11:17:59 -0400
Message-Id: <1281712686-31308-3-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- Rearranged RIO port-write interrupt handling to perform message buffering
as soon as possible.
- Modified to disable port-write controller when clearing Transaction Error (TE)
bit.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Reviewed-by: Thomas Moll <thomas.moll@sysgo.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Li Yang <leoli@freescale.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/fsl_rio.c |   67 ++++++++++++++++++++++------------------
 1 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index cd71dc1..708d94e 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -1065,18 +1065,12 @@ fsl_rio_port_write_handler(int irq, void *dev_instance)
 	struct rio_priv *priv = port->priv;
 	u32 epwisr, tmp;
 
-	ipwmr = in_be32(&priv->msg_regs->pwmr);
-	ipwsr = in_be32(&priv->msg_regs->pwsr);
-
 	epwisr = in_be32(priv->regs_win + RIO_EPWISR);
-	if (epwisr & 0x80000000) {
-		tmp = in_be32(priv->regs_win + RIO_LTLEDCSR);
-		pr_info("RIO_LTLEDCSR = 0x%x\n", tmp);
-		out_be32(priv->regs_win + RIO_LTLEDCSR, 0);
-	}
-
 	if (!(epwisr & 0x00000001))
-		return IRQ_HANDLED;
+		goto pw_done;
+
+	ipwmr = in_be32(&priv->msg_regs->pwmr);
+	ipwsr = in_be32(&priv->msg_regs->pwsr);
 
 #ifdef DEBUG_PW
 	pr_debug("PW Int->IPWMR: 0x%08x IPWSR: 0x%08x (", ipwmr, ipwsr);
@@ -1092,22 +1086,8 @@ fsl_rio_port_write_handler(int irq, void *dev_instance)
 		pr_debug(" PWB");
 	pr_debug(" )\n");
 #endif
-	out_be32(&priv->msg_regs->pwsr,
-		 ipwsr & (RIO_IPWSR_TE | RIO_IPWSR_QFI | RIO_IPWSR_PWD));
-
-	if ((ipwmr & RIO_IPWMR_EIE) && (ipwsr & RIO_IPWSR_TE)) {
-		priv->port_write_msg.err_count++;
-		pr_info("RIO: Port-Write Transaction Err (%d)\n",
-			 priv->port_write_msg.err_count);
-	}
-	if (ipwsr & RIO_IPWSR_PWD) {
-		priv->port_write_msg.discard_count++;
-		pr_info("RIO: Port Discarded Port-Write Msg(s) (%d)\n",
-			 priv->port_write_msg.discard_count);
-	}
-
 	/* Schedule deferred processing if PW was received */
-	if (ipwsr & RIO_IPWSR_QFI) {
+	if ((ipwmr & RIO_IPWMR_QFIE) && (ipwsr & RIO_IPWSR_QFI)) {
 		/* Save PW message (if there is room in FIFO),
 		 * otherwise discard it.
 		 */
@@ -1117,16 +1097,43 @@ fsl_rio_port_write_handler(int irq, void *dev_instance)
 				 RIO_PW_MSG_SIZE);
 		} else {
 			priv->port_write_msg.discard_count++;
-			pr_info("RIO: ISR Discarded Port-Write Msg(s) (%d)\n",
+			pr_debug("RIO: ISR Discarded Port-Write Msg(s) (%d)\n",
 				 priv->port_write_msg.discard_count);
 		}
+		/* Clear interrupt and issue Clear Queue command. This allows
+		 * another port-write to be received.
+		 */
+		out_be32(&priv->msg_regs->pwsr,	RIO_IPWSR_QFI);
+		out_be32(&priv->msg_regs->pwmr, ipwmr | RIO_IPWMR_CQ);
+
 		schedule_work(&priv->pw_work);
 	}
 
-	/* Issue Clear Queue command. This allows another
-	 * port-write to be received.
-	 */
-	out_be32(&priv->msg_regs->pwmr, ipwmr | RIO_IPWMR_CQ);
+	if ((ipwmr & RIO_IPWMR_EIE) && (ipwsr & RIO_IPWSR_TE)) {
+		priv->port_write_msg.err_count++;
+		pr_debug("RIO: Port-Write Transaction Err (%d)\n",
+			 priv->port_write_msg.err_count);
+		/* Clear Transaction Error: port-write controller should be
+		 * disabled when clearing this error
+		 */
+		out_be32(&priv->msg_regs->pwmr, ipwmr & ~RIO_IPWMR_PWE);
+		out_be32(&priv->msg_regs->pwsr,	RIO_IPWSR_TE);
+		out_be32(&priv->msg_regs->pwmr, ipwmr);
+	}
+
+	if (ipwsr & RIO_IPWSR_PWD) {
+		priv->port_write_msg.discard_count++;
+		pr_debug("RIO: Port Discarded Port-Write Msg(s) (%d)\n",
+			 priv->port_write_msg.discard_count);
+		out_be32(&priv->msg_regs->pwsr, RIO_IPWSR_PWD);
+	}
+
+pw_done:
+	if (epwisr & 0x80000000) {
+		tmp = in_be32(priv->regs_win + RIO_LTLEDCSR);
+		pr_debug("RIO_LTLEDCSR = 0x%x\n", tmp);
+		out_be32(priv->regs_win + RIO_LTLEDCSR, 0);
+	}
 
 	return IRQ_HANDLED;
 }
-- 
1.7.0.5
