Return-Path: <shawnxjin@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id D3942B70DE
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Aug 2010 19:04:41 +1000 (EST)
Received: by eyh6 with SMTP id 6so176818eyh.15
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Aug 2010 02:04:39 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 18 Aug 2010 02:04:39 -0700
Message-ID: <AANLkTinTj7E0+fK=JMQoSePOSMt77FO+QETHPoqnT3a6@mail.gmail.com>
Subject: cpm_i2c: write OK but read fail
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

My system is MPC870 based and I'm enabling the I2C driver and the
ds1339 RTC driver. When the kernel tries to probe the RTC chip (slave
address 0x68), the first write seems OK but the subsequent read times
out. I applied the I2C/SPI microcode patch, which doesn't seem
necessary though. Below is the dmesg output and all I2C debug messages
are enabled.

i2c-core: driver [rtc-ds1307] registered
i2c /dev entries driver
i2c-core: driver [dev_driver] registered
fsl-i2c-cpm fa200860.i2c: cpm_i2c_setup()
  alloc irq_desc for 21 on node 0
  alloc kstat_irqs on node 0
irq: irq 16 on host /soc@fa200000/cpm@9c0/interrupt-controller@930
mapped to virtual irq 21
fsl-i2c-cpm fa200860.i2c: i2c_ram 0xfddfa400, i2c_addr 0x0400, freq 60000
fsl-i2c-cpm fa200860.i2c: tbase 0x0340, rbase 0x0360
i2c i2c-0: adapter [i2c-cpm] registered
i2c-dev: adapter [i2c-cpm] registered as minor 0
fsl-i2c-cpm fa200860.i2c: hw routines for i2c-cpm registered.
i2c 0-0068: uevent
rtc-ds1307 0-0068: probe
i2c i2c-0: master_xfer[0] W, addr=0x68, len=1
i2c i2c-0: master_xfer[1] R, addr=0x68, len=2
i2c i2c-0: R: 0 T: 0
i2c i2c-0: cpm_i2c_write(abyte=0xd0)
i2c i2c-0: R: 0 T: 1
i2c i2c-0: cpm_i2c_read(abyte=0xd1)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The above shows there were two transfers being built (one write, one read).

i2c i2c-0: test ready.
i2c i2c-0: Interrupt: 2
i2c i2c-0: ready.
i2c i2c-0: tx sc 0 0x1400
^^^^^^^^^^^^^^^^^^^^^^^
This shows the write command went through successfully.

i2c i2c-0: test ready.
i2c i2c-0: I2C transfer: timeout
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
However the read timed out. :(

i2c i2c-0: cpm_i2c_force_close()
rtc-ds1307: probe of 0-0068 failed with error -5
i2c i2c-0: client [ds1339] registered with bus id 0-0068

The Tx/Rx BDs are dumped below.
fa202340 : 14000002 07b51000 ac000003 07b53000  ..............0.
fa202350 : 9fc3f137 07b55000 9739a1d0 07b4f000  ...7..P..9......
fa202360 : 90000000 07b50000 b68fa19d 07b52000  .............. .
fa202370 : 1b85e6cc 07b54000 49df3090 07b4e000  ......@.I.0.....

What went wrong with read?

Thanks,
-Shawn.
