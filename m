Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95D321A0BE2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 11:27:19 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 27 Apr 2015 11:27:19 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E89443578047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 11:27:16 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3R1R8q745416616
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 11:27:16 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3R1Qgow007872
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 11:26:42 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com
Subject: [PATCH V2 2/4] powerpc/eeh: fix comment for wait_state()
Date: Mon, 27 Apr 2015 09:25:10 +0800
Message-Id: <1430097912-6207-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1430097912-6207-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1430097912-6207-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To retrieve the PCI slot state, EEH driver would set a timeout for that.
While current comment is not aligned to what the code does.

This patch fixes those comments according to the code.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c             |    2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c |    2 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 24768ff..89eb4bc 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -660,7 +660,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 	eeh_pe_dev_traverse(pe, eeh_report_error, &result);
 
 	/* Get the current PCI slot state. This can take a long time,
-	 * sometimes over 3 seconds for certain systems.
+	 * sometimes over 300 seconds for certain systems.
 	 */
 	rc = eeh_ops->wait_state(pe, MAX_WAIT_FOR_RECOVERY*1000);
 	if (rc < 0 || rc == EEH_STATE_NOT_SUPPORT) {
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index ce738ab..d025471 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -979,7 +979,7 @@ static int pnv_eeh_reset(struct eeh_pe *pe, int option)
 /**
  * pnv_eeh_wait_state - Wait for PE state
  * @pe: EEH PE
- * @max_wait: maximal period in microsecond
+ * @max_wait: maximal period in millisecond
  *
  * Wait for the state of associated PE. It might take some time
  * to retrieve the PE's state.
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 2039397..1ba55d0 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -519,7 +519,7 @@ static int pseries_eeh_reset(struct eeh_pe *pe, int option)
 /**
  * pseries_eeh_wait_state - Wait for PE state
  * @pe: EEH PE
- * @max_wait: maximal period in microsecond
+ * @max_wait: maximal period in millisecond
  *
  * Wait for the state of associated PE. It might take some time
  * to retrieve the PE's state.
-- 
1.7.9.5
