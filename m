Return-Path: <edjubenville@adelphia.net>
Received: from mta1.adelphia.net (mta1.adelphia.net [68.168.78.175])
	by ozlabs.org (Postfix) with ESMTP id B3B88DDFBD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Mar 2008 05:01:54 +1100 (EST)
Received: from EJ1 ([76.86.189.85]) by mta11.adelphia.net
	(InterMail vM.6.01.05.02 201-2131-123-102-20050715) with SMTP
	id <20080317174249.LVBS1365.mta11.adelphia.net@EJ1>
	for <linuxppc-embedded@ozlabs.org>; Mon, 17 Mar 2008 13:42:49 -0400
From: "Edward Jubenville" <edjubenville@adelphia.net>
To: "Linuxppc-Embedded" <linuxppc-embedded@ozlabs.org>
Subject: Help getting USB keyboard active on MPC5200B
Date: Mon, 17 Mar 2008 10:42:36 -0700
Message-ID: <GPECLCIGPLHEOMGPMCPAGENCFKAA.edjubenville@adelphia.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I would appreciate a little help getting a USB keyboard working on a
MPC5200B-based Lite5200 clone board.

I'm working with the 2.4.25 kernel from ELDK 3.1.  I've tweaked my kernel
configuration parameters enough to have gotten a some USB functionality
working (memory stick, and mouse), but I cannot get any keyboard-related
device name to show up in the /dev tree.

I have USB debug enabled for verbose messages.  When I plug in a keyboard I
see:

  hub.c: new USB device 0-1.4, assigned address 5
  Manufacturer: Dell
  Product: Dell USB Keyboard
  usb.c: USB device 5 (vend/prod 0x413c/0x2003) is not claimed by any active
driver.
    Length              = 18
    DescriptorType      = 01
    USB version         = 1.10
    Vendor:Product      = 413c:2003
    MaxPacketSize0      = 8
    NumConfigurations   = 1
    Device version      = 3.01
    (remainder omitted)

I assume the message "... is not claimed by any driver" is the problem I
need to address.

I've compared my configuration parameters to those used in the Lite5200
CoralP configuration that supports USB, and I don't see any differences
related to the keyboard that might explain what's wrong.

When I diff my configuration to non-USB
arch/ppc/configs/icecube_5200_defconfig, these parameters stand out:

	CONFIG_INPUT=y
	CONFIG_INPUT_KEYBDEV=y
	CONFIG_INPUT_MOUSEDEV=y
	CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
	CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
	CONFIG_INPUT_EVDEV=y
	CONFIG_VT=y
	CONFIG_VT_CONSOLE=y
	CONFIG_MOUSE=y
	CONFIG_USB=y
	CONFIG_USB_DEBUG=y
	CONFIG_USB_DEVICEFS=y
	CONFIG_USB_OHCI_5xxx=y
	CONFIG_USB_OHCI_BIG_ENDIAN=y
	CONFIG_USB_OHCI=y
	CONFIG_USB_STORAGE=y
	CONFIG_USB_STORAGE_DEBUG=y
	CONFIG_USB_HID=y
	CONFIG_USB_HIDINPUT=y
	CONFIG_USB_HIDDEV=y

Can anyone point me in the right direction to get access to the USB
keyboard?  I'm using a serial system console and wish to keep it that way,
so the keyboard needs to be available an application input device.

Thanks,

Ed Jubenville
