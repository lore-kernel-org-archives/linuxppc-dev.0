Message-Id: <v04003a01b39922047ecb@[207.75.118.199]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 25 Jun 1999 08:15:23 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Ben Martz <benmartz@earthlink.net>
Subject: usb->adb update for usb mouse.c
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Here's an updated patch so that the 2.2.10 usb mouse driver sends mouse
events to the console, basically exactly the same way that
drivers/macintosh/mac_keyb.c does for abd mice.

I wrote this out of necessity for the mac-on-linux project because of the
way that we currently get mouse events and that I only have an iMac (no
adb!).

It only works with the primary button but that's plenty to work with MacOS.

BTW, for those interested, I have mac-on-linux running pretty stably on an
iMac here at MacHack '99.

-----

--- linux/drivers/usb/mouse.c.dist	Sun Jun 13 23:23:26 1999
+++ linux/drivers/usb/mouse.c	Thu Jun 24 06:04:34 1999
@@ -36,6 +36,12 @@
 #include <linux/config.h>
 #include <linux/module.h>

+#ifdef CONFIG_MOUSE_USB_EMULATE_ADB
+#include <linux/tty_flip.h>
+#include <linux/kbd_kern.h>
+#include <linux/kbd_ll.h>
+#endif
+
 #include <asm/spinlock.h>

 #include "usb.h"
@@ -61,8 +67,46 @@

 spinlock_t usb_mouse_lock = SPIN_LOCK_UNLOCKED;

+#ifdef CONFIG_MOUSE_USB_EMULATE_ADB
+
+extern struct kbd_struct	kbd_table[];
+extern struct wait_queue *	keypress_wait;
+extern int			console_loglevel;
+
+static void mac_put_queue(int ch)
+{
+	extern struct tty_driver	console_driver;
+	struct tty_struct *		tty;
+
+	tty = console_driver.table ? console_driver.table[fg_console] : 0L;
+	wake_up(&keypress_wait);
+	if(tty)
+	{
+		tty_insert_flip_char(tty, ch, 0);
+		con_schedule_flip(tty);
+	}
+}
+
+struct fake_data_t
+{
+	union
+	{
+		struct {
+			char	but : 1;
+			char	pos : 7;
+		} s_form;
+
+		char	i_form;
+	} data;
+};
+
+#endif /* CONFIG_MOUSE_USB_EMULATE_ADB */
+
 static int mouse_irq(int state, void *__buffer, void *dev_id)
 {
+#ifdef CONFIG_MOUSE_USB_EMULATE_ADB
+	struct kbd_struct *	kbd;
+#endif
 	signed char *data = __buffer;
 	/* finding the mouse is easy when there's only one */
 	struct mouse_state *mouse = &static_mouse_state;
@@ -85,6 +129,30 @@

 	add_mouse_randomness((mouse->buttons << 24) + (mouse->dz << 16 ) +
 				     (mouse->dy << 8) + mouse->dx);
+
+#ifdef CONFIG_MOUSE_USB_EMULATE_ADB
+	kbd = kbd_table + fg_console;
+
+	if (kbd->kbdmode == VC_RAW)
+	{
+		struct fake_data_t	fake_data_1, fake_data_2;
+
+		fake_data_1.data.s_form.but = !(data[0] & 0x01);
+		fake_data_1.data.s_form.pos = data[2] / 2; /* XXX - hack
for scaling */
+		fake_data_2.data.s_form.but = 0;
+		fake_data_2.data.s_form.pos = data[1] / 2; /* XXX - hack
for scaling */
+
+		mac_put_queue(0x7e);
+		mac_put_queue(fake_data_1.data.i_form);	/* data[1] */
+		mac_put_queue(fake_data_2.data.i_form);	/* data[2] */
+
+		if(console_loglevel >= 8)
+		{
+			printk("usb->adb: %02x %02x\n",fake_data_1.data.i_form,
+						fake_data_2.data.i_form);
+		}
+	}
+#endif

 	wake_up_interruptible(&mouse->wait);
 	if (mouse->fasync)
@@ -139,6 +207,7 @@
  * The PS/2 protocol is fairly strange, but
  * oh, well, it's at least common..
  */
+
 static ssize_t read_mouse(struct file * file, char * buffer, size_t count,
loff_t *ppos)
 {
 	int retval = 0;


----
Ben Martz - benmartz@earthlink.net


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
