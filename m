Return-Path: <shawnxjin@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id B0E4EB70AA
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 07:05:27 +1000 (EST)
Received: by eyh6 with SMTP id 6so11810090eyh.15
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Aug 2010 14:05:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100809122933.5a314af3@schlenkerla.am.freescale.net>
References: <AANLkTinjLBPG9YfpoDnSoKeGvUO2OEjdTXrYLTZ9c8LB@mail.gmail.com>
	<20100809122933.5a314af3@schlenkerla.am.freescale.net>
Date: Mon, 9 Aug 2010 14:05:25 -0700
Message-ID: <AANLkTim4tGYAyCMxHG8nPLKL4dHepB2Pp4Kxq4bNcsJE@mail.gmail.com>
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

>> Reading the fsl i2c bindings in the documentation, I found an example
>> as follows.
>> =A0 27 =A0 =A0 =A0i2c@860 {
>> =A0 28 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc823-i2c",
>> =A0 29 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "fsl,cpm1=
-i2c";
>> =A0 30 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x860 0x20 0x3c80 0x30>;
>> =A0 31 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <16>;
>> =A0 32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&CPM_PIC>;
>> =A0 33 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl,cpm-command =3D <0x10>;
>> =A0 34 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <1>;
>> =A0 35 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <0>;
>> =A0 36
>> =A0 37 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc@68 {
>> =A0 38 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "da=
llas,ds1307";
>> =A0 39 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x68>;
>> =A0 40 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>> =A0 41 =A0 =A0 =A0 =A0};
>> =A0 42
>>
>> In the above example the rtc was explicitly declared as a subnode of
>> the i2c node. Is this the way to connect (or bind) a RTC to the I2C
>> driver?
>
> Yes.

Thanks Scott for the confirmation. I added that to my dts file and the
driver did try to probe the device. But accessing the device timed
out. There are some microcode patches related to I2C that I've not
applied. I'll try the patch(es) later. But how can I find out which
patch should be applied to my MPC870?

Thanks,
-Shawn.
