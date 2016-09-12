Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXhWm1czzzDrfR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 18:57:08 +1000 (AEST)
From: Jeremy Kerr <jk@ozlabs.org>
To: Corey Minyard <minyard@acm.org>, openipmi-developer@lists.sourceforge.net
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] ipmi/powernv: Use dynamic device ids
Date: Mon, 12 Sep 2016 16:55:37 +0800
Message-Id: <1473670537-26428-5-git-send-email-jk@ozlabs.org>
In-Reply-To: <1473670537-26428-1-git-send-email-jk@ozlabs.org>
References: <1473670537-26428-1-git-send-email-jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't currently provide any device ID info in the SMI registration,
so use the dynamic ID infrastructure instead.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---
 drivers/char/ipmi/ipmi_powernv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_powernv.c b/drivers/char/ipmi/ipmi_powernv.c
index 6e658aa..10e69d6 100644
--- a/drivers/char/ipmi/ipmi_powernv.c
+++ b/drivers/char/ipmi/ipmi_powernv.c
@@ -23,7 +23,6 @@
 
 struct ipmi_smi_powernv {
 	u64			interface_id;
-	struct ipmi_device_id	ipmi_id;
 	ipmi_smi_t		intf;
 	unsigned int		irq;
 
@@ -265,9 +264,7 @@ static int ipmi_powernv_probe(struct platform_device *pdev)
 		goto err_unregister;
 	}
 
-	/* todo: query actual ipmi_device_id */
-	rc = ipmi_register_smi(&ipmi_powernv_smi_handlers, ipmi,
-			&ipmi->ipmi_id, dev, 0);
+	rc = ipmi_register_smi(&ipmi_powernv_smi_handlers, ipmi, NULL, dev, 0);
 	if (rc) {
 		dev_warn(dev, "IPMI SMI registration failed (%d)\n", rc);
 		goto err_free_msg;
-- 
2.7.4
