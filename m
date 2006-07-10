Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17586.19091.512322.908434@cargo.ozlabs.ibm.com>
Date: Mon, 10 Jul 2006 22:39:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] Make snd-aoa cope with lack of line-output-detect property
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The snd-aoa stuff falls over on my G4 powerbook (1.5GHz Albook) with a
null pointer dereference in of_find_property.  It turns out that this
was because it couldn't find a device node for the line-output detect
GPIO.  This patch fixes it.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/sound/aoa/core/snd-aoa-gpio-feature.c b/sound/aoa/core/snd-aoa-gpio-feature.c
index 7ae0c0b..e35a1c6 100644
--- a/sound/aoa/core/snd-aoa-gpio-feature.c
+++ b/sound/aoa/core/snd-aoa-gpio-feature.c
@@ -112,7 +112,10 @@ static struct device_node *get_gpio(char
 
 static void get_irq(struct device_node * np, int *irqptr)
 {
-	*irqptr = irq_of_parse_and_map(np, 0);
+	if (np)
+		*irqptr = irq_of_parse_and_map(np, 0);
+	else
+		*irqptr = -1;	/* XXX should this be NO_IRQ? */
 }
 
 /* 0x4 is outenable, 0x1 is out, thus 4 or 5 */
@@ -322,7 +325,7 @@ static int ftr_set_notify(struct gpio_ru
 		return -EINVAL;
 	}
 
-	if (irq == -1)
+	if (irq == -1)		/* XXX should this be NO_IRQ? */
 		return -ENODEV;
 
 	mutex_lock(&notif->mutex);
