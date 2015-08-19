Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D2191A0514
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 20:41:38 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 19 Aug 2015 16:11:35 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id EE1BA394005C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 16:11:31 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7JAfVIH10289178
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 16:11:31 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7JAfTFS019224
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 16:11:31 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
To: linux-leds@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, j.anaszewski@samsung.com, stewart@linux.vnet.ibm.com,
 j.anaszewski81@gmail.com, arnd@arndb.de, cooloney@gmail.com,
 rpurdie@rpsys.net, khandual@linux.vnet.ibm.com, benh@kernel.crashing.org,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: [PATCH v9 2/3] powerpc/powernv: Create LED platform device
Date: Wed, 19 Aug 2015 16:11:25 +0530
Message-Id: <1439980886-16360-3-git-send-email-hegdevasant@linux.vnet.ibm.com>
In-Reply-To: <1439980886-16360-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
References: <1439980886-16360-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds platform devices for leds. Also export LED related
OPAL API's so that led driver can use these APIs.

Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/opal.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index f084afa..6839358 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -648,7 +648,7 @@ static void opal_init_heartbeat(void)
 
 static int __init opal_init(void)
 {
-	struct device_node *np, *consoles;
+	struct device_node *np, *consoles, *leds;
 	int rc;
 
 	opal_node = of_find_node_by_path("/ibm,opal");
@@ -689,6 +689,13 @@ static int __init opal_init(void)
 	/* Setup a heatbeat thread if requested by OPAL */
 	opal_init_heartbeat();
 
+	/* Create leds platform devices */
+	leds = of_find_node_by_path("/ibm,opal/leds");
+	if (leds) {
+		of_platform_device_create(leds, "opal_leds", NULL);
+		of_node_put(leds);
+	}
+
 	/* Create "opal" kobject under /sys/firmware */
 	rc = opal_sysfs_init();
 	if (rc == 0) {
@@ -841,3 +848,6 @@ EXPORT_SYMBOL_GPL(opal_rtc_write);
 EXPORT_SYMBOL_GPL(opal_tpo_read);
 EXPORT_SYMBOL_GPL(opal_tpo_write);
 EXPORT_SYMBOL_GPL(opal_i2c_request);
+/* Export these symbols for PowerNV LED class driver */
+EXPORT_SYMBOL_GPL(opal_leds_get_ind);
+EXPORT_SYMBOL_GPL(opal_leds_set_ind);
-- 
2.1.0
