Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <7ff23fa2e45df19597a9ad77cbfec83d127a08b4.1211767956.git.michael@ellerman.id.au>
In-Reply-To: <097e3536dc91bd2d1383f34f5ae4b61b8ac41d61.1211767956.git.michael@ellerman.id.au>
References: <097e3536dc91bd2d1383f34f5ae4b61b8ac41d61.1211767956.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/4] Rework qe_ic_init() so we can avoid freeing the irq_host
Date: Mon, 26 May 2008 12:12:31 +1000 (EST)
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
 arch/powerpc/sysdev/qe_lib/qe_ic.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index f59444d..c11b313 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -329,6 +329,10 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
 	struct resource res;
 	u32 temp = 0, ret, high_active = 0;
 
+	ret = of_address_to_resource(node, 0, &res);
+	if (ret)
+		return;
+
 	qe_ic = alloc_bootmem(sizeof(struct qe_ic));
 	if (qe_ic == NULL)
 		return;
@@ -342,10 +346,6 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
 		return;
 	}
 
-	ret = of_address_to_resource(node, 0, &res);
-	if (ret)
-		return;
-
 	qe_ic->regs = ioremap(res.start, res.end - res.start + 1);
 
 	qe_ic->irqhost->host_data = qe_ic;
-- 
1.5.5
