Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 561BBDDE25
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 12:16:35 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0B1H40b015355
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 20:17:04 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	l0B1GUes303218
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 20:16:30 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0B1GUDb021006
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 20:16:30 -0500
Date: Wed, 10 Jan 2007 19:16:29 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] Urgent: powerpc 2.6.20-rc4 dma broken on non-LPAR pseries
Message-ID: <20070111011629.GF6177@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul, please review, apply and send upstream. 

I marked the subject line as urgent, as I think 2.6.20-rc4 is
broken for all pSeries non-LPAR systems.

It appears that the iommu table address is never stored, and thus
never found, on non-lpar systems. Thus, for example, during boot:

<7>[   93.067916] PCI: Scanning bus 0001:41
<7>[   93.068542] PCI: Found 0001:41:01.0 [8086/100f] 000200 00
<7>[   93.068550] PCI: Calling quirk c0000000007822e0 for 0001:41:01.0
<7>[   93.069815] PCI: Fixups for bus 0001:41
<4>[   93.070167] iommu: Device 0001:41:01.0 has no iommu table
<7>[   93.070251] PCI: Bus scan for 0001:41 returning with max=41

No iommu table? How can that be? Well, circa line 471 of 
arch/powerpc/platforms/pseries/iommu.c we see the code:

   while (dn && PCI_DN(dn) && PCI_DN(dn)->iommu_table == NULL)
      dn = dn->parent;

and a few lines later is the surprising print statement about
the missing table.  Seems that this loop ran unto the end, never 
once finding a non-null PCI_DN(dn)->iommu_table. 

The problem can be found a few lines earlier: it sems that the
value of PCI_DN(dn)->iommu_table is never ever set. Thus, the 
patch sets it.

The patch was tested on a Power4 system running in full system 
partition mode, which is where I saw the problem. It works; I've
not done any wider testing. Had a breif discussion on this on irc.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/iommu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.20-rc4/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- linux-2.6.20-rc4.orig/arch/powerpc/platforms/pseries/iommu.c	2007-01-10 18:38:37.000000000 -0600
+++ linux-2.6.20-rc4/arch/powerpc/platforms/pseries/iommu.c	2007-01-10 18:40:14.000000000 -0600
@@ -459,7 +459,8 @@ static void pci_dma_dev_setup_pSeries(st
 		tbl = kmalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
 				   phb->node);
 		iommu_table_setparms(phb, dn, tbl);
-		dev->dev.archdata.dma_data = iommu_init_table(tbl, phb->node);
+		PCI_DN(dn)->iommu_table = iommu_init_table(tbl, phb->node);
+		dev->dev.archdata.dma_data = PCI_DN(dn)->iommu_table;
 		return;
 	}
 
