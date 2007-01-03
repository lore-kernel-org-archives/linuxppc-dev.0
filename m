Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 4C8A9DDED7
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jan 2007 05:56:38 +1100 (EST)
Date: Wed, 3 Jan 2007 12:56:28 -0600
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] maple: improve CPC9x5 host bridge detection
Message-ID: <20070103185628.GE6279@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Identify CPC9x5 PCI Express, AGP, and HT host bridges using
device_type and compatible properties, which is a more flexible method
than using the name property (which can differ between firmwares and
models).

Signed-off-by: Nathan Lynch <ntl@pobox.com>

---
 arch/powerpc/platforms/maple/pci.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index 3f6a69f..011f0f1 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -560,13 +560,16 @@ void __init maple_pci_init(void)
 		return;
 	}
 	for (np = NULL; (np = of_get_next_child(root, np)) != NULL;) {
-		if (np->name == NULL)
+		if (!np->type)
 			continue;
-		if (!strcmp(np->name, "pci") || !strcmp(np->name, "pcie")) {
-			if (add_bridge(np) == 0)
-				of_node_get(np);
-		}
-		if (strcmp(np->name, "ht") == 0) {
+		if (strcmp(np->type, "pci") && strcmp(np->type, "ht"))
+			continue;
+		if ((device_is_compatible(np, "u4-pcie") ||
+		     device_is_compatible(np, "u3-agp")) &&
+		    add_bridge(np) == 0)
+			of_node_get(np);
+
+		if (device_is_compatible(np, "u3-ht")) {
 			of_node_get(np);
 			ht = np;
 		}
-- 
1.4.1
