Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <e98a6867610f2057886d144b4ed42228384d9bfa.1211767956.git.michael@ellerman.id.au>
In-Reply-To: <097e3536dc91bd2d1383f34f5ae4b61b8ac41d61.1211767956.git.michael@ellerman.id.au>
References: <097e3536dc91bd2d1383f34f5ae4b61b8ac41d61.1211767956.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/4] Rework ipic_init() so we can avoid freeing the irq_host
Date: Mon, 26 May 2008 12:12:30 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If we do the call to of_address_to_resource() first, then we don't
need to worry about freeing the irq_host (which the code doesn't do
currently anyway).

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/sysdev/ipic.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 0f2dfb0..f95d10b 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -725,6 +725,10 @@ struct ipic * __init ipic_init(struct device_node *node, unsigned int flags)
 	struct resource res;
 	u32 temp = 0, ret;
 
+	ret = of_address_to_resource(node, 0, &res);
+	if (ret)
+		return NULL;
+
 	ipic = alloc_bootmem(sizeof(struct ipic));
 	if (ipic == NULL)
 		return NULL;
@@ -739,12 +743,6 @@ struct ipic * __init ipic_init(struct device_node *node, unsigned int flags)
 		return NULL;
 	}
 
-	ret = of_address_to_resource(node, 0, &res);
-	if (ret) {
-		of_node_put(node);
-		return NULL;
-	}
-
 	ipic->regs = ioremap(res.start, res.end - res.start + 1);
 
 	ipic->irqhost->host_data = ipic;
-- 
1.5.5
