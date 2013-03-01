Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 16DB92C03D2
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2013 01:18:09 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 1 Mar 2013 07:18:07 -0700
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 90B7A6E8020
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2013 09:18:03 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r21EI5Cr324614
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 09:18:05 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r21EI4Bw001235
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 09:18:04 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 22/22] powerpc/eeh: Connect EEH error interrupt handle
Date: Fri,  1 Mar 2013 22:17:20 +0800
Message-Id: <1362147440-14096-23-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1362147440-14096-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1362147440-14096-1-git-send-email-shangw@linux.vnet.ibm.com>
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
index aaa0dba..8aa99de 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -17,6 +17,8 @@
 #include <linux/interrupt.h>
 #include <asm/opal.h>
 #include <asm/firmware.h>
+#include <asm/io.h>
+#include <asm/eeh.h>
 
 #include "powernv.h"
 
@@ -271,6 +273,10 @@ static irqreturn_t opal_interrupt(int irq, void *data)
 	uint64_t events;
 
 	opal_handle_interrupt(virq_to_hw(irq), &events);
+#ifdef CONFIG_EEH
+	if (events & OPAL_EVENT_PCI_ERROR)
+		pci_err_event();
+#endif
 
 	/* XXX TODO: Do something with the events */
 
-- 
1.7.5.4
