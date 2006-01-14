Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17352.29004.496555.416396@cargo.ozlabs.ibm.com>
Date: Sat, 14 Jan 2006 14:34:36 +1100
From: Paul Mackerras <paulus@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Recognize /chaos bridge on old pmacs as PCI
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The first generation of PCI powermacs had a host bridge called /chaos
which was for all intents and purposes a PCI host bridge, but has a
device_type of "vci" in the device tree (presumably it's not really
PCI at the hardware level or something).

The OF parsing stuff in arch/powerpc/kernel/prom_parse.c currently
doesn't recognize it as a PCI bridge, which means that controlfb.c
can't get its device addresses.

This makes prom_parse.c recognize a device_type of "vci" as indicating
a PCI host bridge.  With this, controlfb works again.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 309ae1d..a8099c8 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -113,7 +113,8 @@ static unsigned int of_bus_default_get_f
 
 static int of_bus_pci_match(struct device_node *np)
 {
-	return !strcmp(np->type, "pci");
+	/* "vci" is for the /chaos bridge on 1st-gen PCI powermacs */
+	return !strcmp(np->type, "pci") || !strcmp(np->type, "vci");
 }
 
 static void of_bus_pci_count_cells(struct device_node *np,
