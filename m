Return-Path: <segooon@gmail.com>
From: Vasiliy Kulikov <segooon@gmail.com>
To: kernel-janitors@vger.kernel.org
Subject: [PATCH] powerpc: sysdev: fix signedness bug
Date: Sun, 17 Oct 2010 18:51:41 +0400
Message-Id: <1287327102-9068-1-git-send-email-segooon@gmail.com>
Cc: Harninder Rai <harninder.rai@freescale.com>,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org, Vivek Mahajan <vivek.mahajan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

sram_params.sram_size and sram_params.sram_offset were unsigned.
If get_cache_sram_size() or get_cache_sram_offset() returns error code
then it is not seen to the caller.  Made sram_size and sram_offset signed.

Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
---
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
index cc8d655..23b85ac 100644
--- a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
+++ b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
@@ -94,14 +94,14 @@ static int __devinit mpc85xx_l2ctlr_of_probe(struct platform_device *dev,
 	l2cache_size = *prop;
 
 	sram_params.sram_size  = get_cache_sram_size();
-	if (sram_params.sram_size <= 0) {
+	if ((int)sram_params.sram_size <= 0) {
 		dev_err(&dev->dev,
 			"Entire L2 as cache, Aborting Cache-SRAM stuff\n");
 		return -EINVAL;
 	}
 
 	sram_params.sram_offset  = get_cache_sram_offset();
-	if (sram_params.sram_offset <= 0) {
+	if ((int64_t)sram_params.sram_offset <= 0) {
 		dev_err(&dev->dev,
 			"Entire L2 as cache, provide a valid sram offset\n");
 		return -EINVAL;
-- 
1.7.0.4
