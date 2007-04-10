Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D7000DDF51
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 06:11:26 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3AKBNZl001164
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 16:11:23 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3AKBNnH204430
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 14:11:23 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3AKBNQT010930
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 14:11:23 -0600
Date: Tue, 10 Apr 2007 15:11:23 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH]: ppc64/pseries: null iommu dma-window property.
Message-ID: <20070410201122.GJ4747@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul,
Plese apply.

--linas


Some versions of pSeries firmware fail to set up a 
dma-window property for PCI slots that are unoccupied.
As a result, the loop searching for this propery, in
pci_dma_dev_setup_pSeriesLP(), can run to the end, resulting
in a NULL pointer dereference later in the routine. This
patch prevents the crash, and prints a warning message.

This is theoretically a rare error, as it occurs on what
is hopefully just beta levels of firmware. But just in case
this firmware escapes into the wild, this patch will avoid
the crash.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/iommu.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/arch/powerpc/platforms/pseries/iommu.c	2007-02-04 12:44:54.000000000 -0600
+++ linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/iommu.c	2007-04-10 15:05:30.000000000 -0500
@@ -526,6 +526,12 @@ static void pci_dma_dev_setup_pSeriesLP(
 			break;
 	}
 
+	if (!pdn || !PCI_DN(pdn)) {
+		printk(KERN_WARNING "pci_dma_dev_setup_pSeriesLP: "
+		       "no DMA window found for pci dev=%s dn=%s\n",
+				 pci_name(dev), dn? dn->full_name : "<null>");
+		return;
+	}
 	DBG("  parent is %s\n", pdn->full_name);
 
 	/* Check for parent == NULL so we don't try to setup the empty EADS
