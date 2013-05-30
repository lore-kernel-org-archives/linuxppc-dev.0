Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 97C3D2C02E9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 18:24:23 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 30 May 2013 04:24:20 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 8F8A56E803A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 04:24:14 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4U8OIV1340260
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 04:24:18 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4U8OGMQ022568
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 04:24:17 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/23] powerpc/eeh: Refactor eeh_reset_pe_once()
Date: Thu, 30 May 2013 16:23:50 +0800
Message-Id: <1369902245-5886-9-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch changes the criteria used to judge if the PE has been
resetted successfully. We needn't the PE status is exactly equal
to the combo: (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE).

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 39d2ea6..ffe34c4 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -527,7 +527,6 @@ static void eeh_reset_pe_once(struct eeh_pe *pe)
 	 * Partitionable Endpoint trumps hot-reset.
   	 */
 	eeh_pe_dev_traverse(pe, eeh_set_dev_freset, &freset);
-
 	if (freset)
 		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
 	else
@@ -565,6 +564,7 @@ static void eeh_reset_pe_once(struct eeh_pe *pe)
  */
 int eeh_reset_pe(struct eeh_pe *pe)
 {
+	int flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
 	int i, rc;
 
 	/* Take three shots at resetting the bus */
@@ -572,7 +572,7 @@ int eeh_reset_pe(struct eeh_pe *pe)
 		eeh_reset_pe_once(pe);
 
 		rc = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
-		if (rc == (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE))
+		if ((rc & flags) == flags)
 			return 0;
 
 		if (rc < 0) {
-- 
1.7.5.4
