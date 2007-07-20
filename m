Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84271DDF07
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 15:58:44 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] of_detach_node()'s device node argument cannot be const
Date: Fri, 20 Jul 2007 07:58:38 +0200
Message-Id: <11849111183072-git-send-email-segher@kernel.crashing.org>
Message-Id: <79c56e775e50c9532c605f67fbe75f3f6c43b08b.1184910625.git.segher@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

...since it modifies it (when it sets the OF_DETACHED flag).

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 arch/powerpc/kernel/prom.c |    2 +-
 include/asm-powerpc/prom.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
-- 
1.5.2.1.144.gabc40-dirty
