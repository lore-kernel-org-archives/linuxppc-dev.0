Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 73251DDE02
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 14:14:51 +1000 (EST)
Received: from pd3mr3so.prod.shaw.ca
	(pd3mr3so-qfe3.prod.shaw.ca [10.0.141.179]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPD00EZ6D1Z9030@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 03 Oct 2007 22:13:11 -0600 (MDT)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
	by pd3mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPD00CDED1YPS40@pd3mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 03 Oct 2007 22:13:11 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPD00HFSD1YSZJ0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 03 Oct 2007 22:13:10 -0600 (MDT)
Date: Wed, 03 Oct 2007 22:13:18 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/3] Sysace: Minor coding convention fixup
In-reply-to: <20071004041114.20868.34605.stgit@trillian.cg.shawcable.net>
To: jens.axboe@oracle.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Message-id: <20071004041318.20868.51928.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071004041114.20868.34605.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Put function call and return code test on separate lines.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/block/xsysace.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index 3ea172b..3847464 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -1091,7 +1091,8 @@ ace_alloc(struct device *dev, int id, unsigned long physaddr,
 	ace->bus_width = bus_width;
 
 	/* Call the setup code */
-	if ((rc = ace_setup(ace)) != 0)
+	rc = ace_setup(ace);
+	if (rc)
 		goto err_setup;
 
 	dev_set_drvdata(dev, ace);
@@ -1253,11 +1254,13 @@ static int __init ace_init(void)
 		goto err_blk;
 	}
 
-	if ((rc = ace_of_register()) != 0)
+	rc = ace_of_register();
+	if (rc)
 		goto err_of;
 
 	pr_debug("xsysace: registering platform binding\n");
-	if ((rc = platform_driver_register(&ace_platform_driver)) != 0)
+	rc = platform_driver_register(&ace_platform_driver);
+	if (rc)
 		goto err_plat;
 
 	pr_info("Xilinx SystemACE device driver, major=%i\n", ace_major);
