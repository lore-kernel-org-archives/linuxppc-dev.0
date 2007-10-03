Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 32101DDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Oct 2007 07:13:19 +1000 (EST)
Received: from edison2.selinc.com (edison2.selinc.com [12.110.71.57])
	by tesla.selinc.com (8.12.11.20060308/8.12.11) with ESMTP id
	l93L0oNq000582
	for <linuxppc-embedded@ozlabs.org>; Wed, 3 Oct 2007 14:00:50 -0700
To: linuxppc-embedded@ozlabs.org
Subject: Device tree and external RTC
MIME-Version: 1.0
Message-ID: <OFFFD4BE8F.17F6E427-ON88257369.006D8651-88257369.00736D96@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Wed, 3 Oct 2007 14:00:49 -0700
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I'm seriously confused by how things are supposed to work now with device 
trees on the PowerPC arch.  I'm bringing up our custom HW which is bassed 
on the mpc8347e, with an m41t00 RTC hanging off the i2c bus, U-boot is 
1.2.0, kernel is 2.6.22.  My problem is I can't get the kernel to access 
the RTC.  It works fine in U-boot, but nothing in the kernel.

Where I get confused is I'm not sure if this is something that the device 
tree is supposed to be telling the kernel about or if it's something that 
the kernel should probe for.  I've turned on everything in Kconfig I can 
find for I2C and RTC.  Here's what I think are the relavant parts of 
.config:

<snip># CONFIG_TCG_TPM is not set
CONFIG_DEVPORT=y
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=y
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=y
CONFIG_I2C_AMD756=y
# CONFIG_I2C_AMD756_S4882 is not set
CONFIG_I2C_AMD8111=y
CONFIG_I2C_I801=y
CONFIG_I2C_I810=y
CONFIG_I2C_PIIX4=y
CONFIG_I2C_MPC=y
CONFIG_I2C_NFORCE2=y
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_PROSAVAGE=y
# CONFIG_I2C_SAVAGE4 is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=y
CONFIG_I2C_VOODOO3=y

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_SENSORS_M41T00=y
# CONFIG_SENSORS_MAX6875 is not set
CONFIG_I2C_DEBUG_CORE=y
CONFIG_I2C_DEBUG_ALGO=y
CONFIG_I2C_DEBUG_BUS=y
CONFIG_I2C_DEBUG_CHIP=y

<snip>

#
# Real Time Clock
#
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_DEBUG=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_DS1307=y
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set

#
# SPI RTC drivers
#

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#

However, I get the following error when I run hwclock --debug:
hwclock from util-linux-2.12r
hwclock: Open of /dev/rtc failed, errno=19: No such device.  (note that 
the device is present with a major of 10 and a minor of 135)
No usable clock interface found.
Cannot access the Hardware Clock via any known method.

When I dump out ppc_md, all the RTC functions (i.e., get_rtc_time, 
read_rtc_val, etc.) are all NULL.

I've searched through all the device tree files that come with the kernel 
and I can't find any that explicitly show an external device as a child 
node to a SoC I2C controller but it sure seems to me that the purpose of 
the device tree is to describe to the kernel all the hardware in the 
system.  Therefore it seems to me that there should be something like the 
following in the device tree:

<snip>
i2c@3000 {
        device_type = "i2c";
        compatible = "fsl-i2c";
        reg = <3000 100>;
        interrupts = <e 8>;
        interrupt-parent = < &ipic >;
        dfsrr;

        rtc@54 {
                device_type = "rtc";
                something;
                something;
                something;
        }
}
<snip>

I've googled for "device tree & rtc" and various other things that haven't 
poped out anything that really gives me any direction and 
booting_without_of.txt doesn't really help me very much because I think 
I'm just too dumb to understand it :-\.  (Took me two days to understand 
the ranges filed for the PCI node :(  ).

So, long winded way to get to it: Am I missing something in Kconfig for 
the kernel or am I missing something in the device tree?  Also, is there 
any place where things like the "dfsrr" attribute in the above device tree 
are described/defined?  I have no idea what that's supposed to mean and 
conversly I don't know what things are acceptable.  For example, if I need 
a RTC node in my device tree, what are the required attributes and what 
should the be set to?  Any direction as to where I should be looking to 
figure this sort of stuff out is greatly appreciated.

Sorry for the length of this post and thanks for any direction that can be 
provided.

Bruce
