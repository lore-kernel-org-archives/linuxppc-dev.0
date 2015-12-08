Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 203DC1A0EE1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 17:00:53 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E7B5C1402A9
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Dec 2015 17:00:52 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 8 Dec 2015 16:00:51 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 056263578047
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Dec 2015 17:00:45 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB860atR66256958
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Dec 2015 17:00:44 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB860C7Y031271
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Dec 2015 17:00:12 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2] Revert "powerpc/eeh: Don't unfreeze PHB PE after reset"
Date: Tue,  8 Dec 2015 16:59:25 +1100
Message-Id: <1449554365-22036-1-git-send-email-andrew.donnellan@au1.ibm.com>
In-Reply-To: <1449126972-25400-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1449126972-25400-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reverts commit 527d10ef3a315d3cb9dc098dacd61889a6c26439.

The reverted commit breaks cxlflash devices following an EEH reset (and
possibly other cxl devices, however this has not been tested).

The reverted commit changed the behaviour of eeh_reset_device() so that PHB
PEs are not unfrozen following the completion of the reset. This should not
be problematic, as no device resources should have been associated with the
PHB PE.

However, when attempting to load the cxlflash driver after a reset, the
driver attempts to read Vital Product Data through a call to
pci_read_vpd() (which is called on the physical cxl device, not on the
virtual AFU device). pci_read_vpd() in turn attempts to read from the cxl
device's config space. This fails, as the PE it's trying to read from is
still frozen. In turn, the driver gets an -ENODEV and fails to initialise.

It appears this issue only affects some parts of the VPD area, as "lspci
-vvv", which only reads a subset of the VPD bytes, is not broken by the
original patch.

At this stage, we don't fully understand why we're trying to read a frozen
PE, and we don't know how this affects other cxl devices. It is possible
that there is an underlying bug in the cxl driver or the powerpc CAPI
support code, or alternatively a bug in the PCI resource allocation/mapping
code that is incorrectly mapping resources to PE#0.

As such, this fix is incomplete, however it is necessary to prevent a
serious regression in CAPI support.

In the meantime, revert the commit, especially as it was intended to be a
non-functional change.

Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

Changes from V1:
 - Updated commit message to incorporate comments from Daniel Axtens

We would like to get this fix pushed as soon as possible - I'm on leave for
the rest of this week, so I'll volunteer Daniel to answer any remaining
questions, and I'm happy for him to revise this patch further if needed.
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
