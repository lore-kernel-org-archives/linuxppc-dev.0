Date: Wed, 18 Dec 2002 13:35:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Arctic-2 touchscreen driver
Message-ID: <20021218023548.GF3666@zax.zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Below is a patch against linuxppc_2_4_devel which adds support for the
touchscreen controller on the Arctic-2: this is a Semtech device
attached to the 405LP's second serial port.

This driver is *not* ready to be committed to the tree - if nothing
else, it arbitrarily allocates a new constant in
include/linux/serio.h.  Still, I'm sending this patch out so people
can look at it, and so the (very few, so far) people outside IBM with
Arctic-2s can start to play with it.

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/drivers/char/Config.in linux-bartholomew/drivers/char/Config.in
--- /home/dgibson/kernel/linuxppc_2_4_devel/drivers/char/Config.in	2002-12-16 15:09:46.000000000 +1100
+++ linux-bartholomew/drivers/char/Config.in	2002-12-17 16:24:31.000000000 +1100
@@ -361,4 +361,9 @@
    tristate 'Xilinx on-chip GPIO' CONFIG_XILINX_GPIO
 fi

+# FIXME: depend on SERIO/SERPORT too?
+if [ "$CONFIG_ARCTIC2" = "y" ]; then
+   tristate 'Arctic II Semtech Touchscreen controller' CONFIG_IBMTS_SEMTECH
+fi
+
 endmenu
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/drivers/char/Makefile linux-bartholomew/drivers/char/Makefile
--- /home/dgibson/kernel/linuxppc_2_4_devel/drivers/char/Makefile	2002-12-16 15:09:46.000000000 +1100
+++ linux-bartholomew/drivers/char/Makefile	2002-12-17 16:24:59.000000000 +1100
@@ -290,6 +290,7 @@
 obj-$(CONFIG_AMD7XX_TCO) += amd7xx_tco.o
 obj-$(CONFIG_PPC405_WDT)  += ppc405_wdt.o
 obj-$(CONFIG_IBM_OCP_GPIO) += ibm_ocp_gpio.o
+obj-$(CONFIG_IBMTS_SEMTECH) += ibmts_semtech.o

 mod-subdirs     +=	xilinx_gpio
 subdir-$(CONFIG_XILINX_GPIO) += xilinx_gpio
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/drivers/char/ibmts_semtech.c linux-bartholomew/drivers/char/ibmts_semtech.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/drivers/char/ibmts_semtech.c	Thu Jan 01 10:00:00 1970
+++ linux-bartholomew/drivers/char/ibmts_semtech.c	Wed Dec 18 13:32:31 2002
@@ -0,0 +1,380 @@
+/* IBM Arctic-2 Semtech touch panel controller driver for /dev/ibmts interface
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ *  Copyright (C) 2002 IBM Corporation.
+ *
+ * Ken Inoue
+ * IBM Thomas J. Watson Research Center
+ * <keninoue@us.ibm.com>
+ *
+ * David Gibson
+ * IBM OzLabs, Canberra, Australia.
+ * <arctic@gibson.dropbear.id.au>
+ */
+
+#include <linux/module.h>      /* Get my module mojo */
+#include <linux/types.h>       /* int16_t ... */
+#include <linux/poll.h>        /* polling macros */
+#include <linux/interrupt.h>   /* Tasklets */
+#include <linux/sched.h>       /* wait_on, etc */
+#include <linux/wait.h>        /* wait queues */
+#include <linux/init.h>        /* module_init() macro */
+#include <linux/spinlock.h>    /* mutex structures/code */
+#include <linux/fs.h>          /* struct file, struct inode */
+#include <linux/serio.h>
+
+#define IBMTS_DEVICE_NAME	"ibmts"
+#define IBMTS_MAJOR		254
+
+#define IBMTS_SAMPLES 128
+#define IBMTS_TIMEOUT_INTERVAL 10
+
+#define PEN_RELEASE 0
+#define PEN_GLIDE   2
+#define PEN_PRESS   1
+
+struct ts_event {
+	short pressure;     /* Pressure of stylus  - 0 for release, positive otherwise */
+	int x;              /* X coordinate stylus - -1 for PEN_RELEASE */
+	int y;              /* Y coordinate stylus - -1 for PEN_RELEASE */
+	int millisecs; /* A timestamp */
+	unsigned int flags; /* kind of event, and reserved bits */
+};
+
+typedef struct ibmts_semtech_event {
+	struct ibmts_semtech_event *pNext;
+	struct ts_event event;
+} ibmts_semtech_event;
+
+// HACK: FIXME: put the following in a dynamically allocated struct
+
+static int IsOpenForRead = 0;
+
+static unsigned char pen_down = 0;
+
+static wait_queue_head_t ibmts_semtech_proc_list;
+
+static spinlock_t ibmts_semtech_lock = SPIN_LOCK_UNLOCKED;
+
+#define SEMTECH_FSM_RESET 0
+#define SEMTECH_FSM_DATA_READY 4
+
+#define SEMTECH_SYNC_FLAG 0x80
+
+static unsigned char semtech_FSM = SEMTECH_FSM_RESET;
+static unsigned char semtech_data_index = 0;
+static unsigned char semtech_data[4];
+static unsigned char semtech_FSM_next[] = {
+	(SEMTECH_FSM_RESET + 1), (SEMTECH_FSM_RESET + 2),
+	(SEMTECH_FSM_RESET + 3), SEMTECH_FSM_DATA_READY
+};
+
+static ibmts_semtech_event events[IBMTS_SAMPLES];
+
+static ibmts_semtech_event *ibmts_semtech_rdp = NULL;
+static ibmts_semtech_event *ibmts_semtech_wrp = NULL;
+
+static int queue_empty(void)
+{
+	return (ibmts_semtech_rdp == ibmts_semtech_wrp);
+}
+
+struct ts_event *ibmts_semtech_get_event(void)
+{
+        unsigned long flags;
+        ibmts_semtech_event *result;
+
+        spin_lock_irqsave(&ibmts_semtech_lock, flags);
+
+	if ( (ibmts_semtech_rdp == NULL) || queue_empty() )
+		return NULL;
+
+	result = ibmts_semtech_rdp;
+        ibmts_semtech_rdp = ibmts_semtech_rdp->pNext;
+
+        spin_unlock_irqrestore(&ibmts_semtech_lock, flags);
+        return &(result->event);
+};
+
+static void ibmts_semtech_put_event(struct ts_event *pEvent)
+{
+	if ( ibmts_semtech_rdp == NULL)
+                return;
+
+	if (! IsOpenForRead)
+		return;
+
+	ibmts_semtech_wrp->event.pressure = pEvent->pressure;
+	ibmts_semtech_wrp->event.x = pEvent->x;
+	ibmts_semtech_wrp->event.y = pEvent->y;
+	ibmts_semtech_wrp->event.millisecs = pEvent->millisecs;
+	ibmts_semtech_wrp->event.flags = pEvent->flags;
+
+	ibmts_semtech_wrp = ibmts_semtech_wrp->pNext;
+	if (ibmts_semtech_wrp == ibmts_semtech_rdp) /* Wrap */
+		ibmts_semtech_rdp = ibmts_semtech_rdp->pNext; /* Write over */
+	else
+		if (waitqueue_active(&ibmts_semtech_proc_list))
+			wake_up_interruptible(&ibmts_semtech_proc_list);
+}
+
+static int ibmts_semtech_open(struct inode *inode, struct file *file)
+{
+  	int i;
+
+  	printk("ibmts: %d.%d\n",
+	       inode->i_rdev >> 8, inode->i_rdev & 0xFF);
+        if (file->f_flags & O_NONBLOCK)
+		printk("ibmts: Non-blocked mode\n");
+	else
+		printk("ibmts: Blocked mode\n");
+
+	if ((file-> f_mode & FMODE_READ)) {
+  		if (IsOpenForRead)
+			return -EBUSY;
+      		IsOpenForRead++;
+   	}
+
+
+	/* Initialize the structs. */
+	ibmts_semtech_rdp = &(events[0]);
+	ibmts_semtech_wrp = ibmts_semtech_rdp;
+	for (i=0; i<IBMTS_SAMPLES; i++)
+		events[i].pNext = &(events[i+1]);
+
+	events[IBMTS_SAMPLES-1].pNext = &(events[0]);
+	pen_down = 0;
+	semtech_FSM = SEMTECH_FSM_RESET;
+	semtech_data_index = 0;
+
+	MOD_INC_USE_COUNT;
+
+	return 0;
+}
+
+
+static int ibmts_semtech_release(struct inode *inode, struct file *file)
+{
+	if ((file-> f_mode & FMODE_READ))
+  		IsOpenForRead--;
+
+	MOD_DEC_USE_COUNT;
+
+  	return 0;
+}
+
+static ssize_t ibmts_semtech_read(struct file *pFile, char *buffer,
+				  size_t count, loff_t *ppos)
+{
+        ssize_t bytes_read = 0;
+        struct ts_event *pWork;
+
+        while (queue_empty()) { /* wait for an event */
+                if (pFile->f_flags & O_NONBLOCK)
+                        return -EWOULDBLOCK;
+
+		if (wait_event_interruptible(ibmts_semtech_proc_list, ! queue_empty()))
+			return -ERESTARTSYS;
+        }
+
+        while ( (bytes_read < count)  && (! queue_empty()) ) {
+                pWork = ibmts_semtech_get_event();
+		if (pWork) {
+	                if (copy_to_user (buffer + bytes_read, (void *) pWork,
+					  sizeof(struct ts_event))) {
+        	                bytes_read = -EFAULT;
+                	        break;
+	                }
+        	        bytes_read += sizeof(struct ts_event);
+			if (count - bytes_read < sizeof(struct ts_event)) break;
+		}
+        }
+
+        if (bytes_read > 0)
+                return bytes_read;
+
+        if (signal_pending(current))
+                return -ERESTARTSYS;
+
+        return bytes_read;
+}
+
+static ssize_t ibmts_semtech_write(struct file *file, const char *buffer,
+				   size_t length, loff_t *ppos)
+{
+	return -EINVAL;
+}
+
+static int ibmts_semtech_ioctl(struct inode * dev_inode, struct file *filep,
+			       unsigned int cmd, unsigned long arg)
+{
+	return -EINVAL;
+}
+
+/*
+  Poll for input - return code indicating if there is input to read.
+ */
+
+static unsigned int
+ibmts_semtech_poll (struct file* filp, poll_table * wait)
+{
+        poll_wait(filp, &ibmts_semtech_proc_list, wait);
+        return queue_empty() ? 0 : (POLLIN | POLLRDNORM);
+}
+
+/* Module Declarations ***************************** */
+
+static struct file_operations ibmts_semtech_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ibmts_semtech_open,
+  	.read		= ibmts_semtech_read,
+  	.write		= ibmts_semtech_write,
+	.ioctl		= ibmts_semtech_ioctl,
+	.poll		= ibmts_semtech_poll,
+  	.release	= ibmts_semtech_release
+};
+
+/*
+ * Serial I/O routines (requires drivers/char/joystick/serio and serport)
+ */
+
+static void semtech_parse_data(unsigned char *pData)
+{
+	struct ts_event event;
+	unsigned int dx, dy;
+
+/* #define IBMTS_SEMTECH_XYSWAP */
+
+#if defined(IBMTS_SEMTECH_XYSWAP)
+        dx = (((unsigned int)pData[1] & 0x70) << 3) | ((unsigned int)pData[3] & 0x7f);
+        dy = (((unsigned int)pData[1] & 0x07) << 7) | ((unsigned int)pData[2] & 0x7f);
+#else
+        dy = (((unsigned int)pData[1] & 0x70) << 3) | ((unsigned int)pData[3] & 0x7f);
+        dx = (((unsigned int)pData[1] & 0x07) << 7) | ((unsigned int)pData[2] & 0x7f);
+#endif
+
+	if (! pen_down) { /* Pen up until now */
+                if (( pData[0] & 0x1f)) { /* Pen still up */
+                        return;
+                } else {
+                        event.flags = PEN_PRESS; /* Press */
+                        event.x = dx;
+                        event.y = dy;
+                        event.pressure = 500;
+                        event.millisecs = jiffies*10;
+                        pen_down = 1;
+                }
+
+        } else { /* Pen was down */
+                if (pData[0] & 0x07f) { /* Pen up */
+                        event.flags = PEN_RELEASE; /* 0: Up */
+                        event.x = -1;
+                        event.y = -1;
+                        event.pressure = 0;
+                        event.millisecs = jiffies*10;
+                        pen_down = 0;
+                } else {
+                        event.flags = PEN_GLIDE;
+                        event.x = dx;
+                        event.y = dy;
+                        event.pressure = 500;
+                        event.millisecs = jiffies * 10;
+                }
+        }
+	ibmts_semtech_put_event(&event); /* Wakeup handled in put_event() */
+}
+
+static void semtechts_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
+{
+	/* Between packets & sync flag on, or In packet & sync flag off */
+	if ( ( (semtech_FSM == SEMTECH_FSM_RESET) && (data & SEMTECH_SYNC_FLAG) ) ||
+	     ( (semtech_FSM != SEMTECH_FSM_RESET) && !(data & SEMTECH_SYNC_FLAG) ) ) {
+		/* Record and proceed to next stage   */
+		semtech_data[semtech_data_index++] = data;
+		semtech_FSM = semtech_FSM_next[semtech_FSM];
+	} else { /* Out of sync */
+		semtech_FSM = SEMTECH_FSM_RESET;
+	}
+
+	/* Full packet received, process it now */
+	if (semtech_FSM == SEMTECH_FSM_DATA_READY) {
+		semtech_parse_data(semtech_data);
+		semtech_FSM = SEMTECH_FSM_RESET;
+		semtech_data_index = 0;
+	}
+
+}
+
+static void semtechts_connect(struct serio *serio, struct serio_dev *dev)
+{
+	if (serio->type != (SERIO_RS232 | SERIO_SEMTECHTS)) { /* Must be in serio.h and inputattach.c */
+		printk("semtechts_connect():  serio has wrong type\n");
+		return;
+	}
+
+	if (serio_open(serio, dev)) {
+		printk("semtechts: serio_open failed\n");
+		return;
+	}
+}
+
+static void semtechts_disconnect(struct serio *serio)
+{
+	serio_close(serio);
+}
+
+static struct serio_dev semtechts_dev = {
+	.interrupt	= semtechts_interrupt,
+	.connect	= semtechts_connect,
+	.disconnect	= semtechts_disconnect,
+};
+
+MODULE_AUTHOR("Ken Inoue");
+MODULE_DESCRIPTION("IBM Arctic-2 Semtech touch panel controller driver\n");
+
+int __init init_ibmts_semtech_module(void)
+{
+	int err;
+
+	init_waitqueue_head(&ibmts_semtech_proc_list);
+
+  	err = register_chrdev(IBMTS_MAJOR, IBMTS_DEVICE_NAME, &ibmts_semtech_fops);
+
+  	if (err < 0) {
+    		printk("ibmts_semtech: register_chrdev failed with %d\n",  err);
+	    	return err;
+	}
+
+  	printk("ibmts_semtech: v0.02 e-8 device major %d \n", IBMTS_MAJOR);
+
+	serio_register_device(&semtechts_dev);
+
+  	return 0;
+}
+
+void cleanup_ibmts_semtech_module(void)
+{
+  	int ret;
+
+  	ret = unregister_chrdev(IBMTS_MAJOR, IBMTS_DEVICE_NAME);
+	if (ret < 0)
+		printk("Error : unregister_chrdev: %d\n", ret);
+
+	serio_unregister_device(&semtechts_dev);
+}
+
+module_init(init_ibmts_semtech_module);
+module_exit(cleanup_ibmts_semtech_module);


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
