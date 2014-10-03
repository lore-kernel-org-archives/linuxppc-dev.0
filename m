Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 583DF1A08CD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 14:58:37 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 3 Oct 2014 14:58:35 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1AE8B2CE804D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 14:58:34 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s934eB2S53280876
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Oct 2014 14:40:11 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s934wXfH020698
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Oct 2014 14:58:33 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/eeh: Block CFG upon frozen Shiner adapter
Date: Fri,  3 Oct 2014 14:58:32 +1000
Message-Id: <1412312312-21069-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Broadcom Shiner 2-ports 10G ethernet adapter has same problem
commit 6f20bda0 ("powerpc/eeh: Block PCI config access upon frozen
PE") fixes. Put it to the black list as well.

   # lspci -s 0004:01:00.0
   0004:01:00.0 Ethernet controller: Broadcom Corporation \
                NetXtreme II BCM57810 10 Gigabit Ethernet (rev 10)
   # lspci -n -s 0004:01:00.0
   0004:01:00.0 0200: 14e4:168e (rev 10)

Reported-by: John Walthour <jwalthour@us.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 443ce96..1d19e79 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -182,9 +182,10 @@ static int powernv_eeh_dev_probe(struct pci_dev *dev, void *flag)
 	 * that PE to block its config space.
 	 *
 	 * Broadcom Austin 4-ports NICs (14e4:1657)
+	 * Broadcom Shiner 2-ports 10G NICs (14e4:168e)
 	 */
-	if (dev->vendor == PCI_VENDOR_ID_BROADCOM &&
-	    dev->device == 0x1657)
+	if ((dev->vendor == PCI_VENDOR_ID_BROADCOM && dev->device == 0x1657) ||
+	    (dev->vendor == PCI_VENDOR_ID_BROADCOM && dev->device == 0x168e))
 		edev->pe->state |= EEH_PE_CFG_RESTRICTED;
 
 	/*
-- 
1.8.3.2
