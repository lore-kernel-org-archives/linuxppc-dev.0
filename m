Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B22CDDDDCA
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 23:42:44 +1100 (EST)
Subject: [PATCH] PMU: remove dead code
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 13 Nov 2007 20:08:32 +0100
Message-Id: <1194980912.6695.6.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some code in via-pmu.c is never compiled because of "compile options"
within the file. Remove the code completely.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/macintosh/via-pmu.c |   42 +-----------------------------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

--- everything.orig/drivers/macintosh/via-pmu.c	2007-11-13 19:32:03.058713543 +0100
+++ everything/drivers/macintosh/via-pmu.c	2007-11-13 19:32:05.968717936 +0100
@@ -64,9 +64,7 @@
 #include "via-pmu-event.h"
 
 /* Some compile options */
-#undef SUSPEND_USES_PMU
 #define DEBUG_SLEEP
-#undef HACKED_PCI_SAVE
 
 /* Misc minor number allocated for /dev/pmu */
 #define PMU_MINOR		154
@@ -1255,9 +1253,7 @@ void
 pmu_suspend(void)
 {
 	unsigned long flags;
-#ifdef SUSPEND_USES_PMU
-	struct adb_request *req;
-#endif
+
 	if (!via)
 		return;
 	
@@ -1275,17 +1271,10 @@ pmu_suspend(void)
 		via_pmu_interrupt(0, NULL);
 		spin_lock_irqsave(&pmu_lock, flags);
 		if (!adb_int_pending && pmu_state == idle && !req_awaiting_reply) {
-#ifdef SUSPEND_USES_PMU
-			pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, 0);
-			spin_unlock_irqrestore(&pmu_lock, flags);
-			while(!req.complete)
-				pmu_poll();
-#else /* SUSPEND_USES_PMU */
 			if (gpio_irq >= 0)
 				disable_irq_nosync(gpio_irq);
 			out_8(&via[IER], CB1_INT | IER_CLR);
 			spin_unlock_irqrestore(&pmu_lock, flags);
-#endif /* SUSPEND_USES_PMU */
 			break;
 		}
 	} while (1);
@@ -1306,18 +1295,11 @@ pmu_resume(void)
 		return;
 	}
 	adb_int_pending = 1;
-#ifdef SUSPEND_USES_PMU
-	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, pmu_intr_mask);
-	spin_unlock_irqrestore(&pmu_lock, flags);
-	while(!req.complete)
-		pmu_poll();
-#else /* SUSPEND_USES_PMU */
 	if (gpio_irq >= 0)
 		enable_irq(gpio_irq);
 	out_8(&via[IER], CB1_INT | IER_SET);
 	spin_unlock_irqrestore(&pmu_lock, flags);
 	pmu_poll();
-#endif /* SUSPEND_USES_PMU */
 }
 
 /* Interrupt data could be the result data from an ADB cmd */
@@ -1803,14 +1785,10 @@ static void broadcast_wake(void)
  * PCI devices which may get powered off when we sleep.
  */
 static struct pci_save {
-#ifndef HACKED_PCI_SAVE
 	u16	command;
 	u16	cache_lat;
 	u16	intr;
 	u32	rom_address;
-#else
-	u32	config[16];
-#endif	
 } *pbook_pci_saves;
 static int pbook_npci_saves;
 
@@ -1856,16 +1834,10 @@ pbook_pci_save(void)
 			pci_dev_put(pd);
 			return;
 		}
-#ifndef HACKED_PCI_SAVE
 		pci_read_config_word(pd, PCI_COMMAND, &ps->command);
 		pci_read_config_word(pd, PCI_CACHE_LINE_SIZE, &ps->cache_lat);
 		pci_read_config_word(pd, PCI_INTERRUPT_LINE, &ps->intr);
 		pci_read_config_dword(pd, PCI_ROM_ADDRESS, &ps->rom_address);
-#else
-		int i;
-		for (i=1;i<16;i++)
-			pci_read_config_dword(pd, i<<4, &ps->config[i]);
-#endif
 		++ps;
 	}
 }
@@ -1884,17 +1856,6 @@ pbook_pci_restore(void)
 	int j;
 
 	while ((pd = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
-#ifdef HACKED_PCI_SAVE
-		int i;
-		if (npci-- == 0) {
-			pci_dev_put(pd);
-			return;
-		}
-		ps++;
-		for (i=2;i<16;i++)
-			pci_write_config_dword(pd, i<<4, ps->config[i]);
-		pci_write_config_dword(pd, 4, ps->config[1]);
-#else
 		if (npci-- == 0)
 			return;
 		ps++;
@@ -1918,7 +1879,6 @@ pbook_pci_restore(void)
 			pci_write_config_word(pd, PCI_COMMAND, ps->command);
 			break;
 		}
-#endif	
 	}
 }
 
