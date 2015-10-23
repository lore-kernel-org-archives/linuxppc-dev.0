Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A9A511A0889
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 17:20:22 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 79BDC14131F
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Oct 2015 17:20:22 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 23 Oct 2015 16:20:21 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8B9EB2BB0052
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Oct 2015 17:20:19 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9N6K5i311141194
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Oct 2015 17:20:14 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9N6JksV014530
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Oct 2015 17:19:46 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/eeh: eeh_pci_enable(): fix checking of post-request
 state
Date: Fri, 23 Oct 2015 17:19:46 +1100
Message-Id: <1445581186-10533-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In eeh_pci_enable(), after making the request to set the new options, we
call eeh_ops->wait_state() to check that the request finished successfully.

At the moment, if eeh_ops->wait_state() returns 0, we return 0 without
checking that it reflects the expected outcome. This can lead to callers
further up the chain incorrectly assuming the slot has been successfully
unfrozen and continuing to attempt recovery.

On powernv, this will occur if pnv_eeh_get_pe_state() or
pnv_eeh_get_phb_state() return 0, which in turn occurs if the relevant OPAL
call returns OPAL_EEH_STOPPED_MMIO_DMA_FREEZE or
OPAL_EEH_PHB_ERROR respectively.

On pseries, this will occur if pseries_eeh_get_state() returns 0, which in
turn occurs if RTAS reports that the PE is in the MMIO Stopped and DMA
Stopped states.

Obviously, none of these cases represent a successful completion of a
request to thaw MMIO or DMA.

Fix the check so that a wait_state() return value of 0 won't be considered
successful for the EEH_OPT_THAW_MMIO or EEH_OPT_THAW_DMA cases.

Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 40e4d4a..d757e7c 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -677,7 +677,7 @@ int eeh_pci_enable(struct eeh_pe *pe, int function)
 	/* Check if the request is finished successfully */
 	if (active_flag) {
 		rc = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
-		if (rc <= 0)
+		if (rc < 0)
 			return rc;
 
 		if (rc & active_flag)
-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
