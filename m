Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 53E2E2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2013 13:03:00 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 28 Jan 2013 21:02:56 -0500
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 18C8B6E8047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2013 21:02:50 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0T22oXk54067360
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2013 21:02:50 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0T22nqp010648
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2013 21:02:50 -0500
Date: Mon, 28 Jan 2013 18:02:46 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 1/2] pseries/iommu: restore_default_window does not use liobn
 parameter
Message-ID: <20130129020245.GA12156@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nfont@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 miltonm@bga.com, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The parameter is unused, and complicates a following fix. Just remove
it.
    
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index b4bb9e1..a8e99f9 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -884,7 +884,7 @@ static int create_ddw(struct pci_dev *dev, const u32 *ddw_avail,
 }
 
 static void restore_default_window(struct pci_dev *dev,
-				u32 ddw_restore_token, unsigned long liobn)
+					u32 ddw_restore_token)
 {
 	struct eeh_dev *edev;
 	u32 cfg_addr;
@@ -1100,7 +1100,7 @@ out_free_prop:
 
 out_restore_window:
 	if (ddw_restore_token)
-		restore_default_window(dev, ddw_restore_token, liobn);
+		restore_default_window(dev, ddw_restore_token);
 
 out_unlock:
 	mutex_unlock(&direct_window_init_mutex);
