Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 64D6067B58
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jul 2006 03:00:25 +1000 (EST)
Message-Id: <20060707165531.614016000@sipsolutions.net>
References: <20060707165207.877010000@sipsolutions.net>
Date: Fri, 07 Jul 2006 18:52:14 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/12] aoa fabric layout: clean up messages
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch cleans up the printk's in the layout fabric and also
makes it display which type of GPIO access it is going to use.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-fetch.orig/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2006-07-07 12:15:39.497697157 +0200
+++ linux-2.6-fetch/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2006-07-07 12:15:55.057697157 +0200
@@ -950,11 +950,12 @@ static int aoa_fabric_layout_probe(struc
 	layout_id = (unsigned int *) get_property(sound, "layout-id", NULL);
 	if (!layout_id)
 		goto outnodev;
-	printk(KERN_INFO "snd-aoa-fabric-layout: found bus with layout %d ", *layout_id);
+	printk(KERN_INFO "snd-aoa-fabric-layout: found bus with layout %d\n",
+	       *layout_id);
 
 	layout = find_layout_by_id(*layout_id);
 	if (!layout) {
-		printk("(no idea how to handle)\n");
+		printk(KERN_ERR "snd-aoa-fabric-layout: unknown layout\n");
 		goto outnodev;
 	}
 
@@ -972,15 +973,17 @@ static int aoa_fabric_layout_probe(struc
 	case 51: /* PowerBook5,4 */
 	case 58: /* Mac Mini */
 		ldev->gpio.methods = ftr_gpio_methods;
+		printk(KERN_DEBUG
+		       "snd-aoa-fabric-layout: Using direct GPIOs\n");
 		break;
 	default:
 		ldev->gpio.methods = pmf_gpio_methods;
+		printk(KERN_DEBUG
+		       "snd-aoa-fabric-layout: Using PMF GPIOs\n");
 	}
 	ldev->selfptr_headphone.ptr = ldev;
 	ldev->selfptr_lineout.ptr = ldev;
 	sdev->ofdev.dev.driver_data = ldev;
-
-	printk("(using)\n");
 	list_add(&ldev->list, &layouts_list);
 	layouts_list_items++;
 

--
