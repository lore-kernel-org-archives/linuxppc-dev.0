Return-Path: <jk@bilbo.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] powerpc/cell: fix iommu exception reporting
Message-Id: <1237517195.409190.720454178196.1.gpush@pingu>
To: Ben Herrenschmidt <benh@kernel.crashing.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 20 Mar 2009 13:46:35 +1100
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, we will report a page fault as a segment fault, and report
a segment fault as both a page and segment fault.

Fix the SPF_P definition to be correct according to the iommu docs, and
mask before comparing.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/cell/iommu.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index faabc3f..6bd4be5 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -72,7 +72,7 @@
 #define IOC_IO_ExcpStat_V		0x8000000000000000ul
 #define IOC_IO_ExcpStat_SPF_Mask	0x6000000000000000ul
 #define IOC_IO_ExcpStat_SPF_S		0x6000000000000000ul
-#define IOC_IO_ExcpStat_SPF_P		0x4000000000000000ul
+#define IOC_IO_ExcpStat_SPF_P		0x2000000000000000ul
 #define IOC_IO_ExcpStat_ADDR_Mask	0x00000007fffff000ul
 #define IOC_IO_ExcpStat_RW_Mask		0x0000000000000800ul
 #define IOC_IO_ExcpStat_IOID_Mask	0x00000000000007fful
@@ -242,17 +242,18 @@ static void tce_free_cell(struct iommu_table *tbl, long index, long npages)
 
 static irqreturn_t ioc_interrupt(int irq, void *data)
 {
-	unsigned long stat;
+	unsigned long stat, spf;
 	struct cbe_iommu *iommu = data;
 
 	stat = in_be64(iommu->xlate_regs + IOC_IO_ExcpStat);
+	spf = stat & IOC_IO_ExcpStat_SPF_Mask;
 
 	/* Might want to rate limit it */
 	printk(KERN_ERR "iommu: DMA exception 0x%016lx\n", stat);
 	printk(KERN_ERR "  V=%d, SPF=[%c%c], RW=%s, IOID=0x%04x\n",
 	       !!(stat & IOC_IO_ExcpStat_V),
-	       (stat & IOC_IO_ExcpStat_SPF_S) ? 'S' : ' ',
-	       (stat & IOC_IO_ExcpStat_SPF_P) ? 'P' : ' ',
+	       (spf == IOC_IO_ExcpStat_SPF_S) ? 'S' : ' ',
+	       (spf == IOC_IO_ExcpStat_SPF_P) ? 'P' : ' ',
 	       (stat & IOC_IO_ExcpStat_RW_Mask) ? "Read" : "Write",
 	       (unsigned int)(stat & IOC_IO_ExcpStat_IOID_Mask));
 	printk(KERN_ERR "  page=0x%016lx\n",
