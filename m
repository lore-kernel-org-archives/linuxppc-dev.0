Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 451BE1A0D14
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 18:05:49 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Mon, 20 Apr 2015 13:35:47 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2F9CEE004C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 13:38:21 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3K84qXY60752050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 13:35:43 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3K7bc2A023944
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 13:07:39 +0530
Subject: [PATCH v3 2/3] powerpc/powernv: Create LED platform device
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org
Date: Mon, 20 Apr 2015 13:31:18 +0530
Message-ID: <20150420075945.12371.26173.stgit@localhost.localdomain>
In-Reply-To: <20150420075558.12371.6697.stgit@localhost.localdomain>
References: <20150420075558.12371.6697.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: stewart@linux.vnet.ibm.com, cooloney@gmail.com, rpurdie@rpsys.net,
 j.anaszewski@samsung.com, khandual@linux.vnet.ibm.com
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
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
Tested-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
Since this is the split of origianal LED patch, I have retained Tested-by/Ack
from Stewart's Ack here.

-Vasant

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
