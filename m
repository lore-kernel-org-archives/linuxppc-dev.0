Return-Path: <daniel.ng1234@gmail.com>
Received: from mail-gx0-f25.google.com (mail-gx0-f25.google.com
	[209.85.217.25]) by ozlabs.org (Postfix) with ESMTP id 42BE8DE136
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 12:41:15 +1100 (EST)
Received: by gxk6 with SMTP id 6so107782gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 17:41:14 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 16 Jan 2009 12:22:39 +1100
Message-ID: <547eba1b0901151722p4a6afce4nc769fcb8cff82ea6@mail.gmail.com>
Subject: Re: Device Tree setup for 8272-based board
From: Daniel Ng <daniel.ng1234@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Scott,

> Scott Wood freescale.com> writes:
> > Yes, if u-boot is providing junk, then you'll probably want to hack up
> > the wrapper to ignore it. Or just upgrade u-boot to one that works.

So, I've gotten the latest u-boot installed and working. Here's my boot
sequence-

## Booting kernel from Legacy Image at 00200000 ...
Image Name: Linux-2.6.27-xxx
Image Type: PowerPC Linux Kernel Image (gzip compressed)
Data Size: 1337540 Bytes = 1.3 MB
Load Address: 00400000
Entry Point: 00400b8c
Verifying Checksum ... OK
Uncompressing Kernel Image ... OK
Memory <- <0x0 0x2000000> (32MB)
CPU clock-frequency <- 0x13ab6680 (330MHz)
CPU timebase-frequency <- 0xfbc520 (17MHz)
CPU bus-frequency <- 0x3ef1480 (66MHz)

zImage starting: loaded at 0x00400000 (sp: 0x01f789c8)
Allocating 0x2c96d0 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040c000:0x006c6e28)...done 0x2a819c bytes

Linux/PowerPC load: root=/dev/mtdblock4 rw rootfstype=cramfs
mtdparts=flash:256K(ub
oot),128K(env1),128K(env2),1536K(linux1),6144K(root1),4096K(app1),1536K
(linux2),614
4K(root2),4096K(app2),1536K(usr),-(usb) panic=1 console=ttyCPM0 mem=32M usbid=1
Finalizing device tree... flat tree at 0x40ad90


-after that everything seems to freeze. There is no more console output, and
pings to the board fail.

What sort of debug output is available to me at this point?

I've tried various values for 'console' but I'm quite certain 'ttyCPM0' is the
one to use (just a reminder that it is a PPC-8272-based board).

I've even tried enabling the 'Early serial debugging for Freescale CPM-based
serial ports' option in the Kernel config. Unfortunately this doesn't result
in any noticeable difference.

Can you explain why my board is freezing?

Here is my Device Tree. It is a stripped-down version of mpc8272ads.dts (PCI
has been removed among many others). I have tried to minimise the tree just to
keep things simple.

Perhaps I removed something I shouldn't have?-

/dts-v1/;

/ {
model = "HPXRED";
compatible = "fsl,mpc8272ads";
#address-cells = <1>;
#size-cells = <1>;

cpus {
#address-cells = <1>;
#size-cells = <0>;

PowerPC,8272@0 {
device_type = "cpu";
reg = <0x0>;
d-cache-line-size = <32>;
i-cache-line-size = <32>;
d-cache-size = <16384>;
i-cache-size = <16384>;
timebase-frequency = <0>;
bus-frequency = <0>;
clock-frequency = <0>;
};
};
soc@f0000000 {
#address-cells = <1>;
#size-cells = <1>;
device_type = "soc";
compatible = "fsl,mpc8272", "fsl,pq2-soc";
ranges = <0x0 0xf0000000 0x53000>;

// Temporary -- will go away once kernel uses ranges for
get_immrbase().
reg = <0xf0000000 0x53000>;

cpm@119c0 {
#address-cells = <1>;
#size-cells = <1>;
compatible = "fsl,mpc8272-cpm", "fsl,cpm2";
reg = <0x119c0 0x30>;
ranges;

muram@0 {
#address-cells = <1>;
#size-cells = <1>;
ranges = <0x0 0x0 0x10000>;

data@0 {
compatible = "fsl,cpm-muram-data";
reg = <0x0 0x2000 0x9800 0x800>;
};
};

serial@11a00 {
device_type = "serial";
compatible = "fsl,mpc8272-scc-uart",
"fsl,cpm2-scc-uart";
reg = <0x11a00 0x20 0x8000 0x100>;
interrupts = <40 8>;
interrupt-parent = <&PIC>;
fsl,cpm-brg = <1>;
fsl,cpm-command = <0x800000>;
};

};

PIC: interrupt-controller@10c00 {
#interrupt-cells = <2>;
interrupt-controller;
reg = <0x10c00 0x80>;
compatible = "fsl,mpc8272-pic", "fsl,cpm2-pic";
};

};

chosen {
linux,stdout-path = "/soc/cpm/serial@11a00";
};
};



Cheers,
Daniel
