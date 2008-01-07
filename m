Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 4D4ADDDEBE
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 01:25:35 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/7] powerpc: allow localbus compatible serial ports for
	console device
Date: Mon,  7 Jan 2008 09:25:27 -0500
Message-Id: <11997159342128-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <11997159331132-git-send-email-paul.gortmaker@windriver.com>
References: <11997159321859-git-send-email-paul.gortmaker@windriver.com>
	<11997159331132-git-send-email-paul.gortmaker@windriver.com>
Message-Id: <f6302303b90b7e1516a1f61d85f1eafd51ec3b51.1199715362.git.paul.gortmaker@windriver.com>
In-Reply-To: <ef7d84e06c45289f51f35845ccaa63bbf31827db.1199715362.git.paul.gortmaker@windriver.com>
References: <ef7d84e06c45289f51f35845ccaa63bbf31827db.1199715362.git.paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add to legacy_serial the ability to use any ns16550 compatible
UART with a parent that is compatible with "localbus" as the
console device.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/kernel/legacy_serial.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index a17a5d0..d0b8e35 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -351,6 +351,17 @@ void __init find_legacy_serial_ports(void)
 		of_node_put(opb);
 	}
 
+	/* Next, fill our array with any localbus serial ports */
+	for_each_compatible_node(np, "serial", "ns16550") {
+		struct device_node *lbs = of_get_parent(np);
+		if (lbs && of_device_is_compatible(lbs, "localbus")) {
+			index = add_legacy_soc_port(np, np);
+			if (index >= 0 && np == stdout)
+				legacy_serial_console = index;
+		}
+		of_node_put(lbs);
+	}
+
 #ifdef CONFIG_PCI
 	/* Next, try to locate PCI ports */
 	for (np = NULL; (np = of_find_all_nodes(np));) {
-- 
1.5.0.rc1.gf4b6c
