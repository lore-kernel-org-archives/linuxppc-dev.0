Return-Path: <m.kozlowski@tuxland.pl>
Received: from tuxland.pl (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by ozlabs.org (Postfix) with ESMTP id 28FE1DDF2C
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 23:05:54 +1100 (EST)
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: paulus@samba.org
Subject: [PATCH] ppc: qe_lib of_node_get cleanup
Date: Tue, 2 Jan 2007 13:07:16 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200701021307.16467.m.kozlowski@tuxland.pl>
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

	No need for ?: as of_node_get() can handle NULL argument.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 arch/powerpc/sysdev/qe_lib/qe_ic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -upr linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/qe_lib/qe_ic.c linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/qe_lib/qe_ic.c
--- linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/qe_lib/qe_ic.c	2006-12-24 05:00:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/qe_lib/qe_ic.c	2007-01-02 02:02:29.000000000 +0100
@@ -352,7 +352,7 @@ void __init qe_ic_init(struct device_nod
 		return;
 
 	memset(qe_ic, 0, sizeof(struct qe_ic));
-	qe_ic->of_node = node ? of_node_get(node) : NULL;
+	qe_ic->of_node = of_node_get(node);
 
 	qe_ic->irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR,
 					NR_QE_IC_INTS, &qe_ic_host_ops, 0);


-- 
Regards,

	Mariusz Kozlowski
