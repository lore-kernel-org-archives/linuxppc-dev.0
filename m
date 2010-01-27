Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 1DB5BB7CF6
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 07:26:23 +1100 (EST)
Message-ID: <4B60A014.50304@mlbassoc.com>
Date: Wed, 27 Jan 2010 13:20:36 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: USB host on 83xx
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have two nearly identical boards, with very different behavior.

Older 8347 (PVR: 0x80830011)
New   8347 (PVR: 0x80830031)

I've tried a number of kernels (vintages) on both with wild results.

2.6.20   - Same kernel works on both(*)
2.6.28   - Kernel runs great on OLD, machine check on NEW
2.6.32.6 - Ditto

The problem occurs (only on the new silicon) during the USB host
initialization.  The root hub is found and initialized, then the
EHCI subsystem is reset (to force it to find siblings on the bus).
This results in a machine check at the point where the PHY is
being reinitialized.

I've peppered the driver with messages - here's what I see:

     ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
     fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
     fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
     ********** ehci_fsl_setup.272
     ********** ehci_fsl_setup.296
     ********** ehci_fsl_setup.299
     ********** ehci_fsl_reinit.257
     ********** mpc83xx_usb_setup.192
     ********** mpc83xx_usb_setup.207
     ********** mpc83xx_usb_setup.215
     ********** mpc83xx_usb_setup.220
     ********** mpc83xx_setup_phy.163
     ********** mpc83xx_setup_phy.180
     ********** mpc83xx_setup_phy.182
     ********** mpc83xx_usb_setup.238
     ********** mpc83xx_usb_setup.245
     ********** mpc83xx_usb_setup.249
     ********** mpc83xx_usb_setup.251
     ********** ehci_fsl_reinit.259
     ********** ehci_hub_control.559 - req: 8961
     ********** ehci_hub_control.574
     ********** ehci_hub_control.559 - req: 8961
     ********** ehci_hub_control.574
     ********** ehci_fsl_reinit.261
     ********** ehci_fsl_setup.301
     fsl-ehci fsl-ehci.0: irq 39, io base 0xff022000
     fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00
     usb usb1: configuration #1 chosen from 1 choice
     hub 1-0:1.0: USB hub found
     ********** ehci_hub_control.559 - req: 40966
     ********** ehci_hub_control.637
     hub 1-0:1.0: 2 ports detected
     ********** ehci_hub_control.559 - req: 40960
     ********** ehci_hub_control.642
     ********** ehci_hub_control.559 - req: 8963
     ********** ehci_hub_control.805
     ********** ehci_hub_control.559 - req: 8963
     ********** ehci_hub_control.805
     usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
     usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
     usb usb1: Product: Freescale On-Chip EHCI Host Controller
     usb usb1: Manufacturer: Linux 2.6.28 ehci_hcd
     usb usb1: SerialNumber: fsl-ehci.0
     fsl-ehci fsl-ehci.1: Freescale On-Chip EHCI Host Controller
     fsl-ehci fsl-ehci.1: new USB bus registered, assigned bus number 2
     ********** ehci_fsl_setup.272
     ********** ehci_fsl_setup.296
     ********** ehci_fsl_setup.299
     ********** ehci_fsl_reinit.257
     ********** mpc83xx_usb_setup.192
     ********** mpc83xx_usb_setup.207
     ********** mpc83xx_usb_setup.215
     ********** mpc83xx_setup_phy.163
     ********** mpc83xx_setup_phy.180
       MACHINE CHECK - so dead it can't even print the message!

At this point, it should carry on like this:

     ********** ehci_hub_control.559 - req: 8963
     ********** ehci_hub_control.805
     ********** ehci_hub_control.559 - req: 41728
     ********** ehci_hub_control.648
     ********** ehci_hub_control.559 - req: 8961
     ********** ehci_hub_control.574
     usb 1-1: configuration #1 chosen from 1 choice
     hub 1-1:1.0: USB hub found
     hub 1-1:1.0: 4 ports detected
     usb 1-1: New USB device found, idVendor=05e3, idProduct=0608
     usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
     usb 1-1: Product: USB2.0 Hub
     ********** ehci_hub_control.559 - req: 41728
     ********** ehci_hub_control.648

You can see that it successfully found the connected external HUB.

Any ideas why this happens?  This [basic] code used to work (2.6.20)
on both platforms.  I know that's a long time ago, but MACHINE CHECK??

(*) To get this platform to run 2.6.20, I had to patch the CPU tables
to recognize it as 8347 (kernels of that vintage relied on the SVR to
make choices, not PVR)

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
