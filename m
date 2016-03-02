Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8BB511A005D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 13:29:55 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 2 Mar 2016 12:29:54 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4C7092CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 13:29:51 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u222TgAg8716686
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2016 13:29:51 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u222TIio005535
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2016 13:29:18 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: ruscur@russell.cc, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 2/3] powerpc/eeh: Don't remove passed VFs
Date: Wed,  2 Mar 2016 13:28:51 +1100
Message-Id: <1456885732-23070-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1456885732-23070-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1456885732-23070-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we have partial hotplug as part of the error recovery on PF,
the VFs that are bound with vfio-pci driver will experience hotplug.
That's not allowed.

This checks if the VF PE is passed or not. If it does, we leave
the VF without removing it.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/kernel/eeh_driver.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 6c59de8..fb6207d 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -455,6 +455,9 @@ static void *eeh_rmv_device(void *data, void *userdata)
 	if (driver) {
 		eeh_pcid_put(dev);
 		if (removed &&
+		    eeh_pe_passed(edev->pe))
+			return NULL;
+		if (removed &&
 		    driver->err_handler &&
 		    driver->err_handler->error_detected &&
 		    driver->err_handler->slot_reset)
-- 
2.1.0
