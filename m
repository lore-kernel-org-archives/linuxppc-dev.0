Return-Path: <wei.zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 3D782DDEF5
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 15:33:17 +1100 (EST)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org, benh@kernel.crashing.org, galak@kernel.crashing.org
Subject: [PATCH 2/4] Add i8259 host name.
Date: Fri, 16 Mar 2007 12:38:33 +0800
Message-Id: <11740199152595-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <11740199151814-git-send-email-wei.zhang@freescale.com>
References: <11740199151814-git-send-email-wei.zhang@freescale.com>
Sender: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, r54964@freescale.com
Reply-To: Zhang Wei <wei.zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds i8259 irq controller host name by the i8259 of_node's full name.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
---
 arch/powerpc/sysdev/i8259.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index ad87adc..e80c127 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -278,7 +278,8 @@ void i8259_init(struct device_node *node
 	/* create a legacy host */
 	if (node)
 		i8259_node = of_node_get(node);
-	i8259_host = irq_alloc_host(IRQ_HOST_MAP_LEGACY, 0, &i8259_host_ops, 0);
+	i8259_host = irq_alloc_host(IRQ_HOST_MAP_LEGACY, 0, &i8259_host_ops, 0,
+			(node) ? i8259_node->full_name : NULL);
 	if (i8259_host == NULL) {
 		printk(KERN_ERR "i8259: failed to allocate irq host !\n");
 		return;
-- 
1.4.0
