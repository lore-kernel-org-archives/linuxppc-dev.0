Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4603F1A1E15
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Sep 2015 02:59:45 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 4 Sep 2015 12:59:42 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id A3C40C90041
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Sep 2015 12:50:44 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t84Gxevk46071914
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Sep 2015 16:59:40 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t84GxdsM026562
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Sep 2015 12:59:40 -0400
Date: Fri, 4 Sep 2015 09:59:38 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Hari Bathini <hbathini@in.ibm.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Ben Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv/pci-ioda: fix kdump with non-power-of-2
 crashkernel=
Message-ID: <20150904165938.GL47557@linux.vnet.ibm.com>
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

Michael, I did this as a follow-on patch to my previous one. If you'd
rather I made a v3 of that patch with the two fixes combined, I can
resend.

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index f1c74c28e564..73914f4bd1ab 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2084,6 +2084,12 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
 	 */
 	const u64 window_size =
 		min((u64)pe->table_group.tce32_size, memory_hotplug_max());
+	/*
+	 * crashkernel= specifies the kdump kernel's maximum memory at
+	 * some offset and there is no guaranteed the result is a power
+	 * of 2, which will cause errors later.
+	 */
+	window_size = __rounddown_pow_of_two(window_size);
 
 	rc = pnv_pci_ioda2_create_table(&pe->table_group, 0,
 			IOMMU_PAGE_SHIFT_4K,
