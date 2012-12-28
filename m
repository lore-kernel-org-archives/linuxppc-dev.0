Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp02.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C78632C00DB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Dec 2012 06:09:10 +1100 (EST)
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Fri, 28 Dec 2012 17:09:00 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id DAE3E1DC005C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 14:08:58 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBSJ8b7026607788
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 17:08:37 -0200
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBSJ8v5b030379
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 17:08:57 -0200
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] ppc/iommu: prevent false TCE leak message
Date: Fri, 28 Dec 2012 17:08:51 -0200
Message-Id: <1356721732-24556-1-git-send-email-cascardo@linux.vnet.ibm.com>
In-Reply-To: <20121228165504.GC21831@oc0268524204.ibm.com>
References: <20121228165504.GC21831@oc0268524204.ibm.com>
Cc: paulus@samba.org, shangw@linux.vnet.ibm.com,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>, anton@samba.org
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
 arch/powerpc/kernel/iommu.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 8226c6c..6d48ff8 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -717,6 +717,13 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 		return;
 	}
 
+	/*
+	 * In case we have reserved the first bit, we should not emit
+	 * the warning below.
+	 */
+	if (tbl->it_offset == 0)
+		clear_bit(0, tbl->it_map);
+
 	/* verify that table contains no entries */
 	/* it_size is in entries, and we're examining 64 at a time */
 	for (i = 0; i < (tbl->it_size/64); i++) {
-- 
1.7.1
