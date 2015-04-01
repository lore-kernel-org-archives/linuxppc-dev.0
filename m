Return-Path: <joel@jms.id.au>
Received: from mail-pd0-x22e.google.com (mail-pd0-x22e.google.com
 [IPv6:2607:f8b0:400e:c02::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A94941A0631
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 18:05:20 +1100 (AEDT)
Received: by pddn5 with SMTP id n5so45886917pdd.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2015 00:05:17 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org
Subject: [PATCH v2 1/3] envctrl: Ignore orderly_poweroff return value
Date: Wed,  1 Apr 2015 17:34:46 +1030
Message-Id: <1427871888-27331-1-git-send-email-joel@jms.id.au>
Cc: rusty@rustcorp.com.au, fabf@skynet.be, jk@ozlabs.org,
 akpm@linux-foundation.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

orderly_poweroff() unconditionally returns 0, so remove the dead code
that checks the return value.

A future patch will change the return type to void.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/sbus/char/bbc_envctrl.c | 3 +--
 drivers/sbus/char/envctrl.c     | 7 +------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/sbus/char/bbc_envctrl.c b/drivers/sbus/char/bbc_envctrl.c
index 0787b97..228c782 100644
--- a/drivers/sbus/char/bbc_envctrl.c
+++ b/drivers/sbus/char/bbc_envctrl.c
@@ -160,8 +160,7 @@ static void do_envctrl_shutdown(struct bbc_cpu_temperature *tp)
 	printk(KERN_CRIT "kenvctrld: Shutting down the system now.\n");
 
 	shutting_down = 1;
-	if (orderly_poweroff(true) < 0)
-		printk(KERN_CRIT "envctrl: shutdown execution failed\n");
+	orderly_poweroff(true);
 }
 
 #define WARN_INTERVAL	(30 * HZ)
diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index af15a2f..7946852 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -970,18 +970,13 @@ static struct i2c_child_t *envctrl_get_i2c_child(unsigned char mon_type)
 static void envctrl_do_shutdown(void)
 {
 	static int inprog = 0;
-	int ret;
 
 	if (inprog != 0)
 		return;
 
 	inprog = 1;
 	printk(KERN_CRIT "kenvctrld: WARNING: Shutting down the system now.\n");
-	ret = orderly_poweroff(true);
-	if (ret < 0) {
-		printk(KERN_CRIT "kenvctrld: WARNING: system shutdown failed!\n"); 
-		inprog = 0;  /* unlikely to succeed, but we could try again */
-	}
+	orderly_poweroff(true);
 }
 
 static struct task_struct *kenvctrld_task;
-- 
2.1.4
