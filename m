Message-ID: <3971A06F.11228B3C@wanadoo.fr>
Date: Sun, 16 Jul 2000 13:45:51 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: RTC on 2.4.0-test4 (Was Re: Upgraded utils...)
References: <200007141730.SAA17219@hyperion.valhalla.net> <4.3.2.7.2.20000714210226.039b37f0@mail.munich.netsurf.de> <39708145.63271470@wanadoo.fr>
Content-Type: multipart/mixed;
 boundary="------------B43AE670C37C06A4B44EB954"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------B43AE670C37C06A4B44EB954
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Martin Costabel wrote:
>
> Franz Sirl wrote:
[]
> > Yes! That's why I did CONFIG_PPC_RTC, it's such simple code, but it helps a
> > lot to bring us in line with the other architectures.
>
> For the record: Yes, it works. (On a Pmac 6400, with a 2.2.17pre11
> kernel from bitkeeper; 2.4.0-test4 still doesn't want to boot, so I
> can't test it).

On bitkeeper kernel 2.4.0-test4, I could get it to work, with the
following modifications (a patch is attached below):

- The file drivers/macintosh/rtc.c was absent. I copied the one from the
_2_2 kernel tree and changed it in analogy to the sbus/rtc.c file.

- In drivers/macintosh/Makefile, rtc.o should be in O_OBJS instead of
L_OBJS.

- If compiled as module, rtc reports unresolved symbols, because the
EXPORT_SYMBOLS in arch/ppc/kernel/ppc_ksyms.c are between
#ifdef CONFIG_PPC_RTC - #endif
instead of #ifdef CONFIG_PPC_RTC_MODULE, as in the _2_2 tree.

--
Martin
--------------B43AE670C37C06A4B44EB954
Content-Type: text/plain; charset=us-ascii;
 name="rtc.patch"
Content-Disposition: inline;
 filename="rtc.patch"
Content-Transfer-Encoding: 7bit

--- linux-bk-2.3/arch/ppc/kernel/ppc_ksyms.c.ori	Sun Jul 16 09:00:19 2000
+++ linux-bk-2.3/arch/ppc/kernel/ppc_ksyms.c	Sun Jul 16 09:03:03 2000
@@ -254,7 +254,7 @@
 EXPORT_SYMBOL(pmac_xpram_read);
 EXPORT_SYMBOL(pmac_xpram_write);
 #endif /* CONFIG_NVRAM */
-#ifdef CONFIG_PPC_RTC
+#ifdef CONFIG_PPC_RTC_MODULE
 EXPORT_SYMBOL(mktime);
 EXPORT_SYMBOL(to_tm);
 #endif
--- linux-bk-2.3/drivers/macintosh/Makefile.ori	Sat Jul 15 23:56:39 2000
+++ linux-bk-2.3/drivers/macintosh/Makefile	Sat Jul 15 23:56:09 2000
@@ -41,7 +41,7 @@
 endif

 ifeq ($(CONFIG_PPC_RTC),y)
-  L_OBJS += rtc.o
+  O_OBJS += rtc.o
 else
   ifeq ($(CONFIG_PPC_RTC),m)
     M_OBJS += rtc.o
--- linux-bk-2.2/drivers/macintosh/rtc.c	Mon Jun 26 09:09:05 2000
+++ linux-bk-2.3/drivers/macintosh/rtc.c	Sun Jul 16 08:42:25 2000
@@ -21,6 +21,7 @@
 #include <linux/fcntl.h>
 #include <linux/poll.h>
 #include <linux/init.h>
+#include <linux/smp_lock.h>
 #include <linux/mc146818rtc.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -53,7 +54,7 @@

 	nowtime = mktime(t->tm_year+1900, t->tm_mon+1, t->tm_mday, t->tm_hour, t->tm_min, t->tm_sec);

-	printk(KERN_INFO "rtc.c:set_rtc_time: set rtc time to %d seconds.\n", nowtime);
+	printk(KERN_INFO "rtc.c:set_rtc_time: set rtc time to %ld seconds.\n", nowtime);

 	(ppc_md.set_rtc_time)(nowtime);
 }
@@ -109,29 +110,23 @@

 	rtc_busy = 1;

-	MOD_INC_USE_COUNT;
-
 	return 0;
 }

 static int rtc_release(struct inode *inode, struct file *file)
 {
-	MOD_DEC_USE_COUNT;
+	lock_kernel();
 	rtc_busy = 0;
+	unlock_kernel();
 	return 0;
 }

 static struct file_operations rtc_fops = {
-	rtc_lseek,
-	NULL,		/* rtc_read */
-	NULL,		/* rtc_write */
-	NULL,		/* rtc_readdir */
-	NULL,		/* rtc_poll */
-	rtc_ioctl,
-	NULL,		/* rtc_mmap */
-	rtc_open,
-	NULL,		/* flush */
-	rtc_release
+	owner:          THIS_MODULE,
+	llseek:         rtc_lseek,
+	ioctl:          rtc_ioctl,
+	open:           rtc_open,
+	release:        rtc_release,
 };

 static struct miscdevice rtc_dev = { RTC_MINOR, "rtc", &rtc_fops };
@@ -141,7 +136,7 @@
 #ifdef MODULE
 int init_module(void)
 #else
-__initfunc(int rtc_init(void))
+int __init rtc_init(void)
 #endif
 {
 	int error;


--------------B43AE670C37C06A4B44EB954--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
