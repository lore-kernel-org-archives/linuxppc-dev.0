Return-Path: <ivica@asist-traffic.com>
Received: from mta1.siol.net (pegasus.siol.net [193.189.160.40])
	by ozlabs.org (Postfix) with ESMTP id 099DC2BF07
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Dec 2004 06:26:06 +1100 (EST)
Received: from edge1.siol.net ([10.10.10.210]) by mta1.siol.net with ESMTP
	id <20041220192551.ZOIN10428.mta1.siol.net@edge1.siol.net>
	for <linuxppc-embedded@ozlabs.org>; Mon, 20 Dec 2004 20:25:51 +0100
Received: from linux.asist ([193.95.241.43]) by edge1.siol.net with ESMTP
	id <20041220192547.RIRS29321.edge1.siol.net@linux.asist>
	for <linuxppc-embedded@ozlabs.org>; Mon, 20 Dec 2004 20:25:47 +0100
Received: from [192.168.254.58] (unknown [192.168.254.58])
	by linux.asist (Postfix) with ESMTP id 09403644A9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Dec 2004 20:25:40 +0100 (CET)
Message-ID: <41C72733.9030300@asist-traffic.com>
Date: Mon, 20 Dec 2004 20:25:39 +0100
From: ivica@asist-traffic.com
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: i2c on mpc5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!

I have a hardware clock (RTC) which is not yet supported in
the linux kernel. It is RX-8025 module from EPSON and it is
I2C bus-interface based. Before I start writing support for this
module I would like to have I2C support working in my kernel.
Has anybody succeeded in getting I2C supported for MPC5200
based boards with 2.6 kernels? I'm using the one which maintains
Sylvain Munaut. If I boot up the kernel with I2C support in it
I don't get any initialization messages for I2C, only this one line:
----------------------------------------------------------------------
eth0: Phy @ 0x0, type LXT971 (0x001378e2)                           
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
-----------------------------------------------------------------------

I tried with v various 2.4 kernels but I only had some success with a 
kernel
form metrowerks which I got from a colleague. This is it's output.
--------------------------------------------------------------------------------
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-algo-bit.o: i2c bit algorithm module
i2c-proc.o version 2.6.1 (20010825)
devfs_register(ttyS): could not append to parent, err: -17
devfs_register(ttyS): could not append to parent, err: -17
devfs_register(cua): could not append to parent, err: -17
devfs_register(cua): could not append to parent, err: -17
PORT CONFIG 4
PORT CONFIG 500044
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
i2c-dev.o: Registered 'Icecube I2C module #2 interface' as minor 0
i2c-core.o: adapter Icecube I2C module #2 interface registered as adapter 0.
i2c-algo-5xxx.o: scanning bus Icecube I2C module #2 interface...
..................................................(0x32).............................(0x50)(0x51)(0x52)(0x53)(0x54)(0x55)(0x56)(0x57).......................................(0x)
i2c-icecube.o: I2C module #2 installed
------------------------------------------------------------------------------------

This kernel has some strange hacks in it and I needed to change some 
code in order
for it to compile under gcc. Ok, it works now but I would really like to 
code the driver
for RTC module under 2.6 tree and like it is supposed to be done. I like 
the 2.6 I2C directory tree
and it all makes more sense to a newb like me. First I need to get those 
core.o and algo.o
stuff working. Under the menuconfig in the I2C there is a
I2C Hardware Bus support  ---> [*] MPC107/824x/85xx/52xx
'Help' says :
"If you say yes to this option, support will be included for the
built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245 and
MPC85xx family processors. The driver may also work on 52xx
family processors, though interrupts are known not to work."

I'm guessing this (drivers/i2c/busses/i2c-mpc.c) is the part I need to 
work on?
Of course any input on where should I start would be greatly appreciated.
Also if anyone has already succeeded in supporting i2c for mpc5200 I 
would love
to hear your experience.

Best regards,
Ivica
