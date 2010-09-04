Return-Path: <julia@diku.dk>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 03015B7151
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Sep 2010 20:12:07 +1000 (EST)
From: Julia Lawall <julia@diku.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/2] arch/powerpc/kernel/irq.c: Add of_node_put to avoid
	memory leak
Date: Sat,  4 Sep 2010 12:12:44 +0200
Message-Id: <1283595164-29146-2-git-send-email-julia@diku.dk>
Cc: Paul Mackerras <paulus@samba.org>, kernel-janitors@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In this case, a device_node structure is stored in another structure that
is then freed without first decrementing the reference count of the
device_node structure.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r exists@
expression x;
identifier f;
position p1,p2;
@@

x@p1->f = \(of_find_node_by_path\|of_find_node_by_name\|of_find_node_by_phandle\|of_get_parent\|of_get_next_parent\|of_get_next_child\|of_find_compatible_node\|of_match_node\|of_find_node_by_type\|of_find_node_with_property\|of_find_matching_node\|of_parse_phandle\|of_node_get\)(...);
... when != of_node_put(x)
kfree@p2(x)

@script:python@
p1 << r.p1;
p2 << r.p2;
@@
cocci.print_main("call",p1)
cocci.print_secs("free",p2)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/powerpc/kernel/irq.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 4a65386..0a5bbe5 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -587,8 +587,10 @@ struct irq_host *irq_alloc_host(struct device_node *of_node,
 			 * this will be fixed once slab is made available early
 			 * instead of the current cruft
 			 */
-			if (mem_init_done)
+			if (mem_init_done) {
+				of_node_put(host->of_node);
 				kfree(host);
+			}
 			return NULL;
 		}
 		irq_map[0].host = host;
