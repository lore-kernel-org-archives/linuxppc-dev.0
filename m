Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 261F2DE04B
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 09:32:43 +1000 (EST)
Message-Id: <200806092326.m59NQ9vo014224@imap1.linux-foundation.org>
Subject: [patch 3/5] macintosh: therm_windtunnel: semaphore to mutex
To: paulus@samba.org
From: akpm@linux-foundation.org
Date: Mon, 09 Jun 2008 16:26:08 -0700
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Daniel Walker <dwalker@mvista.com>

Signed-off-by: Daniel Walker <dwalker@mvista.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/macintosh/therm_windtunnel.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff -puN drivers/macintosh/therm_windtunnel.c~macintosh-therm_windtunnel-semaphore-to-mutex drivers/macintosh/therm_windtunnel.c
--- a/drivers/macintosh/therm_windtunnel.c~macintosh-therm_windtunnel-semaphore-to-mutex
+++ a/drivers/macintosh/therm_windtunnel.c
@@ -62,7 +62,7 @@ static struct {
 	volatile int		running;
 	struct task_struct	*poll_task;
 	
-	struct semaphore 	lock;
+	struct mutex	 	lock;
 	struct of_device	*of_dev;
 	
 	struct i2c_client	*thermostat;
@@ -286,23 +286,23 @@ restore_regs( void )
 
 static int control_loop(void *dummy)
 {
-	down(&x.lock);
+	mutex_lock(&x.lock);
 	setup_hardware();
-	up(&x.lock);
+	mutex_unlock(&x.lock);
 
 	for (;;) {
 		msleep_interruptible(8000);
 		if (kthread_should_stop())
 			break;
 
-		down(&x.lock);
+		mutex_lock(&x.lock);
 		poll_temp();
-		up(&x.lock);
+		mutex_unlock(&x.lock);
 	}
 
-	down(&x.lock);
+	mutex_lock(&x.lock);
 	restore_regs();
-	up(&x.lock);
+	mutex_unlock(&x.lock);
 
 	return 0;
 }
@@ -489,7 +489,7 @@ g4fan_init( void )
 	const struct apple_thermal_info *info;
 	struct device_node *np;
 
-	init_MUTEX( &x.lock );
+	mutex_init(&x.lock);
 
 	if( !(np=of_find_node_by_name(NULL, "power-mgt")) )
 		return -ENODEV;
_
