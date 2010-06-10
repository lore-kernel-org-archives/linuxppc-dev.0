Return-Path: <grant.likely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH v2 1/5] gpiolib: cosmetic improvements for error handling in
	gpiochip_add()
To: dbrownell@users.sourceforge.net, avorontsov@ru.mvista.com
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 09 Jun 2010 23:40:46 -0600
Message-ID: <20100610054046.16716.54159.stgit@angua>
In-Reply-To: <20100610053439.16716.53944.stgit@angua>
References: <20100610053439.16716.53944.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: bgat@billgatliff.com, dbaryshkov@gmail.com,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>

Hopefully it makes the code look nicer and makes it easier to extend
this function.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: devicetree-discuss@lists.ozlabs.org
CC: linux-kernel@vger.kernel.org
---
 drivers/gpio/gpiolib.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 3ca3654..713ca0e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1101,14 +1101,20 @@ int gpiochip_add(struct gpio_chip *chip)
 
 unlock:
 	spin_unlock_irqrestore(&gpio_lock, flags);
-	if (status == 0)
-		status = gpiochip_export(chip);
+
+	if (status)
+		goto fail;
+
+	status = gpiochip_export(chip);
+	if (status)
+		goto fail;
+
+	return 0;
 fail:
 	/* failures here can mean systems won't boot... */
-	if (status)
-		pr_err("gpiochip_add: gpios %d..%d (%s) failed to register\n",
-			chip->base, chip->base + chip->ngpio - 1,
-			chip->label ? : "generic");
+	pr_err("gpiochip_add: gpios %d..%d (%s) failed to register\n",
+		chip->base, chip->base + chip->ngpio - 1,
+		chip->label ? : "generic");
 	return status;
 }
 EXPORT_SYMBOL_GPL(gpiochip_add);
