Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F0861A002B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 16:04:40 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 12 Feb 2016 15:04:40 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C55F42CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 16:04:35 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1C54RSl13762750
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 16:04:35 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1C542VG007355
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 16:04:03 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/eeh: Fix partial hotplug criterion
Date: Fri, 12 Feb 2016 16:03:05 +1100
Message-Id: <1455253387-478-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During error recovery, the device could be removed as part of the
partial hotplug. The criterion used to come with partial hotplug
is: if the device driver provides error_detected(), slot_reset()
and resume() callbacks, it's immune from hotplug. Otherwise,
it's going to experience partial hotplug during EEH recovery. But
the criterion isn't correct enough: mlx4_core driver for Mellanox
adapters provides error_detected(), slot_reset() callbacks, but
resume() isn't there. Those Mellanox adapters won't be to involved
in the partial hotplug.

This fixes the criterion to a practical one: adpater with driver
that provides error_detected(), slot_reset() will be immune from
partial hotplug. resume() isn't mandatory.

Fixes: f2da4ccf ("powerpc/eeh: More relaxed hotplug criterion")
Cc: stable@vger.kernel.org #v4.4+
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 301be31..650cfb3 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -418,8 +418,7 @@ static void *eeh_rmv_device(void *data, void *userdata)
 		eeh_pcid_put(dev);
 		if (driver->err_handler &&
 		    driver->err_handler->error_detected &&
-		    driver->err_handler->slot_reset &&
-		    driver->err_handler->resume)
+		    driver->err_handler->slot_reset)
 			return NULL;
 	}
 
-- 
2.1.0
