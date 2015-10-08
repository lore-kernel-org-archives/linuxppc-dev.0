Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 97D271A0023
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 15:00:01 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3526F140D8C
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 15:00:01 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 8 Oct 2015 14:00:00 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 22A6E3578052
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 14:59:58 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t983xpaj590124
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 14:59:59 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t983xPfd016208
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 14:59:25 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 2/8] powerpc/eeh: More relexed hotplug criterion
Date: Thu,  8 Oct 2015 14:58:53 +1100
Message-Id: <1444276739-20372-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1444276739-20372-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1444276739-20372-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, we rely on the existence of struct pci_driver::err_handler
to judge if the corresponding PCI device should be unplugged during
EEH recovery (partially hotplug case). However, it's not elaborate.
some device drivers are implementing part of the EEH error handlers
to collect diag-data. That means the driver still expects a hotplug
to recover from the EEH error.

This makes the hotplug criterion more relaxed: if the device driver
doesn't provide all necessary EEH error handlers, it will experience
hotplug during EEH recovery.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 3a626ed..32178a4 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -416,7 +416,10 @@ static void *eeh_rmv_device(void *data, void *userdata)
 	driver = eeh_pcid_get(dev);
 	if (driver) {
 		eeh_pcid_put(dev);
-		if (driver->err_handler)
+		if (driver->err_handler &&
+		    driver->err_handler->error_detected &&
+		    driver->err_handler->slot_reset &&
+		    driver->err_handler->resume)
 			return NULL;
 	}
 
-- 
2.1.0
