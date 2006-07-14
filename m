Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 542DD67B52
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Jul 2006 00:47:51 +1000 (EST)
Received: from localhost (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 274CF3685A1
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Jul 2006 00:47:51 +1000 (EST)
Date: Sat, 15 Jul 2006 00:47:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] [POWERPC] iseries: Small viotape cleanup allowed by devfs
	removal
Message-Id: <20060715004739.45edf19c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/viotape.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/drivers/char/viotape.c b/drivers/char/viotape.c
index b72b204..73c78bf 100644
--- a/drivers/char/viotape.c
+++ b/drivers/char/viotape.c
@@ -940,7 +940,6 @@ static void vioHandleTapeEvent(struct Hv
 
 static int viotape_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 {
-	char tapename[32];
 	int i = vdev->unit_address;
 	int j;
 
@@ -956,10 +955,9 @@ static int viotape_probe(struct vio_dev 
 			"iseries!vt%d", i);
 	class_device_create(tape_class, NULL, MKDEV(VIOTAPE_MAJOR, i | 0x80),
 			NULL, "iseries!nvt%d", i);
-	sprintf(tapename, "iseries/vt%d", i);
-	printk(VIOTAPE_KERN_INFO "tape %s is iSeries "
+	printk(VIOTAPE_KERN_INFO "tape iseries/vt%d is iSeries "
 			"resource %10.10s type %4.4s, model %3.3s\n",
-			tapename, viotape_unitinfo[i].rsrcname,
+			i, viotape_unitinfo[i].rsrcname,
 			viotape_unitinfo[i].type, viotape_unitinfo[i].model);
 	return 0;
 }
-- 
1.4.0
