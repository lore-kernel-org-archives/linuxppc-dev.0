Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 47E80679E9
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jul 2006 10:37:34 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH maple] Fix new interrupt code (MPIC detection)
To: linuxppc-dev@ozlabs.org
Message-Id: <20060708003720.8E49F3BB9DE@schermpje.krocht>
Date: Sat,  8 Jul 2006 02:37:20 +0200 (CEST)
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As the code comment already says, the Maple device-tree is incorrect here;
make the Linux code detect the correct thing, too.

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
Index: linux-powerpc/arch/powerpc/platforms/maple/setup.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/platforms/maple/setup.c	2006-07-03 19:38:29.597405696 +0200
+++ linux-powerpc/arch/powerpc/platforms/maple/setup.c	2006-07-03 19:56:28.469294976 +0200
@@ -221,10 +221,17 @@
 	 * in Maple device-tree where the type of the controller is
 	 * open-pic and not interrupt-controller
 	 */
-	for_each_node_by_type(np, "open-pic") {
-		mpic_node = np;
-		break;
-	}
+
+	for_each_node_by_type(np, "interrupt-controller")
+		if (device_is_compatible(np, "open-pic")) {
+			mpic_node = np;
+			break;
+		}
+	if (mpic_node == NULL)
+		for_each_node_by_type(np, "open-pic") {
+			mpic_node = np;
+			break;
+		}
 	if (mpic_node == NULL) {
 		printk(KERN_ERR
 		       "Failed to locate the MPIC interrupt controller\n");
