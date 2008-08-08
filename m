Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D9360DE02C
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Aug 2008 02:18:14 +1000 (EST)
Date: Fri, 8 Aug 2008 20:18:13 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Greg Kroah-Hartman <greg@kroah.com>, linux-usb@vger.kernel.org
Subject: [PATCH 1/3] gpiolib: make gpio_to_chip() public
Message-ID: <20080808161813.GA31258@polina.dev.rtsoft.ru>
References: <20080808161717.GA19095@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20080808161717.GA19095@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, David Brownell <dbrownell@users.sourceforge.net>,
	Li Yang <leoli@freescale.com>, linux-kernel@vger.kernel.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We'll need this function to write platform-specific hooks to deal
with pin's dedicated functions. Quite obviously this will work only
for the platforms with 1-to-1 GPIO to PIN mapping.

This is stopgap solution till we think out and implement a proper
api (pinlib?).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/gpio/gpiolib.c     |    3 ++-
 include/asm-generic/gpio.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8d29405..9536fa8 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -81,10 +81,11 @@ static void gpio_ensure_requested(struct gpio_desc *desc)
 }
 
 /* caller holds gpio_lock *OR* gpio is marked as requested */
-static inline struct gpio_chip *gpio_to_chip(unsigned gpio)
+struct gpio_chip *gpio_to_chip(unsigned gpio)
 {
 	return gpio_desc[gpio].chip;
 }
+EXPORT_SYMBOL_GPL(gpio_to_chip);
 
 /* dynamic allocation of GPIOs, e.g. on a hotplugged device */
 static int gpiochip_find_base(int ngpio)
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index 0f99ad3..d70ee45 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -81,6 +81,7 @@ struct gpio_chip {
 	unsigned		exported:1;
 };
 
+extern struct gpio_chip *gpio_to_chip(unsigned gpio);
 extern const char *gpiochip_is_requested(struct gpio_chip *chip,
 			unsigned offset);
 extern int __must_check gpiochip_reserve(int start, int ngpio);
-- 
1.5.5.4
