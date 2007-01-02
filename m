Return-Path: <m.kozlowski@tuxland.pl>
Received: from tuxland.pl (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by ozlabs.org (Postfix) with ESMTP id 3A016DDE0C
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 22:37:14 +1100 (EST)
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: paulus@samba.org
Subject: [PATCH] ppc: vio of_node_put cleanup
Date: Tue, 2 Jan 2007 12:38:36 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200701021238.36297.m.kozlowski@tuxland.pl>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

	This patch removes redundant argument check for of_node_put().

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 arch/powerpc/kernel/vio.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff -upr linux-2.6.20-rc2-mm1-a/arch/powerpc/kernel/vio.c linux-2.6.20-rc2-mm1-b/arch/powerpc/kernel/vio.c
--- linux-2.6.20-rc2-mm1-a/arch/powerpc/kernel/vio.c	2006-12-24 05:00:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/arch/powerpc/kernel/vio.c	2007-01-02 01:55:31.000000000 +0100
@@ -199,10 +199,8 @@ EXPORT_SYMBOL(vio_unregister_driver);
 /* vio_dev refcount hit 0 */
 static void __devinit vio_dev_release(struct device *dev)
 {
-	if (dev->archdata.of_node) {
-		/* XXX should free TCE table */
-		of_node_put(dev->archdata.of_node);
-	}
+	/* XXX should free TCE table */
+	of_node_put(dev->archdata.of_node);
 	kfree(to_vio_dev(dev));
 }
 


-- 
Regards,

	Mariusz Kozlowski
