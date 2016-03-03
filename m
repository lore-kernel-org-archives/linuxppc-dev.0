Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7097B1A0BAB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 10:54:41 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 09:54:41 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 00DF52CE805A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 10:54:38 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u23NsTim64028750
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 10:54:37 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u23Ns5q5002719
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 10:54:05 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: ruscur@russell.cc, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v15 11/12] powerpc/eeh: Don't remove passed VFs
Date: Fri,  4 Mar 2016 10:53:13 +1100
Message-Id: <1457049194-9281-12-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1457049194-9281-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1457049194-9281-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
