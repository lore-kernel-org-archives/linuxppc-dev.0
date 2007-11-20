Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it
	(host20-155-static.82-213-b.business.telecomitalia.it
	[213.82.155.20]) by ozlabs.org (Postfix) with ESMTP id 66E2CDDE1C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Nov 2007 07:29:20 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C82BB3.AF99B85E"
Subject: linux2.6.19.2-> mpc8xx_wdt.c: timeout extended to reach several
	seconds... but I have a problem
Date: Tue, 20 Nov 2007 21:26:52 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E2649FB@aquib01a>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C82BB3.AF99B85E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Till yesterday I thought I was able to code a simple driver but now I'm =
facing a problem that is puzzling me.

I added a kernel timer (triggering every 500 ms) to reset the watchdog =
of mpc8xx. This timer starts when the driver is opened. The timer is =
rearmed till a counter reaches a zero value. A process can use the write =
method of the driver to set the counter to a preferred value. If the =
application misses to set the counter, it will decrease to zero and then =
the board will restart.

Unfortunately as soon as my application "calls" the write method the =
kernel freezes. If the watchdog is enabled the board restarts otherwise =
the kernel remains blocked forever without any indication. Even if I =
empty the write method leaving only the get_user the board freezes. =
Below you can find the code, if anyone has an hint I would really =
appreciate his advice:

_________________________________________________________________________=
__________
/*
 * mpc8xx_wdt.c - MPC8xx watchdog userspace interface
 *
 * Author: Florian Schirmer <jolt@tuxbox.org>
 *
 * 2002 (c) Florian Schirmer <jolt@tuxbox.org> This file is licensed =
under
 * the terms of the GNU General Public License version 2. This program
 * is licensed "as is" without any warranty of any kind, whether express
 * or implied.
 */

#include <linux/fs.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/miscdevice.h>
#include <linux/module.h>
#include <linux/watchdog.h>
#include <asm/8xx_immap.h>
#include <asm/uaccess.h>
#include <asm/io.h>
#include <syslib/m8xx_wdt.h>

#define KTIMER_TIMEOUT  (HZ/2)

static struct timer_list wd_timer;	/* structure for timer administration	=
	*/
static unsigned long mpc8xx_wdt_dummy;
static int timer_count =3D 600;
static unsigned long wdt_opened;
static int wdt_status;
static spinlock_t counter_spinlock;

static void mpc8xx_wdt_handler_disable(void)
{
	volatile ushort __iomem *piscr;
	piscr =3D (ushort *)&((immap_t*)IMAP_ADDR)->im_sit.sit_piscr;

	if (!m8xx_has_internal_rtc)
		m8xx_wdt_stop_timer();
	else
		out_be16(piscr, in_be16(piscr) & ~(PISCR_PIE | PISCR_PTE));

	printk(KERN_NOTICE "mpc8xx_wdt: keep-alive handler deactivated\n");
}

static void mpc8xx_wdt_handler_enable(void)
{
	volatile ushort __iomem *piscr;
	piscr =3D (ushort *)&((immap_t*)IMAP_ADDR)->im_sit.sit_piscr;

	if (!m8xx_has_internal_rtc)
		m8xx_wdt_install_timer();
	else
		out_be16(piscr, in_be16(piscr) | PISCR_PIE | PISCR_PTE);

	printk(KERN_NOTICE "mpc8xx_wdt: keep-alive handler activated\n");
}



static int mpc8xx_wdt_open(struct inode *inode, struct file *file)
{
	if (test_and_set_bit(0, &wdt_opened))
		return -EBUSY;

	m8xx_wdt_reset();

        wd_timer.expires =3D jiffies + KTIMER_TIMEOUT;  =20
        add_timer (&wd_timer);	/* ...re-activate timer */=20
   =20
	mpc8xx_wdt_handler_disable();

	return 0;
}

static int mpc8xx_wdt_release(struct inode *inode, struct file *file)
{
	m8xx_wdt_reset();

#if !defined(CONFIG_WATCHDOG_NOWAYOUT)
	mpc8xx_wdt_handler_enable();
#endif

	clear_bit(0, &wdt_opened);

	return 0;
}

static void mpc8xx_wdt_ktimer_handler(unsigned long data)
{
    int counter;
   =20
    spin_lock(&counter_spinlock);
    counter =3D timer_count--;
    spin_unlock(&counter_spinlock);
   =20
   =20
    printk("Counter %d\n", counter);
   =20
    if (counter > 0)
    {
      wd_timer.expires =3D jiffies + KTIMER_TIMEOUT;  =20
      add_timer (&wd_timer);	/* ...re-activate timer */=20
      m8xx_wdt_reset();
    }
    else
    {
      printk(KERN_NOTICE "mpc8xx_wdt: Watchdog expired ... =
restarting\n");
    }
}


static ssize_t mpc8xx_wdt_write(struct file *file, const char *data, =
size_t len, loff_t * ppos)
{
        unsigned long flags;
	int new_count;


	if (len !=3D sizeof(new_count))=20
        {
		return -EINVAL;
	}

	/* copy count value into kernel space */
	get_user(new_count, (int *) data);
        printk("new_count %d\n", new_count);

        /* Removing the following three lines doesn't prevent=20
           the kernel freeze */
        spin_lock_irqsave(&counter_spinlock, flags);
	timer_count =3D (HZ*new_count)/KTIMER_TIMEOUT;
        spin_unlock_irqrestore(&counter_spinlock, flags);
       =20
	return (sizeof(new_count));
}

static int mpc8xx_wdt_ioctl(struct inode *inode, struct file *file,
			    unsigned int cmd, unsigned long arg)
{
	int timeout;
	static struct watchdog_info info =3D {
		.options =3D WDIOF_KEEPALIVEPING,
		.firmware_version =3D 0,
		.identity =3D "MPC8xx watchdog",
	};

	switch (cmd) {
	case WDIOC_GETSUPPORT:
		if (copy_to_user((void *)arg, &info, sizeof(info)))
			return -EFAULT;
		break;

	case WDIOC_GETSTATUS:
	case WDIOC_GETBOOTSTATUS:
		if (put_user(wdt_status, (int *)arg))
			return -EFAULT;
		wdt_status &=3D ~WDIOF_KEEPALIVEPING;
		break;

	case WDIOC_GETTEMP:
		return -EOPNOTSUPP;

	case WDIOC_SETOPTIONS:
		return -EOPNOTSUPP;

	case WDIOC_KEEPALIVE:
		m8xx_wdt_reset();
		wdt_status |=3D WDIOF_KEEPALIVEPING;
		break;

	case WDIOC_SETTIMEOUT:
		return -EOPNOTSUPP;

	case WDIOC_GETTIMEOUT:
		timeout =3D m8xx_wdt_get_timeout();
		if (put_user(timeout, (int *)arg))
			return -EFAULT;
		break;

	default:
		return -ENOTTY;
	}

	return 0;
}

static const struct file_operations mpc8xx_wdt_fops =3D {
	.owner =3D THIS_MODULE,
	.llseek =3D no_llseek,
	.write =3D mpc8xx_wdt_write,
	.ioctl =3D mpc8xx_wdt_ioctl,
	.open =3D mpc8xx_wdt_open,
	.release =3D mpc8xx_wdt_release,
};

static struct miscdevice mpc8xx_wdt_miscdev =3D {
	.minor =3D WATCHDOG_MINOR,
	.name =3D "watchdog",
	.fops =3D &mpc8xx_wdt_fops,
};


static int __init mpc8xx_wdt_init(void)
{
	init_timer (&wd_timer);			/* initialize timer-structure... */
	wd_timer.function =3D mpc8xx_wdt_ktimer_handler;
	wd_timer.data =3D (unsigned long) &mpc8xx_wdt_dummy;
        spin_lock_init(&counter_spinlock);
	return misc_register(&mpc8xx_wdt_miscdev);
}

static void __exit mpc8xx_wdt_exit(void)
{
	misc_deregister(&mpc8xx_wdt_miscdev);

	m8xx_wdt_reset();
	mpc8xx_wdt_handler_enable();
}

module_init(mpc8xx_wdt_init);
module_exit(mpc8xx_wdt_exit);

MODULE_AUTHOR("Florian Schirmer <jolt@tuxbox.org>");
MODULE_DESCRIPTION("MPC8xx watchdog driver");
MODULE_LICENSE("GPL");
MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
_________________________________________________________________________=
___


------_=_NextPart_001_01C82BB3.AF99B85E
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7235.2">
<TITLE>linux2.6.19.2-&gt; mpc8xx_wdt.c: timeout extended to reach =
several seconds... but I have a problem </TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Till yesterday I thought I was able to code a simple =
driver but now I'm facing a problem that is puzzling me.<BR>
<BR>
I added a kernel timer (triggering every 500 ms) to reset the watchdog =
of mpc8xx. This timer starts when the driver is opened. The timer is =
rearmed till a counter reaches a zero value. A process can use the write =
method of the driver to set the counter to a preferred value. If the =
application misses to set the counter, it will decrease to zero and then =
the board will restart.<BR>
<BR>
Unfortunately as soon as my application &quot;calls&quot; the write =
method the kernel freezes. If the watchdog is enabled the board restarts =
otherwise the kernel remains blocked forever without any indication. =
Even if I empty the write method leaving only the get_user the board =
freezes. Below you can find the code, if anyone has an hint I would =
really appreciate his advice:<BR>
<BR>
_________________________________________________________________________=
__________<BR>
/*<BR>
&nbsp;* mpc8xx_wdt.c - MPC8xx watchdog userspace interface<BR>
&nbsp;*<BR>
&nbsp;* Author: Florian Schirmer &lt;jolt@tuxbox.org&gt;<BR>
&nbsp;*<BR>
&nbsp;* 2002 (c) Florian Schirmer &lt;jolt@tuxbox.org&gt; This file is =
licensed under<BR>
&nbsp;* the terms of the GNU General Public License version 2. This =
program<BR>
&nbsp;* is licensed &quot;as is&quot; without any warranty of any kind, =
whether express<BR>
&nbsp;* or implied.<BR>
&nbsp;*/<BR>
<BR>
#include &lt;linux/fs.h&gt;<BR>
#include &lt;linux/init.h&gt;<BR>
#include &lt;linux/kernel.h&gt;<BR>
#include &lt;linux/miscdevice.h&gt;<BR>
#include &lt;linux/module.h&gt;<BR>
#include &lt;linux/watchdog.h&gt;<BR>
#include &lt;asm/8xx_immap.h&gt;<BR>
#include &lt;asm/uaccess.h&gt;<BR>
#include &lt;asm/io.h&gt;<BR>
#include &lt;syslib/m8xx_wdt.h&gt;<BR>
<BR>
#define KTIMER_TIMEOUT&nbsp; (HZ/2)<BR>
<BR>
static struct timer_list wd_timer;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
structure for timer administration&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>
static unsigned long mpc8xx_wdt_dummy;<BR>
static int timer_count =3D 600;<BR>
static unsigned long wdt_opened;<BR>
static int wdt_status;<BR>
static spinlock_t counter_spinlock;<BR>
<BR>
static void mpc8xx_wdt_handler_disable(void)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile ushort __iomem =
*piscr;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; piscr =3D (ushort =
*)&amp;((immap_t*)IMAP_ADDR)-&gt;im_sit.sit_piscr;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!m8xx_has_internal_rtc)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m8xx_wdt_stop_timer();<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_be16(piscr, =
in_be16(piscr) &amp; ~(PISCR_PIE | PISCR_PTE));<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_NOTICE =
&quot;mpc8xx_wdt: keep-alive handler deactivated\n&quot;);<BR>
}<BR>
<BR>
static void mpc8xx_wdt_handler_enable(void)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile ushort __iomem =
*piscr;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; piscr =3D (ushort =
*)&amp;((immap_t*)IMAP_ADDR)-&gt;im_sit.sit_piscr;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!m8xx_has_internal_rtc)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m8xx_wdt_install_timer();<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_be16(piscr, =
in_be16(piscr) | PISCR_PIE | PISCR_PTE);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_NOTICE =
&quot;mpc8xx_wdt: keep-alive handler activated\n&quot;);<BR>
}<BR>
<BR>
<BR>
<BR>
static int mpc8xx_wdt_open(struct inode *inode, struct file *file)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (test_and_set_bit(0, =
&amp;wdt_opened))<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EBUSY;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m8xx_wdt_reset();<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wd_timer.expires =3D jiffies =
+ KTIMER_TIMEOUT;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; add_timer =
(&amp;wd_timer);&nbsp; /* ...re-activate timer */<BR>
&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mpc8xx_wdt_handler_disable();<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
}<BR>
<BR>
static int mpc8xx_wdt_release(struct inode *inode, struct file =
*file)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m8xx_wdt_reset();<BR>
<BR>
#if !defined(CONFIG_WATCHDOG_NOWAYOUT)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mpc8xx_wdt_handler_enable();<BR>
#endif<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clear_bit(0, =
&amp;wdt_opened);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
}<BR>
<BR>
static void mpc8xx_wdt_ktimer_handler(unsigned long data)<BR>
{<BR>
&nbsp;&nbsp;&nbsp; int counter;<BR>
&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp; spin_lock(&amp;counter_spinlock);<BR>
&nbsp;&nbsp;&nbsp; counter =3D timer_count--;<BR>
&nbsp;&nbsp;&nbsp; spin_unlock(&amp;counter_spinlock);<BR>
&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp; printk(&quot;Counter %d\n&quot;, counter);<BR>
&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp; if (counter &gt; 0)<BR>
&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wd_timer.expires =3D jiffies + =
KTIMER_TIMEOUT;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; add_timer =
(&amp;wd_timer);&nbsp;&nbsp;&nbsp; /* ...re-activate timer */<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m8xx_wdt_reset();<BR>
&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&nbsp;&nbsp; else<BR>
&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_NOTICE &quot;mpc8xx_wdt: =
Watchdog expired ... restarting\n&quot;);<BR>
&nbsp;&nbsp;&nbsp; }<BR>
}<BR>
<BR>
<BR>
static ssize_t mpc8xx_wdt_write(struct file *file, const char *data, =
size_t len, loff_t * ppos)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int new_count;<BR>
<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (len !=3D =
sizeof(new_count))<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* copy count value into =
kernel space */<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_user(new_count, (int *) =
data);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(&quot;new_count =
%d\n&quot;, new_count);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Removing the following =
three lines doesn't prevent<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the kernel =
freeze */<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
spin_lock_irqsave(&amp;counter_spinlock, flags);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timer_count =3D =
(HZ*new_count)/KTIMER_TIMEOUT;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
spin_unlock_irqrestore(&amp;counter_spinlock, flags);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
(sizeof(new_count));<BR>
}<BR>
<BR>
static int mpc8xx_wdt_ioctl(struct inode *inode, struct file *file,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; unsigned =
int cmd, unsigned long arg)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int timeout;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static struct watchdog_info =
info =3D {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .options =3D =
WDIOF_KEEPALIVEPING,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .firmware_version =3D 0,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .identity =3D &quot;MPC8xx =
watchdog&quot;,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (cmd) {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case WDIOC_GETSUPPORT:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (copy_to_user((void *)arg, =
&amp;info, sizeof(info)))<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case WDIOC_GETSTATUS:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case WDIOC_GETBOOTSTATUS:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (put_user(wdt_status, (int =
*)arg))<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wdt_status &amp;=3D =
~WDIOF_KEEPALIVEPING;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case WDIOC_GETTEMP:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case WDIOC_SETOPTIONS:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case WDIOC_KEEPALIVE:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m8xx_wdt_reset();<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wdt_status |=3D =
WDIOF_KEEPALIVEPING;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case WDIOC_SETTIMEOUT:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case WDIOC_GETTIMEOUT:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout =3D =
m8xx_wdt_get_timeout();<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (put_user(timeout, (int =
*)arg))<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOTTY;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
}<BR>
<BR>
static const struct file_operations mpc8xx_wdt_fops =3D {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D no_llseek,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write =3D =
mpc8xx_wdt_write,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ioctl =3D =
mpc8xx_wdt_ioctl,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .open =3D =
mpc8xx_wdt_open,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .release =3D =
mpc8xx_wdt_release,<BR>
};<BR>
<BR>
static struct miscdevice mpc8xx_wdt_miscdev =3D {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .minor =3D =
WATCHDOG_MINOR,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D =
&quot;watchdog&quot;,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fops =3D =
&amp;mpc8xx_wdt_fops,<BR>
};<BR>
<BR>
<BR>
static int __init mpc8xx_wdt_init(void)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_timer (&amp;wd_timer); =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* initialize =
timer-structure... */<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wd_timer.function =3D =
mpc8xx_wdt_ktimer_handler;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wd_timer.data =3D (unsigned =
long) &amp;mpc8xx_wdt_dummy;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
spin_lock_init(&amp;counter_spinlock);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
misc_register(&amp;mpc8xx_wdt_miscdev);<BR>
}<BR>
<BR>
static void __exit mpc8xx_wdt_exit(void)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
misc_deregister(&amp;mpc8xx_wdt_miscdev);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m8xx_wdt_reset();<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mpc8xx_wdt_handler_enable();<BR>
}<BR>
<BR>
module_init(mpc8xx_wdt_init);<BR>
module_exit(mpc8xx_wdt_exit);<BR>
<BR>
MODULE_AUTHOR(&quot;Florian Schirmer &lt;jolt@tuxbox.org&gt;&quot;);<BR>
MODULE_DESCRIPTION(&quot;MPC8xx watchdog driver&quot;);<BR>
MODULE_LICENSE(&quot;GPL&quot;);<BR>
MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);<BR>
_________________________________________________________________________=
___<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C82BB3.AF99B85E--
