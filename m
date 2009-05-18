Return-Path: <vapier@gentoo.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F10CBDE054
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 17:42:14 +1000 (EST)
From: Mike Frysinger <vapier@gentoo.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/hvc: add missing __devexit_p()
Date: Mon, 18 May 2009 03:42:01 -0400
Message-Id: <1242632521-15954-1-git-send-email-vapier@gentoo.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The remove function uses __devexit, so the .remove assignment needs
__devexit_p() to fix a build error with hotplug disabled.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
CC: linuxppc-dev@ozlabs.org
CC: linux-kernel@vger.kernel.org
---
 drivers/char/hvc_iseries.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/hvc_iseries.c b/drivers/char/hvc_iseries.c
index 449727b..936d05b 100644
--- a/drivers/char/hvc_iseries.c
+++ b/drivers/char/hvc_iseries.c
@@ -241,7 +241,7 @@ static int __devexit hvc_vio_remove(struct vio_dev *vdev)
 static struct vio_driver hvc_vio_driver = {
 	.id_table	= hvc_driver_table,
 	.probe		= hvc_vio_probe,
-	.remove		= hvc_vio_remove,
+	.remove		= __devexit_p(hvc_vio_remove),
 	.driver		= {
 		.name	= hvc_driver_name,
 		.owner	= THIS_MODULE,
-- 
1.6.3
