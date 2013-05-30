Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5C2172C016F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 18:24:31 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 30 May 2013 04:24:28 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id DF1B96E8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 04:24:22 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4U8OQ1e264314
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 04:24:26 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4U8OPOO013441
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 05:24:26 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 22/23] powerpc/eeh: Connect EEH error interrupt handle
Date: Thu, 30 May 2013 16:24:04 +0800
Message-Id: <1369902245-5886-23-git-send-email-shangw@linux.vnet.ibm.com>
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
index 628c564..cca78c9 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -18,6 +18,8 @@
 #include <linux/slab.h>
 #include <asm/opal.h>
 #include <asm/firmware.h>
+#include <asm/io.h>
+#include <asm/eeh.h>
 
 #include "powernv.h"
 
@@ -296,6 +298,10 @@ static irqreturn_t opal_interrupt(int irq, void *data)
 	uint64_t events;
 
 	opal_handle_interrupt(virq_to_hw(irq), &events);
+#ifdef CONFIG_EEH
+	if (events & OPAL_EVENT_PCI_ERROR)
+		pci_err_event();
+#endif
 
 	/* XXX TODO: Do something with the events */
 
-- 
1.7.5.4
