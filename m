Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sWV324CrxzDrq8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Sep 2016 20:01:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linux-pcmcia@lists.infradead.org
Cc: linuxppc-dev@ozlabs.org,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/pcmcia: NO_IRQ removal for electra_cf.c
Date: Sat, 10 Sep 2016 20:01:30 +1000
Message-Id: <1473501690-11987-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We'd like to eventually remove NO_IRQ on powerpc, so remove usages of it
from electra_cf.c which is a powerpc-only driver.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/pcmcia/electra_cf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/electra_cf.c
index 4d7bc3f4124a..c6fe2a4a7a6a 100644
--- a/drivers/pcmcia/electra_cf.c
+++ b/drivers/pcmcia/electra_cf.c
@@ -207,7 +207,7 @@ static int electra_cf_probe(struct platform_device *ofdev)
 		return -ENOMEM;
 
 	setup_timer(&cf->timer, electra_cf_timer, (unsigned long)cf);
-	cf->irq = NO_IRQ;
+	cf->irq = 0;
 
 	cf->ofdev = ofdev;
 	cf->mem_phys = mem.start;
@@ -313,7 +313,7 @@ fail3:
 fail2:
 	release_mem_region(cf->mem_phys, cf->mem_size);
 fail1:
-	if (cf->irq != NO_IRQ)
+	if (cf->irq)
 		free_irq(cf->irq, cf);
 
 	if (cf->io_virt)
-- 
2.7.4
