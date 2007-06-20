Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 771DADDED9
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2007 10:15:12 +1000 (EST)
Subject: [PATCH] Add a check for keyboard/mouse device nodes in
	check_legacy_ioport()
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: paulus@samba.org
Content-Type: text/plain
Date: Tue, 19 Jun 2007 17:15:10 -0700
Message-Id: <1182298510.5674.357.camel@rhino>
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

The device tree for the MPC8641 HPCN does not implement the device type
property for I8042 nodes.

In addition to checking the I8042 node's device type, also match the
keyboard and/or mouse nodes' compatible property.

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

---

The previous version of this patch also removed the device type test.
This version keeps the test, per Segher's comments.

 arch/powerpc/kernel/setup-common.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-2.6-powerpc-8641/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux-2.6-powerpc-8641.orig/arch/powerpc/kernel/setup-common.c
+++ linux-2.6-powerpc-8641/arch/powerpc/kernel/setup-common.c
@@ -486,6 +486,14 @@ int check_legacy_ioport(unsigned long ba
 
 	switch(base_port) {
 	case I8042_DATA_REG:
+		if (!(np = of_find_compatible_node(NULL, NULL, "pnpPNP,303")))
+			np = of_find_compatible_node(NULL, NULL, "pnpPNP,f03");
+		if (np) {
+			parent = of_get_parent(np);
+			of_node_put(np);
+			np = parent;
+			break;
+		}
 		np = of_find_node_by_type(NULL, "8042");
 		break;
 	case FDC_BASE: /* FDC1 */
