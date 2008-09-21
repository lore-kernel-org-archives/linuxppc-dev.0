Return-Path: <julia@diku.dk>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9C6D3DDE04
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Sep 2008 21:20:35 +1000 (EST)
Date: Sun, 21 Sep 2008 13:01:31 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: paulus@samba.org, benh@kernel.crashing.org,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] arch/powerpc/platforms/powermac/pic.c: move of_node_put
Message-ID: <Pine.LNX.4.64.0809211301030.7450@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

It seems better to dereference master before decrementing the reference
count rather than afterwards.

The problem was found using the following semantic match:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@r exists@
expression n,E;
identifier fld;
iterator I;
statement S;
@@

* of_node_put(n)
... when != n = E
    when != I(n,...) S
* n->fld
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---

 arch/powerpc/platforms/powermac/pic.c          |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 6d149ae..d17aa2b 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -395,10 +395,10 @@ static void __init pmac_pic_probe_oldstyle(void)
 	if (max_real_irqs > 32)
 		pmac_irq_hw[i++] = (volatile struct pmac_irq_hw __iomem *)
 			(addr + 0x10);
-	of_node_put(master);
 
 	printk(KERN_INFO "irq: Found primary Apple PIC %s for %d irqs\n",
 	       master->full_name, max_real_irqs);
+	of_node_put(master);
 
 	/* Map interrupts of cascaded controller */
 	if (slave && !of_address_to_resource(slave, 0, &r)) {
