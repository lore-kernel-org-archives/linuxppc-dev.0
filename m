Return-Path: <bywxiaobai@163.com>
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
 by lists.ozlabs.org (Postfix) with ESMTP id 894EA1A0310
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 00:00:49 +1000 (AEST)
From: Yaowei Bai <bywxiaobai@163.com>
To: perex@perex.cz, tiwai@suse.com, johannes@sipsolutions.net,
 k.kozlowski@samsung.com, elfring@users.sourceforge.net, fabf@skynet.be,
 lars@metafoo.de
Cc: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 3/4] sound/fabrics/layout: make aoa_fabric_layout_init
 return directly
Date: Wed, 23 Sep 2015 21:58:30 +0800
Message-Id: <1443016711-5297-3-git-send-email-bywxiaobai@163.com>
In-Reply-To: <1443016711-5297-1-git-send-email-bywxiaobai@163.com>
References: <1443016711-5297-1-git-send-email-bywxiaobai@163.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Catching the return value of soundbus_register_driver in
aoa_fabric_layout_init is not necessary, let's return it
directly.

No functional change.

Signed-off-by: Yaowei Bai <bywxiaobai@163.com>
---
 sound/aoa/fabrics/layout.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index 8f71f7e..b6ba091 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -1161,12 +1161,7 @@ static struct soundbus_driver aoa_soundbus_driver = {
 
 static int __init aoa_fabric_layout_init(void)
 {
-	int err;
-
-	err = soundbus_register_driver(&aoa_soundbus_driver);
-	if (err)
-		return err;
-	return 0;
+	return soundbus_register_driver(&aoa_soundbus_driver);
 }
 
 static void __exit aoa_fabric_layout_exit(void)
-- 
1.9.1
