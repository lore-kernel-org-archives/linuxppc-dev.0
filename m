Return-Path: <tim.gardner@canonical.com>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6FAA51A0072
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 05:02:04 +1000 (AEST)
Received: by pdbnt7 with SMTP id nt7so34912153pdb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 12:02:02 -0700 (PDT)
From: tim.gardner@canonical.com
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Tim Gardner <tim.gardner@canonical.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4.2-rc3] macintosh/ans-lcd.c: Missing include causes compile
 failure
Date: Mon, 20 Jul 2015 13:01:42 -0600
Message-Id: <1437418902-23324-1-git-send-email-tim.gardner@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tim Gardner <tim.gardner@canonical.com>

drivers/macintosh/ans-lcd.c:201:1: warning: data definition has no type or storage class
 module_init(anslcd_init);
 ^
drivers/macintosh/ans-lcd.c:201:1: error: type defaults to 'int' in declaration of 'module_init' [-Werror=implicit-int]

gcc version 4.9.3 (Ubuntu 4.9.3-1ubuntu1)

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---

This is a compile regression from v4.2-rc2

 drivers/macintosh/ans-lcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/macintosh/ans-lcd.c b/drivers/macintosh/ans-lcd.c
index 1a57e88..36a0047 100644
--- a/drivers/macintosh/ans-lcd.c
+++ b/drivers/macintosh/ans-lcd.c
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/miscdevice.h>
 #include <linux/fcntl.h>
 #include <linux/init.h>
-- 
1.9.1
