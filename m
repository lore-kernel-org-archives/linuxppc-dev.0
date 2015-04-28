Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC9191A0D87
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 20:12:01 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Tue, 28 Apr 2015 15:41:59 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 80205125805F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 15:43:57 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3SAAIoW50528430
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 15:41:26 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3S9gJHs018788
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 15:12:20 +0530
Subject: [PATCH v4 2/3] powerpc/powernv: Create LED platform device
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org
Date: Tue, 28 Apr 2015 15:40:02 +0530
Message-ID: <20150428100958.26912.78396.stgit@localhost.localdomain>
In-Reply-To: <20150428100535.26912.29607.stgit@localhost.localdomain>
References: <20150428100535.26912.29607.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: stewart@linux.vnet.ibm.com, j.anaszewski81@gmail.com, cooloney@gmail.com,
 rpurdie@rpsys.net, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds paltform devices for leds. Also export LED related
OPAL API's so that led driver can use these APIs.

Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2241565..b1951aa 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -784,7 +784,7 @@ static void opal_init_heartbeat(void)
 
 static int __init opal_init(void)
 {
-	struct device_node *np, *consoles;
+	struct device_node *np, *consoles, *led;
 	int rc;
 
 	opal_node = of_find_node_by_path("/ibm,opal");
@@ -813,6 +813,13 @@ static int __init opal_init(void)
 	/* Setup a heatbeat thread if requested by OPAL */
 	opal_init_heartbeat();
 
+	/* Create led platform devices */
+	led = of_find_node_by_path("/ibm,opal/led");
+	if (led) {
+		of_platform_device_create(led, "opal_led", NULL);
+		of_node_put(led);
+	}
+
 	/* Find all OPAL interrupts and request them */
 	opal_irq_init(opal_node);
 
@@ -970,3 +977,6 @@ EXPORT_SYMBOL_GPL(opal_rtc_write);
 EXPORT_SYMBOL_GPL(opal_tpo_read);
 EXPORT_SYMBOL_GPL(opal_tpo_write);
 EXPORT_SYMBOL_GPL(opal_i2c_request);
+/* Export these symbols for PowerNV LED class driver */
+EXPORT_SYMBOL_GPL(opal_leds_get_ind);
+EXPORT_SYMBOL_GPL(opal_leds_set_ind);
