Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id F36C4DDF27
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 14:08:10 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so207466wfg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 01 Jul 2008 21:08:09 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc/5200: fix compile warnings in bestcomm driver
To: linuxppc-dev@ozlabs.org
Date: Tue, 01 Jul 2008 22:08:06 -0600
Message-ID: <20080702040806.3152.29986.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Fix for the following compiler warnings:

  CC      arch/powerpc/sysdev/bestcomm/bestcomm.o
  arch/powerpc/sysdev/bestcomm/bestcomm.c: In function 'mpc52xx_bcom_probe':
  arch/powerpc/sysdev/bestcomm/bestcomm.c:446:
      warning: format '%08lx' expects type 'long unsigned int',
      but argument 2 has type 'phys_addr_t'
  CC      arch/powerpc/sysdev/bestcomm/sram.o
  arch/powerpc/sysdev/bestcomm/sram.c: In function 'bcom_sram_init':
  arch/powerpc/sysdev/bestcomm/sram.c:89:
      warning: format '%08lx' expects type 'long unsigned int',
      but argument 3 has type 'phys_addr_t'

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/sysdev/bestcomm/bestcomm.c |    2 +-
 arch/powerpc/sysdev/bestcomm/sram.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/bestcomm/bestcomm.c b/arch/powerpc/sysdev/bestcomm/bestcomm.c
index 64ec7d6..446c9ea 100644
--- a/arch/powerpc/sysdev/bestcomm/bestcomm.c
+++ b/arch/powerpc/sysdev/bestcomm/bestcomm.c
@@ -443,7 +443,7 @@ mpc52xx_bcom_probe(struct of_device *op, const struct of_device_id *match)
 
 	/* Done ! */
 	printk(KERN_INFO "DMA: MPC52xx BestComm engine @%08lx ok !\n",
-		bcom_eng->regs_base);
+		(long)bcom_eng->regs_base);
 
 	return 0;
 
diff --git a/arch/powerpc/sysdev/bestcomm/sram.c b/arch/powerpc/sysdev/bestcomm/sram.c
index 9978438..5d74ef7 100644
--- a/arch/powerpc/sysdev/bestcomm/sram.c
+++ b/arch/powerpc/sysdev/bestcomm/sram.c
@@ -86,7 +86,7 @@ int bcom_sram_init(struct device_node *sram_node, char *owner)
 	if (!bcom_sram->base_virt) {
 		printk(KERN_ERR "%s: bcom_sram_init: "
 			"Map error SRAM zone 0x%08lx (0x%0x)!\n",
-			owner, bcom_sram->base_phys, bcom_sram->size );
+			owner, (long)bcom_sram->base_phys, bcom_sram->size );
 		rv = -ENOMEM;
 		goto error_release;
 	}
