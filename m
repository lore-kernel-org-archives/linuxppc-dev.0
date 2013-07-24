Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A62BF2C00F6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 12:25:18 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 23 Jul 2013 20:25:16 -0600
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 067CAC90068
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 22:25:12 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6O2PDUZ148150
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 22:25:13 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6O2PCAH030486
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 23:25:13 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/11] powerpc/eeh: Fix unbalanced enable for IRQ
Date: Wed, 24 Jul 2013 10:25:00 +0800
Message-Id: <1374632701-20972-11-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1374632701-20972-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1374632701-20972-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch fixes following issue:

Unbalanced enable for IRQ 23
------------[ cut here ]------------
WARNING: at kernel/irq/manage.c:437
:
NIP [c00000000016de8c] .__enable_irq+0x11c/0x140
LR [c00000000016de88] .__enable_irq+0x118/0x140
Call Trace:
[c000003ea1f23880] [c00000000016de88] .__enable_irq+0x118/0x140 (unreliable)
[c000003ea1f23910] [c00000000016df08] .enable_irq+0x58/0xa0
[c000003ea1f239a0] [c0000000000388b4] .eeh_enable_irq+0xc4/0xe0
[c000003ea1f23a30] [c000000000038a28] .eeh_report_reset+0x78/0x130
[c000003ea1f23ac0] [c000000000037508] .eeh_pe_dev_traverse+0x98/0x170
[c000003ea1f23b60] [c0000000000391ac] .eeh_handle_normal_event+0x2fc/0x3d0
[c000003ea1f23bf0] [c000000000039538] .eeh_handle_event+0x2b8/0x2c0
[c000003ea1f23c90] [c000000000039600] .eeh_event_handler+0xc0/0x170
[c000003ea1f23d30] [c0000000000da9a0] .kthread+0xf0/0x100
[c000003ea1f23e30] [c00000000000a1dc] .ret_from_kernel_thread+0x5c/0x80

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 9fda75d..36bed5a 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -143,10 +143,14 @@ static void eeh_disable_irq(struct pci_dev *dev)
 static void eeh_enable_irq(struct pci_dev *dev)
 {
 	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
+	struct irq_desc *desc;
 
 	if ((edev->mode) & EEH_DEV_IRQ_DISABLED) {
 		edev->mode &= ~EEH_DEV_IRQ_DISABLED;
-		enable_irq(dev->irq);
+
+		desc = irq_to_desc(dev->irq);
+		if (desc && desc->depth > 0)
+			enable_irq(dev->irq);
 	}
 }
 
-- 
1.7.5.4
