Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4E315DDDE7
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 17:55:56 +1100 (EST)
Received: from ash.ozlabs.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 129AB368006
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 17:55:56 +1100 (EST)
Date: Fri, 7 Dec 2007 17:55:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] [POWERPC] eeh: avoid a possible NULL pointer dereference
Message-Id: <20071207175551.df0d7779.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/pseries/eeh_driver.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
index 06b89b5..68ea5ee 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -310,8 +310,6 @@ struct pci_dn * handle_eeh_events (struct eeh_event *event)
 	const char *location, *pci_str, *drv_str;
 
 	frozen_dn = find_device_pe(event->dn);
-	frozen_bus = pcibios_find_pci_bus(frozen_dn);
-
 	if (!frozen_dn) {
 
 		location = of_get_property(event->dn, "ibm,loc-code", NULL);
@@ -321,6 +319,8 @@ struct pci_dn * handle_eeh_events (struct eeh_event *event)
 		        location, pci_name(event->dev));
 		return NULL;
 	}
+
+	frozen_bus = pcibios_find_pci_bus(frozen_dn);
 	location = of_get_property(frozen_dn, "ibm,loc-code", NULL);
 	location = location ? location : "unknown";
 
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
