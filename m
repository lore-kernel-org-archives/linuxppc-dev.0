Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 1330BB6EF1
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 03:29:53 +1000 (EST)
Received: from mail189-va3 (localhost.localdomain [127.0.0.1])	by
	mail189-va3-R.bigfish.com (Postfix) with ESMTP id 9D3061E8247	for
	<linuxppc-dev@ozlabs.org>; Mon,  9 Aug 2010 17:29:49 +0000 (UTC)
Received: from VA3EHSMHS031.bigfish.com (unknown [10.7.14.252])	by
	mail189-va3.bigfish.com (Postfix) with ESMTP id 48E9951004F	for
	<linuxppc-dev@ozlabs.org>; Mon,  9 Aug 2010 17:29:49 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o79HTZsH020440	for <linuxppc-dev@ozlabs.org>;
	Mon, 9 Aug 2010 10:29:46 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o79Hf5a1017935	for <linuxppc-dev@ozlabs.org>;
	Mon, 9 Aug 2010 12:41:05 -0500 (CDT)
Date: Mon, 9 Aug 2010 12:29:33 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: mpc870: hctosys.c unable to open rtc device rtc0
Message-ID: <20100809122933.5a314af3@schlenkerla.am.freescale.net>
In-Reply-To: <AANLkTinjLBPG9YfpoDnSoKeGvUO2OEjdTXrYLTZ9c8LB@mail.gmail.com>
References: <AANLkTinjLBPG9YfpoDnSoKeGvUO2OEjdTXrYLTZ9c8LB@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 8 Aug 2010 23:37:00 -0700
Shawn Jin <shawnxjin@gmail.com> wrote:

> Reading the fsl i2c bindings in the documentation, I found an example
> as follows.
>   27      i2c@860 {
>   28                compatible = "fsl,mpc823-i2c",
>   29                             "fsl,cpm1-i2c";
>   30                reg = <0x860 0x20 0x3c80 0x30>;
>   31                interrupts = <16>;
>   32                interrupt-parent = <&CPM_PIC>;
>   33                fsl,cpm-command = <0x10>;
>   34                #address-cells = <1>;
>   35                #size-cells = <0>;
>   36
>   37                rtc@68 {
>   38                        compatible = "dallas,ds1307";
>   39                        reg = <0x68>;
>   40                };
>   41        };
>   42
> 
> In the above example the rtc was explicitly declared as a subnode of
> the i2c node. Is this the way to connect (or bind) a RTC to the I2C
> driver?

Yes.

> What is the reg (0x68) under rtc node?

It's the 7-bit I2C address (without the low-order direction bit).

> I set breakpoint at ds1037_probe() and was hoping that it might be hit
> during the driver registration. But it didn't. Would the
> ds1037_probe() be called during when the ds1037_driver was registered
> as an I2C driver?

The probe function is called only if the device is declared.  There is
no autodetection.

-Scott
