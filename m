Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id D0575DDDFB
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 02:42:26 +1000 (EST)
Subject: [PATCH] When checking I8042 io port, use of_find_compatible_node()
	instead of of_find_node_by_type()
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: paulus@samba.org
Content-Type: text/plain
Date: Wed, 06 Jun 2007 09:42:25 -0700
Message-Id: <1181148145.5674.121.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In check_legacy_ioport(), instead of using of_find_node_by_type() to
find the 8042 node, use of_find_compatible_node() to find either the
keyboard or mouse node.

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

---

 arch/powerpc/kernel/setup-common.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: linux-2.6-powerpc-8641/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux-2.6-powerpc-8641.orig/arch/powerpc/kernel/setup-common.c
+++ linux-2.6-powerpc-8641/arch/powerpc/kernel/setup-common.c
@@ -517,7 +517,14 @@ int check_legacy_ioport(unsigned long ba
 
 	switch(base_port) {
 	case I8042_DATA_REG:
-		np = of_find_node_by_type(NULL, "8042");
+		np = of_find_compatible_node(NULL, NULL, "pnpPNP,303");
+		if (!np)
+			np = of_find_compatible_node(NULL, NULL, "pnpPNP,f03");
+		if (np) {
+			parent = of_get_parent(np);
+			of_node_put(np);
+			np = parent;
+		}
 		break;
 	case FDC_BASE: /* FDC1 */
 		np = of_find_node_by_type(NULL, "fdc");
