Return-Path: <rdpatel55@yahoo.co.in>
Received: from n8-vm0.bullet.mail.in.yahoo.com
	(n8-vm0.bullet.mail.in.yahoo.com [202.86.4.189])
	by ozlabs.org (Postfix) with SMTP id 29CE5DE198
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 16:20:45 +1000 (EST)
Message-ID: <601801.28414.qm@web94805.mail.in2.yahoo.com>
Date: Thu, 21 May 2009 11:50:42 +0530 (IST)
From: patel rajendra <rdpatel55@yahoo.co.in>
Subject: problem in registering the device while inserting the kernel module
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-623270791-1242886842=:28414"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--0-623270791-1242886842=:28414
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Members of linuxppc,

=A0

I'm working on XUPV2P board with Virtex II Pro FPGA device.

=A0

I written a kernel module for LED device. I got that module run
successfuly on ML403 board having Virtex 4 FPGA.I have not make any
change in my source code for XUP board, because I don't feel any change is =
required.

=A0

On XUP board when I run "insmod xilinx_led.ko" command on my target board, =
I got following message.

=A0

# insmod xilinx_led.ko=20

Oops: kernel access of bad area, sig: 11 [#1]=20

PREEMPT=20

NIP: d1006190 LR: d1006188 CTR: 00000000=20

REGS: c0705db0 TRAP: 0300=A0=A0 Not tainted=A0 (2.6.23xlnx)=20

MSR: 00029030 <EE,ME,IR,DR>=A0 CR: 24000024=A0 XER: 00000000=20

DEAR: 0000004c, ESR: 00000000=20

TASK =3D c04c63d0[186] 'insmod' THREAD: c0704000=20

GPR00: d1006188 c0705e60 c04c63d0 00000000 000000d0 00000001 00000000 c0220=
ae0=20

GPR08: c006c60c 00000000 00000001 c04553f0 026f4bac 100b4260 d1003288 d1007=
668=20

GPR16: d1003288 d1003238 0000fff1 0000fff2 0000004c 00000000 d100762c c003e=
94c=20

GPR24: d1002e02 00000018 d1002000 00000019 d1000000 d1007598 d10077c8 00000=
000=20

NIP [d1006190] xilinx_ml403_led_setup+0x174/0x1dc [xilinx_led]=20

LR [d1006188] xilinx_ml403_led_setup+0x16c/0x1dc [xilinx_led]=20

Call Trace:=20

[c0705e60] [d1006188] xilinx_ml403_led_setup+0x16c/0x1dc [xilinx_led] (unre=
liable)=20

[c0705e90] [c0040be0] sys_init_module+0x120c/0x12f8=20

[c0705f40] [c0002c10] ret_from_syscall+0x0/0x3c=20

Instruction dump:=20

48000819 3d20d100 39297620 913f003c 93bf0040 3c800fc0 60840001 7fe3fb78=20

38a00001 48000805 813e0014 7c7f1b78 <80e9004c> 3c60d100 3c80d100 80bc77c8=
=20

 =A0=20

Note: After above output when I execute "lsmod" command. I observed that le=
d device is tainted.=20

 =A0=20

~ # lsmod=20

Module=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Size=A0 Used by=
=A0=A0=A0 Tainted: G=20

xilinx_led=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A06172=A0 1=20

~ #=20


=A0

What I understood from above message is that there is a problem in register=
ing the device in function xilinx_ml403_led_setup( ).=20

=A0

Anyone can help me out to solve this problem?

The source code is given below.=A0

Rajendra


---------------------------------------Xilinx_led.c------------------------=
---------------------------------------

#include <linux/init.h>

#include <linux/module.h>

#include <linux/kernel.h>

#include <linux/slab.h>

#include <linux/fs.h>

#include <linux/errno.h>

#include <linux/types.h>

#include <linux/mm.h>

#include <linux/cdev.h>

#include <linux/proc_fs.h>

#include <linux/fcntl.h>

#include <linux/ioport.h>

#include <linux/interrupt.h>

#include <linux/xilinx_devices.h>

#include <asm/system.h>

#include <asm/io.h>

#include <asm/uaccess.h>



#include "xparameters.h"

#include "xio.h"

#include "xgpio.h"

#include "xgpio_l.h"

#include "xstatus.h"



#include "xbasic_types.h"

/* LED constant */



#define DRIVER_NAME "led"

#define DRIVER_DESCRIPTION "GPIO based 4 bit led peripheral driver"

#define LED_PHY_BASEADDR XPAR_LEDS_4BIT_BASEADDR

#define LED_PHY_HIGHADDR XPAR_LEDS_4BIT_HIGHADDR

#define LED_DEVICE_ID XPAR_LEDS_4BIT_DEVICE_ID

#define LED_MAJOR 252

#define LED_MINOR 1

#define LEDChan 1



XGpio gp_out;



/* Device Structure */



struct led_instance

{

=A0=A0=A0 Xuint32 phy_baseaddr;

=A0=A0=A0 Xuint32 phy_highaddr;

=A0=A0=A0 Xuint32 remap_size;

=A0=A0=A0 Xuint32 virtual_baseaddr;

=A0=A0=A0 u32=A0=A0=A0 device_id;

=A0=A0=A0 struct=A0 cdev *cdev;



=A0=A0=A0 XGpio=A0=A0=A0 gpio;

};



struct led_instance xilinx_ml403_led;



/*Open and Release method */



int led_open(struct inode *inode, struct file *filp)

{

=A0=A0=A0 struct led_instance *dev;



=A0=A0=A0 dev =3D container_of(inode -> i_cdev, struct led_instance, cdev);

=A0=A0=A0 filp -> private_data =3D dev;

=A0=A0=A0 return 0;

}



int led_release(struct inode *inode, struct file *filp)

{

=A0=A0=A0 return 0;

}



/* Read Method */



ssize_t led_read(struct file *flip, char __user *buf, size_t count, loff_t =
*f_pos)

{

=A0=A0=A0 size_t=A0 retval =3D 0;

=A0=A0=A0 u32=A0=A0=A0 data;



=A0=A0=A0 printk(KERN_INFO "%s: Entering\n\r", __FUNCTION__);



=A0=A0=A0 if(*f_pos >=3D sizeof(data))

=A0=A0=A0 {

=A0=A0=A0 =A0=A0=A0 goto out01;

=A0=A0=A0 }



=A0=A0=A0 if(*f_pos + count >=3D sizeof(data))

=A0=A0=A0 {

=A0=A0=A0 =A0=A0=A0 count =3D sizeof(data) - *f_pos;

=A0=A0=A0 }



=A0=A0=A0 data =3D XGpio_DiscreteRead(&gp_out, LEDChan);

=A0=A0=A0 printk(KERN_INFO "data =3D 0x%08X!\n\r", data);



=A0=A0=A0 if(copy_to_user(buf, &data, count))

=A0=A0=A0 {

=A0=A0=A0 =A0=A0=A0 retval =3D -EFAULT;

=A0=A0=A0 =A0=A0=A0 goto out01;

=A0=A0=A0 }

=A0=A0=A0 *f_pos +=3D count;

=A0=A0=A0 retval =3D count;



out01:=A0=A0=A0 return retval;



}



/* Write Method */

ssize_t led_write(struct file *flip, const char __user *buf, size_t count, =
loff_t *f_pos)

{

=A0=A0=A0 size_t=A0 retval =3D 0;

=A0=A0=A0 Xuint32=A0=A0=A0 data;



=A0=A0=A0 printk(KERN_INFO "%s: Entering\n\r", __FUNCTION__);



=A0=A0=A0 if(count < sizeof(data))

=A0=A0=A0 {

=A0=A0=A0 =A0=A0=A0 printk("argument to small!\n\r");

=A0=A0=A0 =A0=A0=A0 retval =3D -EINVAL;

=A0=A0=A0 =A0=A0=A0 goto out01;

=A0=A0=A0 }

=A0=A0=A0=20

=A0=A0=A0 if(*f_pos + count >=3D sizeof(data))

=A0=A0=A0 {

=A0=A0=A0 =A0=A0=A0 count =3D sizeof(data) - *f_pos;

=A0=A0=A0 }

=A0=A0=A0 if(copy_from_user(&data,buf, count))

=A0=A0=A0 {

=A0=A0=A0 =A0=A0=A0 retval =3D -EFAULT;

=A0=A0=A0 =A0=A0=A0 goto out01;

=A0=A0=A0 }

=A0=A0=A0 XGpio_DiscreteWrite(&gp_out,LEDChan,data);

=A0=A0=A0 *f_pos +=3D count;

=A0=A0=A0 retval =3D count;



out01:=A0=A0=A0 return retval;

}



/* File Operations Structure */



struct file_operations led_fops =3D {

=A0=A0=A0=20

=A0=A0=A0 owner:=A0=A0=A0 THIS_MODULE,

=A0=A0=A0 open:=A0=A0=A0 led_open,

=A0=A0=A0 read:=A0=A0=A0 led_read,

=A0=A0=A0 write:=A0=A0=A0 led_write,

=A0=A0=A0 release:led_release

};



/* Device Registration */

int xilinx_ml403_led_setup(void)

{

=A0=A0=A0 XGpio_Config xgpio_config;

=A0=A0=A0 struct cdev *cdev=3D0;

=A0=A0=A0 int retval =3D 0;

=A0=A0=A0 dev_t devno;



=A0=A0=A0 memset(&xilinx_ml403_led, 0, sizeof(struct led_instance));

=A0=A0=A0=20

=A0=A0=A0 /* Map the control registers in */

=A0=A0=A0 /* get baseaddress and highaddress */

=A0=A0=A0 xilinx_ml403_led.phy_baseaddr=A0=A0=A0 =3D LED_PHY_BASEADDR;

=A0=A0=A0 xilinx_ml403_led.remap_size=A0=A0=A0 =3D LED_PHY_HIGHADDR - LED_P=
HY_BASEADDR + 1;

=A0=A0=A0 xilinx_ml403_led.device_id=A0=A0=A0 =3D LED_DEVICE_ID;



=A0=A0=A0 if(!xilinx_ml403_led.phy_baseaddr ||
(xilinx_ml403_led.remap_size - xilinx_ml403_led.phy_baseaddr + 1 <
8))

=A0=A0=A0 {



=A0=A0=A0 =A0=A0=A0 printk(KERN_ERR "%s: Couldn't get registers resource\n\=
r","led");

=A0=A0=A0 =A0=A0=A0 retval =3D -EFAULT;

=A0=A0=A0 =A0=A0=A0 goto failed1;

=A0=A0=A0 }=A0=A0=A0=20



=A0=A0=A0 if(!request_mem_region(xilinx_ml403_led.phy_baseaddr, xilinx_ml40=
3_led.remap_size, DRIVER_NAME))

=A0=A0=A0 {

=A0=A0=A0 =A0=A0=A0=20

=A0=A0=A0 =A0=A0=A0 printk(KERN_ERR "Couldn't lock
memory region at 0x%08lX\n\r",(unsigned long)
xilinx_ml403_led.phy_baseaddr);

=A0=A0=A0 =A0=A0=A0 retval =3D -EBUSY;

=A0=A0=A0 =A0=A0=A0 goto failed2;=20



=A0=A0=A0 }



=A0=A0=A0 xilinx_ml403_led.virtual_baseaddr =3D ioremap(xilinx_ml403_led.ph=
y_baseaddr, xilinx_ml403_led.remap_size);



=A0=A0=A0=20

=A0=A0=A0 if(!xilinx_ml403_led.virtual_baseaddr)

=A0=A0=A0 {

=A0=A0=A0 =A0=A0=A0=20

=A0=A0=A0 =A0=A0=A0 printk(KERN_ERR "Couldn't ioremap
memory at 0x%08lX\n\r", (unsigned long) xilinx_ml403_led.phy_baseaddr);

=A0=A0=A0 =A0=A0=A0 retval =3D -EFAULT;

=A0=A0=A0 =A0=A0=A0 goto failed3;



=A0=A0=A0 }



=A0=A0=A0 if(XGpio_CfgInitialize(&gp_out, &xgpio_config,xilinx_ml403_led.vi=
rtual_baseaddr) !=3D XST_SUCCESS)

=A0=A0=A0 {

=A0=A0=A0 =A0=A0=A0 printk(KERN_ERR "%s: Couldn't initialize instance.\n\r"=
,"xilinx_led");

=A0=A0=A0 =A0=A0=A0 retval =3D -ENODEV;

=A0=A0=A0 =A0=A0=A0 goto failed3;

=A0=A0=A0 }

=A0=A0=A0 XGpio_SetDataDirection(&gp_out, LEDChan , 0x00000000);



=A0=A0=A0 cdev=3D kmalloc(sizeof(struct cdev), GFP_KERNEL);

=A0=A0=A0 if(!cdev)

=A0=A0=A0 {

=A0=A0=A0 =A0=A0=A0 printk(KERN_ERR "%s: Couldn't allocate device private r=
ecord\n\r","led");

=A0=A0=A0 return -ENOMEM;

=A0=A0=A0 }



=A0=A0=A0 memset(cdev,0,sizeof(struct cdev));



=A0=A0=A0 cdev_init(cdev,&led_fops);

=A0=A0=A0 cdev->owner =3D THIS_MODULE;

=A0=A0=A0 cdev->ops =3D &led_fops;

=A0=A0=A0 devno =3D MKDEV(LED_MAJOR,LED_MINOR);

=A0=A0=A0 retval =3D cdev_add(cdev,devno,1);



=A0=A0=A0 xilinx_ml403_led.cdev;



=A0=A0=A0 printk(KERN_ERR "%s at 0x%081X mapped to 0x%08X
device:%u,%u\n\r","xilinx_led",xilinx_ml403_led.phy_baseaddr,(unsigned
int) xilinx_ml403_led.virtual_baseaddr,(unsigned
int)MAJOR(xilinx_ml403_led.cdev->dev),(unsigned
int)MINOR(xilinx_ml403_led.cdev->dev));



=A0=A0=A0 failed3:

=A0=A0=A0 =A0=A0=A0 iounmap((void *) (xilinx_ml403_led.phy_baseaddr));

=A0=A0=A0 =A0=A0=A0=20

=A0=A0=A0 failed2:

=A0=A0=A0 =A0=A0=A0 release_mem_region(xilinx_ml403_led.phy_baseaddr,xilinx=
_ml403_led.remap_size);



=A0=A0=A0 failed1:

=A0=A0=A0 =A0=A0=A0 return retval;

}



int __init led_init(void)

{

=A0=A0=A0 int retval;

=A0=A0=A0 retval=3Dxilinx_ml403_led_setup();

=A0=A0=A0 if(retval)

=A0=A0=A0 =A0=A0=A0 return retval;

=A0=A0=A0 return 0;

}



void __exit led_exit(void)

{

=A0=A0=A0 cdev_del(xilinx_ml403_led.cdev);



=A0=A0=A0 iounmap((void *)(xilinx_ml403_led.virtual_baseaddr));

=A0=A0=A0 release_mem_region(xilinx_ml403_led.phy_baseaddr,xilinx_ml403_led=
..remap_size);

}



module_init(led_init);

module_exit(led_exit);



MODULE_AUTHOR("SANDEEPANI - SCHOOL OF EMBEDDDED DESIGN");

MODULE_DESCRIPTION(DRIVER_DESCRIPTION);

MODULE_LICENSE("Dual BSD/GPL");





=0A=0A=0A      Explore your hobbies and interests. Go to http://in.promos.y=
ahoo.com/groups/
--0-623270791-1242886842=:28414
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><div>Hi Members of linuxppc,</div>

<div>&nbsp;</div>

<div>I'm working on XUPV2P board with Virtex II Pro FPGA device.</div>

<div>&nbsp;</div>

<div>I written a kernel module for LED device. I got that module run
successfuly on ML403 board having Virtex 4 FPGA.I have not make any
change in my source code for XUP board, because I don't feel any change is =
required.</div>

<div>&nbsp;</div>

<div>On XUP board when I run "insmod xilinx_led.ko" command on my target bo=
ard, I got following message.</div>

<div>&nbsp;</div>

<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff"># insmod xilinx_led=
..ko</font></span>=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><b><span style=3D"fon=
t-size: 10pt; font-family: Arial;"><font color=3D"#0000ff">Oops: kernel acc=
ess of bad area, sig: 11 [#1]</font></span></b>=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">PREEMPT</font></spa=
n>=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">NIP: d1006190 LR: d=
1006188 CTR: 00000000</font></span>=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">REGS: c0705db0 TRAP=
: 0300<span style=3D"">&nbsp;&nbsp; </span>Not tainted<span style=3D"">&nbs=
p; </span>(2.6.23xlnx)</font></span>=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">MSR: 00029030 &lt;E=
E,ME,IR,DR&gt;<span style=3D"">&nbsp; </span>CR: 24000024<span style=3D"">&=
nbsp; </span>XER: 00000000</font></span>=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">DEAR: 0000004c, ESR=
: 00000000</font></span>=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">TASK =3D c04c63d0[1=
86] 'insmod' THREAD: c0704000</font></span>=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">GPR00: d1006188 c07=
05e60 c04c63d0 00000000 000000d0 00000001 00000000 c0220ae0</font></span>=
=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">GPR08: c006c60c 000=
00000 00000001 c04553f0 026f4bac 100b4260 d1003288 d1007668</font></span>=
=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">GPR16: d1003288 d10=
03238 0000fff1 0000fff2 0000004c 00000000 d100762c c003e94c</font></span>=
=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">GPR24: d1002e02 000=
00018 d1002000 00000019 d1000000 d1007598 d10077c8 00000000</font></span>=
=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">NIP [d1006190] xili=
nx_ml403_led_setup+0x174/0x1dc [xilinx_led]</font></span>=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">LR [d1006188] xilin=
x_ml403_led_setup+0x16c/0x1dc [xilinx_led]</font></span>=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">Call Trace:</font><=
/span>=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">[c0705e60] [d100618=
8] <strong>xilinx_ml403_led_setup</strong>+0x16c/0x1dc [xilinx_led] <b>(unr=
eliable)</b></font></span>=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">[c0705e90] [c0040be=
0] sys_init_module+0x120c/0x12f8</font></span>=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">[c0705f40] [c0002c1=
0] ret_from_syscall+0x0/0x3c</font></span>=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">Instruction dump:</=
font></span>=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">48000819 3d20d100 3=
9297620 913f003c 93bf0040 3c800fc0 60840001 7fe3fb78</font></span>=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">38a00001 48000805 8=
13e0014 7c7f1b78 &lt;80e9004c&gt; 3c60d100 3c80d100 80bc77c8</font></span>=
=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"> &nbsp;</span>=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;">Note: After above output when I execute "ls=
mod" command. I observed that led device is tainted.</span>=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"> &nbsp;</span>=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">~ # lsmod</font></s=
pan>=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">Module<span style=
=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Size<span style=3D"">&nbsp; </span=
>Used by<span style=3D"">&nbsp;&nbsp;&nbsp; </span>Tainted: G</font></span>=
=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">xilinx_led<span sty=
le=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style=3D"">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>6172<span style=3D"">&nbsp; </sp=
an>1</font></span>=20
</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt;"><span style=3D"font-s=
ize: 10pt; font-family: Arial;"><font color=3D"#0000ff">~ #</font></span>=
=20
</p>
<div>
<div>&nbsp;</div></div>

<div>What I understood from above message is that there is a problem in reg=
istering the device in function <strong><font color=3D"#0000ff">xilinx_ml40=
3_led_setup( ). </font></strong></div>

<div><strong></strong>&nbsp;</div>

<div><font color=3D"#000000">Anyone can help me out to solve this problem?<=
/font></div>

<div>The source code is given below.&nbsp;</div>

<div>Rajendra</div>
<br>
---------------------------------------Xilinx_led.c------------------------=
---------------------------------------<br>
#include &lt;linux/init.h&gt;<br>
#include &lt;linux/module.h&gt;<br>
#include &lt;linux/kernel.h&gt;<br>
#include &lt;linux/slab.h&gt;<br>
#include &lt;linux/fs.h&gt;<br>
#include &lt;linux/errno.h&gt;<br>
#include &lt;linux/types.h&gt;<br>
#include &lt;linux/mm.h&gt;<br>
#include &lt;linux/cdev.h&gt;<br>
#include &lt;linux/proc_fs.h&gt;<br>
#include &lt;linux/fcntl.h&gt;<br>
#include &lt;linux/ioport.h&gt;<br>
#include &lt;linux/interrupt.h&gt;<br>
#include &lt;linux/xilinx_devices.h&gt;<br>
#include &lt;asm/system.h&gt;<br>
#include &lt;asm/io.h&gt;<br>
#include &lt;asm/uaccess.h&gt;<br>
<br>
#include "xparameters.h"<br>
#include "xio.h"<br>
#include "xgpio.h"<br>
#include "xgpio_l.h"<br>
#include "xstatus.h"<br>
<br>
#include "xbasic_types.h"<br>
/* LED constant */<br>
<br>
#define DRIVER_NAME "led"<br>
#define DRIVER_DESCRIPTION "GPIO based 4 bit led peripheral driver"<br>
#define LED_PHY_BASEADDR XPAR_LEDS_4BIT_BASEADDR<br>
#define LED_PHY_HIGHADDR XPAR_LEDS_4BIT_HIGHADDR<br>
#define LED_DEVICE_ID XPAR_LEDS_4BIT_DEVICE_ID<br>
#define LED_MAJOR 252<br>
#define LED_MINOR 1<br>
#define LEDChan 1<br>
<br>
XGpio gp_out;<br>
<br>
/* Device Structure */<br>
<br>
struct led_instance<br>
{<br>
&nbsp;&nbsp;&nbsp; Xuint32 phy_baseaddr;<br>
&nbsp;&nbsp;&nbsp; Xuint32 phy_highaddr;<br>
&nbsp;&nbsp;&nbsp; Xuint32 remap_size;<br>
&nbsp;&nbsp;&nbsp; Xuint32 virtual_baseaddr;<br>
&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp; device_id;<br>
&nbsp;&nbsp;&nbsp; struct&nbsp; cdev *cdev;<br>
<br>
&nbsp;&nbsp;&nbsp; XGpio&nbsp;&nbsp;&nbsp; gpio;<br>
};<br>
<br>
struct led_instance xilinx_ml403_led;<br>
<br>
/*Open and Release method */<br>
<br>
int led_open(struct inode *inode, struct file *filp)<br>
{<br>
&nbsp;&nbsp;&nbsp; struct led_instance *dev;<br>
<br>
&nbsp;&nbsp;&nbsp; dev =3D container_of(inode -&gt; i_cdev, struct led_inst=
ance, cdev);<br>
&nbsp;&nbsp;&nbsp; filp -&gt; private_data =3D dev;<br>
&nbsp;&nbsp;&nbsp; return 0;<br>
}<br>
<br>
int led_release(struct inode *inode, struct file *filp)<br>
{<br>
&nbsp;&nbsp;&nbsp; return 0;<br>
}<br>
<br>
/* Read Method */<br>
<br>
ssize_t led_read(struct file *flip, char __user *buf, size_t count, loff_t =
*f_pos)<br>
{<br>
&nbsp;&nbsp;&nbsp; size_t&nbsp; retval =3D 0;<br>
&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp; data;<br>
<br>
&nbsp;&nbsp;&nbsp; printk(KERN_INFO "%s: Entering\n\r", __FUNCTION__);<br>
<br>
&nbsp;&nbsp;&nbsp; if(*f_pos &gt;=3D sizeof(data))<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; goto out01;<br>
&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp; if(*f_pos + count &gt;=3D sizeof(data))<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; count =3D sizeof(data) - *f_pos;<br>
&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp; data =3D XGpio_DiscreteRead(&amp;gp_out, LEDChan);<br>
&nbsp;&nbsp;&nbsp; printk(KERN_INFO "data =3D 0x%08X!\n\r", data);<br>
<br>
&nbsp;&nbsp;&nbsp; if(copy_to_user(buf, &amp;data, count))<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; retval =3D -EFAULT;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; goto out01;<br>
&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; *f_pos +=3D count;<br>
&nbsp;&nbsp;&nbsp; retval =3D count;<br>
<br>
out01:&nbsp;&nbsp;&nbsp; return retval;<br>
<br>
}<br>
<br>
/* Write Method */<br>
ssize_t led_write(struct file *flip, const char __user *buf, size_t count, =
loff_t *f_pos)<br>
{<br>
&nbsp;&nbsp;&nbsp; size_t&nbsp; retval =3D 0;<br>
&nbsp;&nbsp;&nbsp; Xuint32&nbsp;&nbsp;&nbsp; data;<br>
<br>
&nbsp;&nbsp;&nbsp; printk(KERN_INFO "%s: Entering\n\r", __FUNCTION__);<br>
<br>
&nbsp;&nbsp;&nbsp; if(count &lt; sizeof(data))<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printk("argument to small!\n\r");<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; retval =3D -EINVAL;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; goto out01;<br>
&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; if(*f_pos + count &gt;=3D sizeof(data))<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; count =3D sizeof(data) - *f_pos;<br>
&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; if(copy_from_user(&amp;data,buf, count))<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; retval =3D -EFAULT;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; goto out01;<br>
&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; XGpio_DiscreteWrite(&amp;gp_out,LEDChan,data);<br>
&nbsp;&nbsp;&nbsp; *f_pos +=3D count;<br>
&nbsp;&nbsp;&nbsp; retval =3D count;<br>
<br>
out01:&nbsp;&nbsp;&nbsp; return retval;<br>
}<br>
<br>
/* File Operations Structure */<br>
<br>
struct file_operations led_fops =3D {<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; owner:&nbsp;&nbsp;&nbsp; THIS_MODULE,<br>
&nbsp;&nbsp;&nbsp; open:&nbsp;&nbsp;&nbsp; led_open,<br>
&nbsp;&nbsp;&nbsp; read:&nbsp;&nbsp;&nbsp; led_read,<br>
&nbsp;&nbsp;&nbsp; write:&nbsp;&nbsp;&nbsp; led_write,<br>
&nbsp;&nbsp;&nbsp; release:led_release<br>
};<br>
<br>
/* Device Registration */<br>
int xilinx_ml403_led_setup(void)<br>
{<br>
&nbsp;&nbsp;&nbsp; XGpio_Config xgpio_config;<br>
&nbsp;&nbsp;&nbsp; struct cdev *cdev=3D0;<br>
&nbsp;&nbsp;&nbsp; int retval =3D 0;<br>
&nbsp;&nbsp;&nbsp; dev_t devno;<br>
<br>
&nbsp;&nbsp;&nbsp; memset(&amp;xilinx_ml403_led, 0, sizeof(struct led_insta=
nce));<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; /* Map the control registers in */<br>
&nbsp;&nbsp;&nbsp; /* get baseaddress and highaddress */<br>
&nbsp;&nbsp;&nbsp; xilinx_ml403_led.phy_baseaddr&nbsp;&nbsp;&nbsp; =3D LED_=
PHY_BASEADDR;<br>
&nbsp;&nbsp;&nbsp; xilinx_ml403_led.remap_size&nbsp;&nbsp;&nbsp; =3D LED_PH=
Y_HIGHADDR - LED_PHY_BASEADDR + 1;<br>
&nbsp;&nbsp;&nbsp; xilinx_ml403_led.device_id&nbsp;&nbsp;&nbsp; =3D LED_DEV=
ICE_ID;<br>
<br>
&nbsp;&nbsp;&nbsp; if(!xilinx_ml403_led.phy_baseaddr ||
(xilinx_ml403_led.remap_size - xilinx_ml403_led.phy_baseaddr + 1 &lt;
8))<br>
&nbsp;&nbsp;&nbsp; {<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printk(KERN_ERR "%s: Couldn't get reg=
isters resource\n\r","led");<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; retval =3D -EFAULT;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; goto failed1;<br>
&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp;&nbsp; <br>
<br>
&nbsp;&nbsp;&nbsp; if(!request_mem_region(xilinx_ml403_led.phy_baseaddr, xi=
linx_ml403_led.remap_size, DRIVER_NAME))<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printk(KERN_ERR "Couldn't lock
memory region at 0x%08lX\n\r",(unsigned long)
xilinx_ml403_led.phy_baseaddr);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; retval =3D -EBUSY;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; goto failed2; <br>
<br>
&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp; xilinx_ml403_led.virtual_baseaddr =3D ioremap(xilinx_ml4=
03_led.phy_baseaddr, xilinx_ml403_led.remap_size);<br>
<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; if(!xilinx_ml403_led.virtual_baseaddr)<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printk(KERN_ERR "Couldn't ioremap
memory at 0x%08lX\n\r", (unsigned long) xilinx_ml403_led.phy_baseaddr);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; retval =3D -EFAULT;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; goto failed3;<br>
<br>
&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp; if(XGpio_CfgInitialize(&amp;gp_out, &amp;xgpio_config,xi=
linx_ml403_led.virtual_baseaddr) !=3D XST_SUCCESS)<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printk(KERN_ERR "%s: Couldn't initial=
ize instance.\n\r","xilinx_led");<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; retval =3D -ENODEV;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; goto failed3;<br>
&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; XGpio_SetDataDirection(&amp;gp_out, LEDChan , 0x00000000=
);<br>
<br>
&nbsp;&nbsp;&nbsp; cdev=3D kmalloc(sizeof(struct cdev), GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp; if(!cdev)<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printk(KERN_ERR "%s: Couldn't allocat=
e device private record\n\r","led");<br>
&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp; memset(cdev,0,sizeof(struct cdev));<br>
<br>
&nbsp;&nbsp;&nbsp; cdev_init(cdev,&amp;led_fops);<br>
&nbsp;&nbsp;&nbsp; cdev-&gt;owner =3D THIS_MODULE;<br>
&nbsp;&nbsp;&nbsp; cdev-&gt;ops =3D &amp;led_fops;<br>
&nbsp;&nbsp;&nbsp; devno =3D MKDEV(LED_MAJOR,LED_MINOR);<br>
&nbsp;&nbsp;&nbsp; retval =3D cdev_add(cdev,devno,1);<br>
<br>
&nbsp;&nbsp;&nbsp; xilinx_ml403_led.cdev;<br>
<br>
&nbsp;&nbsp;&nbsp; printk(KERN_ERR "%s at 0x%081X mapped to 0x%08X
device:%u,%u\n\r","xilinx_led",xilinx_ml403_led.phy_baseaddr,(unsigned
int) xilinx_ml403_led.virtual_baseaddr,(unsigned
int)MAJOR(xilinx_ml403_led.cdev-&gt;dev),(unsigned
int)MINOR(xilinx_ml403_led.cdev-&gt;dev));<br>
<br>
&nbsp;&nbsp;&nbsp; failed3:<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; iounmap((void *) (xilinx_ml403_led.ph=
y_baseaddr));<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; failed2:<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; release_mem_region(xilinx_ml403_led.p=
hy_baseaddr,xilinx_ml403_led.remap_size);<br>
<br>
&nbsp;&nbsp;&nbsp; failed1:<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return retval;<br>
}<br>
<br>
int __init led_init(void)<br>
{<br>
&nbsp;&nbsp;&nbsp; int retval;<br>
&nbsp;&nbsp;&nbsp; retval=3Dxilinx_ml403_led_setup();<br>
&nbsp;&nbsp;&nbsp; if(retval)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return retval;<br>
&nbsp;&nbsp;&nbsp; return 0;<br>
}<br>
<br>
void __exit led_exit(void)<br>
{<br>
&nbsp;&nbsp;&nbsp; cdev_del(xilinx_ml403_led.cdev);<br>
<br>
&nbsp;&nbsp;&nbsp; iounmap((void *)(xilinx_ml403_led.virtual_baseaddr));<br=
>
&nbsp;&nbsp;&nbsp; release_mem_region(xilinx_ml403_led.phy_baseaddr,xilinx_=
ml403_led.remap_size);<br>
}<br>
<br>
module_init(led_init);<br>
module_exit(led_exit);<br>
<br>
MODULE_AUTHOR("SANDEEPANI - SCHOOL OF EMBEDDDED DESIGN");<br>
MODULE_DESCRIPTION(DRIVER_DESCRIPTION);<br>
MODULE_LICENSE("Dual BSD/GPL");<br>
<br>
<br>
</td></tr></table><br>=0A=0A=0A      <!--3--><hr size=3D1></hr> Explore and=
 discover exciting holidays and getaways with Yahoo! India Travel <a href=
=3D"http://in.rd.yahoo.com/tagline_Travel_1/*http://in.travel.yahoo.com/"> =
Click here!</a>
--0-623270791-1242886842=:28414--
