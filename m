Return-Path: <bennett78@digis.net>
Received: from mercury.testsyseng.com (unknown [209.120.144.205])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5001A679E2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Feb 2006 02:59:44 +1100 (EST)
Message-ID: <43FF2D69.3030902@digis.net>
Date: Fri, 24 Feb 2006 08:59:37 -0700
From: bennett78 <bennett78@digis.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: mpc5200 timer3 Interrupts stopped working
Content-Type: multipart/mixed; boundary="------------060802000002050004020801"
Reply-To: Frank Bennett <bennett78@digis.net>
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
--------------060802000002050004020801
Content-Type: multipart/alternative;
 boundary="------------060205060300080202070306"


--------------060205060300080202070306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Help, how do I debug timer3 Interrupts?  My driver was working and then 
interrupts
stopped coming (most likely blocked).  I have a driver that is very 
similar to
     linuxppc_2_4_devel/drivers/char/pp01_ad64.c
I have attached the complete driver (et.c)

/ # insmod et
ET Display Driver v0.1 loaded ET_TIN irq 16

et_init 00 intr->per_mask  1bfffc00
et_init 10 intr->ctrl      00c01001
et_init 14 intr->main_mask 00010e00
et_init 24 intr->enc_stat  00000001
et_init 28 intr->crit_stat 00000000
et_init 2c intr->main_stat 00002000
et_init 30 intr->per_stat  00000000
et_init 38 intr->per_error 00000000

/ # cat /proc/interrupts
           CPU0
 16:          0  MPC5xxx Edge      et Trubine
 23:       1049  MPC5xxx Edge      eth_xmit
 24:       2468  MPC5xxx Edge      eth_recv
 39:         51  MPC5xxx Edge      serial
 40:          0  MPC5xxx Edge      serial
 43:         69  MPC5xxx Edge      eth_err
BAD:          0

with a pulse train on timer3 input "et_interrupt" no longer gets
called.

code snippets
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#define ET_TIN         3   // Turbine PULSE IN

static void et_interrupt (int irq, void *dev_id, struct pt_regs * regs)
{
    int port = ET_IRQ_TO_PORT(irq);
    unsigned long stat;

    printk(KERN_INFO "et_interrupt IRQ %d port %d main_stat %x gpt.sr %x 
\n",
                        irq, port, intr->main_status, gpt[port].sr );

    if( port == ET_TIN ) {
        // Clear pending interrupt
        stat = in_be32(&gpt[port].sr) & 0xffff;
        out_be32(&gpt[port].sr,  MPC5xxx_GPT_SR_CAPT);
        printk(KERN_INFO "et_int irq=%d port=%d stat %0lx \n", irq, 
port, stat);
        // wake_up_interruptible(&et_wait);
    } else {
        printk(KERN_ERR ET_MSG "Unexpected IRQ %d received", irq);
    }
    spin_lock (&et_lock);
    turbine_per = in_be32(&gpt[port].sr) >> 16;
    spin_unlock (&et_lock);
}


static int __init et_init (void)
....
if (request_irq(ET_PORT_TO_IRQ(ET_TIN), et_interrupt, 0, "et Trubine", 
NULL)) {
            printk(KERN_ERR ET_MSG "couldn't register interrupts\n");
            goto abort_remove_proc;
    }
out_be32(&gpt[ET_TIN].cir, (   66<<16) | 1 );  /* prescale(16), 
period(16)  */
out_be32(&gpt[ET_TIN].emsr,
        MPC5xxx_GPT_EMSR_INP_CAPTURE
      | MPC5xxx_GPT_EMSR_ICT_FALLING
      | MPC5xxx_GPT_EMSR_INT_ENABLE);
...
printk(KERN_INFO "ET Display Driver v%s loaded ET_TIN irq %d\n",
        ET_VERSION, ET_PORT_TO_IRQ(ET_TIN) );

    //broke with or without the following
    intr->main_mask &= ~(0x000000ff);   /* enable timer ints */

    printk(KERN_INFO "et_init 00 intr->per_mask  %08x\n", intr->per_mask);
    printk(KERN_INFO "et_init 10 intr->ctrl      %08x\n", intr->ctrl);
    printk(KERN_INFO "et_init 14 intr->main_mask %08x\n", intr->main_mask);
    printk(KERN_INFO "et_init 24 intr->enc_stat  %08x\n", intr->enc_status);
    printk(KERN_INFO "et_init 28 intr->crit_stat %08x\n", 
intr->crit_status);
    printk(KERN_INFO "et_init 2c intr->main_stat %08x\n", 
intr->main_status);
    printk(KERN_INFO "et_init 30 intr->per_stat  %08x\n", intr->per_status);
    printk(KERN_INFO "et_init 38 intr->per_error %08x\n", intr->per_error);

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
thanks in advance for any help,

Frank Bennett

*//*




--------------060205060300080202070306
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<tt>Help, how do I debug timer3 Interrupts?&nbsp; My driver was working and
then interrupts <br>
stopped coming (m</tt><tt>ost likely blocked).&nbsp; I have a driver that is
very similar to<br>
&nbsp;&nbsp;&nbsp;&nbsp; linuxppc_2_4_devel/drivers/char/pp01_ad64.c <br>
I have attached the complete driver (et.c)<br>
</tt><tt><br>
/ # insmod et<br>
ET Display Driver v0.1 loaded ET_TIN irq 16<br>
<br>
et_init 00 intr-&gt;per_mask&nbsp; 1bfffc00<br>
et_init 10 intr-&gt;ctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00c01001<br>
et_init 14 intr-&gt;main_mask 00010e00<br>
et_init 24 intr-&gt;enc_stat&nbsp; 00000001<br>
et_init 28 intr-&gt;crit_stat 00000000<br>
et_init 2c intr-&gt;main_stat 00002000<br>
et_init 30 intr-&gt;per_stat&nbsp; 00000000<br>
et_init 38 intr-&gt;per_error 00000000<br>
<br>
/ # cat /proc/interrupts<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0<br>
&nbsp;16:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; MPC5xxx Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; et Trubine<br>
&nbsp;23:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1049&nbsp; MPC5xxx Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_xmit<br>
&nbsp;24:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2468&nbsp; MPC5xxx Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_recv<br>
&nbsp;39:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 51&nbsp; MPC5xxx Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; serial<br>
&nbsp;40:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; MPC5xxx Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; serial<br>
&nbsp;43:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 69&nbsp; MPC5xxx Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_err<br>
BAD:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
<br>
with a pulse train on timer3 input "et_interrupt" no longer gets<br>
called.<br>
<br>
code snippets<br>
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=<br>
#define ET_TIN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp; // Turbine PULSE IN<br>
<br>
static void et_interrupt (int irq, void *dev_id, struct pt_regs * regs)<br>
{<br>
&nbsp;&nbsp;&nbsp; int port = ET_IRQ_TO_PORT(irq);<br>
&nbsp;&nbsp;&nbsp; unsigned long stat;<br>
<br>
&nbsp;&nbsp;&nbsp; printk(KERN_INFO "et_interrupt IRQ %d port %d main_stat %x gpt.sr
%x \n",<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irq, port, intr-&gt;main_status, gpt[port].sr );<br>
<br>
&nbsp;&nbsp;&nbsp; if( port == ET_TIN ) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Clear pending interrupt<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stat = in_be32(&amp;gpt[port].sr) &amp; 0xffff;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_be32(&amp;gpt[port].sr,&nbsp; MPC5xxx_GPT_SR_CAPT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_INFO "et_int irq=%d port=%d stat %0lx \n", irq,
port, stat);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // wake_up_interruptible(&amp;et_wait);<br>
&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_ERR ET_MSG "Unexpected IRQ %d received", irq);<br>
&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; spin_lock (&amp;et_lock);<br>
&nbsp;&nbsp;&nbsp; turbine_per = in_be32(&amp;gpt[port].sr) &gt;&gt; 16;<br>
&nbsp;&nbsp;&nbsp; spin_unlock (&amp;et_lock);<br>
}<br>
<br>
<br>
static int __init et_init (void)<br>
....<br>
if (request_irq(ET_PORT_TO_IRQ(ET_TIN), et_interrupt, 0, "et Trubine",
NULL)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_ERR ET_MSG "couldn't register interrupts\n");<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto abort_remove_proc;<br>
&nbsp;&nbsp;&nbsp; }<br>
out_be32(&amp;gpt[ET_TIN].cir, (&nbsp;&nbsp; 66&lt;&lt;16) | 1 );&nbsp; /*
prescale(16), period(16)&nbsp; */<br>
out_be32(&amp;gpt[ET_TIN].emsr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPC5xxx_GPT_EMSR_INP_CAPTURE <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | MPC5xxx_GPT_EMSR_ICT_FALLING <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | MPC5xxx_GPT_EMSR_INT_ENABLE);<br>
...<br>
printk(KERN_INFO "ET Display Driver v%s loaded ET_TIN irq %d\n",<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ET_VERSION, ET_PORT_TO_IRQ(ET_TIN) );<br>
<br>
&nbsp;&nbsp;&nbsp; //broke with or without the following<br>
&nbsp;&nbsp;&nbsp; intr-&gt;main_mask &amp;= ~(0x000000ff);&nbsp;&nbsp; /* enable timer ints */<br>
<br>
&nbsp;&nbsp;&nbsp; printk(KERN_INFO "et_init 00 intr-&gt;per_mask&nbsp; %08x\n",
intr-&gt;per_mask);<br>
&nbsp;&nbsp;&nbsp; printk(KERN_INFO "et_init 10 intr-&gt;ctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; %08x\n",
intr-&gt;ctrl);<br>
&nbsp;&nbsp;&nbsp; printk(KERN_INFO "et_init 14 intr-&gt;main_mask %08x\n",
intr-&gt;main_mask);<br>
&nbsp;&nbsp;&nbsp; printk(KERN_INFO "et_init 24 intr-&gt;enc_stat&nbsp; %08x\n",
intr-&gt;enc_status);<br>
&nbsp;&nbsp;&nbsp; printk(KERN_INFO "et_init 28 intr-&gt;crit_stat %08x\n",
intr-&gt;crit_status);<br>
&nbsp;&nbsp;&nbsp; printk(KERN_INFO "et_init 2c intr-&gt;main_stat %08x\n",
intr-&gt;main_status);<br>
&nbsp;&nbsp;&nbsp; printk(KERN_INFO "et_init 30 intr-&gt;per_stat&nbsp; %08x\n",
intr-&gt;per_status);<br>
&nbsp;&nbsp;&nbsp; printk(KERN_INFO "et_init 38 intr-&gt;per_error %08x\n",
intr-&gt;per_error);<br>
<br>
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=<br>
thanks in advance for any help,</tt><br>
<div class="moz-signature"><br>
<meta content="text/html;" http-equiv="Content-Type">
<title></title>
<span style="font-style: italic; font-weight: bold;">Frank Bennett</span><br>
<pre wrap=""><b><big><font face="Times New Roman, Times, serif"><em></em></font></big></b>

<span style="text-decoration: underline;">
</span>
</pre>
</div>
</body>
</html>

--------------060205060300080202070306--

--------------060802000002050004020801
Content-Type: text/x-c;
 name="et.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="et.c"

/*
 * et.c - Driver for EMCO Timers 
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.
 */

#include <linux/module.h>
#include <linux/config.h>
#include <linux/version.h>
#include <linux/types.h>
#include <linux/version.h>
#include <linux/module.h>
#include <linux/config.h>
#include <linux/types.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/delay.h>
#include <linux/proc_fs.h>

#include <asm/uaccess.h>
#include <asm/types.h>
#include <asm/irq.h>
#include <asm/io.h>
#include <asm/mpc5xxx.h>
#include <asm/emco_et.h>

#define CONFIG_PPC_5xxx_IPBFREQ 66000

#define	ET_VERSION	"0.1"
#define ET_NAME	"et"
#define ET_MSG	"et: "

#undef ET_EXCLUSIVE_OPEN

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Frank Bennett");
MODULE_DESCRIPTION("Emco Timers Driver");

#define ET_MAJOR	190
static int major = ET_MAJOR;
MODULE_PARM(major,"i");
MODULE_PARM_DESC(major, "Device major number (default=190)");

static struct mpc5xxx_gpt  *gpt    = (struct mpc5xxx_gpt  *)MPC5xxx_GPT;
// static struct mpc5xxx_gpio *gpio   = (struct mpc5xxx_gpio *)MPC5xxx_GPIO;
static struct mpc5xxx_intr *intr   = (struct mpc5xxx_intr *)MPC5xxx_INTR;
static unsigned long turbine_per;
static DECLARE_WAIT_QUEUE_HEAD(et_wait);

/*
 * ET timer related definitions:
 *
 */
#define ET_POUT        0   // Pulse Out
#define ET_KP_ACTIVE   1   // not KeyPad active (low) IN see gui.c
#define ET_TDIR        2   // Turbine DIR IN
#define ET_TIN         3   // Turbine PULSE IN
#define ET_52k         4   // start SAR convert
#define ET_RLY1        5   // RELAY 1 active low OUT
#define ET_RLY2        6   // RELAY 2 active low OUT
#define ET_BKL         7   // LCD Backlite OUT

#define ET_DELAY_US		10 /* in micro-seconds */

#define ET_PORT_TO_IRQ(port) (13 + port)
#define ET_IRQ_TO_PORT(irq)  (irq - 13)

#ifdef ET_EXCLUSICE_OPEN
static char et_is_open = 0;
#endif

static spinlock_t et_lock = SPIN_LOCK_UNLOCKED;

static void et_interrupt (int irq, void *dev_id, struct pt_regs * regs)
{	
    int port = ET_IRQ_TO_PORT(irq);
	unsigned long stat;

	printk(KERN_INFO "et_interrupt IRQ %d port %d main_stat %x gpt.sr %x \n", 
	 		  			irq, port, intr->main_status, gpt[port].sr ); 

    if( port == ET_TIN ) {
		// Clear pending interrupt 
		stat = in_be32(&gpt[port].sr) & 0xffff;
    	out_be32(&gpt[port].sr,  MPC5xxx_GPT_SR_CAPT);
    	printk(KERN_INFO "et_int irq=%d port=%d stat %0lx \n", irq, port, stat); 
		// wake_up_interruptible(&et_wait);
    } else {		
		printk(KERN_ERR ET_MSG "Unexpected IRQ %d received", irq); 
    }
	spin_lock (&et_lock);
	turbine_per = in_be32(&gpt[port].sr) >> 16;
	spin_unlock (&et_lock);
}

#ifdef CONFIG_PROC_FS
static int et_read_proc(char *page, char **start, off_t off,
                          int count, int *eof, void *data)
{
    *eof = 1;
    return count;
}

static int et_write_proc(struct file *file, const char *buffer,
			   unsigned long count, void *data)
{    
    if (count > 128)
		return -EINVAL;

    return count;
}
#endif

/*
 * Device file operations
 */

static int et_open(struct inode *inode, struct file *file)
{
#ifdef ET_EXCLUSICE_OPEN
    if (et_is_open != 0)
		return -EBUSY;
    et_is_open = 1;
#endif
	spin_lock_irq (&et_lock);
	turbine_per = 0L;
	spin_unlock_irq (&et_lock);
    return 0;
}

static int et_close(struct inode *inode, struct file *file)
{
#ifdef ET_EXCLUSICE_OPEN
    et_is_open = 0;
#endif
    return 0;
}

static int et_write (struct file *file, u8 *buf, 
			  size_t count, loff_t *ppos)
{
    printk(KERN_DEBUG "  et_write \n" );
	return 0;
} 

static size_t et_read (struct file *file, char *buf, 
			 size_t count, loff_t *ppos)
{
    DECLARE_WAITQUEUE(wait, current);
    unsigned long data;
    ssize_t retval;

    printk(KERN_DEBUG "  et_read \n" );

    if (count != sizeof (unsigned int) && count != sizeof (unsigned long))
        return -EINVAL;

//    add_wait_queue(&et_wait, &wait);

    while (1) {
        __set_current_state(TASK_INTERRUPTIBLE);
        spin_lock_irq (&et_lock);
        data = turbine_per;
        turbine_per = 0L;
        spin_unlock_irq (&et_lock);

        if (data != 0)
            break;

        if (file->f_flags & O_NONBLOCK) {
            retval = -EAGAIN;
            goto out;
        }
        if (signal_pending(current)) {
            retval = -ERESTARTSYS;
            goto out;
        }
        schedule();
    }
    if (count == sizeof(unsigned int))
        retval = put_user(data, (unsigned int *)buf);
    else
        retval = put_user(data, (unsigned long *)buf);
    if (!retval)
        retval = count;
 out:
    current->state = TASK_RUNNING;
//    remove_wait_queue(&et_wait, &wait);

    return retval;
}

static int et_ioctl (struct inode *inode, struct file *file, 
		      unsigned int cmd, unsigned long arg)
{
	unsigned long data;

	// printk(KERN_DEBUG "et_ioctl %04x %08lx\n", cmd, arg);
	switch (cmd) {
	case ET_POUT:
	case ET_52k:
	case ET_BKL: 
	case ET_RLY1: 
	case ET_RLY2:
		out_be32(&gpt[cmd].cr,  (arg & 0xffff0000) |1);  /* width, update_now */
    	out_be32(&gpt[cmd].cir, ((CONFIG_PPC_5xxx_IPBFREQ / 1000) << 16) | (arg&0xffff) ); // prescale, period
		break;
	case ET_TIN: 
		data = turbine_per;
		turbine_per = 0L;
		return copy_to_user((void *)arg, &data, sizeof data) ? -EFAULT : 0;
		break;
	case ET_TDIR:
	case ET_KP_ACTIVE: 
		data = (gpt[cmd].sr & MPC5xxx_GPT_SR_PIN)>>8;
		return copy_to_user((void *)arg, &data, sizeof data) ? -EFAULT : 0;

	//case ET_RLY1: 
	//case ET_RLY2:
	//	if( arg == 1L)
	//		out_be32(&gpt[cmd].emsr, MPC5xxx_GPT_EMSR_OUTPUT_1 | MPC5xxx_GPT_EMSR_INTERNAL);
	//	else
	//		out_be32(&gpt[cmd].emsr, MPC5xxx_GPT_EMSR_OUTPUT_0 | MPC5xxx_GPT_EMSR_INTERNAL);
	//	break;
	}
    return 0;
}

static struct file_operations et_fops = {
    owner: 		THIS_MODULE,
    open:  		et_open,
    release:  	et_close,
    read: 		et_read,
    write: 		et_write,
    ioctl: 		et_ioctl,
};

static void et_init_gpt(void)
{
	unsigned int per;

    /* Pulse Out   -      Timer 0 */
    out_be32(&gpt[ET_POUT].emsr, 
        MPC5xxx_GPT_EMSR_PWM | MPC5xxx_GPT_EMSR_CE | MPC5xxx_GPT_EMSR_CONTINOUS);

	/* Turbine in  - GPIO Timer 1 */
	turbine_per = 0L;
    out_be32(&gpt[ET_TIN].cir, (   66<<16) | 1 );  /* prescale(16), period(16)  */
    out_be32(&gpt[ET_TIN].emsr,
        MPC5xxx_GPT_EMSR_INP_CAPTURE | MPC5xxx_GPT_EMSR_ICT_FALLING | MPC5xxx_GPT_EMSR_INT_ENABLE);

	/* Turbine dir - GPIO Timer 2 */
    out_be32(&gpt[ET_TDIR].emsr,
        MPC5xxx_GPT_EMSR_INP_CAPTURE | MPC5xxx_GPT_EMSR_ICT_FALLING );

	/* 52k ref     - GPIO Timer 3 */
	per = 40 ; // 40 usec
    out_be32(&gpt[ET_52k].cr,  (per/2)<<16  | 1);     /* width, update_now */
    out_be32(&gpt[ET_52k].cir, (    33<<16) | per );  /* prescale(16), period(16)  */
    out_be32(&gpt[ET_52k].emsr,
         MPC5xxx_GPT_EMSR_PWM | MPC5xxx_GPT_EMSR_CE | MPC5xxx_GPT_EMSR_CONTINOUS);

	/* KP_active  - GPIO Timer 4 */
    out_be32(&gpt[ET_KP_ACTIVE].emsr,
        MPC5xxx_GPT_EMSR_INP_CAPTURE | MPC5xxx_GPT_EMSR_ICT_FALLING );

	/* Relay 1    - GPIO Timer 5 */
    out_be32(&gpt[ET_RLY1].emsr,
        MPC5xxx_GPT_EMSR_PWM | MPC5xxx_GPT_EMSR_CE | MPC5xxx_GPT_EMSR_CONTINOUS);
    //		MPC5xxx_GPT_EMSR_OUTPUT_1 | MPC5xxx_GPT_EMSR_INTERNAL);

	/* Relay 2    - GPIO Timer 5 */
    out_be32(&gpt[ET_RLY2].emsr,
        MPC5xxx_GPT_EMSR_PWM | MPC5xxx_GPT_EMSR_CE | MPC5xxx_GPT_EMSR_CONTINOUS);
 	//		MPC5xxx_GPT_EMSR_OUTPUT_1 | MPC5xxx_GPT_EMSR_INTERNAL);


	/* LCD BL Lite- GPIO Timer 7 */
	per = 4000 ; // 4 msec
    out_be32(&gpt[ET_BKL].cr,  (per/4)<<16  | 1);     /* width, update_now */
    out_be32(&gpt[ET_BKL].cir, (    66<<16) | per );  /* prescale(16), period(16)  */
    out_be32(&gpt[ET_BKL].emsr,
         MPC5xxx_GPT_EMSR_PWM | MPC5xxx_GPT_EMSR_CE | MPC5xxx_GPT_EMSR_CONTINOUS);
}

static int __init et_init (void)
{
#ifdef CONFIG_PROC_FS
    struct proc_dir_entry * proc;
#endif
    int ret = -ENODEV;
	
    ret = register_chrdev(ET_MAJOR, ET_NAME, &et_fops);
    if (ret < 0) {
		printk(KERN_ERR ET_MSG "Couldn't register " ET_NAME " driver\n");
		goto abort;
    }
    if (major == 0)
		major = ret;   /* dynamic */

#ifdef CONFIG_PROC_FS
    proc = create_proc_entry(ET_NAME, S_IFREG | S_IRUGO, NULL);
    if (proc == NULL) {
		printk(KERN_ERR ET_MSG "failed to create /proc/"ET_NAME"\n");
		goto abort_unregister;
    }
    proc->read_proc  = et_read_proc;
    proc->write_proc = et_write_proc;
#endif

	if (request_irq(ET_PORT_TO_IRQ(ET_TIN), et_interrupt, 0, "et Trubine", NULL)) {
			printk(KERN_ERR ET_MSG "couldn't register interrupts\n");
			goto abort_remove_proc;
    }
	et_init_gpt();

    printk(KERN_INFO "ET Display Driver v%s loaded ET_TIN irq %d\n", 
		ET_VERSION, ET_PORT_TO_IRQ(ET_TIN) );

	intr->main_mask &= ~(0x000000ff);	/* enable timer ints */
    printk(KERN_INFO "et_init 00 intr->per_mask  %08x\n", intr->per_mask);
    printk(KERN_INFO "et_init 10 intr->ctrl      %08x\n", intr->ctrl);
    printk(KERN_INFO "et_init 14 intr->main_mask %08x\n", intr->main_mask);
    printk(KERN_INFO "et_init 24 intr->enc_stat  %08x\n", intr->enc_status);
    printk(KERN_INFO "et_init 28 intr->crit_stat %08x\n", intr->crit_status);
    printk(KERN_INFO "et_init 2c intr->main_stat %08x\n", intr->main_status);
    printk(KERN_INFO "et_init 30 intr->per_stat  %08x\n", intr->per_status);
    printk(KERN_INFO "et_init 38 intr->per_error %08x\n", intr->per_error);

	sti();

/*
    volatile u32        per_mask;    // INTR + 0x00 
    volatile u32        per_pri1;    // INTR + 0x04
    volatile u32        per_pri2;    // INTR + 0x08
    volatile u32        per_pri3;    // INTR + 0x0c
    volatile u32        ctrl;        // INTR + 0x10
    volatile u32        main_mask;   // INTR + 0x14
    volatile u32        main_pri1;   // INTR + 0x18
    volatile u32        main_pri2;   // INTR + 0x1c
    volatile u32        reserved1;   // INTR + 0x20
    volatile u32        enc_status;  // INTR + 0x24
    volatile u32        crit_status; // INTR + 0x28
    volatile u32        main_status; // INTR + 0x2c
    volatile u32        per_status;  // INTR + 0x30
    volatile u32        reserved2;   // INTR + 0x34
    volatile u32        per_error;   // INTR + 0x38
*/

    return 0;
	
 abort_remove_proc:
    remove_proc_entry(ET_NAME,  NULL);
 abort_unregister:
    unregister_chrdev(major, ET_NAME);	
 abort:
    return ret;
}

static void __devexit et_cleanup (void)
{
    free_irq(ET_PORT_TO_IRQ(ET_TIN), NULL);
    remove_proc_entry(ET_NAME,  NULL);
    unregister_chrdev(major, ET_NAME);
    printk(KERN_INFO "ET Display Driver v%s unloaded\n", ET_VERSION);
}

EXPORT_NO_SYMBOLS;

module_init(et_init)
module_exit(et_cleanup)


--------------060802000002050004020801--
