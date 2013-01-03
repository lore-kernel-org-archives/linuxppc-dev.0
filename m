Return-Path: <jjo.braun@gmail.com>
Received: from mail-ia0-f179.google.com (mail-ia0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EEFB52C0080
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2013 00:20:44 +1100 (EST)
Received: by mail-ia0-f179.google.com with SMTP id o25so12839452iad.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Jan 2013 05:20:41 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 3 Jan 2013 14:20:41 +0100
Message-ID: <CADwvPCve5GaRZZXuLUq4Es2FLN8AxtbRP4TQP7gQVRXoMw3S0g@mail.gmail.com>
Subject: tqm5200s i2c bus timeout
From: Johannes Braun <jjo.braun@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I hope someone could help me with my problem. Currently I am porting
a new kernel (3.3.8) for a tqm5200s based board.
The previous kernel was 2.6.23. The new kernel version is needed because
of support for a wireless card.

I got issues with the i2c bus and this kernel. When the kernel boots up,
the i2c initialization ends in a timout. This is the kernel log:

[    1.460652] i2c /dev entries driver
[    1.465434] mpc-i2c f0003d40.i2c: timeout 1000000 us

Connected to the bus is an eeprom (Microchip 24c32a) and a realtime
clock (Philips PCF8563).
The i2c bus section in the dtb file looks as follows:

i2c@3d40 {
     #address-cells = <1>;
     #size-cells = <0>;
     compatible = "fsl,mpc5200-i2c","fsl-i2c";
     reg = <0x3d40 0x40>;
     interrupts = <2 16 0>;
     fsl5200-clocking;
};

The dtb file from the kernel 2.6.23 looks as follows:
i2c@3d40 {

#address-cells = <1>;
     #size-cells = <0>;
     compatible = "fsl,mpc5200-i2c","fsl-i2c";
     reg = <0x3d40 0x40>;
     interrupts = <2 16 0>;
     fsl5200-clocking;
};

I can`t see any devices in /sys/bus/i2c/devices except the bus itself.
# ls /sys/bus/i2c/devices
# i2c-0
# cat /sys/bus/i2c/devices/i2c-0/name
# MPC adapter

Is there something wrong with my dtb file or is it a bug in the mpc-i2c driver

Best regards
Johannes
