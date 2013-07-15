Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E491C2C0219
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 13:03:36 +1000 (EST)
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r6F33KdL013377
 for <linuxppc-dev@ozlabs.org>; Sun, 14 Jul 2013 22:03:33 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/8] powerpc: Check "status" property before adding legacy ISA
 serial ports
Date: Mon, 15 Jul 2013 13:03:13 +1000
Message-Id: <1373857395-2084-6-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1373857395-2084-1-git-send-email-benh@kernel.crashing.org>
References: <1373857395-2084-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/legacy_serial.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 5cf11b0..6f2a15c 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -386,9 +386,11 @@ void __init find_legacy_serial_ports(void)
 		struct device_node *isa = of_get_parent(np);
 		if (isa && (!strcmp(isa->name, "isa") ||
 			    !strcmp(isa->name, "lpc"))) {
-			index = add_legacy_isa_port(np, isa);
-			if (index >= 0 && np == stdout)
-				legacy_serial_console = index;
+			if (of_device_is_available(np)) {
+				index = add_legacy_isa_port(np, isa);
+				if (index >= 0 && np == stdout)
+					legacy_serial_console = index;
+			}
 		}
 		of_node_put(isa);
 	}
-- 
1.8.1.2
