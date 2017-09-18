Return-Path: <roy.pledge@nxp.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0065.outbound.protection.outlook.com [104.47.34.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwyYV4wkQzDqBc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 06:39:58 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: <leoyang.li@nxp.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
CC: <oss@buserror.net>, <madalin.bucur@nxp.com>, <catalin.marinas@arm.com>,
 <linux@armlinux.org.uk>, <arnd@arndb.de>, <mark.rutland@arm.com>, Roy Pledge
 <roy.pledge@nxp.com>
Subject: [v5 03/12] soc/fsl/qbman: Use shared-dma-pool for QMan private memory
 allocations
Date: Mon, 18 Sep 2017 16:39:38 -0400
Message-ID: <1505767187-4596-4-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1505767187-4596-1-git-send-email-roy.pledge@nxp.com>
References: <1505767187-4596-1-git-send-email-roy.pledge@nxp.com>
Reply-To: <roy.pledge@nxp.com>
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

Use the shared-memory-pool mechanism for frame queue descriptor and
packed frame descriptor record area allocations.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/qman_ccsr.c | 93 ++++++++++++++++++++++++++-------------
 drivers/soc/fsl/qbman/qman_priv.h |  2 -
 drivers/soc/fsl/qbman/qman_test.h |  2 -
 3 files changed, 63 insertions(+), 34 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
index 835ce94..607355b9 100644
--- a/drivers/soc/fsl/qbman/qman_ccsr.c
+++ b/drivers/soc/fsl/qbman/qman_ccsr.c
@@ -401,21 +401,42 @@ static int qm_init_pfdr(struct device *dev, u32 pfdr_start, u32 num)
 }
 
 /*
- * Ideally we would use the DMA API to turn rmem->base into a DMA address
- * (especially if iommu translations ever get involved).  Unfortunately, the
- * DMA API currently does not allow mapping anything that is not backed with
- * a struct page.
+ * QMan needs two global memory areas initialized at boot time:
+ *  1) FQD: Frame Queue Descriptors used to manage frame queues
+ *  2) PFDR: Packed Frame Queue Descriptor Records used to store frames
+ * Both areas are reserved using the device tree reserved memory framework
+ * and the addresses and sizes are initialized when the QMan device is probed
  */
 static dma_addr_t fqd_a, pfdr_a;
 static size_t fqd_sz, pfdr_sz;
 
+#ifdef CONFIG_PPC
+/*
+ * Support for PPC Device Tree backward compatibility when compatible
+ * string is set to fsl-qman-fqd and fsl-qman-pfdr
+ */
+static int zero_priv_mem(phys_addr_t addr, size_t sz)
+{
+	/* map as cacheable, non-guarded */
+	void __iomem *tmpp = ioremap_prot(addr, sz, 0);
+
+	if (!tmpp)
+		return -ENOMEM;
+
+	memset_io(tmpp, 0, sz);
+	flush_dcache_range((unsigned long)tmpp,
+			   (unsigned long)tmpp + sz);
+	iounmap(tmpp);
+
+	return 0;
+}
+
 static int qman_fqd(struct reserved_mem *rmem)
 {
 	fqd_a = rmem->base;
 	fqd_sz = rmem->size;
 
 	WARN_ON(!(fqd_a && fqd_sz));
-
 	return 0;
 }
 RESERVEDMEM_OF_DECLARE(qman_fqd, "fsl,qman-fqd", qman_fqd);
@@ -431,32 +452,13 @@ static int qman_pfdr(struct reserved_mem *rmem)
 }
 RESERVEDMEM_OF_DECLARE(qman_pfdr, "fsl,qman-pfdr", qman_pfdr);
 
+#endif
+
 static unsigned int qm_get_fqid_maxcnt(void)
 {
 	return fqd_sz / 64;
 }
 
-/*
- * Flush this memory range from data cache so that QMAN originated
- * transactions for this memory region could be marked non-coherent.
- */
-static int zero_priv_mem(struct device *dev, struct device_node *node,
-			 phys_addr_t addr, size_t sz)
-{
-	/* map as cacheable, non-guarded */
-	void __iomem *tmpp = ioremap_prot(addr, sz, 0);
-
-	if (!tmpp)
-		return -ENOMEM;
-
-	memset_io(tmpp, 0, sz);
-	flush_dcache_range((unsigned long)tmpp,
-			   (unsigned long)tmpp + sz);
-	iounmap(tmpp);
-
-	return 0;
-}
-
 static void log_edata_bits(struct device *dev, u32 bit_count)
 {
 	u32 i, j, mask = 0xffffffff;
@@ -727,10 +729,41 @@ static int fsl_qman_probe(struct platform_device *pdev)
 		qm_channel_caam = QMAN_CHANNEL_CAAM_REV3;
 	}
 
-	ret = zero_priv_mem(dev, node, fqd_a, fqd_sz);
-	WARN_ON(ret);
-	if (ret)
-		return -ENODEV;
+	if (fqd_a) {
+#ifdef CONFIG_PPC
+		/*
+		 * For PPC backward DT compatibility
+		 * FQD memory MUST be zero'd by software
+		 */
+		zero_priv_mem(fqd_a, fqd_sz);
+#else
+		WARN(1, "Unexpected architecture using non shared-dma-mem reservations");
+#endif
+	} else {
+		/*
+		 * Order of memory regions is assumed as FQD followed by PFDR
+		 * in order to ensure allocations from the correct regions the
+		 * driver initializes then allocates each piece in order
+		 */
+		ret = qbman_init_private_mem(dev, 0, &fqd_a, &fqd_sz);
+		if (ret) {
+			dev_err(dev, "qbman_init_private_mem() for FQD failed 0x%x\n",
+				ret);
+			return -ENODEV;
+		}
+	}
+	dev_dbg(dev, "Allocated FQD 0x%llx 0x%zx\n", fqd_a, fqd_sz);
+
+	if (!pfdr_a) {
+		/* Setup PFDR memory */
+		ret = qbman_init_private_mem(dev, 1, &pfdr_a, &pfdr_sz);
+		if (ret) {
+			dev_err(dev, "qbman_init_private_mem() for PFDR failed 0x%x\n",
+				ret);
+			return -ENODEV;
+		}
+	}
+	dev_dbg(dev, "Allocated PFDR 0x%llx 0x%zx\n", pfdr_a, pfdr_sz);
 
 	ret = qman_init_ccsr(dev);
 	if (ret) {
diff --git a/drivers/soc/fsl/qbman/qman_priv.h b/drivers/soc/fsl/qbman/qman_priv.h
index 5fe9faf..b1e2cbf 100644
--- a/drivers/soc/fsl/qbman/qman_priv.h
+++ b/drivers/soc/fsl/qbman/qman_priv.h
@@ -28,8 +28,6 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include "dpaa_sys.h"
 
 #include <soc/fsl/qman.h>
diff --git a/drivers/soc/fsl/qbman/qman_test.h b/drivers/soc/fsl/qbman/qman_test.h
index d5f8cb2..41bdbc48 100644
--- a/drivers/soc/fsl/qbman/qman_test.h
+++ b/drivers/soc/fsl/qbman/qman_test.h
@@ -30,7 +30,5 @@
 
 #include "qman_priv.h"
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 int qman_test_stash(void);
 int qman_test_api(void);
-- 
2.7.4
