Return-Path: <curt@cumulusnetworks.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 34DA71A0376
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 05:46:47 +1100 (AEDT)
Received: by pabfh17 with SMTP id fh17so67049703pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 10:46:45 -0800 (PST)
From: Curt Brune <curt@cumulusnetworks.com>
To: galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com,
 pawel.moll@arm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, robh+dt@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org
Subject: [RFC 1/1] powerpc: legacy serial port use device tree cell-index
 property
Date: Wed, 25 Nov 2015 10:46:49 -0800
Message-Id: <1448477209-22340-2-git-send-email-curt@cumulusnetworks.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently for PowerPC systems using device tree, the legacy serial
ports are allocated in the order by which they are found in the device
tree structure.

This can cause problems in cases where the device tree nodes are
sysnthesized by an external program (kexec for example), which may not
preserve the original order of the device tree nodes.  This in turn
can result in the serial console changing from ttyS0 to ttyS1
unexpectedly.

This patch uses the 'cell-index' property (if present) to map UART
device tree nodes to legacy serial port number.  The cell-index
property is widely used in all the Freescale .dts files for PowerPC.

Signed-off-by: Curt Brune <curt@cumulusnetworks.com>
---
 arch/powerpc/kernel/legacy_serial.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 7b750c4..b717133 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -164,6 +164,8 @@ static int __init add_legacy_soc_port(struct device_node *np,
 	u64 addr;
 	const __be32 *addrp;
 	struct device_node *tsi = of_get_parent(np);
+	int index = -1, len;
+	u32 *indexp;
 
 	/* We only support ports that have a clock frequency properly
 	 * encoded in the device-tree.
@@ -188,14 +190,19 @@ static int __init add_legacy_soc_port(struct device_node *np,
 	if (addr == OF_BAD_ADDR)
 		return -1;
 
+	/* Check if the ports have an ordering, defined by 'cell-index' */
+	if (((indexp = (u32*)of_get_property(np, "cell-index", &len)) != NULL) &&
+	    (len == sizeof(u32)))
+		index = *indexp;
+
 	/* Add port, irq will be dealt with later. We passed a translated
 	 * IO port value. It will be fixed up later along with the irq
 	 */
 	if (tsi && !strcmp(tsi->type, "tsi-bridge"))
-		return add_legacy_port(np, -1, UPIO_TSI, addr, addr,
+		return add_legacy_port(np, index, UPIO_TSI, addr, addr,
 				       NO_IRQ, legacy_port_flags, 0);
 	else
-		return add_legacy_port(np, -1, UPIO_MEM, addr, addr,
+		return add_legacy_port(np, index, UPIO_MEM, addr, addr,
 				       NO_IRQ, legacy_port_flags, 0);
 }
 
-- 
1.9.1
