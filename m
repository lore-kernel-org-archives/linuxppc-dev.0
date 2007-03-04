Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 9CED2DDFE5
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Mar 2007 17:07:52 +1100 (EST)
Date: Sun, 4 Mar 2007 17:03:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 3/6] [POWERPC] make iSeries build without CONFIG_PCI
Message-Id: <20070304170348.511af7cb.sfr@canb.auug.org.au>
In-Reply-To: <20070304170241.816f9802.sfr@canb.auug.org.au>
References: <20070304165839.4d2bf50b.sfr@canb.auug.org.au>
	<20070304170241.816f9802.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/irq.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/irq.c b/arch/powerpc/platforms/iseries/irq.c
index 5225abf..9f9972b 100644
--- a/arch/powerpc/platforms/iseries/irq.c
+++ b/arch/powerpc/platforms/iseries/irq.c
@@ -337,6 +337,8 @@ unsigned int iSeries_get_irq(void)
 	return irq;
 }
 
+#ifdef CONFIG_PCI
+
 static int iseries_irq_host_map(struct irq_host *h, unsigned int virq,
 				irq_hw_number_t hw)
 {
@@ -384,3 +386,4 @@ void __init iSeries_init_IRQ(void)
 				"failed with rc 0x%x\n", ret);
 }
 
+#endif	/* CONFIG_PCI */
-- 
1.5.0.1
