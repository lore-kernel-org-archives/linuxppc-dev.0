Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6DFB62C011E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 13:35:25 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 14 May 2013 23:35:22 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 84F716E8048
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 23:35:17 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4F3ZKNn306848
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 23:35:20 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4F3ZJcl007038
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 00:35:20 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 22/22] powerpc/eeh: Connect EEH error interrupt handle
Date: Wed, 15 May 2013 11:34:58 +0800
Message-Id: <1368588898-16224-23-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1368588898-16224-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1368588898-16224-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The EEH error interrupts should have been exported by firmware
through device tree. The OS already installed the interrupt
handler (opal_interrupt()) for them. The patch checks if we have
any existing EEH errors and wakes the kernel thread up to process
that if possible.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index ade4463..75acc6d 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -17,6 +17,8 @@
 #include <linux/interrupt.h>
 #include <asm/opal.h>
 #include <asm/firmware.h>
+#include <asm/io.h>
+#include <asm/eeh.h>
 
 #include "powernv.h"
 
@@ -282,6 +284,10 @@ static irqreturn_t opal_interrupt(int irq, void *data)
 	uint64_t events;
 
 	opal_handle_interrupt(virq_to_hw(irq), &events);
+#ifdef CONFIG_EEH
+	if (events & OPAL_EVENT_PCI_ERROR)
+		pci_err_event();
+#endif
 
 	/* XXX TODO: Do something with the events */
 
-- 
1.7.5.4
