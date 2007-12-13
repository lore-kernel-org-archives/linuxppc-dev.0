Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18272.48073.970124.233244@cargo.ozlabs.ibm.com>
Date: Thu, 13 Dec 2007 15:57:45 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Convert therm_windtunnel.c to use the kthread API
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is fairly straightforward, and lets us get rid of x.completion
as well.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index 5452da1..3722402 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -36,6 +36,7 @@
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/kthread.h>
 
 #include <asm/prom.h>
 #include <asm/machdep.h>
@@ -61,8 +62,7 @@ I2C_CLIENT_INSMOD;
 
 static struct {
 	volatile int		running;
-	struct completion	completion;
-	pid_t			poll_task;
+	struct task_struct	*poll_task;
 	
 	struct semaphore 	lock;
 	struct of_device	*of_dev;
@@ -282,27 +282,27 @@ restore_regs( void )
 	write_reg( x.fan, 0x00, x.r0, 1 );
 }
 
-static int
-control_loop( void *dummy )
+static int control_loop(void *dummy)
 {
-	daemonize("g4fand");
-
-	down( &x.lock );
+	down(&x.lock);
 	setup_hardware();
+	up(&x.lock);
 
-	while( x.running ) {
-		up( &x.lock );
-
+	for (;;) {
 		msleep_interruptible(8000);
-		
-		down( &x.lock );
+		if (kthread_should_stop())
+			break;
+
+		down(&x.lock);
 		poll_temp();
+		up(&x.lock);
 	}
 
+	down(&x.lock);
 	restore_regs();
-	up( &x.lock );
+	up(&x.lock);
 
-	complete_and_exit( &x.completion, 0 );
+	return 0;
 }
 
 
@@ -322,8 +322,7 @@ do_attach( struct i2c_adapter *adapter )
 		ret = i2c_probe( adapter, &addr_data, &do_probe );
 		if( x.thermostat && x.fan ) {
 			x.running = 1;
-			init_completion( &x.completion );
-			x.poll_task = kernel_thread( control_loop, NULL, SIGCHLD | CLONE_KERNEL );
+			x.poll_task = kthread_run(control_loop, NULL, "g4fand");
 		}
 	}
 	return ret;
@@ -339,7 +338,8 @@ do_detach( struct i2c_client *client )
 	else {
 		if( x.running ) {
 			x.running = 0;
-			wait_for_completion( &x.completion );
+			kthread_stop(x.poll_task);
+			x.poll_task = NULL;
 		}
 		if( client == x.thermostat )
 			x.thermostat = NULL;
