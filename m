Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A5661B7218
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Nov 2011 02:59:38 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAKFxZL0026360
 for <linuxppc-dev@ozlabs.org>; Sun, 20 Nov 2011 09:59:35 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Fix compile error on p3060_qds.c
Date: Sun, 20 Nov 2011 09:59:35 -0600
Message-Id: <1321804775-15455-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/powerpc/platforms/85xx/p3060_qds.c: In function '__machine_initcall_p3060_qds_declare_of_platform_devices':
arch/powerpc/platforms/85xx/p3060_qds.c:73:1: error: implicit declaration of function 'declare_of_platform_devices'

declare_of_platform_devices should have been corenet_ds_publish_devices.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/p3060_qds.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p3060_qds.c b/arch/powerpc/platforms/85xx/p3060_qds.c
index 01dcf44..081cf4a 100644
--- a/arch/powerpc/platforms/85xx/p3060_qds.c
+++ b/arch/powerpc/platforms/85xx/p3060_qds.c
@@ -70,7 +70,7 @@ define_machine(p3060_qds) {
 	.power_save		= e500_idle,
 };
 
-machine_device_initcall(p3060_qds, declare_of_platform_devices);
+machine_device_initcall(p3060_qds, corenet_ds_publish_devices);
 
 #ifdef CONFIG_SWIOTLB
 machine_arch_initcall(p3060_qds, swiotlb_setup_bus_notifier);
-- 
1.7.3.4
