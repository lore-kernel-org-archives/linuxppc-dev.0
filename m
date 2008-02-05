Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4D767DDDED
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 14:15:13 +1100 (EST)
Date: Tue, 5 Feb 2008 14:15:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] iSeries: fix section mismatch in viodsasd
Message-Id: <20080205141512.5fb579c0.sfr@canb.auug.org.au>
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

WARNING: vmlinux.o(.text+0x3017c): Section mismatch in reference from the function .vio_create_viodasd() to the function .devinit.text:.vio_register_device_node()

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/vio.c |    2 +-
 include/asm-powerpc/vio.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index f0bad70..f988672 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -176,7 +176,7 @@ static void __devinit vio_dev_release(struct device *dev)
  * Returns a pointer to the created vio_dev or NULL if node has
  * NULL device_type or compatible fields.
  */
-struct vio_dev * __devinit vio_register_device_node(struct device_node *of_node)
+struct vio_dev *vio_register_device_node(struct device_node *of_node)
 {
 	struct vio_dev *viodev;
 	const unsigned int *unit_address;
diff --git a/include/asm-powerpc/vio.h b/include/asm-powerpc/vio.h
index 9204c15..56512a9 100644
--- a/include/asm-powerpc/vio.h
+++ b/include/asm-powerpc/vio.h
@@ -66,7 +66,7 @@ extern void __devinit vio_unregister_device(struct vio_dev *dev);
 
 struct device_node;
 
-extern struct vio_dev * __devinit vio_register_device_node(
+extern struct vio_dev *vio_register_device_node(
 		struct device_node *node_vdev);
 extern const void *vio_get_attribute(struct vio_dev *vdev, char *which,
 		int *length);
-- 
1.5.4

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
