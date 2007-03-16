Return-Path: <wei.zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id F1207DDEF2
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 15:33:17 +1100 (EST)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org, benh@kernel.crashing.org, galak@kernel.crashing.org
Subject: [PATCH 3/4] Add mpic host name.
Date: Fri, 16 Mar 2007 12:38:34 +0800
Message-Id: <11740199154116-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <11740199152595-git-send-email-wei.zhang@freescale.com>
References: <11740199151814-git-send-email-wei.zhang@freescale.com>
	<11740199152595-git-send-email-wei.zhang@freescale.com>
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

This patch adds mpic controller host name by the mpic of_node's full_name.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
---
 arch/powerpc/sysdev/mpic.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index bcfb900..4e1581e 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -926,7 +926,8 @@ struct mpic * __init mpic_alloc(struct d
 
 	mpic->irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR, isu_size,
 				       &mpic_host_ops,
-				       flags & MPIC_LARGE_VECTORS ? 2048 : 256);
+				       flags & MPIC_LARGE_VECTORS ? 2048 : 256,
+				       mpic->of_node->full_name);
 	if (mpic->irqhost == NULL) {
 		of_node_put(node);
 		return NULL;
-- 
1.4.0
