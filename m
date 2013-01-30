Return-Path: <guy.yribarren@actis-computer.com>
Received: from smtp1.infomaniak.ch (smtp1.infomaniak.ch
 [IPv6:2001:1600:2:5:21d:9ff:fe65:d5cd])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 486AC2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 01:38:24 +1100 (EST)
Received: from guydesktop (136-199.5-85.cust.bluewin.ch [85.5.199.136])
 (authenticated bits=0)
 by smtp1.infomaniak.ch (8.14.2/8.14.2) with ESMTP id r0UERRZx019273
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2013 15:27:27 +0100
Message-Id: <201301301427.r0UERRZx019273@smtp1.infomaniak.ch>
From: "Guy Yribarren" <guy.yribarren@actis-computer.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: powerpc/usb: machine check when writing to portsc in ehci-fsl
Date: Wed, 30 Jan 2013 15:27:42 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently using kernel 3.7.1 with mpc8315e, I am observing instability
during the usb initialisation. The usb controller is set as a host
controller with internal PHY defined in UTMI mode. This issue appears
sometimes after a warm reset. The kernel hangs and the log buffer =
contents
shows that a machine check exception is detected when execution is =
located
into ehci_fsl_setup_phy function.=20
=20
The latest messages available from the console are:
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
uhci_hcd: USB Universal Host Controller Interface driver
/immr@e0000000/usb@23000: Invalid 'dr_mode' property, fallback to host =
mode
fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1

By adding multiple printk into the ehci-fsl, I found that the issue =
happens
when executing the write to the portsc register nearly at the end of the
function (ehci_writel(ehci, portsc, =
&ehci->regs->port_status[port_offset]);)

This issue appears either with or without external usb devices =
connected.

I didn't find any restrictions to access this register and/or =
explanation
from freescale doc and usb2 & ehci specification.

This issue has been also seen with older kernel release like 2.6.39.=20

Applying a warn reset, then the processor boot correctly and the usb
interface is now fully functional and really stable with intensive
activities.

The processor is based on the latest 1.2 mask revision.=20

Hope that someone has some suggestions about this strange behaviour.=20

Thanks for your help,
Regards

Guy Yribarren
=20
ACTIS Computer - 42 Route de Satigny - CH-1217 Meyrin - Switzerland
Tel +41 (22) 706 1830 - Fax +41 (22) 794 4391
guy.yribarren <at> actis-computer.com

=A0=A0=A0
