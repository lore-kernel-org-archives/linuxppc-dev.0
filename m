Subject: spurious hangups on serial console
From: "Guy M. Streeter" <streeter@redhat.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Content-Type: multipart/mixed; boundary="=-8nqMcqzIW/R59xg/cF65"
Message-Id: <1067283179.1034.44.camel@jarjar.hsv.redhat.com>
Mime-Version: 1.0
Date: 27 Oct 2003 13:32:59 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-8nqMcqzIW/R59xg/cF65
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

 I have been investigating a situation where the login prompt begins to
fail on a serial console. What I have discovered is that there is an
unexpected call to the serial driver's hangup() routine, between the
login prompt and the password prompt.
 I traced this to do_tty_hangup() (called from sys_vhangup), and I see
that it attempts to avoid calling the driver's hangup() routine for the
console device. The test for the console doesn't account for serial
console. The attached patch adds a check for ttyS0 if serial console is
configured.
 I only see this problem only recent kernels, and I don't know what
changed to make it start happening. Perhaps someone else has a better
idea?

--Guy



--=-8nqMcqzIW/R59xg/cF65
Content-Disposition: attachment; filename=serial_hangup.diff
Content-Type: text/plain; name=serial_hangup.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- v2.4.23-pre8/drivers/char/tty_io.c.orig	2003-10-27 13:22:19.000000000 -0600
+++ v2.4.23-pre8/drivers/char/tty_io.c	2003-10-27 13:23:49.000000000 -0600
@@ -109,6 +109,7 @@ extern void con_init_devfs (void);
 extern void disable_early_printk(void);

 #define CONSOLE_DEV MKDEV(TTY_MAJOR,0)
+#define SERIAL_CONSOLE_DEV MKDEV(TTY_MAJOR,64)
 #define TTY_DEV MKDEV(TTYAUX_MAJOR,0)
 #define SYSCONS_DEV MKDEV(TTYAUX_MAJOR,1)
 #define PTMX_DEV MKDEV(TTYAUX_MAJOR,2)
@@ -461,6 +462,9 @@ void do_tty_hangup(void *data)
 	for (l = tty->tty_files.next; l != &tty->tty_files; l = l->next) {
 		struct file * filp = list_entry(l, struct file, f_list);
 		if (filp->f_dentry->d_inode->i_rdev == CONSOLE_DEV ||
+#ifdef CONFIG_SERIAL_CONSOLE
+		    filp->f_dentry->d_inode->i_rdev == SERIAL_CONSOLE_DEV ||
+#endif
 		    filp->f_dentry->d_inode->i_rdev == SYSCONS_DEV) {
 			cons_filp = filp;
 			continue;

--=-8nqMcqzIW/R59xg/cF65--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
