Return-Path: <weiyj.lk@gmail.com>
MIME-Version: 1.0
Date: Tue, 7 May 2013 21:46:36 +0800
Message-ID: <CAPgLHd_AKxWd1bOKF9afGLKsQzyfueYV6b3SrAf_V7ut2bUQzQ@mail.gmail.com>
Subject: [PATCH] powerpc/fsl_msi: fix error return code in fsl_of_msi_probe()
From: Wei Yongjun <weiyj.lk@gmail.com>
To: benh@kernel.crashing.org, paulus@samba.org, grant.likely@linaro.org,
 rob.herring@calxeda.com, galak@kernel.crashing.org,
 u.kleine-koenig@pengutronix.de, agraf@suse.de, gregkh@linuxfoundation.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei@trendmicro.com.cn, linuxppc-dev@lists.ozlabs.org,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code in the MSI bitmap alloc error
handling case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/powerpc/sysdev/fsl_msi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index ab02db3..f45556a 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -370,7 +370,6 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 	struct fsl_msi *msi;
 	struct resource res;
 	int err, i, j, irq_index, count;
-	int rc;
 	const u32 *p;
 	const struct fsl_msi_feature *features;
 	int len;
@@ -431,8 +430,8 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 	 */
 	msi->phandle = dev->dev.of_node->phandle;
 
-	rc = fsl_msi_init_allocator(msi);
-	if (rc) {
+	err = fsl_msi_init_allocator(msi);
+	if (err) {
 		dev_err(&dev->dev, "Error allocating MSI bitmap\n");
 		goto error_out;
 	}
