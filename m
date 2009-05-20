Return-Path: <roel.kluin@gmail.com>
Received: from mail-ew0-f167.google.com (mail-ew0-f167.google.com
	[209.85.219.167]) by ozlabs.org (Postfix) with ESMTP id 32F5FDDDF0
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 10:58:57 +1000 (EST)
Received: by ewy11 with SMTP id 11so188262ewy.9
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 17:58:55 -0700 (PDT)
Message-ID: <4A1355D0.80406@gmail.com>
Date: Wed, 20 May 2009 02:58:56 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] tape: beyond ARRAY_SIZE of viocd_diskinfo
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, Andrew Morton <akpm@linux-foundation.org>,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Do not go beyond ARRAY_SIZE of tape_device and viotape_unitinfo

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
diff --git a/drivers/char/viotape.c b/drivers/char/viotape.c
index ffc9254..042c814 100644
--- a/drivers/char/viotape.c
+++ b/drivers/char/viotape.c
@@ -867,7 +867,7 @@ static int viotape_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	int j;
 	struct device_node *node = vdev->dev.archdata.of_node;
 
-	if (i > VIOTAPE_MAX_TAPE)
+	if (i >= VIOTAPE_MAX_TAPE)
 		return -ENODEV;
 	if (!node)
 		return -ENODEV;
