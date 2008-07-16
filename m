Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B191BDDF58
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 23:43:19 +1000 (EST)
Date: Wed, 16 Jul 2008 08:39:12 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/ep8248e: Fix compile problem if !CONFIG_FS_ENET
Message-ID: <Pine.LNX.4.64.0807160838520.14127@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: davej@redhat.com, akpm@linux-foundation.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If we don't enable FS_ENET we get build issues:

arch/powerpc/platforms/built-in.o: In function `ep8248e_mdio_probe':
arch/powerpc/platforms/82xx/ep8248e.c:129: undefined reference to `alloc_mdio_bitbang'
arch/powerpc/platforms/82xx/ep8248e.c:143: undefined reference to `mdiobus_register'

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

In my powerpc-next tree.

- k

 arch/powerpc/platforms/82xx/ep8248e.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/ep8248e.c b/arch/powerpc/platforms/82xx/ep8248e.c
index d5770fd..373e993 100644
--- a/arch/powerpc/platforms/82xx/ep8248e.c
+++ b/arch/powerpc/platforms/82xx/ep8248e.c
@@ -59,6 +59,7 @@ static void __init ep8248e_pic_init(void)
 	of_node_put(np);
 }

+#ifdef CONFIG_FS_ENET_MDIO_FCC
 static void ep8248e_set_mdc(struct mdiobb_ctrl *ctrl, int level)
 {
 	if (level)
@@ -164,6 +165,7 @@ static struct of_platform_driver ep8248e_mdio_driver = {
 	.probe = ep8248e_mdio_probe,
 	.remove = ep8248e_mdio_remove,
 };
+#endif

 struct cpm_pin {
 	int port, pin, flags;
@@ -296,7 +298,9 @@ static  __initdata struct of_device_id of_bus_ids[] = {
 static int __init declare_of_platform_devices(void)
 {
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+#ifdef CONFIG_FS_ENET_MDIO_FCC
 	of_register_platform_driver(&ep8248e_mdio_driver);
+#endif

 	return 0;
 }
-- 
1.5.5.1
