Return-Path: <nacc@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 18C6E100C56
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Oct 2010 04:33:52 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o98HOEtQ030933
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 11:24:14 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o98HXcog137448
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 11:33:39 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o98HXcx5021359
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 11:33:38 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [RFC PATCH 10/11] ppc/iommu: add routines to pseries iommu to map
	tces 1-1
Date: Fri,  8 Oct 2010 10:33:11 -0700
Message-Id: <1286559192-10898-11-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1286559192-10898-1-git-send-email-nacc@us.ibm.com>
References: <1286559192-10898-1-git-send-email-nacc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, miltonm@bga.com,
	Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c |   98 ++++++++++++++++++++++++++++++++
 1 files changed, 98 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 8ec81df..451d2d1 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -270,6 +270,104 @@ static unsigned long tce_get_pSeriesLP(struct iommu_table *tbl, long tcenum)
 	return tce_ret;
 }
 
+/* this is compatable with cells for the device tree property */
+struct dynamic_dma_window_prop {
+	__be32	liobn;		/* tce table number */
+	__be32	dma_base[2];	/* address hi,lo */
+	__be32	tce_shift;	/* ilog2(tce_page_size) */
+	__be32	window_shift;	/* ilog2(tce_window_size) */
+};
+
+static int tce_clearrange_multi_pSeriesLP(unsigned long start_pfn,
+					unsigned long num_pfn, void *arg)
+{
+	struct dynamic_dma_window_prop *maprange = arg;
+	int rc;
+	u64 tce_size, num_tce, dma_offset;
+	u32 tce_shift;
+
+	tce_shift = be32_to_cpu(maprange->tce_shift);
+	tce_size = 1ULL << tce_shift;
+	num_tce = num_pfn << PAGE_SHIFT;
+	dma_offset = start_pfn << PAGE_SHIFT;
+
+	/* round back to the beginning of the tce page size */
+	num_tce += dma_offset & (tce_size - 1);
+	dma_offset &= ~(tce_size - 1);
+
+	/* covert to number of tces */
+	num_tce |= tce_size - 1;
+	num_tce >>= tce_shift;
+
+	rc = plpar_tce_stuff(maprange->liobn, dma_offset, 0, num_tce);
+
+	return rc;
+}
+
+static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
+					unsigned long num_pfn, void *arg)
+{
+	struct dynamic_dma_window_prop *maprange = arg;
+	u64 *tcep, tce_size, num_tce, dma_offset, next, proto_tce;
+	u32 tce_shift;
+	long rc = 0;
+	long l, limit;
+
+	local_irq_disable();	/* to protect tcep and the page behind it */
+	tcep = __get_cpu_var(tce_page);
+
+	if (!tcep) {
+		tcep = (u64 *)__get_free_page(GFP_ATOMIC);
+		if (!tcep) {
+			local_irq_enable();
+			return -ENOMEM;
+		}
+		__get_cpu_var(tce_page) = tcep;
+	}
+
+	proto_tce = TCE_PCI_READ | TCE_PCI_WRITE;
+
+	tce_shift = be32_to_cpu(maprange->tce_shift);
+	tce_size = 1ULL << tce_shift;
+	next = start_pfn << PAGE_SHIFT;
+	num_tce = num_pfn << PAGE_SHIFT;
+
+	/* round back to the beginning of the tce page size */
+	num_tce += next & (tce_size - 1);
+	next &= ~(tce_size - 1);
+
+	/* covert to number of tces */
+	num_tce |= tce_size - 1;
+	num_tce >>= maprange->tce_shift;
+
+	/* We can map max one pageful of TCEs at a time */
+	do {
+		/*
+		 * Set up the page with TCE data, looping through and setting
+		 * the values.
+		 */
+		limit = min_t(long, num_tce, 4096/TCE_ENTRY_SIZE);
+		dma_offset = next;
+
+		for (l = 0; l < limit; l++) {
+			tcep[l] = proto_tce | dma_offset;
+			next += tce_size;
+		}
+
+		rc = plpar_tce_put_indirect((u64)maprange->liobn,
+					    (u64)dma_offset,
+					    (u64)virt_to_abs(tcep),
+					    limit);
+
+		num_tce -= limit;
+	} while (num_tce > 0 && !rc);
+
+	/* error cleanup: caller will clear whole range */
+
+	local_irq_enable();
+	return rc;
+}
+
 #ifdef CONFIG_PCI
 static void iommu_table_setparms(struct pci_controller *phb,
 				 struct device_node *dn,
-- 
1.7.1
