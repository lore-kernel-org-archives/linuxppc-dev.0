Return-Path: <grant@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 5CC58DDF0B
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 14:20:33 +1100 (EST)
Received: from pd2mr1so.prod.shaw.ca
	(pd2mr1so-qfe3.prod.shaw.ca [10.0.141.110]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JY400E9J3Y6LN00@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 21 Mar 2008 21:20:30 -0600 (MDT)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
	by pd2mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JY40034T3Y6TN00@pd2mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 21 Mar 2008 21:20:30 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep 5
	2006))
	with ESMTP id <0JY4000083Y5UK20@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 21 Mar 2008 21:20:30 -0600 (MDT)
Date: Fri, 21 Mar 2008 21:20:29 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [POWERPC] mpc5200-fec: Fix possible NULL dereference in mdio
	driver
In-reply-to: <>
To: linux-kernel@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org
Message-id: <1206156029-2761-1-git-send-email-grant.likely@secretlab.ca>
References: <>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If the reg property is missing from the phy node (unlikely, but possible),
then the kernel will oops with a NULL pointer dereference.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
This one is a bugfix that should go in for 2.6.25.  Paul, can you please
pick it up?

Thanks,
g.

 drivers/net/fec_mpc52xx_phy.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/net/fec_mpc52xx_phy.c b/drivers/net/fec_mpc52xx_phy.c
index 1837584..6a3ac4e 100644
--- a/drivers/net/fec_mpc52xx_phy.c
+++ b/drivers/net/fec_mpc52xx_phy.c
@@ -109,7 +109,8 @@ static int mpc52xx_fec_mdio_probe(struct of_device *of, const struct of_device_i
 		int irq = irq_of_parse_and_map(child, 0);
 		if (irq != NO_IRQ) {
 			const u32 *id = of_get_property(child, "reg", NULL);
-			bus->irq[*id] = irq;
+			if (id)
+				bus->irq[*id] = irq;
 		}
 	}
 
-- 
1.5.4.3
