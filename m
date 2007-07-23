Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D5D2BDDE1E
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 11:55:17 +1000 (EST)
Date: Mon, 23 Jul 2007 11:55:32 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] iSeries: we need vio_enable_interrupts
Message-Id: <20070723115532.28d22e3e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Brian King <brking@linux.vnet.ibm.com>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 3d0e91f7ace12499c4b00088e9a6b1361e1bb0ca introduced a requirement
for vio_enable_interrupts which iSeires has never needed.  So create a
dummy one.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/vio.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

Paul, this is a fix for a 2.6.23 regression.  I should do a better fix
for 2.6.24.  Built for iseries_defconfig, ppc64_defconfig and
allmodconfig.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-powerpc/vio.h b/include/asm-powerpc/vio.h
index 0117b54..3a0975e 100644
--- a/include/asm-powerpc/vio.h
+++ b/include/asm-powerpc/vio.h
@@ -80,6 +80,11 @@ extern const void *vio_get_attribute(struct vio_dev *vdev, char *which,
 extern struct vio_dev *vio_find_node(struct device_node *vnode);
 extern int vio_enable_interrupts(struct vio_dev *dev);
 extern int vio_disable_interrupts(struct vio_dev *dev);
+#else
+static inline int vio_enable_interrupts(struct vio_dev *dev)
+{
+	return 0;
+}
 #endif
 
 static inline struct vio_driver *to_vio_driver(struct device_driver *drv)
-- 
1.5.2.3
