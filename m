Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 28671DDDEF
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 15:21:51 +1100 (EST)
Date: Fri, 21 Dec 2007 15:21:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] constify the of_device_id passed to
	of_platform_bus_probe
Message-Id: <20071221152151.52ca72ff.sfr@canb.auug.org.au>
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

This will allow us to declare const all the statically declared arrrays
of these.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/of_platform.c |    8 ++++----
 include/asm-powerpc/of_platform.h |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index 79c04d1..de36e23 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -40,7 +40,7 @@
  * a bus type in the list
  */
 
-static struct of_device_id of_default_bus_ids[] = {
+static const struct of_device_id of_default_bus_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "spider", },
@@ -100,8 +100,8 @@ EXPORT_SYMBOL(of_platform_device_create);
  * @matches: match table, NULL to use the default, OF_NO_DEEP_PROBE to
  * disallow recursive creation of child busses
  */
-static int of_platform_bus_create(struct device_node *bus,
-				  struct of_device_id *matches,
+static int of_platform_bus_create(const struct device_node *bus,
+				  const struct of_device_id *matches,
 				  struct device *parent)
 {
 	struct device_node *child;
@@ -137,7 +137,7 @@ static int of_platform_bus_create(struct device_node *bus,
  */
 
 int of_platform_bus_probe(struct device_node *root,
-			  struct of_device_id *matches,
+			  const struct of_device_id *matches,
 			  struct device *parent)
 {
 	struct device_node *child;
diff --git a/include/asm-powerpc/of_platform.h b/include/asm-powerpc/of_platform.h
index d20a4cd..1bce5ef 100644
--- a/include/asm-powerpc/of_platform.h
+++ b/include/asm-powerpc/of_platform.h
@@ -32,7 +32,7 @@ extern struct of_device *of_platform_device_create(struct device_node *np,
 #define OF_NO_DEEP_PROBE ((struct of_device_id *)-1)
 
 extern int of_platform_bus_probe(struct device_node *root,
-				 struct of_device_id *matches,
+				 const struct of_device_id *matches,
 				 struct device *parent);
 
 extern struct of_device *of_find_device_by_phandle(phandle ph);
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
