Return-Path: <galak@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id A656167A84
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jan 2005 11:18:02 +1100 (EST)
Date: Tue, 25 Jan 2005 18:17:48 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: akpm@osdl.org
Message-ID: <Pine.LNX.4.61.0501251814480.26772@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH] netdrv gianfar: Fix usage of gfar_read in debug code   
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fixes instances where gfar_read() was invoked in debug codewith a value, 
rather than a pointer.

Signed-of-by: Andy Fleming <afleming@freescale.com>
Signed-of-by: Kumar Gala <afleming@freescale.com>

---

diff -Nru a/drivers/net/gianfar.c b/drivers/net/gianfar.c
--- a/drivers/net/gianfar.c	2005-01-25 18:14:13 -06:00
+++ b/drivers/net/gianfar.c	2005-01-25 18:14:13 -06:00
@@ -1190,8 +1190,8 @@
 	} else {
 #ifdef VERBOSE_GFAR_ERRORS
 		printk(KERN_DEBUG "%s: receive called twice (%x)[%x]\n",
-		       dev->name, gfar_read(priv->regs->ievent),
-		       gfar_read(priv->regs->imask));
+		       dev->name, gfar_read(&priv->regs->ievent),
+		       gfar_read(&priv->regs->imask));
 #endif
 	}
 #else
@@ -1415,7 +1415,7 @@
 
 #ifdef VERBOSE_GFAR_ERRORS
 		printk(KERN_DEBUG "%s: busy error (rhalt: %x)\n", dev->name,
-		       gfar_read(priv->regs->rstat));
+		       gfar_read(&priv->regs->rstat));
 #endif
 	}
 	if (events & IEVENT_BABR) {
@@ -1793,7 +1793,7 @@
 
 #ifdef VERBOSE_GFAR_ERRORS
 		printk(KERN_DEBUG "%s: busy error (rhalt: %x)\n", dev->name,
-		       gfar_read(priv->regs->rstat));
+		       gfar_read(&priv->regs->rstat));
 #endif
 	}
 	if (events & IEVENT_BABR) {
