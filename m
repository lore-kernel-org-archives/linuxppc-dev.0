Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id AA8F8DDE20
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 03:32:33 +1100 (EST)
Received: from pd2mr5so.prod.shaw.ca (pd2mr5so-qfe3.prod.shaw.ca [10.0.141.8])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JUD00CTCXY57HD0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 09 Jan 2008 09:32:29 -0700 (MST)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
	by pd2mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JUD00GHFXY3YK20@pd2mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 09 Jan 2008 09:32:30 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JUD00K7MXY2HS50@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 09 Jan 2008 09:32:26 -0700 (MST)
Date: Wed, 09 Jan 2008 09:32:19 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC] add phy-handle property for fec_mpc52xx
To: olaf@aepfle.de, linuxppc-dev@ozlabs.org, matt@genesi-usa.com,
	sven@genesi-usa.com
Message-id: <20080109163058.21643.30876.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Olaf Hering <olaf@aepfle.de>

The new network driver fec_mpc52xx will not work on efika because the
firmware does not provide all required properties.
http://www.powerdeveloper.org/asset/by-id/46 has a Forth script to
create more properties. But only the phy stuff is required to get a
working network.

This should go into the kernel because its appearently
impossible to boot the script via tftp and then load the real boot
binary (yaboot or zimage).

(Olaf's s-o-b line needs to go here)
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Here's my respin of Olaf's patch to move it to fixup_device_tree_efika()
and to make it check if the nodes exist before blindly creating them.

Cheers,
g.

 arch/powerpc/kernel/prom_init.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 1add6ef..5d89a21 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2216,6 +2216,45 @@ static void __init fixup_device_tree_efika(void)
 			prom_printf("fixup_device_tree_efika: ",
 				"skipped entry %x - setprop error\n", i);
 	}
+
+	/* Make sure ethernet mdio bus node exists */
+	node = call_prom("finddevice", 1, 1, ADDR("/builtin/mdio"));
+	if (!PHANDLE_VALID(node)) {
+		prom_printf("Adding Ethernet MDIO node\n");
+		call_prom("interpret", 1, 1,
+			" s\" /builtin\" find-device"
+			" new-device"
+				" 1 encode-int s\" #address-cells\" property"
+				" 0 encode-int s\" #size-cells\" property"
+				" s\" mdio\" 2dup device-name device-type"
+				" s\" mpc5200b-fec-phy\" encode-string"
+				" s\" compatible\" property"
+				" 0xf0003000 0x400 reg"
+				" 0x2 encode-int"
+				" 0x5 encode-int encode+"
+				" 0x3 encode-int encode+"
+				" s\" interrupts\" property"
+			" finish-device");
+	};
+
+	/* Make sure ethernet phy device node exist */
+	node = call_prom("finddevice", 1, 1, ADDR("/builtin/mdio/ethernet-phy"));
+	if (!PHANDLE_VALID(node)) {
+		prom_printf("Adding Ethernet PHY node\n");
+		call_prom("interpret", 1, 1,
+			" s\" /builtin/mdio\" find-device"
+			" new-device"
+				" s\" ethernet-phy\" device-name"
+				" 0x10 encode-int s\" reg\" property"
+				" my-self"
+				" ihandle>phandle"
+			" finish-device"
+			" s\" /builtin/ethernet\" find-device"
+				" encode-int"
+				" s\" phy-handle\" property"
+			" device-end");
+	}
+
 }
 #else
 #define fixup_device_tree_efika()
