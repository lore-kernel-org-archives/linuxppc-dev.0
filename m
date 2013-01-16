Return-Path: <kishon@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <devicetree-discuss@lists.ozlabs.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-usb@vger.kernel.org>,
 <linux-sh@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, <balbi@ti.com>
Subject: [RFC PATCH 6/6] USB: MUSB: OMAP: get PHY by phandle for dt boot
Date: Wed, 16 Jan 2013 20:31:02 +0530
Message-ID: <1358348462-27693-7-git-send-email-kishon@ti.com>
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

The OMAP glue has been modified to get PHY by phandle for dt boot.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/musb/omap2430.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 3628a50..08709cf 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -346,7 +346,12 @@ static int omap2430_musb_init(struct musb *musb)
 	 * up through ULPI.  TWL4030-family PMICs include one,
 	 * which needs a driver, drivers aren't always needed.
 	 */
-	musb->xceiv = devm_usb_get_phy(dev, 0);
+	if (dev->parent->of_node)
+		musb->xceiv = devm_usb_get_phy_by_phandle(dev->parent,
+		    "usb_phy", 0);
+	else
+		musb->xceiv = devm_usb_get_phy(dev, 0);
+
 	if (IS_ERR_OR_NULL(musb->xceiv)) {
 		pr_err("HS USB OTG: no transceiver configured\n");
 		return -ENODEV;
-- 
1.7.9.5
