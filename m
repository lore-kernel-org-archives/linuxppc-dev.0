Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5002C67A62
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2005 12:39:36 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 18 Jan 2005 12:39:18 +1100
Message-Id: <1106012359.4533.35.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Add try_acquire_console_sem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

The new PowerMac sleep code provides an arch hook that can be used by video drivers
on laptops to bring back the screen very early, pretty much before anything else.
This basically turns reports of the style "my laptop doesn't wakeup" to "I get this
or this oops/error/panic on wakeup", making fixing the PM related bugs possible on
a whole range of them.

However, the fbdev wakeup code triggers WARN_ON's in the VT subsystem if called
without the console semaphore when redrawing the screen (I added those warnings a
couple of kernel versions ago), and we can't call acquire_console_sem() since we
are so early in the wakeup process that we are considered as in_atomic() (we hold
irqs off too).

This patch addds a try_acquire_console_sem() function that can be used by those
video drivers that implement this early wakeup hook. If the acquire fails (which
should never happen in practice), wakeup is delayed to the normal PCI callback
which does a blocking acquire_console_sem().

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/include/linux/console.h
===================================================================
--- linux-work.orig/include/linux/console.h	2004-11-22 11:50:54.000000000 +1100
+++ linux-work/include/linux/console.h	2005-01-17 13:49:21.006958624 +1100
@@ -105,6 +105,7 @@
 extern int unregister_console(struct console *);
 extern struct console *console_drivers;
 extern void acquire_console_sem(void);
+extern int try_acquire_console_sem(void);
 extern void release_console_sem(void);
 extern void console_conditional_schedule(void);
 extern void console_unblank(void);
Index: linux-work/kernel/printk.c
===================================================================
--- linux-work.orig/kernel/printk.c	2005-01-14 08:17:22.000000000 +1100
+++ linux-work/kernel/printk.c	2005-01-17 13:49:21.008958320 +1100
@@ -611,6 +611,16 @@
 }
 EXPORT_SYMBOL(acquire_console_sem);
 
+int try_acquire_console_sem(void)
+{
+	if (down_trylock(&console_sem))
+		return -1;
+	console_locked = 1;
+	console_may_schedule = 0;
+	return 0;
+}
+EXPORT_SYMBOL(try_acquire_console_sem);
+
 int is_console_locked(void)
 {
 	return console_locked;
