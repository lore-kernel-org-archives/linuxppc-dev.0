Message-ID: <002f01c3c93a$6c0fb240$0f00a8c0@matto>
From: "Matteo Bortolin" <matteo.bortolin@wawnet.biz>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: <wd@denx.de>
Subject: module initialization sequence writing i2c client driver(RTC) 
Date: Tue, 23 Dec 2003 10:52:05 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I'm developing an RTC driver that uses i2c core for a PPC405-based board (PPChameleonEVB).
I've followed the example of driver for pcf 8563 (pcf8563.c) where in the __init function
pcf8563_rtc_init(void) there are code that performs "Switching kernel RTC pointers"
(ppc_md.set_rtc_time, ppc_md.get_rtc_time), when at this time i2c module should been initialized.

I've inserted the driver module m41t00.c  in drivers/char/ .
So in drivers/char/Makefile I've added the following line:

obj-$(CONFIG_M41T00_RTC) += m41t00.o

The code of __init m41t00_rtc_init function:

 static int __init m41t00_rtc_init (void)
{
 unsigned long now, flags;
 extern time_t last_rtc_update;
 extern rwlock_t xtime_lock;

 printk (KERN_INFO "m41t00Real-Time Clock Driver " RTC_VERSION "\n");
 misc_register(&rtc_dev);

 i2c_add_driver(&m41t00_driver);

 /* Switching kernel RTC pointers */
 debugk ("RTC switching kernel pointers\n");
 save_set_rtc_time   = ppc_md.set_rtc_time;
 save_get_rtc_time   = ppc_md.get_rtc_time;
 ppc_md.set_rtc_time = m41t00_set_rtc_time;
 ppc_md.get_rtc_time = m41t00_get_rtc_time;

 /*
  * Set system time
  * Code copied from arch/ppc/kernel/time.c
  */
 write_lock_irqsave(&xtime_lock, flags);
 now = m41t00_get_rtc_time();
..........


The problem is that when m41t00_get_rtc_time() is invoked, the pointer "static struct i2c_client *clnt"
has not yet been initialized (I've seen it with printk)!!!
This means that the called to i2c_add_driver function has not yet called the function
"m41t00_attach".

The code of m41t00_attach is

 clnt = kmalloc(sizeof(*clnt), GFP_KERNEL);
 if (!clnt)
  return -ENOMEM;
......

This is the kernel message on console

tyS00 at 0xef600300 (irq = 0) is a 16550A
ttyS01 at 0xef600400 (irq = 1) is a 16550A
M41T00 Real-Time Clock Driver
i2c-core.o: driver M41T00registered.
RTC switching kernel pointers
RTC switching kernel pointer ends
m41t00.o:M41T00_get_rtc_time Entering
m41t00.o: client=0
RTC installed, minor 135
IBM gpio driver version 07.25.02
GPIO #0 at 0xc3070700
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
eth0: Phy @ 0x1, type STE100P (0x1c040011)
Reset ethernet interfaces
eth1: Phy @ 0x2, type STE100P (0x1c040011)
Reset ethernet interfaces
NAND device: Manufacturer ID: 0xec, Chip ID: 0x75 (Samsung NAND 32MiB 3,3V)
kmod: failed to exec /sbin/modprobe -s -k cmdlinepart, errno = 2
cmdlinepart partition parsing not available
Using static partition definition
Creating 1 MTD partitions on "ppchameleonevb-nand":
0x00000000-0x02000000 : "PPChameleonEVB Nand Flash"
IBM On-chip iic (i2c) algorithm module 2002.30.04
iic_ibmocp_init: IBM on-chip iic adapter module

m41t00.o: M41T00_attach
m41t00.o: client=c1ff93a0
i2c-core.o: client [M41T00] registered to adapter [IBM OCP IIC adapter](pos. 0)
m41t00.o: client=c1ff93a0
i2c-core.o: adapter IBM OCP IIC adapter registered as adapter 0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP

So, the problem is that
"IBM On-chip iic (i2c) algorithm module" and  "IBM on-chip iic adapter module"
must be initialized before than m41t00.o module.

How can I force the m41t00.o module to be initialized after i2c core is set-up completely?

Best regards,

Matteo Bortolin

DAVE Srl - Electronics System House
via Forniz 2/1
33080 Porcia (PN) - Italy
Telephone: +39.0434.921215
Telefax: +39.0434.591631
Freefax: +39.02.700520062
web: www.dave-tech.it
e-mail: matteo.bortolin@wawnet.biz
how to reach us: http://mail.map24.com/dave


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
