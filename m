Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2BEBDE039
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 01:54:39 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l92FrSRe003594
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 19:53:28 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l92FrS0Y003591
	for linuxppc-dev@ozlabs.org; Tue, 2 Oct 2007 19:53:28 +0400
Date: Tue, 2 Oct 2007 19:53:28 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Remove unnecessary memset from physmap_of driver
Message-ID: <20071002155328.GA3574@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

No need for memset to zero memory here, since we use kzalloc.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 drivers/mtd/maps/physmap_of.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
index cf75a56..aeed9ea 100644
--- a/drivers/mtd/maps/physmap_of.c
+++ b/drivers/mtd/maps/physmap_of.c
@@ -232,7 +232,6 @@ static int __devinit of_flash_probe(struct of_device *dev,
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		goto err_out;
-	memset(info, 0, sizeof(*info));
 
 	dev_set_drvdata(&dev->dev, info);
 
-- 
1.5.2.4
