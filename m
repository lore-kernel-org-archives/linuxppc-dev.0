Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C01AB1A0258
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 17:28:08 +1000 (AEST)
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4AF17140779
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2015 17:28:06 +1000 (AEST)
Received: by pawq9 with SMTP id q9so46772709paw.3
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2015 00:28:04 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, Ryan Grimm <grimm@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH] cxl: Remove racy attempt to force EEH invocation in reset
Date: Fri, 21 Aug 2015 17:25:15 +1000
Message-Id: <1440141915-27716-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cxl_reset currently PERSTs the slot, and then repeatedly tries to
read MMIO space in order to kick off EEH.

There are 2 problems with this: it's unnecessary, and it's racy.

It's unnecessary because the PERST will bring down the PHB link.
That will be picked up by the CAPP, which will send out an HMI.
Skiboot, noticing an HMI from the CAPP, will send an OPAL
notification to the kernel, which will trigger EEH recovery.

It's also racy: the EEH recovery triggered by the CAPP will
eventually cause the MMIO space to have its mapping invalidated
and the pointer NULLed out. This races with our attempt to read
the MMIO space. This is causing OOPSes in testing.

Simply drop all the attempts to force EEH detection, and trust
that Skiboot will send the notification and that we'll act on it.
The Skiboot code to send the EEH notification has been in Skiboot
for as long as CAPP recovery has been supported, so we don't need
to worry about breaking obscure setups with ancient firmware.

Cc: Ryan Grimm <grimm@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
Fixes: 62fa19d4b4fd ("cxl: Add ability to reset the card")
Signed-off-by: Daniel Axtens <dja@axtens.net>

---
Oddly, the commit message in 62fa19d4b4fd ("cxl: Add ability to
reset the card") is correct in its explanation of EEH triggering.

My guess is that the extra code was added because in our development
environment (bml) the notifications don't seem to work reliably.

However, I have tested that the notifications do work on real/normal
hardware.
---
 drivers/misc/cxl/pci.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index be3839e34b7c..84bb9adbccb1 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -887,8 +887,6 @@ int cxl_reset(struct cxl *adapter)
 {
 	struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
 	int rc;
-	int i;
-	u32 val;
 
 	if (adapter->perst_same_image) {
 		dev_warn(&dev->dev,
@@ -906,20 +904,6 @@ int cxl_reset(struct cxl *adapter)
 		return rc;
 	}
 
-	/* the PERST done above fences the PHB.  So, reset depends on EEH
-	 * to unbind the driver, tell Sapphire to reinit the PHB, and rebind
-	 * the driver.  Do an mmio read explictly to ensure EEH notices the
-	 * fenced PHB.  Retry for a few seconds before giving up. */
-	i = 0;
-	while (((val = mmio_read32be(adapter->p1_mmio)) != 0xffffffff) &&
-		(i < 5)) {
-		msleep(500);
-		i++;
-	}
-
-	if (val != 0xffffffff)
-		dev_err(&dev->dev, "cxl: PERST failed to trigger EEH\n");
-
 	return rc;
 }
 
-- 
2.5.0
