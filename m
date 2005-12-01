Return-Path: <soumya.k.s@motorola.com>
Received: from motgate7.mot.com (motgate7.mot.com [129.188.136.7])
	by ozlabs.org (Postfix) with ESMTP id 4A4FC68867
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Dec 2005 22:57:45 +1100 (EST)
Received: from az33exr02.mot.com ([10.64.251.232])
	by motgate7.mot.com (8.12.11/Motgate7) with ESMTP id jB1CMOXY021958
	for <linuxppc-embedded@ozlabs.org>; Thu, 1 Dec 2005 05:22:24 -0700 (MST)
Received: from ZMY16EXM66.ds.mot.com (zmy16exm66.ap.mot.com [10.179.4.26])
	by az33exr02.mot.com (8.13.1/8.13.0) with ESMTP id jB1C6KmF002372
	for <linuxppc-embedded@ozlabs.org>; Thu, 1 Dec 2005 06:06:21 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 1 Dec 2005 19:52:36 +0800
Message-ID: <C82A9B11BE247C4E952DC733EA98DAA13D2CF5@ZMY16EXM66.ds.mot.com>
From: "KS Soumya-ask067" <soumya.k.s@motorola.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: Linux hangs while Uncompressing
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 Hi Pritha,
	These are the few things that you might want to look for.

1) Check for the command line argument which is being passed to the =
kernel, if that is alright. (I mean to say set the console options to =
the kernel)
	Something which looks like
	 setenv bootargs=3D/dev/(nfs/ram???) rw console=3D(ttyS?),baudrate

2) Try to enable "early debug messages" options in the kernel if =
available to debug more.

Hope this helps a bit.

-Soumya
=09

-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org =
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of =
linuxppc-embedded-request@ozlabs.org
Sent: Thursday, December 01, 2005 5:02 PM
To: linuxppc-embedded@ozlabs.org
Subject: Linuxppc-embedded Digest, Vol 16, Issue 3

Send Linuxppc-embedded mailing list submissions to
	linuxppc-embedded@ozlabs.org

To subscribe or unsubscribe via the World Wide Web, visit
	https://ozlabs.org/mailman/listinfo/linuxppc-embedded
or, via email, send a message with subject or body 'help' to
	linuxppc-embedded-request@ozlabs.org

You can reach the person managing the list at
	linuxppc-embedded-owner@ozlabs.org

When replying, please edit your Subject line so it is more specific than =
"Re: Contents of Linuxppc-embedded digest..."


Today's Topics:

   1. Re: Xilinx_uartlite (T Ziomek)
   2. Re:RE: linuxppc-embedded help needed:kernel access of bad
      area (zengshuai@sogou.com)
   3. RE: Xilinx_uartlite (Jaap de Jong)
   4. Re: [PATCH] ibm_emac: fix graceful stop timeout handling
      (Jeff Garzik)
   5. AW: RE: linuxppc-embedded help needed:kernel access of bad
      area (Achim Machura)
   6. bus error (zengshuai@sogou.com)
   7. porting linux to new board type (Nathael PAJANI)
   8. Linux hangs while Uncompressing (pritha.bhattacharya@tcs.com)


----------------------------------------------------------------------

Message: 1
Date: Wed, 30 Nov 2005 19:06:29 -0600 (Central Standard Time)
From: T Ziomek <ctz001@email.mot.com>
Subject: Re: Xilinx_uartlite
To: jaap.dejong@nedap.com, linuxppc-embedded
	<linuxppc-embedded@ozlabs.org>
Message-ID: <Pine.WNT.4.61.0511301902100.3620@holyoke.labs.mot.com>
Content-Type: TEXT/PLAIN; charset=3DUS-ASCII; format=3Dflowed

> I'm trying to get my avnet virtex4fx12 running with linux.
> It boots, but ends with:
>         Warning: unable to open an initial console.
> This means /dev/console was not opened; init is running.
> Since my board has no 16550 uart I must use xilinx_uartlite Part of my =

> configuration:
>         +--Character devices
>                 +--Xilinx UART Lite                     ON
>                 +--Console on UART Lite port            ON
> Any ideas?

/dev/console may not be tied to your UARTLite.  If you don't specify the =
console on your kernel command line, try adding something along the =
lines of "console=3DttyS0,19200" to it (with the appropriate device and =
baud rate of course).

Tom
--=20
   /"\  ASCII Ribbon Campaign   |
   \ /                          |   Email to user 'CTZ001'
    X        Against HTML       |             at 'email.mot.com'
   / \     in e-mail & news     |


------------------------------

Message: 2
Date: Thu, 1 Dec 2005 14:52:01 +0800 (CST)
From: <zengshuai@sogou.com>
Subject: Re:RE: linuxppc-embedded help needed:kernel access of bad
	area
To: "Fillod Stephane" <stephane.fillod@thomson.net>
Cc: Linuxppc-embedded@ozlabs.org
Message-ID: <5100380.1133419921433.JavaMail.postfix@mx3.mail.sohu.com>
Content-Type: text/plain; charset=3D"ISO-8859-1"

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

#define CONFIG_TASK_SIZE 0x80000000 =20

#include <asm/processor.h>
#include <linux/init.h>
#include <asm/uaccess.h> /* copy_to_user(), copy_from_user() */ #include =
<linux/fs.h> /* struct file_operations, register_chrdev(), ... */ =
#include <linux/kernel.h> /* printk()*/ #include <linux/sched.h>=20

#include "led-module.h"

#define BCSRADDR 0x04500000

static int PQ2FADS_GPL_open (struct inode *inode, struct file *filp); =
static ssize_t PQ2FADS_GPL_read (struct file *filp, char *buf, size_t =
count,loff_t *f_pos); static ssize_t PQ2FADS_GPL_write (struct file =
*filp, const char *buf, size_t count,loff_t *f_pos); static int =
PQ2FADS_GPL_ioctl (struct inode *inode,struct file *filp,unsigned int =
cmd,unsigned long scmd); static int PQ2FADS_GPL_release (struct inode =
*inode, struct file *filp);

struct file_operations PQ2FADS_GPL_fops =3D {
open: PQ2FADS_GPL_open,
release: PQ2FADS_GPL_release,
ioctl: PQ2FADS_GPL_ioctl,
read: PQ2FADS_GPL_read,
write: PQ2FADS_GPL_write,
};

static int PQ2FADS_GPL_major;
static int PQ2FADS_GPL_state;
static volatile PQ2FADS_BCSR *PQ2FADS_GPL_CSR=3D0;

static int init_module(void)
{
	printk ("This' a PQ2FADS_ZU board GPL LED Device File!\n");
	PQ2FADS_GPL_major =3D register_chrdev (0, "GPL LED Device", =
&PQ2FADS_GPL_fops);=20
	if (PQ2FADS_GPL_major < 0)=20
	{
		printk("error1");
		return PQ2FADS_GPL_major;
	}=20
	printk ("The major is:%d\n", PQ2FADS_GPL_major);=20
	return 0;
}

static void cleanup_module(void)
{
	unregister_chrdev(PQ2FADS_GPL_major, "GPL LED Device");
	printk("PQ2FADS_ZU board GPL LED Device has been removed! bye!\n"); }

static int PQ2FADS_GPL_open(struct inode *inode,struct file *filp) {
	PQ2FADS_GPL_CSR=3D(PQ2FADS_BCSR*)BCSRADDR;
	printk("open %s...OK!\n ", current->comm);
	return 0;
}

static int PQ2FADS_GPL_release(struct inode *inode,struct file *filp) {
	printk("close....OK!\n ");
	return 0;
}

static ssize_t PQ2FADS_GPL_read(struct file *filp,char *buf,size_t =
count,loff_t *f_pos) {
//	char ledopen[20]=3D"led is open.";
//	char ledclose[20]=3D"led is close.";
//	count=3D20;
	if(((PQ2FADS_GPL_CSR->bcsr0) & 0x02000000) =3D=3D 0x0) printk("led is =
open");
//	else copy_to_user(buf,ledclose,20);
	return count;
}

static ssize_t PQ2FADS_GPL_write(struct file *filp,const char =
*buf,size_t count,loff_t *f_pos) {
	PQ2FADS_GPL_CSR->bcsr0 |=3D0x02000000;
	return 0;
}

static int PQ2FADS_GPL_ioctl(struct inode *inode,struct file =
*filp,unsigned int cmd,unsigned long scmd) {
	return 0;
}


//led-app.c
#include <stdio.h>

int main(void)
{
	int mydev,err;
	char resultchar[20]=3D"begin...";

	mydev=3Dopen("/dev/PQ2FADS_GPL","rb+");
	if(mydev<0)
	{
		printf("open error.\n");
		return 1;
	}
=09
	err=3Dread(mydev,resultchar,20);
	if(err !=3D20) printf("read1 error!\n");
	printf("read1=3D%s",resultchar);

	err=3Dwrite(mydev,resultchar,20);
	if(err !=3D0) printf("write error!\n");

	err=3Dread(mydev,resultchar,20);
	if(err !=3D20) printf("read2 error!\n");
	printf("read2=3D%s",resultchar);

	return 0;
}

i got led-module.o and led-app.exe
i insmod led-module.o   =20
mknod /dev/PQ2FADS_GPL
and when i run led-app.exe
show:
# ./led-app.exe
open led-app.exe...OK!
Oops: kernel access of bad area, sig: 11
NIP: C30B11B4 XER: 00000000 LR: C003A310 SP: C06B1F00 REGS: c06b1e50 =
TRAP: 0300
  Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 04500000, DSISR: 20000000
TASK =3D c06b0000[201] 'led-app.exe' Last syscall: 3 last math c06b0000 =
last altivec 00000000
GPR00: C003A310 C06B1F00 C06B0000 C01A5AA0 7FFFFDE0 00000014 C01A5AC0 =
00000000
GPR08: 00000000 04500000 0000000C C01A0000 30025CE8 10018B5C 00000000 =
00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 006B1F40 00000000 =
C0003E88
GPR24: C0003BE0 00000001 10000500 7FFFFEA4 7FFFFDE0 FFFFFFEA C01A5AA0 =
00000014 Call backtrace:
10000A1C C003A310 C0003C3C 100004AC 0FEC6D74 00000000 Segmentation fault =
# as you know,i am really a new gay.help me please.

-----  Original Message  -----
From: Fillod Stephane
To: zengshuai@sogou.com ;ppc
Subject: RE: linuxppc-embedded help needed:kernel access of bad area
Sent: Wed Nov 30 17:33:25 CST 2005

> Dear zengshuai,
>=20
> zengshuai@sogou.com wrote:
> > i writed a led driver for PQ2FADS(a ppc board).
> > but i can't read/write 0x04500000 where led register addr locate in.
> > i tested two ways to do that.
> > first,
> > p=3D0x04500000;
> > *p=3D0x12;
> > ....
> > second,
> > outb(0x12,0x04500000);
> > ...
> > two ways both didn't work.they had a some wrong:kernel access of bad
> area.
> > how can i know which area is bad area or good area?
> > and what can i do next? thanks.
>=20
> Do yourself a favor, read a book about Linux device driver=20
> development, for example one listed[1] in the excellent Denx's DLUG =
FAQ[2].
> Getting some training on PowerPC development is a good idea too.
> [1] http://www.denx.de/wiki/view/DULG/MoreInformationBooks
> [2] http://www.denx.de/wiki/DULG/Manual
>=20
> Peruse also your chip data-sheet, and you will see that outb() is=20
> non-sense.
>=20
> If you are accessing the led register from kernel space, you'll find a =

> solution using ioremap(). Otherwise, if you are accessing the led=20
> register from user space, this link[3] will help you, or this shorter=20
> one[4].
> You can follow this thread[5] for more information.
>=20
> [3]
> http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Ac
> ce
> ssingPeripheralsFromUserSpace
> [4] http://tinyurl.com/6c7th
> [5] http://lists.linuxppc.org/linuxppc-embedded/200403/msg00059.html
>=20
> Please next time, do ourselves a favor, try some searching first=20
> (google, whatever). Your question is a FAQ.
>=20
> Regards,
> --
> Stephane
>=20


------------------------------
?????Sogou.com?2G??????????!=20
http://mail.sogou.com/recommend/sogoumail_invite_reg1.jsp?from=3Dsogouinv=
itation&s_EMAIL=3Dzengshuai%40sogou.com&username=3D&FullName=3D&Email=3D&=
verify=3De197bd6dbd1fc7f8d6a035729df08d63



------------------------------

Message: 3
Date: Thu, 1 Dec 2005 08:13:11 +0100
From: "Jaap de Jong" <jaap.dejong@nedap.com>
Subject: RE: Xilinx_uartlite
To: "T Ziomek" <ctz001@email.mot.com>,	"linuxppc-embedded"
	<linuxppc-embedded@ozlabs.org>
Message-ID:
	<6915D0AE8B9047438F320B466AE30FDD324CCD@nvs0003.nedap.local>
Content-Type: text/plain;	charset=3D"us-ascii"

Hi Tom,

Thanks for your reply, but then I only get:
	Now booting the kernel

Beste regards,

Jaap

-----Oorspronkelijk bericht-----
Van: T Ziomek [mailto:ctz001@email.mot.com]=20
Verzonden: donderdag 1 december 2005 02:06
Aan: Jaap de Jong; linuxppc-embedded
Onderwerp: Re: Xilinx_uartlite

> I'm trying to get my avnet virtex4fx12 running with linux.
> It boots, but ends with:
>         Warning: unable to open an initial console.
> This means /dev/console was not opened; init is running.
> Since my board has no 16550 uart I must use xilinx_uartlite Part of my

> configuration:
>         +--Character devices
>                 +--Xilinx UART Lite                     ON
>                 +--Console on UART Lite port            ON
> Any ideas?

/dev/console may not be tied to your UARTLite.  If you don't specify the
console on your kernel command line, try adding something along the
lines of "console=3DttyS0,19200" to it (with the appropriate device and
baud rate of course).

Tom
--=20
   /"\  ASCII Ribbon Campaign   |
   \ /                          |   Email to user 'CTZ001'
    X        Against HTML       |             at 'email.mot.com'
   / \     in e-mail & news     |




------------------------------

Message: 4
Date: Thu, 01 Dec 2005 02:23:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ibm_emac: fix graceful stop timeout handling
To: Eugene Surovegin <ebs@ebshome.net>
Cc: netdev@vger.kernel.org, linuxppc-embedded@ozlabs.org
Message-ID: <438EA4FE.8010903@pobox.com>
Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed

applied



------------------------------

Message: 5
Date: Thu, 1 Dec 2005 09:00:41 +0100
From: "Achim Machura" <achim.machura@berghof.com>
Subject: AW: RE: linuxppc-embedded help needed:kernel access of bad
	area
To: <zengshuai@sogou.com>
Cc: "Linuxppc-Embedded \(E-Mail\)" <linuxppc-embedded@ozlabs.org>
Message-ID: <000001c5f64d$538113d0$34f1ff0a@beint.local>
Content-Type: text/plain;	charset=3D"iso-8859-1"

Hello,

> #define BCSRADDR 0x04500000
>=20
...
> static int PQ2FADS_GPL_open(struct inode *inode,struct file *filp)
> {
> 	PQ2FADS_GPL_CSR=3D(PQ2FADS_BCSR*)BCSRADDR;

possible you have to change physical address to logical see ioremap.

achim


------------------------------

Message: 6
Date: Thu, 1 Dec 2005 16:37:43 +0800 (CST)
From: <zengshuai@sogou.com>
Subject: bus error
To: "ppc" <linuxppc-embedded@ozlabs.org>
Message-ID:
	<13090422.1133426263198.JavaMail.postfix@mx3.mail.sohu.com>
Content-Type: text/plain; charset=3D"GB2312"

//test.c
#include <stdio.h>
#include <stdlib.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

int main(void)
{
	static volatile char *reg_mem;
  static int axs_mem_fd =3D -1;
  axs_mem_fd =3D open("/dev/mem", O_RDWR|O_SYNC);
    if (axs_mem_fd < 0) {
        perror("AXS: can't open /dev/mem");
        return NULL;
    }
    /* memory map */
  reg_mem =3D(volatile char*)mmap(
      (caddr_t)reg_mem,
      0x4,
      PROT_READ|PROT_WRITE,
      MAP_SHARED,
      axs_mem_fd,
      0x04600000
  );
	if(reg_mem[0]=3D=3D0x10) printf("OK");
	else printf("sorry");
}
host:
ppc_6xx-gcc -o test test.c
target:
./test
Bus error

need help,thanks

------------------------------
=CE=D2=CF=D6=D4=DA=CA=B9=D3=C3Sogou.com=B5=C42G=D3=CA=CF=E4=C1=CB=A3=AC=C4=
=E3=D2=B2=C0=B4=CA=D4=CA=D4=B0=C9!=20
http://mail.sogou.com/recommend/sogoumail_invite_reg1.jsp?from=3Dsogouinv=
itation&s_EMAIL=3Dzengshuai%40sogou.com&username=3Dlinuxppc-embedded&Full=
Name=3Dlinuxppc-embedded&Email=3Dlinuxppc-embedded%40ozlabs.org&verify=3D=
755eff4e640bdcfc57d93cbd8b0a9cb7



------------------------------

Message: 7
Date: Thu, 01 Dec 2005 12:30:54 +0100
From: Nathael PAJANI <nathael.pajani@cpe.fr>
Subject: porting linux to new board type
To: linuxppc-embedded@ozlabs.org
Message-ID: <438EDEEE.2000000@cpe.fr>
Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed

Hi!

I stepped over your message without noticing, do you still need help?

I do not have much experience yet, as I've been graduated only two month =

ago, but my job actualy is porting linux to custom boards, and I=20
achieved my first one two weeks ago.
So maybe I can hand out some usefull clues.

Have fun :)
+++


------------------------------

Message: 8
Date: Thu, 1 Dec 2005 15:29:10 +0530
From: pritha.bhattacharya@tcs.com
Subject: Linux hangs while Uncompressing
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID:
	<OF0098DF7F.857DE409-ON652570CA.001AA3F7-652570CA.0036DB32@tcs.com>
Content-Type: text/plain; charset=3D"us-ascii"


Hi All,

I have RAM version of U-Boot which is running on a board similar to=20
MPC8260. My memory map isas follows:

Staring address         Device          Size                  Memory=20
controller and CS

0000 0000
0800 0000
FFF0 0000
0F00 0000
3000 0000
3800 0000
4200 0000
5000 0000
FLASH (Boot)
FLASH (Code)
SSRAM
CPU internal registers
SDRAM
SDRAM
Framer
DSP 8102
1MB (512Kx16)
4 MB (1Mx16)
2 MB (512Kx36)
128 KB
128 MB (16Mx72)
128 MB (16Mx72)
1 MB
2 MB
BR0/OR0: CS0
BR1/OR1: CS1
BR2/OR2: CS2

BR3/OR3: CS3
BR4/OR4: CS4
BR5/OR5: CS5
BR6/OR6: CS6


I have downloaded Linux 2.4.25 kernel image through kermit. after=20
downloading the image in SDRAM location 0x30000000 and giving the =
command=20
bootm 0x30000000

 the prompt shows a message:


TCS-PIC-UBOOT=3D> loadb 0x30000000## Ready for binary (kermit) download =
to=20
0x30000000 at 57600 bps...

## Total Size      =3D 0x000936f6 =3D 603894 Bytes
## Start Addr      =3D 0x30000000
TCS-PIC-UBOOT=3D> bootm 0x30000000## Booting image at 30000000 ...
   Image Name:   Linux-2.4.25
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    603830 Bytes =3D 589.7 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ...=20

The system hangs here and is not able to uncompress the kernel any=20
further. I have checked in the FAQs provided in the denx's site, but =
could=20
not find anything similar to my case.

I would appreciate any help.

Thanks & Regards,
Pritha Bhattacharya
Tata Consultancy Services Limited
Mailto: pritha.bhattacharya@tcs.com
Website: http://www.tcs.com

Notice: The information contained in this e-mail message and/or =
attachments to it may contain confidential or privileged information.   =
If you are not the intended recipient, any dissemination, use, review, =
distribution, printing or copying of the information contained in this =
e-mail message and/or attachments to it are strictly prohibited.   If =
you have received this communication in error, please notify us by reply =
e-mail or telephone and immediately and permanently delete the message =
and any attachments.  Thank you
-------------- next part --------------
An HTML attachment was scrubbed...
URL: =
http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20051201/f2efec=
47/attachment.htm

------------------------------

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

End of Linuxppc-embedded Digest, Vol 16, Issue 3
************************************************
