Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C731C2C0321
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 18:34:15 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 18 Jun 2013 04:34:13 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id EC61438C8047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 04:34:08 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5I8Y9vs277192
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 04:34:09 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5I8Y93n021161
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 05:34:09 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/31] powerpc/eeh: Refactor eeh_reset_pe_once()
Date: Tue, 18 Jun 2013 16:33:32 +0800
Message-Id: <1371544435-4943-9-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We shouldn't check that the returned PE status is exactly equal to
(EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE) but instead only check
that they are both set.

[benh: changelog]
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index a29cf47..cda0b62 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -565,6 +565,7 @@ static void eeh_reset_pe_once(struct eeh_pe *pe)
  */
 int eeh_reset_pe(struct eeh_pe *pe)
 {
+	int flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
 	int i, rc;
 
 	/* Take three shots at resetting the bus */
@@ -572,7 +573,7 @@ int eeh_reset_pe(struct eeh_pe *pe)
 		eeh_reset_pe_once(pe);
 
 		rc = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
-		if (rc == (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE))
+		if ((rc & flags) == flags)
 			return 0;
 
 		if (rc < 0) {
-- 
1.7.5.4
