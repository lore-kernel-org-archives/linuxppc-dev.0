Return-Path: <shawnxjin@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 954DAB70CE
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Aug 2010 16:37:02 +1000 (EST)
Received: by eyh6 with SMTP id 6so11395003eyh.15
	for <linuxppc-dev@ozlabs.org>; Sun, 08 Aug 2010 23:37:01 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 8 Aug 2010 23:37:00 -0700
Message-ID: <AANLkTinjLBPG9YfpoDnSoKeGvUO2OEjdTXrYLTZ9c8LB@mail.gmail.com>
Subject: mpc870: hctosys.c unable to open rtc device rtc0
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

A DS1339 RTC is connected to the I2C bus (i2c-cpm in mpc870). The
dmesg below shows that the ds1037 driver was registered. But the
hctosys.c was not able to open the rtc device rtc0. The rtc doesn't
seem to be connected with I2C driver properly.

i2c-core: driver [rtc-ds1307] registered
i2c /dev entries driver
i2c-core: driver [dev_driver] registered
fsl-i2c-cpm fa200860.i2c: cpm_i2c_setup()
  alloc irq_desc for 21 on node 0
  alloc kstat_irqs on node 0
irq: irq 16 on host /soc@fa200000/cpm@9c0/interrupt-controller@930
mapped to virtual irq 21
fsl-i2c-cpm fa200860.i2c: i2c_ram 0xfddfbc80, i2c_addr 0x1c80, freq 60000
fsl-i2c-cpm fa200860.i2c: tbase 0x0340, rbase 0x0360
i2c i2c-0: adapter [i2c-cpm] registered
i2c-dev: adapter [i2c-cpm] registered as minor 0
fsl-i2c-cpm fa200860.i2c: hw routines for i2c-cpm registered.
i2c-core: driver [lm75] registered
TCP cubic registered
NET: Registered protocol family 17
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)

My I2C settings in the dts is as follows, same as the mpc885ads.

                        i2c@860 {
                                compatible = "fsl,mpc885-i2c",
                                             "fsl,cpm1-i2c";
                                reg = <0x860 0x20 0x3c80 0x30>;
                                interrupts = <16>;
                                interrupt-parent = <&CPM_PIC>;
                                fsl,cpm-command = <0x10>;
                                #address-cells = <1>;
                                #size-cells = <0>;
                        };

Reading the fsl i2c bindings in the documentation, I found an example
as follows.
  27      i2c@860 {
  28                compatible = "fsl,mpc823-i2c",
  29                             "fsl,cpm1-i2c";
  30                reg = <0x860 0x20 0x3c80 0x30>;
  31                interrupts = <16>;
  32                interrupt-parent = <&CPM_PIC>;
  33                fsl,cpm-command = <0x10>;
  34                #address-cells = <1>;
  35                #size-cells = <0>;
  36
  37                rtc@68 {
  38                        compatible = "dallas,ds1307";
  39                        reg = <0x68>;
  40                };
  41        };
  42

In the above example the rtc was explicitly declared as a subnode of
the i2c node. Is this the way to connect (or bind) a RTC to the I2C
driver? If not how is an RTC driver (or hwmon driver) bound to the I2C
driver? What is the reg (0x68) under rtc node?

I set breakpoint at ds1037_probe() and was hoping that it might be hit
during the driver registration. But it didn't. Would the
ds1037_probe() be called during when the ds1037_driver was registered
as an I2C driver?

Thanks,
-Shawn.
