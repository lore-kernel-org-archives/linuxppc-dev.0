Date: Fri, 7 May 2004 12:47:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] fix MOD_{INC,DEC}_USE_COUNT abuse in ppc 4xx/8xx code
Message-ID: <20040507104748.GA10971@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


not that most of the drivers are in a compiling shape currently, but
I want to get rid of the last callers of those.


--- 1.17/arch/ppc/4xx_io/serial_sicc.c	Wed Apr 28 09:21:30 2004
+++ edited/arch/ppc/4xx_io/serial_sicc.c	Mon May  3 13:23:42 2004
@@ -1431,7 +1431,6 @@
     save_flags(flags); cli();

     if (tty_hung_up_p(filp)) {
-        MOD_DEC_USE_COUNT;
         restore_flags(flags);
         return;
     }
@@ -1452,7 +1451,6 @@
         state->count = 0;
     }
     if (state->count) {
-        MOD_DEC_USE_COUNT;
         restore_flags(flags);
         return;
     }
@@ -1495,7 +1493,6 @@
     }
     info->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
     wake_up_interruptible(&info->close_wait);
-    MOD_DEC_USE_COUNT;
 }

 static void siccuart_wait_until_sent(struct tty_struct *tty, int timeout)
@@ -1685,9 +1682,7 @@


     // is this a line that we've got?
-    MOD_INC_USE_COUNT;
     if (line >= SERIAL_SICC_NR) {
-        MOD_DEC_USE_COUNT;
         return -ENODEV;
     }

@@ -1707,7 +1702,6 @@
         if (tmp_buf)
             free_page(page);
         else if (!page) {
-            MOD_DEC_USE_COUNT;
             return -ENOMEM;
         }
         tmp_buf = (u_char *)page;
@@ -1720,7 +1714,6 @@
         (info->flags & ASYNC_CLOSING)) {
         if (info->flags & ASYNC_CLOSING)
             interruptible_sleep_on(&info->close_wait);
-        MOD_DEC_USE_COUNT;
         return -EAGAIN;
     }

@@ -1729,13 +1722,11 @@
      */
     retval = siccuart_startup(info);
     if (retval) {
-        MOD_DEC_USE_COUNT;
         return retval;
     }

     retval = block_til_ready(tty, filp, info);
     if (retval) {
-        MOD_DEC_USE_COUNT;
         return retval;
     }

@@ -1778,6 +1769,7 @@
 	return -ENOMEM;
     printk("IBM Vesta SICC serial port driver V 0.1 by Yudong Yang and Yi Ge / IBM CRL .\n");
     siccnormal_driver->driver_name = "serial_sicc";
+    siccnormal_driver->owner = THIS_MODULE;
     siccnormal_driver->name = SERIAL_SICC_NAME;
     siccnormal_driver->major = SERIAL_SICC_MAJOR;
     siccnormal_driver->minor_start = SERIAL_SICC_MINOR;
===== arch/ppc/8260_io/uart.c 1.31 vs edited =====
--- 1.31/arch/ppc/8260_io/uart.c	Thu Apr  8 00:55:06 2004
+++ edited/arch/ppc/8260_io/uart.c	Mon May  3 13:24:59 2004
@@ -592,9 +592,7 @@
 #ifdef SERIAL_DEBUG_OPEN
 			printk("scheduling hangup...");
 #endif
-			MOD_INC_USE_COUNT;
-			if (schedule_work(&info->tqueue_hangup) == 0)
-				MOD_DEC_USE_COUNT;
+			schedule_work(&info->tqueue_hangup);
 		}
 	}
 	if (info->flags & ASYNC_CTS_FLOW) {
@@ -723,7 +721,6 @@
 	tty = info->tty;
 	if (tty)
 		tty_hangup(tty);
-	MOD_DEC_USE_COUNT;
 }

 /*static void rs_8xx_timer(void)
@@ -1689,7 +1686,6 @@

 	if (tty_hung_up_p(filp)) {
 		DBG_CNT("before DEC-hung");
-		MOD_DEC_USE_COUNT;
 		restore_flags(flags);
 		return;
 	}
@@ -1716,7 +1712,6 @@
 	}
 	if (state->count) {
 		DBG_CNT("before DEC-2");
-		MOD_DEC_USE_COUNT;
 		restore_flags(flags);
 		return;
 	}
@@ -1770,7 +1765,6 @@
 	}
 	info->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
 	wake_up_interruptible(&info->close_wait);
-	MOD_DEC_USE_COUNT;
 	restore_flags(flags);
 }

@@ -2021,7 +2015,6 @@
 	if (retval)
 		return retval;

-	MOD_INC_USE_COUNT;
 	retval = block_til_ready(tty, filp, info);
 	if (retval) {
 #ifdef SERIAL_DEBUG_OPEN
@@ -2530,6 +2523,7 @@

 	/* Initialize the tty_driver structure */

+	serial_driver->owner = THIS_MODULE;
 	serial_driver->driver_name = "serial";
 	serial_driver->devfs_name = "tts/";
 	serial_driver->name = "ttyS";
===== arch/ppc/8xx_io/cs4218_tdm.c 1.9 vs edited =====
--- 1.9/arch/ppc/8xx_io/cs4218_tdm.c	Fri Sep 12 18:26:50 2003
+++ edited/arch/ppc/8xx_io/cs4218_tdm.c	Mon May  3 13:27:57 2004
@@ -1456,21 +1456,10 @@
 	restore_flags(flags);
 }

-static void CS_open(void)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void CS_release(void)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 static MACHINE mach_cs4218 = {
+	.owner =	THIS_MODULE,
 	.name =		"HIOX CS4218",
 	.name2 =	"Built-in Sound",
-	.open =		CS_open,
-	.release =	CS_release,
 	.dma_alloc =	CS_Alloc,
 	.dma_free =	CS_Free,
 	.irqinit =	CS_IrqInit,
===== arch/ppc/8xx_io/uart.c 1.33 vs edited =====
--- 1.33/arch/ppc/8xx_io/uart.c	Wed Sep 24 08:15:15 2003
+++ edited/arch/ppc/8xx_io/uart.c	Mon May  3 13:25:48 2004
@@ -583,9 +583,7 @@
 #ifdef SERIAL_DEBUG_OPEN
 			printk("scheduling hangup...");
 #endif
-			MOD_INC_USE_COUNT;
-			if (schedule_task(&info->tqueue_hangup) == 0)
-				MOD_DEC_USE_COUNT;
+			schedule_task(&info->tqueue_hangup);
 		}
 	}
 	if (info->flags & ASYNC_CTS_FLOW) {
@@ -719,7 +717,6 @@
 	tty = info->tty;
 	if (tty)
 		tty_hangup(tty);
-	MOD_DEC_USE_COUNT;
 }

 /*static void rs_8xx_timer(void)
@@ -1664,7 +1661,6 @@

 	if (tty_hung_up_p(filp)) {
 		DBG_CNT("before DEC-hung");
-		MOD_DEC_USE_COUNT;
 		restore_flags(flags);
 		return;
 	}
@@ -1691,7 +1687,6 @@
 	}
 	if (state->count) {
 		DBG_CNT("before DEC-2");
-		MOD_DEC_USE_COUNT;
 		restore_flags(flags);
 		return;
 	}
@@ -1746,7 +1741,6 @@
 	}
 	info->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
 	wake_up_interruptible(&info->close_wait);
-	MOD_DEC_USE_COUNT;
 	restore_flags(flags);
 }

@@ -2008,14 +2002,12 @@
 	if (retval)
 		return retval;

-	MOD_INC_USE_COUNT;
 	retval = block_til_ready(tty, filp, info);
 	if (retval) {
 #ifdef SERIAL_DEBUG_OPEN
 		printk("rs_open returning after block_til_ready with %d\n",
 		       retval);
 #endif
-		MOD_DEC_USE_COUNT;
 		return retval;
 	}

@@ -2520,6 +2512,7 @@

 	/* Initialize the tty_driver structure */

+	serial_driver->owner = THIS_MODULE;
 	serial_driver->driver_name = "serial";
 	serial_driver->devfs_name = "tts/";
 	serial_driver->name = "ttyS";

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
