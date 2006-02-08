Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC9FE689F3
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 14:19:45 +1100 (EST)
To: torvalds@osdl.org
Subject: [PATCH 22/29] eeh_driver NULL noise removal
Message-Id: <E1F6frq-0006Dl-5B@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:19:42 +0000
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Date: 1138796604 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/powerpc/platforms/pseries/eeh_driver.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

d04e4e115bd9df2b748cb30abd610f3c0eb1e303
diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
index 6373372..e3cbba4 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -333,7 +333,7 @@ void handle_eeh_events (struct eeh_event
 		rc = eeh_reset_device(frozen_pdn, NULL);
 		if (rc)
 			goto hard_fail;
-		pci_walk_bus(frozen_bus, eeh_report_reset, 0);
+		pci_walk_bus(frozen_bus, eeh_report_reset, NULL);
 	}
 
 	/* If all devices reported they can proceed, the re-enable PIO */
@@ -342,11 +342,11 @@ void handle_eeh_events (struct eeh_event
 		rc = eeh_reset_device(frozen_pdn, NULL);
 		if (rc)
 			goto hard_fail;
-		pci_walk_bus(frozen_bus, eeh_report_reset, 0);
+		pci_walk_bus(frozen_bus, eeh_report_reset, NULL);
 	}
 
 	/* Tell all device drivers that they can resume operations */
-	pci_walk_bus(frozen_bus, eeh_report_resume, 0);
+	pci_walk_bus(frozen_bus, eeh_report_resume, NULL);
 
 	return;
 	
@@ -367,7 +367,7 @@ hard_fail:
 	eeh_slot_error_detail(frozen_pdn, 2 /* Permanent Error */);
 
 	/* Notify all devices that they're about to go down. */
-	pci_walk_bus(frozen_bus, eeh_report_failure, 0);
+	pci_walk_bus(frozen_bus, eeh_report_failure, NULL);
 
 	/* Shut down the device drivers for good. */
 	pcibios_remove_pci_devices(frozen_bus);
-- 
0.99.9.GIT
