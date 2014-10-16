Return-Path: <ddstreet@gmail.com>
Received: from mail-ig0-x22a.google.com (mail-ig0-x22a.google.com
 [IPv6:2607:f8b0:4001:c05::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 695BB1A0244
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 06:30:46 +1100 (AEDT)
Received: by mail-ig0-f170.google.com with SMTP id hn15so1657573igb.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 12:30:44 -0700 (PDT)
Sender: Dan Streetman <ddstreet@gmail.com>
From: Dan Streetman <ddstreet@ieee.org>
To: benh@kernel.crashing.org, Seth Jennings <sjennings@variantweb.net>,
 Robert Jennings <rcj4747@gmail.com>
Subject: [PATCH] drivers/crypto/nx: prevent oops on module exit
Date: Thu, 16 Oct 2014 15:30:19 -0400
Message-Id: <1413487819-6119-1-git-send-email-ddstreet@ieee.org>
Cc: linuxppc-dev@lists.ozlabs.org, Dan Streetman <ddstreet@ieee.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Check old_devdata->dev in nx-842 driver before accessing it, as
on systems without any nx-842 hardware, the ->dev will never be
set.  Currently, the module will cause an oops during unload
since old_devdata->dev is null.

Signed-off-by: Dan Streetman <ddstreet@ieee.org>
---

Also Seth and Rob, you guys should change your emails in this
driver, your IBM emails are still listed.

 drivers/crypto/nx/nx-842.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/nx/nx-842.c b/drivers/crypto/nx/nx-842.c
index 061407d..809a220 100644
--- a/drivers/crypto/nx/nx-842.c
+++ b/drivers/crypto/nx/nx-842.c
@@ -1269,7 +1269,7 @@ static void __exit nx842_exit(void)
 	RCU_INIT_POINTER(devdata, NULL);
 	spin_unlock_irqrestore(&devdata_mutex, flags);
 	synchronize_rcu();
-	if (old_devdata)
+	if (old_devdata && old_devdata->dev)
 		dev_set_drvdata(old_devdata->dev, NULL);
 	kfree(old_devdata);
 	vio_unregister_driver(&nx842_driver);
-- 
1.8.3.1
