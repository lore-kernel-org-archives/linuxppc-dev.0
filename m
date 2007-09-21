Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5D0C7DDEA2
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 14:41:10 +1000 (EST)
Date: Fri, 21 Sep 2007 14:32:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 03/11] [POWERPC] Make vio_bus_type static
Message-Id: <20070921143205.64271521.sfr@canb.auug.org.au>
In-Reply-To: <20070921143102.eb30d770.sfr@canb.auug.org.au>
References: <20070921135533.461eecdf.sfr@canb.auug.org.au>
	<20070921142928.64451ad8.sfr@canb.auug.org.au>
	<20070921143102.eb30d770.sfr@canb.auug.org.au>
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


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/vio.c |    4 +++-
 include/asm-powerpc/vio.h |    1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index ee15c22..1d7b272 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -39,6 +39,8 @@
 
 extern struct kset devices_subsys; /* needed for vio_find_name() */
 
+static struct bus_type vio_bus_type;
+
 static struct vio_dev vio_bus_device  = { /* fake "parent" device */
 	.name = vio_bus_device.dev.bus_id,
 	.type = "",
@@ -388,7 +390,7 @@ static int vio_hotplug(struct device *dev, char **envp, int num_envp,
 	return 0;
 }
 
-struct bus_type vio_bus_type = {
+static struct bus_type vio_bus_type = {
 	.name = "vio",
 	.dev_attrs = vio_dev_attrs,
 	.uevent = vio_hotplug,
diff --git a/include/asm-powerpc/vio.h b/include/asm-powerpc/vio.h
index 3a0975e..598d111 100644
--- a/include/asm-powerpc/vio.h
+++ b/include/asm-powerpc/vio.h
@@ -63,7 +63,6 @@ struct vio_driver {
 };
 
 extern struct dma_mapping_ops vio_dma_ops;
-extern struct bus_type vio_bus_type;
 
 extern int vio_register_driver(struct vio_driver *drv);
 extern void vio_unregister_driver(struct vio_driver *drv);
-- 
1.5.3.2
