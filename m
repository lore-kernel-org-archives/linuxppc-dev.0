Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7DB4367C00
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 06:42:11 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9HKg8r9005516
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 16:42:08 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9HKg8Hd258224
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 14:42:08 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9HKg7L1006441
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 14:42:08 -0600
Date: Tue, 17 Oct 2006 15:42:06 -0500
To: akpm@osdl.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Auke Kok <auke-jan.h.kok@intel.com>
Subject: [PATCH] e1000: Reset all functions after a PCI error
Message-ID: <20061017204206.GG6537@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please apply and forward upstream.

--linas

During the handling of the PCI error recovery sequence,
the current e1000 driver erroneously blocks a device reset
for any but the first PCI function. It shouldn't -- this 
is a cut-n-paste error from a different driver (which
tolerated only one hardware reset per hardware card). 

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Auke Kok <auke-jan.h.kok@intel.com>

----
 drivers/net/e1000/e1000_main.c |    4 ----
 1 file changed, 4 deletions(-)

Index: linux-2.6.19-rc1-git11/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.19-rc1-git11.orig/drivers/net/e1000/e1000_main.c	2006-10-17 15:02:25.000000000 -0500
+++ linux-2.6.19-rc1-git11/drivers/net/e1000/e1000_main.c	2006-10-17 15:03:35.000000000 -0500
@@ -4914,10 +4914,6 @@ static pci_ers_result_t e1000_io_slot_re
 	pci_enable_wake(pdev, PCI_D3hot, 0);
 	pci_enable_wake(pdev, PCI_D3cold, 0);
 
-	/* Perform card reset only on one instance of the card */
-	if (PCI_FUNC (pdev->devfn) != 0)
-		return PCI_ERS_RESULT_RECOVERED;
-
 	e1000_reset(adapter);
 	E1000_WRITE_REG(&adapter->hw, WUS, ~0);
 
