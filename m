Return-Path: <albert_herranz@yahoo.es>
Received: from smtp133.mail.ukl.yahoo.com (smtp133.mail.ukl.yahoo.com
	[77.238.184.64]) by ozlabs.org (Postfix) with SMTP id 5CC88B7CF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Mar 2010 05:33:03 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v5 09/10] wii: enable swiotlb
Date: Fri, 19 Mar 2010 19:32:25 +0100
Message-Id: <1269023546-25534-10-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1269023546-25534-1-git-send-email-albert_herranz@yahoo.es>
References: <1269023546-25534-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>, konrad.wilk@oracle.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable the use of a software IO TLB on the Nintendo Wii video game console.

This is used by the platform DMA support code to overcome the limitations
found in some of the devices within the "Hollywood" chipset.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/boot/dts/wii.dts            |    2 +-
 arch/powerpc/platforms/embedded6xx/wii.c |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
index 77528c9..92b8ca6 100644
--- a/arch/powerpc/boot/dts/wii.dts
+++ b/arch/powerpc/boot/dts/wii.dts
@@ -29,7 +29,7 @@
 	#size-cells = <1>;
 
 	chosen {
-		bootargs = "root=/dev/mmcblk0p2 rootwait udbg-immortal";
+		bootargs = "root=/dev/mmcblk0p2 swiotlb=512 rootwait udbg-immortal";
 	};
 
 	memory {
diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index 57e5b60..e63c5c8 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -164,6 +164,7 @@ static void __init wii_setup_arch(void)
 		clrbits32(hw_gpio + HW_GPIO_OUT(0),
 			  HW_GPIO_SLOT_LED | HW_GPIO_SENSOR_BAR);
 	}
+	ppc_swiotlb_enable = 1;
 }
 
 static void wii_restart(char *cmd)
-- 
1.6.3.3
