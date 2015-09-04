Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 74AE61A027B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Sep 2015 04:23:00 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 4 Sep 2015 14:22:57 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id CA8CD38C8039
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Sep 2015 14:22:55 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t84IMtTe59375864
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Sep 2015 18:22:55 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t84IMsPD005282
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Sep 2015 14:22:55 -0400
Date: Fri, 4 Sep 2015 11:22:52 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Hari Bathini <hbathini@in.ibm.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Ben Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Jan Stancek <jstancek@redhat.com>
Subject: [PATCH v2] powerpc/powernv/pci-ioda: fix kdump with non-power-of-2
 crashkernel=
Message-ID: <20150904182252.GN47557@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 32-bit TCE table initialization relies on the DMA window having a
size equal to a power of 2 (and checks for it explicitly). But
crashkernel= has no constraint that requires a power-of-2 be specified.
This causes the kdump kernel to fail to boot as none of the PCI devices
(including the disk controller) are successfully initialized.

After this change, the PCI devices successfully set up the 32-bit TCE
table and kdump succeeds.

Fixes: aca6913f5551 ("powerpc/powernv/ioda2: Introduce helpers to allocate TCE pages")
Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org # 4.2

---

Michael, I kept this as a follow-on patch to my previous one. If you'd
rather I made a v3 of that patch with the two fixes combined, I can
resend. Also, I fixed up the context on my end to be u64, but not sure
if that will match your tree (next doesn't have my prior patch applied
yet, that I can see).

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index f1c74c28e564..d5e635f2c3aa 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2078,12 +2078,18 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
 	struct iommu_table *tbl = NULL;
 	long rc;
 	/*
+	 * crashkernel= specifies the kdump kernel's maximum memory at
+	 * some offset and there is no guaranteed the result is a power
+	 * of 2, which will cause errors later.
+	 */
+	const u64 max_memory = __rounddown_pow_of_two(memory_hotplug_max());
+	/*
 	 * In memory constrained environments, e.g. kdump kernel, the
 	 * DMA window can be larger than available memory, which will
 	 * cause errors later.
 	 */
 	const u64 window_size =
-		min((u64)pe->table_group.tce32_size, memory_hotplug_max());
+		min((u64)pe->table_group.tce32_size, max_memory);
 
 	rc = pnv_pci_ioda2_create_table(&pe->table_group, 0,
 			iommu_page_shift_4k,
