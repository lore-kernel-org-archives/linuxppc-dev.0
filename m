Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 495AB1A078B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Dec 2015 18:17:19 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 24A111402D2
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Dec 2015 18:17:18 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 3 Dec 2015 17:17:18 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3325D3578047
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Dec 2015 18:17:16 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB37H88b27328672
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Dec 2015 18:17:16 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB37Gh4s010085
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Dec 2015 18:16:43 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: gwshan@linux.vnet.ibm.com, imunsie@au1.ibm.com
Subject: [PATCH] Revert "powerpc/eeh: Don't unfreeze PHB PE after reset"
Date: Thu,  3 Dec 2015 18:16:12 +1100
Message-Id: <1449126972-25400-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reverts commit 527d10ef3a315d3cb9dc098dacd61889a6c26439.

The reverted commit breaks cxlflash devices following an EEH reset.
Attempting to load the cxlflash driver after a reset results in a call to
pci_read_vpd() returning -ENODEV, causing driver initialisation to fail.

At this stage, we don't fully understand why this is happening, and we
also haven't tested whether this occurs for other cxl devices. In the
meantime, though, revert the commit, especially as it was intended to be a
non-functional change.

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

This issue was identified by bisection following breakage observed in
4.4-rc1. I'm continuing to investigate the root cause (and testing on cxl
devices other than cxlflash), as the commit in question shouldn't have
caused problems.
---
 arch/powerpc/kernel/eeh_driver.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 80dfe89..8d14feb 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -590,16 +590,10 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	eeh_ops->configure_bridge(pe);
 	eeh_pe_restore_bars(pe);
 
-	/*
-	 * If it's PHB PE, the frozen state on all available PEs should have
-	 * been cleared by the PHB reset. Otherwise, we unfreeze the PE and its
-	 * child PEs because they might be in frozen state.
-	 */
-	if (!(pe->type & EEH_PE_PHB)) {
-		rc = eeh_clear_pe_frozen_state(pe, false);
-		if (rc)
-			return rc;
-	}
+	/* Clear frozen state */
+	rc = eeh_clear_pe_frozen_state(pe, false);
+	if (rc)
+		return rc;
 
 	/* Give the system 5 seconds to finish running the user-space
 	 * hotplug shutdown scripts, e.g. ifdown for ethernet.  Yes,
-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
