Return-Path: <christophe.jaillet@wanadoo.fr>
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr
 [80.12.242.128])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 306E11A065D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 07:27:45 +1100 (AEDT)
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] powerpc/mpc5xxx: Use of_get_next_parent to simplify code
Date: Sun, 11 Oct 2015 22:27:40 +0200
Message-Id: <1444595260-3332-1-git-send-email-christophe.jaillet@wanadoo.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

of_get_next_parent can be used to simplify the while() loop and
avoid the need of a temp variable.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/powerpc/sysdev/mpc5xxx_clocks.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/mpc5xxx_clocks.c b/arch/powerpc/sysdev/mpc5xxx_clocks.c
index f4f0301..5732926 100644
--- a/arch/powerpc/sysdev/mpc5xxx_clocks.c
+++ b/arch/powerpc/sysdev/mpc5xxx_clocks.c
@@ -13,7 +13,6 @@
 
 unsigned long mpc5xxx_get_bus_frequency(struct device_node *node)
 {
-	struct device_node *np;
 	const unsigned int *p_bus_freq = NULL;
 
 	of_node_get(node);
@@ -22,9 +21,7 @@ unsigned long mpc5xxx_get_bus_frequency(struct device_node *node)
 		if (p_bus_freq)
 			break;
 
-		np = of_get_parent(node);
-		of_node_put(node);
-		node = np;
+		node = of_get_next_parent(node);
 	}
 	of_node_put(node);
 
-- 
2.1.4
