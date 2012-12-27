Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp04.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1D2D52C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 03:28:26 +1100 (EST)
Received: from /spool/local
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Thu, 27 Dec 2012 14:28:20 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id EA70F1DC0050
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2012 11:28:15 -0500 (EST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBRGRrUn37552258
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2012 14:27:53 -0200
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBRGSEpQ028405
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2012 14:28:15 -0200
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ppc/iommu: prevent false TCE leak message
Date: Thu, 27 Dec 2012 14:28:06 -0200
Message-Id: <1356625686-8943-1-git-send-email-cascardo@linux.vnet.ibm.com>
Cc: paulus@samba.org, anton@samba.org,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a device DMA window includes the address 0, it's reserved in the
TCE bitmap to avoid returning that address to drivers.

When the device is removed, the bitmap is checked for any mappings not
removed by the driver, indicating a possible DMA mapping leak. Since the
reserved address is not cleared, a message is printed, warning of such a
leak.

Check for the reservation, and clear it before checking for any other
standing mappings.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/iommu.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 8226c6c..226e9e5 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -717,6 +717,11 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 		return;
 	}
 
+	/* In case we have reserved the first bit, we should not emit
+	 * the warning below. */
+	if (tbl->it_offset == 0)
+		clear_bit(0, tbl->it_map);
+
 	/* verify that table contains no entries */
 	/* it_size is in entries, and we're examining 64 at a time */
 	for (i = 0; i < (tbl->it_size/64); i++) {
-- 
1.7.1
