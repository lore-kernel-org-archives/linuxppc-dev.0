Return-Path: <anton@ozlabs.org>
Date: Sat, 10 Jun 2006 22:16:23 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: console_initcall ordering issues
Message-ID: <20060610121622.GQ23891@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: akpm@osdl.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Milton Miller <miltonm@bga.com>

The add_preferred_console call in rtas_console.c was not causing the
console to be selected. It turns out that the add_preferred_console
was being called after the hvc_console driver was registered. It only
works when it is called before the console driver is registered.

Reorder hvc_console.o after the hvc_console drivers to allow the selection
during console_initcall processing.

Signed-Off-By: Milton Miller <miltonm@bga.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: kernel/drivers/char/Makefile
===================================================================
--- kernel.orig/drivers/char/Makefile	2006-06-05 22:49:52.056236490 -0500
+++ kernel/drivers/char/Makefile	2006-06-05 22:50:12.918997949 -0500
@@ -41,9 +41,9 @@ obj-$(CONFIG_N_HDLC)		+= n_hdlc.o
 obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
 obj-$(CONFIG_SX)		+= sx.o generic_serial.o
 obj-$(CONFIG_RIO)		+= rio/ generic_serial.o
-obj-$(CONFIG_HVC_DRIVER)	+= hvc_console.o
 obj-$(CONFIG_HVC_CONSOLE)	+= hvc_vio.o hvsi.o
 obj-$(CONFIG_HVC_RTAS)		+= hvc_rtas.o
+obj-$(CONFIG_HVC_DRIVER)	+= hvc_console.o
 obj-$(CONFIG_RAW_DRIVER)	+= raw.o
 obj-$(CONFIG_SGI_SNSC)		+= snsc.o snsc_event.o
 obj-$(CONFIG_MMTIMER)		+= mmtimer.o
