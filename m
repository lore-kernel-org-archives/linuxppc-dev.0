Return-Path: <shawnxjin@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id 2A9DEB70ED
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 17:07:27 +1000 (EST)
Received: by ewy2 with SMTP id 2so12125105ewy.15
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 00:07:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTim4tGYAyCMxHG8nPLKL4dHepB2Pp4Kxq4bNcsJE@mail.gmail.com>
References: <AANLkTinjLBPG9YfpoDnSoKeGvUO2OEjdTXrYLTZ9c8LB@mail.gmail.com>
	<20100809122933.5a314af3@schlenkerla.am.freescale.net>
	<AANLkTim4tGYAyCMxHG8nPLKL4dHepB2Pp4Kxq4bNcsJE@mail.gmail.com>
Date: Tue, 10 Aug 2010 00:07:25 -0700
Message-ID: <AANLkTimWHbRO=pZeWEkJdqhuWxecJWVNtytUy0rVwMjx@mail.gmail.com>
Subject: Re: mpc870: hctosys.c unable to open rtc device rtc0
From: Shawn Jin <shawnxjin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Thanks Scott for the confirmation. I added that to my dts file and the
> driver did try to probe the device. But accessing the device timed
> out. There are some microcode patches related to I2C that I've not
> applied. I'll try the patch(es) later. But how can I find out which
> patch should be applied to my MPC870?

:(, the I2C_SPI patch doesn't do any help. It still gets timeout when
probing the device. The slave address of DS1339 is 0x68. Here are the
debug messages. Before hooking up the oscilloscope, any quick hints
for me to try? The 2.4 kernel worked OK, BTW.

i2c-core: driver [rtc-ds1307] registered
i2c /dev entries driver
i2c-core: driver [dev_driver] registered
fsl-i2c-cpm fa200860.i2c: cpm_i2c_setup()
  alloc irq_desc for 21 on node 0
  alloc kstat_irqs on node 0
irq: irq 16 on host /soc@fa200000/cpm@9c0/interrupt-controller@930
mapped to virtual irq 21
fsl-i2c-cpm fa200860.i2c: i2c_ram 0xfddfa500, i2c_addr 0x0500, freq 60000
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
i2c i2c-0: test ready.
i2c i2c-0: Interrupt: 2
i2c i2c-0: ready.
i2c i2c-0: tx sc 0 0x1400
i2c i2c-0: test ready.
i2c i2c-0: I2C transfer: timeout
i2c i2c-0: cpm_i2c_force_close()
rtc-ds1307: probe of 0-0068 failed with error -5
i2c i2c-0: client [ds1339] registered with bus id 0-0068
i2c-core: driver [lm75] registered
TCP cubic registered
NET: Registered protocol family 17
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Freeing unused kernel memory: 1512k init

Thanks,
-Shawn.
