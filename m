Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CA530DDE04
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 16:21:27 +1000 (EST)
Date: Thu, 12 Jul 2007 16:21:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] of_detach_node now modifies its argument
Message-Id: <20070712162124.f0125b49.sfr@canb.auug.org.au>
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

Commit 6a281856c02d2291df2f7d9df5bfdee2e7bdd747 modified of_detach_node
so that it now sets a flag in the passed device_node.  Remove the const
from the parameter to get rid of this warning:

arch/powerpc/kernel/prom.c: In function 'of_detach_node':
arch/powerpc/kernel/prom.c:1468: warning: passing argument 1 of 'of_node_set_flag' discards qualifiers from pointer target type

The only caller was already passing a non-const device_node.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/prom.c |    2 +-
 include/asm-powerpc/prom.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Paul, another for 2.6.23.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 37ff99b..67a1bda 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1433,7 +1433,7 @@ void of_attach_node(struct device_node *np)
  * a reference to the node.  The memory associated with the node
  * is not freed until its refcount goes to zero.
  */
-void of_detach_node(const struct device_node *np)
+void of_detach_node(struct device_node *np)
 {
 	struct device_node *parent;
 
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 1632baa..1bba741 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -160,7 +160,7 @@ extern unsigned long __init of_get_flat_dt_root(void);
 
 /* For updating the device tree at runtime */
 extern void of_attach_node(struct device_node *);
-extern void of_detach_node(const struct device_node *);
+extern void of_detach_node(struct device_node *);
 
 /* Other Prototypes */
 extern void finish_device_tree(void);
