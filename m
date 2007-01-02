Return-Path: <m.kozlowski@tuxland.pl>
Received: from tuxland.pl (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by ozlabs.org (Postfix) with ESMTP id 0355CDDEEB
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 22:48:58 +1100 (EST)
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: paulus@samba.org
Subject: [PATCH] ppc: ipic of_node_get cleanup
Date: Tue, 2 Jan 2007 12:50:20 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200701021250.20259.m.kozlowski@tuxland.pl>
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

 arch/powerpc/sysdev/ipic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -upr linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/ipic.c linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/ipic.c
--- linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/ipic.c	2006-12-24 05:00:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/ipic.c	2007-01-02 02:03:23.000000000 +0100
@@ -569,7 +569,7 @@ void __init ipic_init(struct device_node
 		return;
 
 	memset(ipic, 0, sizeof(struct ipic));
-	ipic->of_node = node ? of_node_get(node) : NULL;
+	ipic->of_node = of_node_get(node);
 
 	ipic->irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR,
 				       NR_IPIC_INTS,


-- 
Regards,

	Mariusz Kozlowski
