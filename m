Return-Path: <kishon@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <devicetree-discuss@lists.ozlabs.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-usb@vger.kernel.org>,
 <linux-sh@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, <balbi@ti.com>
Subject: [RFC PATCH 2/6] ARM: OMAP: USB: Add phy binding information
Date: Wed, 16 Jan 2013 20:30:58 +0530
Message-ID: <1358348462-27693-3-git-send-email-kishon@ti.com>
In-Reply-To: <1358348462-27693-1-git-send-email-kishon@ti.com>
References: <1358348462-27693-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux@arm.linux.org.uk, b-cousson@ti.com, tony@atomide.com,
 gregkh@linuxfoundation.org, rob.herring@calxeda.com, kishon@ti.com,
 cbou@mail.ru, alexander.shishkin@linux.intel.com, horms@verge.net.au,
 stern@rowland.harvard.edu, haojian.zhuang@gmail.com, rob@landley.net,
 eric.y.miao@gmail.com, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is in preparation for the changes in PHY library to support adding
and getting multiple PHYs of the same type. In the new design, the
binding information between the PHY and the USB controller should be
specified in the platform specific initialization code. So it's been
done for OMAP platforms here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
This kind-of binding should be done in all the platforms (I've done only
for OMAP platform). 
 arch/arm/mach-omap2/usb-musb.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 9d27e3f..bbe2fa5 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -24,6 +24,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/usb/musb.h>
+#include <linux/usb/phy.h>
 
 #include "omap_device.h"
 #include "soc.h"
@@ -85,8 +86,12 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
 	musb_plat.mode = board_data->mode;
 	musb_plat.extvbus = board_data->extvbus;
 
-	if (cpu_is_omap44xx())
+	if (cpu_is_omap44xx()) {
 		musb_plat.has_mailbox = true;
+		usb_bind_phy("musb-hdrc.0.auto", 0, "omap-usb2.1.auto");
+	} else if (cpu_is_omap34xx()) {
+		usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
+	}
 
 	if (soc_is_am35xx()) {
 		oh_name = "am35x_otg_hs";
-- 
1.7.9.5
