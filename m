Return-Path: <jonsmirl@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 15388DDF90
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 10:25:32 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1959282yxb.39
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 17:25:31 -0700 (PDT)
Subject: [PATCH] Modify mpc5200 AC97 driver to use V9 of spin_event_timeout()
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, broonie@sirena.org.uk, timur@freescale.com
From: Jon Smirl <jonsmirl@gmail.com>
Date: Tue, 26 May 2009 20:25:30 -0400
Message-ID: <20090527002530.16740.62502.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The function signature for spin_event_timeout() has changed in version V9.
Adjust the mpc5200 AC97 driver to use the new function.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 sound/soc/fsl/mpc5200_psc_ac97.c |   30 ++++++++++++++----------------
 1 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 9f2df15..bab80ac 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -31,13 +31,13 @@ static struct psc_dma *psc_dma;
 
 static unsigned short psc_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 {
-	int rc;
+	int status;
 	unsigned int val;
 
 	/* Wait for command send status zero = ready */
-	spin_event_timeout(!(in_be16(&psc_dma->psc_regs->sr_csr.status) &
-				MPC52xx_PSC_SR_CMDSEND), 100, 0, rc);
-	if (rc == 0) {
+	status= spin_event_timeout(!(in_be16(&psc_dma->psc_regs->sr_csr.status) &
+				MPC52xx_PSC_SR_CMDSEND), 100, 0);
+	if (status == 0) {
 		pr_err("timeout on ac97 bus (rdy)\n");
 		return -ENODEV;
 	}
@@ -45,9 +45,9 @@ static unsigned short psc_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 	out_be32(&psc_dma->psc_regs->ac97_cmd, (1<<31) | ((reg & 0x7f) << 24));
 
 	/* Wait for the answer */
-	spin_event_timeout((in_be16(&psc_dma->psc_regs->sr_csr.status) &
-				MPC52xx_PSC_SR_DATA_VAL), 100, 0, rc);
-	if (rc == 0) {
+	status = spin_event_timeout((in_be16(&psc_dma->psc_regs->sr_csr.status) &
+				MPC52xx_PSC_SR_DATA_VAL), 100, 0);
+	if (status == 0) {
 		pr_err("timeout on ac97 read (val) %x\n",
 				in_be16(&psc_dma->psc_regs->sr_csr.status));
 		return -ENODEV;
@@ -66,12 +66,12 @@ static unsigned short psc_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 static void psc_ac97_write(struct snd_ac97 *ac97,
 				unsigned short reg, unsigned short val)
 {
-	int rc;
+	int status;
 
 	/* Wait for command status zero = ready */
-	spin_event_timeout(!(in_be16(&psc_dma->psc_regs->sr_csr.status) &
-				MPC52xx_PSC_SR_CMDSEND), 100, 0, rc);
-	if (rc == 0) {
+	status = spin_event_timeout(!(in_be16(&psc_dma->psc_regs->sr_csr.status) &
+				MPC52xx_PSC_SR_CMDSEND), 100, 0);
+	if (status == 0) {
 		pr_err("timeout on ac97 bus (write)\n");
 		return;
 	}
@@ -82,24 +82,22 @@ static void psc_ac97_write(struct snd_ac97 *ac97,
 
 static void psc_ac97_warm_reset(struct snd_ac97 *ac97)
 {
-	int rc;
 	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;
 
 	out_be32(&regs->sicr, psc_dma->sicr | MPC52xx_PSC_SICR_AWR);
-	spin_event_timeout(0, 3, 0, rc);
+	spin_event_timeout(0, 3, 0);
 	out_be32(&regs->sicr, psc_dma->sicr);
 }
 
 static void psc_ac97_cold_reset(struct snd_ac97 *ac97)
 {
-	int rc;
 	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;
 
 	/* Do a cold reset */
 	out_8(&regs->op1, MPC52xx_PSC_OP_RES);
-	spin_event_timeout(0, 10, 0, rc);
+	spin_event_timeout(0, 10, 0);
 	out_8(&regs->op0, MPC52xx_PSC_OP_RES);
-	spin_event_timeout(0, 50, 0, rc);
+	spin_event_timeout(0, 50, 0);
 	psc_ac97_warm_reset(ac97);
 }
 
