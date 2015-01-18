Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C36941A0C54
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 09:47:29 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 19 Jan 2015 08:47:28 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 55A712CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 09:47:26 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0IMlPmP36438228
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 09:47:26 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0IMlPLY022193
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 09:47:25 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pseries: Avoid context switch in EEH reset if required
Date: Mon, 19 Jan 2015 09:47:23 +1100
Message-Id: <1421621243-21265-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On pseries platform, the EEH reset backend pseries_eeh_reset() can
be called in atomic context as follows. For this case, we should
call udelay() instead of msleep() to avoid context switching.

     drivers/scsi/ipr.c::ipr_reset_slot_reset_done()
     drivers/pci/pci.c::pci_set_pcie_reset_state()
     arch/powerpc/kernel/eeh.c::pcibios_set_pcie_reset_state()
     arch/powerpc/platforms/pseries/eeh_pseries.c::pseries_eeh_reset()

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Tested-by: Wen Xiong<wenxiong@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_pseries.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index a6c7e19..67623a3 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -503,8 +503,7 @@ static int pseries_eeh_get_state(struct eeh_pe *pe, int *state)
  */
 static int pseries_eeh_reset(struct eeh_pe *pe, int option)
 {
-	int config_addr;
-	int ret;
+	int config_addr, delay, ret;
 
 	/* Figure out PE address */
 	config_addr = pe->config_addr;
@@ -528,9 +527,14 @@ static int pseries_eeh_reset(struct eeh_pe *pe, int option)
 	/* We need reset hold or settlement delay */
 	if (option == EEH_RESET_FUNDAMENTAL ||
 	    option == EEH_RESET_HOT)
-		msleep(EEH_PE_RST_HOLD_TIME);
+		delay = EEH_PE_RST_HOLD_TIME;
+	else
+		delay = EEH_PE_RST_SETTLE_TIME;
+
+	if (in_atomic())
+		udelay(delay * 1000);
 	else
-		msleep(EEH_PE_RST_SETTLE_TIME);
+		msleep(delay);
 
 	return ret;
 }
-- 
1.8.3.2
