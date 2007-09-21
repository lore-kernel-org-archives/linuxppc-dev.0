Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id EF613DDE3B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 14:41:08 +1000 (EST)
Date: Fri, 21 Sep 2007 14:29:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 01/11] [POWERPC] Remove debug printk from vio_bus_init
Message-Id: <20070921142928.64451ad8.sfr@canb.auug.org.au>
In-Reply-To: <20070921135533.461eecdf.sfr@canb.auug.org.au>
References: <20070921135533.461eecdf.sfr@canb.auug.org.au>
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

As it just adds noise to the boot messages.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/vio.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 62c1bc1..54645ba 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -317,11 +317,8 @@ static int __init vio_bus_init(void)
 		 * the device tree. Drivers will associate with them later.
 		 */
 		for (of_node = node_vroot->child; of_node != NULL;
-				of_node = of_node->sibling) {
-			printk(KERN_DEBUG "%s: processing %p\n",
-					__FUNCTION__, of_node);
+				of_node = of_node->sibling)
 			vio_register_device_node(of_node);
-		}
 		of_node_put(node_vroot);
 	}
 
-- 
1.5.3.2
