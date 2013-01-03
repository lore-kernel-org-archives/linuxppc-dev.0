Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5AF372C007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2013 01:11:14 +1100 (EST)
Date: Thu, 3 Jan 2013 15:11:06 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Johannes Braun <jjo.braun@gmail.com>
Subject: Re: tqm5200s i2c bus timeout
Message-ID: <20130103151106.04e1ae94@crub>
In-Reply-To: <CADwvPCve5GaRZZXuLUq4Es2FLN8AxtbRP4TQP7gQVRXoMw3S0g@mail.gmail.com>
References: <CADwvPCve5GaRZZXuLUq4Es2FLN8AxtbRP4TQP7gQVRXoMw3S0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Thu, 3 Jan 2013 14:20:41 +0100
Johannes Braun <jjo.braun@gmail.com> wrote:

> Hello,
> 
> I hope someone could help me with my problem. Currently I am porting
> a new kernel (3.3.8) for a tqm5200s based board.
> The previous kernel was 2.6.23. The new kernel version is needed because
> of support for a wireless card.
> 
> I got issues with the i2c bus and this kernel. When the kernel boots up,
> the i2c initialization ends in a timout. This is the kernel log:
> 
> [    1.460652] i2c /dev entries driver
> [    1.465434] mpc-i2c f0003d40.i2c: timeout 1000000 us

No, the initialization doesn't end in timeout. It is just an info
which timeout value will be used for i2c transfers.

> 
> Connected to the bus is an eeprom (Microchip 24c32a) and a realtime
> clock (Philips PCF8563).
> The i2c bus section in the dtb file looks as follows:
> 
> i2c@3d40 {
>      #address-cells = <1>;
>      #size-cells = <0>;
>      compatible = "fsl,mpc5200-i2c","fsl-i2c";
>      reg = <0x3d40 0x40>;
>      interrupts = <2 16 0>;
>      fsl5200-clocking;

This "fsl5200-clocking" property is not needed anymore, you can remove it.

> };

> 
> The dtb file from the kernel 2.6.23 looks as follows:
> i2c@3d40 {
> 
> #address-cells = <1>;
>      #size-cells = <0>;
>      compatible = "fsl,mpc5200-i2c","fsl-i2c";
>      reg = <0x3d40 0x40>;
>      interrupts = <2 16 0>;
>      fsl5200-clocking;
> };
> 
> I can`t see any devices in /sys/bus/i2c/devices except the bus itself.
> # ls /sys/bus/i2c/devices
> # i2c-0
> # cat /sys/bus/i2c/devices/i2c-0/name
> # MPC adapter

This is expected since you didn't add sub-nodes for your i2c devices
24c32a and PCF8563 in the i2c adapter node.

> Is there something wrong with my dtb file or is it a bug in the mpc-i2c driver

It is an issue with our dtb file. Please look at the I2C eeprom
sub-node in the arch/powerpc/boot/dts/mpc5121ads.dts file and at
the pcf8563 RTC sub-node in the arch/powerpc/boot/dts/mucmc52.dts
file for an example how to add needed nodes for your devices.

Thanks,
Anatolij
