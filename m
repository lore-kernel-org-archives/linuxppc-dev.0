Return-Path: <BillF@optiscan.com>
Received: from mail.optiscan.com (mail.optiscan.com [203.26.112.1])
	by ozlabs.org (Postfix) with ESMTP id BBAE7DDE28
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 May 2007 13:15:23 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: MPC8560 Gianfar driver hangs after soft reboot
Date: Fri, 25 May 2007 12:58:18 +1000
Message-ID: <34E73CC1202BF246B7DE3463BEBC068998EE82@postie.optiscan.com>
From: "Bill Farrow" <BillF@optiscan.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
The Gianfar driver is hanging during boot-up after a soft reboot.  It
works fine when the board is power cycled.

Any hints on where to look further on this issue?



Here are the details (cut and pasted from my colleague's email):

1. Load the kernel from the Flash and the rootfs from a NFS server.
2. Issue the "reboot" command.  This runs the Busybox reboot producing
the following output:

  The system is going down NOW!
  Sending SIGTERM to all processes
  Sending SIGKILL to all processes
  Requesting system reboot

3. After rebooting, the system starts up Linux and it hangs after:

  eth0: Gianfar Ethernet Controller Version 1.2, 00:40:42:01:00:00
  eth0: Running with NAPI enabled
  eth0: 256/256 RX/TX BD ring size


When stepped through, the kernel endlessly loops in the function:
  gfar_probe(struct platform_device *pdev)

  File: gianfar.c
  Line 233: while (!(gfar_read(&priv->regs->ievent) & (IEVENT_GRSC |
IEVENT_GTSC)))
		cpu_relax();

The soft reset procedure in the MPC8560RM.pdf was followed by separating
out the GTS and GRS completion polling with a delay between these.  The
kernel seems to get stuck at waiting for the GTS to complete.

Tried not doing this "Graceful" stop procedure by commenting out the
relevant driver code.  In this case the Kernel seems to continue on and
gets stuck at mounting the rootfs from NFS, indicating that the network
cannot be accessed.

Also tried soft rebooting without the network cable and the kernel boots
without hanging, but the network does not work when the re-connected.
The PHY seems to be working because when we plug the cable back in it
detects the link and writes this console message:

  [ 1557.465085] PHY: 0:01 - Link is Up - 100/Full

Note that there are two Ethernet controllers on the board (eth0 and
eth1).  Only eth1 is connected to the network.

Background info:
Kernel version 2.6.20.4 PPC
Uboot version 1.2.0
Busybox version 1.5.0
ELDK: 4.1
JTAG: BDI-2000
Board : Microsys PM856 - with MPC8560 processor.


Bill
--
Bill Farrow
Phone : +61 3 9538-3386 <http://www.optiscan.com>
