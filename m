Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B77CFDDE01
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 00:07:47 +1000 (EST)
Date: Wed, 3 Oct 2007 18:05:28 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] mtd: remove unnecessary memset from physmap_of driver
Message-ID: <20071003140528.GA11871@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18178.55231.813138.369480@cargo.ozlabs.ibm.com>
Cc: linux-mtd@lists.infradead.org
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
