Return-Path: <tothphu@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) by ozlabs.org (Postfix) with ESMTP id A39F4B70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Oct 2010 01:24:38 +1100 (EST)
Received: by gxk21 with SMTP id 21so62193gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Oct 2010 07:24:36 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 21 Oct 2010 16:24:35 +0200
Message-ID: <AANLkTi=ZWqEGcdUWARdA7vAaQq1zx66TnyLvygjNY8Eb@mail.gmail.com>
Subject: USB bring-up with MPC8313
From: =?UTF-8?B?UMOpdGVy?= <tothphu@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

We are trying to bring-up USB support on a custom HW using MPC8313
(version 2 hw). Our Linux kernel version is a standard 2.6.23. We are
trying to use the ULPI interface of 8313, which is connected to an
USB3300 chip.
The relevant part of the device tree is the following:
 /* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
usb@23000 {
device_type = "usb";
compatible = "fsl-usb2-dr";
reg = <23000 1000>;
#address-cells = <1>;
#size-cells = <0>;
interrupt-parent = < &ipic >;
interrupts = <26 8>;
phy_type = "ulpi"; };

In the first run we are trying to run it in host mode. Although in the
future we might use OTG. If nothing is set up we can measure 1.4 volts
on the usb power pins. While in one occasion we have managed to reach
5 volts. In both cases the usb drivers are built-in the kernel and
booted up correctly.

Do you know if our linux kernel version supports ulpi correctly? If
yes how can we verify the functionality? Even when we have 5 volts, we
were unable to see any extra devices in /proc/bus/usb/devices.

Where shall we see that any usb device has been connected? (/sys, /proc ???)

If you need any more description of the problem I can give you that.

Thanks for the help,
Peter
