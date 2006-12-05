Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D13B867B92
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 15:54:19 +1100 (EST)
Date: Tue, 5 Dec 2006 15:54:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: [POWERPC] fix cell pmu initialisation
Message-Id: <20061205155414.4afdcc77.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make sure that the pmu is not initialised unless we are running on a cell.
Also make the init routine static.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/cell/pmu.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

After this patch, a combined kernel (including all the 64 bit platforms)
will boot on my Series P 285 (apart from a ata panic which may be
unrelated).

This should be safe for 2.6.20 (I think).
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/cell/pmu.c b/arch/powerpc/platforms/cell/pmu.c
index 99c6120..d04ae16 100644
--- a/arch/powerpc/platforms/cell/pmu.c
+++ b/arch/powerpc/platforms/cell/pmu.c
@@ -382,11 +382,14 @@ static irqreturn_t cbe_pm_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-int __init cbe_init_pm_irq(void)
+static int __init cbe_init_pm_irq(void)
 {
 	unsigned int irq;
 	int rc, node;
 
+	if (!machine_is(cell))
+		return 0;
+
 	for_each_node(node) {
 		irq = irq_create_mapping(NULL, IIC_IRQ_IOEX_PMI |
 					       (node << IIC_IRQ_NODE_SHIFT));
-- 
1.4.4.1
