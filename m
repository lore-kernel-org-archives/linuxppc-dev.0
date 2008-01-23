Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A26AFDDE2C
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 23:40:15 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id m0NCeAVn014540
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 06:40:11 -0600
Date: Wed, 23 Jan 2008 06:37:49 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [RAPIDIO] Fix compile error and warning
Message-ID: <Pine.LNX.4.64.0801230637430.4478@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

drivers/rapidio/rio.c: In function 'rio_get_asm':
drivers/rapidio/rio.c:413: error: implicit declaration of function 'in_interrupt'
drivers/rapidio/rio.c: In function 'rio_init_mports':
drivers/rapidio/rio.c:480: warning: format '%8.8lx' expects type 'long unsigned int', but argument 2 has type 'resource_size_t'
drivers/rapidio/rio.c:480: warning: format '%8.8lx' expects type 'long unsigned int', but argument 3 has type 'resource_size_t'

---
 drivers/rapidio/rio.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rapidio/rio.c b/drivers/rapidio/rio.c
index f644807..80c5f1b 100644
--- a/drivers/rapidio/rio.c
+++ b/drivers/rapidio/rio.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>

 #include "rio.h"

@@ -476,8 +477,8 @@ int rio_init_mports(void)
 					port->iores.end - port->iores.start,
 					port->name)) {
 			printk(KERN_ERR
-			       "RIO: Error requesting master port region %8.8lx-%8.8lx\n",
-			       port->iores.start, port->iores.end - 1);
+			       "RIO: Error requesting master port region 0x%016llx-0x%016llx\n",
+			       (u64)port->iores.start, (u64)port->iores.end - 1);
 			rc = -ENOMEM;
 			goto out;
 		}
-- 
1.5.3.7
