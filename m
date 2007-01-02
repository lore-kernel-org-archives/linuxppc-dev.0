Return-Path: <m.kozlowski@tuxland.pl>
Received: from tuxland.pl (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by ozlabs.org (Postfix) with ESMTP id F0BD6DDF0B
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 22:51:24 +1100 (EST)
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: paulus@samba.org
Subject: [PATCH] ppc: mpic of_node_get cleanup
Date: Tue, 2 Jan 2007 12:52:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200701021252.47425.m.kozlowski@tuxland.pl>
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

	No need for ?: because of_node_get() can handle NULL argument.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 arch/powerpc/sysdev/mpic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -upr linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/mpic.c linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/mpic.c
--- linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/mpic.c	2006-12-24 05:00:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/mpic.c	2007-01-02 02:02:54.000000000 +0100
@@ -912,7 +912,7 @@ struct mpic * __init mpic_alloc(struct d
 	
 	memset(mpic, 0, sizeof(struct mpic));
 	mpic->name = name;
-	mpic->of_node = node ? of_node_get(node) : NULL;
+	mpic->of_node = of_node_get(node);
 
 	mpic->irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR, 256,
 				       &mpic_host_ops,


-- 
Regards,

	Mariusz Kozlowski
