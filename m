Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id B28A6DDDF5
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Oct 2007 19:28:49 +1000 (EST)
Date: Thu, 4 Oct 2007 11:29:06 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Bruce_Leonard@selinc.com
Subject: Re: Device tree and external RTC
In-Reply-To: <OF5A3A8901.AAC62E29-ON88257369.007F3E0B-88257369.007FC5D0@selinc.com>
Message-ID: <Pine.LNX.4.60.0710041046040.4537@poirot.grange>
References: <OF5A3A8901.AAC62E29-ON88257369.007F3E0B-88257369.007FC5D0@selinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 3 Oct 2007 Bruce_Leonard@selinc.com wrote:

> I'm seriously confused by how things are supposed to work now with device 
> trees on the PowerPC arch.  I'm bringing up our custom HW which is bassed 
> on the mpc8347e, with an m41t00 RTC hanging off the i2c bus, U-boot is 
> 1.2.0, kernel is 2.6.22.  My problem is I can't get the kernel to access 
> the RTC.  It works fine in U-boot, but nothing in the kernel.
> 
> Where I get confused is I'm not sure if this is something that the device 
> tree is supposed to be telling the kernel about or if it's something that 
> the kernel should probe for.

i2c probing is not perfectly reliable, so, yes, you have to tell the i2c 
subsystem what i2c devices you have. There are several possibilities to do 
this currently in the kernel, one of which is using the device-tree, which 
is also the way I personally prefer:-)

> I've turned on everything in Kconfig I can 
> find for I2C and RTC.  Here's what I think are the relavant parts of 
> .config:

Let's see

...
> CONFIG_I2C_BOARDINFO=y

This is good.

> #
> # I2C Algorithms
> #
> CONFIG_I2C_ALGOBIT=y
> CONFIG_I2C_ALGOPCF=y
> CONFIG_I2C_ALGOPCA=y

You don't need any of these.

> #
> # I2C Hardware Bus support
> #
> CONFIG_I2C_ALI1535=y
> # CONFIG_I2C_ALI1563 is not set
> CONFIG_I2C_ALI15X3=y
> CONFIG_I2C_AMD756=y
> # CONFIG_I2C_AMD756_S4882 is not set
> CONFIG_I2C_AMD8111=y
> CONFIG_I2C_I801=y
> CONFIG_I2C_I810=y
> CONFIG_I2C_PIIX4=y
> CONFIG_I2C_MPC=y

You only have one i2c bus, I guess, and it is the one above: "I2C_MPC".

> CONFIG_I2C_NFORCE2=y
> # CONFIG_I2C_OCORES is not set
> CONFIG_I2C_PARPORT_LIGHT=y
> CONFIG_I2C_PROSAVAGE=y
> # CONFIG_I2C_SAVAGE4 is not set
> CONFIG_I2C_SIMTEC=y
> CONFIG_I2C_SIS5595=y
> CONFIG_I2C_SIS630=y
> CONFIG_I2C_SIS96X=y
> # CONFIG_I2C_STUB is not set
> # CONFIG_I2C_VIA is not set
> CONFIG_I2C_VIAPRO=y
> CONFIG_I2C_VOODOO3=y
> 
> #
> # Miscellaneous I2C Chip support
> #
> # CONFIG_SENSORS_DS1337 is not set
> # CONFIG_SENSORS_DS1374 is not set
> # CONFIG_SENSORS_EEPROM is not set
> # CONFIG_SENSORS_PCF8574 is not set
> # CONFIG_SENSORS_PCA9539 is not set
> # CONFIG_SENSORS_PCF8591 is not set
> CONFIG_SENSORS_M41T00=y

It shall not hurt, but do you really have this one?

> # CONFIG_SENSORS_MAX6875 is not set
> CONFIG_I2C_DEBUG_CORE=y
> CONFIG_I2C_DEBUG_ALGO=y
> CONFIG_I2C_DEBUG_BUS=y
> CONFIG_I2C_DEBUG_CHIP=y
> 
> <snip>
> 
> #
> # Real Time Clock
> #
> CONFIG_RTC_LIB=y
> CONFIG_RTC_CLASS=y
> CONFIG_RTC_HCTOSYS=y
> CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> CONFIG_RTC_DEBUG=y
> 
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=y
> CONFIG_RTC_INTF_PROC=y
> CONFIG_RTC_INTF_DEV=y
> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> # CONFIG_RTC_DRV_TEST is not set
> 
> #
> # I2C RTC drivers
> #
> CONFIG_RTC_DRV_DS1307=y

Ok, so, this is your rtc.

> However, I get the following error when I run hwclock --debug:
> hwclock from util-linux-2.12r
> hwclock: Open of /dev/rtc failed, errno=19: No such device.  (note that 
> the device is present with a major of 10 and a minor of 135)
> No usable clock interface found.
> Cannot access the Hardware Clock via any known method.

First, this might be either a userspace or a kernel problem. Do you have 
the correct device nodes? Are you using udev? Should be something like

$ ls -l /dev/rtc*
lrwxrwxrwx 1 root root      4 Oct  4 10:44 /dev/rtc -> rtc0
crw-rw---- 1 root root 254, 0 Oct  4 10:44 /dev/rtc0

> When I dump out ppc_md, all the RTC functions (i.e., get_rtc_time, 
> read_rtc_val, etc.) are all NULL.

Don't think you need those. Those are for powerpc platforms not using 
the generic rtc driver.

> I've searched through all the device tree files that come with the kernel 
> and I can't find any that explicitly show an external device as a child 
> node to a SoC I2C controller but it sure seems to me that the purpose of 
> the device tree is to describe to the kernel all the hardware in the 
> system.  Therefore it seems to me that there should be something like the 
> following in the device tree:
> 
> <snip>
> i2c@3000 {
>         device_type = "i2c";
>         compatible = "fsl-i2c";
>         reg = <3000 100>;
>         interrupts = <e 8>;
>         interrupt-parent = < &ipic >;
>         dfsrr;
> 
>         rtc@54 {
>                 device_type = "rtc";
>                 something;
>                 something;
>                 something;
>         }
> }
> <snip>

Yes, this is exactly what you need, if you don't want to hard code your 
rtc in the kernel board-specific code. I'm gessing, examples you were 
looking at are in arch/powerpc/boot/dts/kuroboxH[DG].dts. For this to work 
you need suitable entries in arch/powerpc/sysdev/fsl_soc.c in the 
i2c_devices array. I think, patch at 
http://patchwork.ozlabs.org/linuxppc/patch?id=13624 is exactly what you 
need.

Having applied the above patch and booted with the new kernel and 
device-tree, after "cd /proc/device-tree" and calling lsprop you should 
see something like

soc10x/i2c@80003000:
name             "i2c"
interrupt-parent 00000001
interrupts       00000005 00000002
reg              80003000 00001000
compatible       "fsl-i2c"
device_type      "i2c"
#size-cells      00000000
#address-cells   00000001

soc10x/i2c@80003000/rtc@32:
name             "rtc"
reg              00000032 (50)
compatible       "ricoh,rs5c372a"
device_type      "rtc"

Then you should have a directory like

/sys/devices/platform/fsl-i2c.0/i2c-adapter/i2c-0/0-0032

with a link in it like

lrwxrwxrwx 1 root root    0 Oct  4 11:00 driver -> ../../../../../../bus/i2c/drivers/rtc-rs5c372

dmesg should report something like

rtc-rs5c372 0-0032: rtc core: registered rtc-rs5c372 as rtc0

and

rtc-rs5c372 0-0032: setting the system clock to 2007-10-04 08:44:26 (1191487466)

Don't know what other messages ds1307 prints out.

> Okay, I figured out that I was indeed reading the clock (should have been 
> using date command rather than hwclock command), so sorry for the noise. 
> So what is is that hwclock is trying to do that it's unhappy about?

No, date is just giving you the system time, set either from rtc, or from 
an ntp server, or to 1.1.1970 on startup.

Thanks
Guennadi
---
Guennadi Liakhovetski
