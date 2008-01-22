Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <3ce7be4c77581ce103a8da9f33a734270c9dc6e8.1200999872.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/4] Search for and publish cell OF platform devices earlier
Date: Tue, 22 Jan 2008 22:04:39 +1100 (EST)
Cc: cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently cell publishes OF devices at device_initcall() time, which
means the earliest a driver can bind to a device is also device_initcall()
time. We have a driver we want to register before other devices, so
publish the devices at subsys_initcall() time.

This should not cause any behaviour change for existing drivers, as they
are still bound at device_initcall() time.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index e6534b5..a7f609b 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -98,7 +98,7 @@ static int __init cell_publish_devices(void)
 	}
 	return 0;
 }
-machine_device_initcall(cell, cell_publish_devices);
+machine_subsys_initcall(cell, cell_publish_devices);
 
 static void cell_mpic_cascade(unsigned int irq, struct irq_desc *desc)
 {
-- 
1.5.2.rc1.1884.g59b20
