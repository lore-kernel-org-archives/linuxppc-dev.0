Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 740D72C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 17:49:34 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 12 Nov 2013 01:49:30 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 10A0B38C8042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 01:49:26 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAC6nRak61145170
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 06:49:27 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAC6nQtX023265
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 01:49:27 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/eeh: Enable PCI_COMMAND_MASTER for PCI bridges
Date: Tue, 12 Nov 2013 14:49:21 +0800
Message-Id: <1384238962-13170-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PHB3, we will fail to fetch IODA tables without PCI_COMMAND_MASTER
on PCI bridges. According to one experiment I had, the MSIx interrupts
didn't raise from the adapter without the bit applied to all upstream
PCI bridges including root port of the adapter. The patch forces to
have that bit enabled accordingly.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 1fb331d..180af13 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -687,6 +687,15 @@ void eeh_save_bars(struct eeh_dev *edev)
 
 	for (i = 0; i < 16; i++)
 		eeh_ops->read_config(dn, i * 4, 4, &edev->config_space[i]);
+
+	/*
+	 * For PCI bridges including root port, we need enable bus
+	 * master explicitly. Otherwise, it can't fetch IODA table
+	 * entries correctly. So we cache the bit in advance so that
+	 * we can restore it after reset, either PHB range or PE range.
+	 */
+	if (edev->mode & EEH_DEV_BRIDGE)
+		edev->config_space[1] |= PCI_COMMAND_MASTER;
 }
 
 /**
-- 
1.7.9.5
