Return-Path: <m.kozlowski@tuxland.pl>
Received: from tuxland.pl (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by ozlabs.org (Postfix) with ESMTP id 83266DDE26
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 22:34:58 +1100 (EST)
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: paulus@samba.org
Subject: [PATCH] ppc: cpm2_pic of_node_get cleanup
Date: Tue, 2 Jan 2007 12:36:20 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200701021236.20697.m.kozlowski@tuxland.pl>
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

	This patch removes redundant argument check for of_node_get().

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 arch/powerpc/sysdev/cpm2_pic.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff -upr linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/cpm2_pic.c linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/cpm2_pic.c
--- linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/cpm2_pic.c	2006-12-24 05:00:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/cpm2_pic.c	2007-01-02 02:04:25.000000000 +0100
@@ -245,9 +245,7 @@ void cpm2_pic_init(struct device_node *n
 	cpm2_intctl->ic_scprrl = 0x05309770;
 
 	/* create a legacy host */
-	if (node)
-		cpm2_pic_node = of_node_get(node);
-
+	cpm2_pic_node = of_node_get(node);
 	cpm2_pic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, 64, &cpm2_pic_host_ops, 64);
 	if (cpm2_pic_host == NULL) {
 		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");


-- 
Regards,

	Mariusz Kozlowski
