Return-Path: <albert_herranz@yahoo.es>
Received: from smtp134.mail.ukl.yahoo.com (smtp134.mail.ukl.yahoo.com
	[77.238.184.65]) by ozlabs.org (Postfix) with SMTP id 161E0B7F46
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Mar 2010 23:12:07 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v3 10/11] wii: enable swiotlb
Date: Sun,  7 Mar 2010 13:11:51 +0100
Message-Id: <1267963912-984-11-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1267963912-984-1-git-send-email-albert_herranz@yahoo.es>
References: <1267963912-984-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
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
 arch/powerpc/platforms/embedded6xx/wii.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index 57e5b60..6ad5c0a 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -164,6 +164,8 @@ static void __init wii_setup_arch(void)
 		clrbits32(hw_gpio + HW_GPIO_OUT(0),
 			  HW_GPIO_SLOT_LED | HW_GPIO_SENSOR_BAR);
 	}
+	swiotlb_set_default_size(1<<20); /* 1 MB */
+	ppc_swiotlb_enable = 1;
 }
 
 static void wii_restart(char *cmd)
-- 
1.6.3.3
