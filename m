Return-Path: <>
From: "Andrew F. Davis" <afd@ti.com>
To: Russell King <linux@armlinux.org.uk>, Miguel Ojeda Sandonis
 <miguel.ojeda.sandonis@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
 Richard Purdie <rpurdie@rpsys.net>,
 Jacek Anaszewski <j.anaszewski@samsung.com>,
 Rusty Russell <rusty@rustcorp.com.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,
 Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Lauro Ramos Venancio
 <lauro.venancio@openbossa.org>, Aloisio Almeida Jr
 <aloisio.almeida@openbossa.org>, Samuel Ortiz <sameo@linux.intel.com>, Ingo
 Molnar <mingo@kernel.org>
CC: <linux-gpio@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
 <linux-leds@vger.kernel.org>, <lguest@lists.ozlabs.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-media@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Andrew F .
 Davis" <afd@ti.com>
Subject: [PATCH 01/12] gpio: Only descend into gpio directory when
 CONFIG_GPIOLIB is set
Date: Mon, 13 Jun 2016 15:02:00 -0500
Message-ID: <20160613200211.14790-2-afd@ti.com>
In-Reply-To: <20160613200211.14790-1-afd@ti.com>
References: <20160613200211.14790-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When CONFIG_GPIOLIB is not set make will still descend into the gpio
directory but nothing will be built. This produces unneeded build
artifacts and messages in addition to slowing the build. Fix this here.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 0b6f3d6..50f6131 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_GENERIC_PHY)	+= phy/
 
 # GPIO must come after pinctrl as gpios may need to mux pins etc
 obj-$(CONFIG_PINCTRL)		+= pinctrl/
-obj-y				+= gpio/
+obj-$(CONFIG_GPIOLIB)		+= gpio/
 obj-y				+= pwm/
 obj-$(CONFIG_PCI)		+= pci/
 obj-$(CONFIG_PARISC)		+= parisc/
-- 
2.8.3
