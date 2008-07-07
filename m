Return-Path: <benh@ozlabs.org>
To: Linus Torvalds <torvalds@osdl.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 07 Jul 2008 16:39:50 +1000
Subject: [PATCH] powerpc: Fix unterminated of_device_id array in
	legacy_serial.c
Message-Id: <20080707063956.4D8F2DDDF9@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A recent patch to legacy_serial.c factored out some code by
using the of_match_node() facility to match a node against
an array of possible matches. However, the patch didn't properly
terminate the array causing potential crashes in cases where no
match is found. In addition, the name of the array was poorly
chosen for a static symbol making debugging harder.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Linus, any chance you can still stick that in .26 ?
 
 arch/powerpc/kernel/legacy_serial.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/legacy_serial.c	2008-07-07 16:34:05.000000000 +1000
+++ linux-work/arch/powerpc/kernel/legacy_serial.c	2008-07-07 16:36:06.000000000 +1000
@@ -33,13 +33,14 @@ static struct legacy_serial_info {
 	phys_addr_t			taddr;
 } legacy_serial_infos[MAX_LEGACY_SERIAL_PORTS];
 
-static struct __initdata of_device_id parents[] = {
+static struct __initdata of_device_id legacy_serial_parents[] = {
 	{.type = "soc",},
 	{.type = "tsi-bridge",},
 	{.type = "opb", },
 	{.compatible = "ibm,opb",},
 	{.compatible = "simple-bus",},
 	{.compatible = "wrs,epld-localbus",},
+	{},
 };
 
 static unsigned int legacy_serial_count;
@@ -322,7 +323,7 @@ void __init find_legacy_serial_ports(voi
 		struct device_node *parent = of_get_parent(np);
 		if (!parent)
 			continue;
-		if (of_match_node(parents, parent) != NULL) {
+		if (of_match_node(legacy_serial_parents, parent) != NULL) {
 			index = add_legacy_soc_port(np, np);
 			if (index >= 0 && np == stdout)
 				legacy_serial_console = index;
