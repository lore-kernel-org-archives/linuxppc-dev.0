Return-Path: <zengshuai@sogou.com>
Message-ID: <5100380.1133419921433.JavaMail.postfix@mx3.mail.sohu.com>
Date: Thu, 1 Dec 2005 14:52:01 +0800 (CST)
From: <zengshuai@sogou.com>
To: "Fillod Stephane" <stephane.fillod@thomson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re:RE: linuxppc-embedded help needed:kernel access of bad area
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

thanks very much.but i'm not going to write a user space program.
this is the detail:

//led-module.c
#ifndef __KERNEL__
#define __KERNEL__
#endif
#ifndef MODULE
#define MODULE
#endif
#include <linux/config.h>
#include <linux/module.h>
MODULE_LICENSE("GPL");
#ifdef CONFIG_SMP
#define __SMP__
#endif

#define CONFIG_TASK_SIZE 0x80000000  

#include <asm/processor.h>
#include <linux/init.h>
#include <asm/uaccess.h> /* copy_to_user(), copy_from_user() */
#include <linux/fs.h> /* struct file_operations, register_chrdev(), ... */
#include <linux/kernel.h> /* printk()*/
#include <linux/sched.h> 

#include "led-module.h"

#define BCSRADDR 0x04500000

static int PQ2FADS_GPL_open (struct inode *inode, struct file *filp);
static ssize_t PQ2FADS_GPL_read (struct file *filp, char *buf, size_t count,loff_t *f_pos);
static ssize_t PQ2FADS_GPL_write (struct file *filp, const char *buf, size_t count,loff_t *f_pos);
static int PQ2FADS_GPL_ioctl (struct inode *inode,struct file *filp,unsigned int cmd,unsigned long scmd);
static int PQ2FADS_GPL_release (struct inode *inode, struct file *filp);

struct file_operations PQ2FADS_GPL_fops = {
open: PQ2FADS_GPL_open,
release: PQ2FADS_GPL_release,
ioctl: PQ2FADS_GPL_ioctl,
read: PQ2FADS_GPL_read,
write: PQ2FADS_GPL_write,
};

static int PQ2FADS_GPL_major;
static int PQ2FADS_GPL_state;
static volatile PQ2FADS_BCSR *PQ2FADS_GPL_CSR=0;

static int init_module(void)
{
	printk ("This' a PQ2FADS_ZU board GPL LED Device File!\n");
	PQ2FADS_GPL_major = register_chrdev (0, "GPL LED Device", &PQ2FADS_GPL_fops); 
	if (PQ2FADS_GPL_major < 0) 
	{
		printk("error1");
		return PQ2FADS_GPL_major;
	} 
	printk ("The major is:%d\n", PQ2FADS_GPL_major); 
	return 0; 
}

static void cleanup_module(void)
{
	unregister_chrdev(PQ2FADS_GPL_major, "GPL LED Device");
	printk("PQ2FADS_ZU board GPL LED Device has been removed! bye!\n");
}

static int PQ2FADS_GPL_open(struct inode *inode,struct file *filp)
{
	PQ2FADS_GPL_CSR=(PQ2FADS_BCSR*)BCSRADDR;
	printk("open %s...OK!\n ", current->comm);
	return 0;
}

static int PQ2FADS_GPL_release(struct inode *inode,struct file *filp)
{
	printk("close....OK!\n ");
	return 0;
}

static ssize_t PQ2FADS_GPL_read(struct file *filp,char *buf,size_t count,loff_t *f_pos)
{
//	char ledopen[20]="led is open.";
//	char ledclose[20]="led is close.";
//	count=20;
	if(((PQ2FADS_GPL_CSR->bcsr0) & 0x02000000) == 0x0) printk("led is open");
//	else copy_to_user(buf,ledclose,20);
	return count;
}

static ssize_t PQ2FADS_GPL_write(struct file *filp,const char *buf,size_t count,loff_t *f_pos)
{
	PQ2FADS_GPL_CSR->bcsr0 |=0x02000000;
	return 0;
}

static int PQ2FADS_GPL_ioctl(struct inode *inode,struct file *filp,unsigned int cmd,unsigned long scmd)
{
	return 0;
}


//led-app.c
#include <stdio.h>

int main(void)
{
	int mydev,err;
	char resultchar[20]="begin...";

	mydev=open("/dev/PQ2FADS_GPL","rb+");
	if(mydev<0)
	{
		printf("open error.\n");
		return 1;
	}
	
	err=read(mydev,resultchar,20);
	if(err !=20) printf("read1 error!\n");
	printf("read1=%s",resultchar);

	err=write(mydev,resultchar,20);
	if(err !=0) printf("write error!\n");

	err=read(mydev,resultchar,20);
	if(err !=20) printf("read2 error!\n");
	printf("read2=%s",resultchar);

	return 0;
}

i got led-module.o and led-app.exe
i insmod led-module.o    
mknod /dev/PQ2FADS_GPL
and when i run led-app.exe
show:
# ./led-app.exe
open led-app.exe...OK!
Oops: kernel access of bad area, sig: 11
NIP: C30B11B4 XER: 00000000 LR: C003A310 SP: C06B1F00 REGS: c06b1e50 TRAP: 0300
  Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 04500000, DSISR: 20000000
TASK = c06b0000[201] 'led-app.exe' Last syscall: 3
last math c06b0000 last altivec 00000000
GPR00: C003A310 C06B1F00 C06B0000 C01A5AA0 7FFFFDE0 00000014 C01A5AC0 00000000
GPR08: 00000000 04500000 0000000C C01A0000 30025CE8 10018B5C 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 006B1F40 00000000 C0003E88
GPR24: C0003BE0 00000001 10000500 7FFFFEA4 7FFFFDE0 FFFFFFEA C01A5AA0 00000014
Call backtrace:
10000A1C C003A310 C0003C3C 100004AC 0FEC6D74 00000000
Segmentation fault
#
as you know,i am really a new gay.help me please.

-----  Original Message  -----
From: Fillod Stephane 
To: zengshuai@sogou.com ;ppc 
Subject: RE: linuxppc-embedded help needed:kernel access of bad area
Sent: Wed Nov 30 17:33:25 CST 2005

> Dear zengshuai,
> 
> zengshuai@sogou.com wrote:
> > i writed a led driver for PQ2FADS(a ppc board).
> > but i can't read/write 0x04500000 where led register addr locate in.
> > i tested two ways to do that.
> > first,
> > p=0x04500000;
> > *p=0x12;
> > ....
> > second,
> > outb(0x12,0x04500000);
> > ...
> > two ways both didn't work.they had a some wrong:kernel access of bad
> area.
> > how can i know which area is bad area or good area?
> > and what can i do next? thanks.
> 
> Do yourself a favor, read a book about Linux device driver development,
> for example one listed[1] in the excellent Denx's DLUG FAQ[2].
> Getting some training on PowerPC development is a good idea too.
> [1] http://www.denx.de/wiki/view/DULG/MoreInformationBooks
> [2] http://www.denx.de/wiki/DULG/Manual
> 
> Peruse also your chip data-sheet, and you will see that outb() is
> non-sense.
> 
> If you are accessing the led register from kernel space, you'll find
> a solution using ioremap(). Otherwise, if you are accessing the led
> register
> from user space, this link[3] will help you, or this shorter one[4].
> You can follow this thread[5] for more information.
> 
> [3]
> http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Acce
> ssingPeripheralsFromUserSpace
> [4] http://tinyurl.com/6c7th
> [5] http://lists.linuxppc.org/linuxppc-embedded/200403/msg00059.html
> 
> Please next time, do ourselves a favor, try some searching first
> (google, 
> whatever). Your question is a FAQ.
> 
> Regards,
> -- 
> Stephane
> 


------------------------------
?????Sogou.com?2G??????????! 
http://mail.sogou.com/recommend/sogoumail_invite_reg1.jsp?from=sogouinvitation&s_EMAIL=zengshuai%40sogou.com&username=&FullName=&Email=&verify=e197bd6dbd1fc7f8d6a035729df08d63
