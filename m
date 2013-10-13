Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 78AE42C014B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Oct 2013 03:06:03 +1100 (EST)
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Subject: [PATCH] arch/powerpc/platforms/83xx: Remove obsolete cleanup for
 clientdata
Date: Sun, 13 Oct 2013 18:05:38 +0200
Message-Id: <1381680348-5298-1-git-send-email-wsa@the-dreams.de>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Wolfram Sang <wsa@the-dreams.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A few new i2c-drivers came into the kernel which clear the clientdata-pointer
on exit or error. This is obsolete meanwhile, the core will do it.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
index 7bc3158..fd71cfd 100644
--- a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
+++ b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
@@ -204,7 +204,6 @@ static int mcu_remove(struct i2c_client *client)
 	ret = mcu_gpiochip_remove(mcu);
 	if (ret)
 		return ret;
-	i2c_set_clientdata(client, NULL);
 	kfree(mcu);
 	return 0;
 }
-- 
1.8.4.rc3
