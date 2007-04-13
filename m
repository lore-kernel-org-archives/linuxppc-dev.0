Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 89064DDF61
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 17:14:10 +1000 (EST)
Date: Fri, 13 Apr 2007 17:14:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Rename last get_property calls
Message-Id: <20070413171422.c19353e2.sfr@canb.auug.org.au>
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

These got added recently.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/of_device.c     |    4 ++--
 arch/powerpc/platforms/52xx/efika.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

This is relative to the current powerpc for-2.6.22 tree.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/of_device.c b/arch/powerpc/kernel/of_device.c
index e8aa1f3..0c8ea76 100644
--- a/arch/powerpc/kernel/of_device.c
+++ b/arch/powerpc/kernel/of_device.c
@@ -132,7 +132,7 @@ static ssize_t of_device_get_modalias(struct of_device *ofdev,
 				ofdev->node->name, ofdev->node->type);
 
 	/* Get compatible property if any */
-	compat = get_property(ofdev->node, "compatible", &cplen);
+	compat = of_get_property(ofdev->node, "compatible", &cplen);
 	if (!compat)
 		return csize;
 
@@ -194,7 +194,7 @@ int of_device_uevent(struct device *dev,
          * it's not really legal to split it out with commas. We split it
          * up using a number of environment variables instead. */
 
-	compat = get_property(ofdev->node, "compatible", &cplen);
+	compat = of_get_property(ofdev->node, "compatible", &cplen);
 	while (compat && *compat && cplen > 0) {
 		if (add_uevent_var(envp, num_envp, &i,
 				   buffer, buffer_size, &length,
diff --git a/arch/powerpc/platforms/52xx/efika.c b/arch/powerpc/platforms/52xx/efika.c
index 0420084..0eceb1f 100644
--- a/arch/powerpc/platforms/52xx/efika.c
+++ b/arch/powerpc/platforms/52xx/efika.c
@@ -232,12 +232,12 @@ static void __init efika_init_early(void)
 	/* find the boot console from /chosen/stdout */
 	if (!of_chosen)
 		return;
-	device_type = get_property(of_chosen, "linux,stdout-path", NULL);
+	device_type = of_get_property(of_chosen, "linux,stdout-path", NULL);
 	if (!device_type)
 		return;
 	stdout_node = of_find_node_by_path(device_type);
 	if (stdout_node) {
-		device_type = get_property(stdout_node, "device_type", NULL);
+		device_type = of_get_property(stdout_node, "device_type", NULL);
 		if (device_type && strcmp(device_type, "serial") == 0)
 			add_preferred_console("ttyPSC", 0, NULL);
 		of_node_put(stdout_node);
-- 
1.5.1.1
