Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 6BAE2DDE03
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 07:26:12 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so358935anc
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 12:26:11 -0800 (PST)
Message-ID: <fa686aa40711201226o74b526fchebb547a8d08886fa@mail.gmail.com>
Date: Tue, 20 Nov 2007 13:26:11 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	"Kim Phillips" <kim.phillips@freescale.com>
Subject: USB failure on mpc8347 based board
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm seeing the following error on an MPC8347 based board.  The
physical board is wired up with the fsl-usb2-dr controller setup as a
USB device using port0 and fsl-usb2-mph as a USB host using port1.
The EHCI driver fails with the following error when initializing the
fsl-usb2-mph controller:

In particular I'm wondering if anyone knows the cause of "HC died; cleaning up".

The board has a hard wired USB hub connected to port1, and the host
controller seems to be dying while probing that device.

Cheers,
g.

[    0.754259] usbmon: debugfs is not available
[    0.758862] fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
[    0.765948] fsl-ehci fsl-ehci.0: new USB bus registered, assigned
bus number 1
[    0.795863] fsl-ehci fsl-ehci.0: irq 39, io base 0xe0022000
[    0.801475] fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00, driver
10 Dec 2004
[    0.809948] usb usb1: configuration #1 chosen from 1 choice
[    0.815971] hub 1-0:1.0: USB hub found
[    0.819778] hub 1-0:1.0: 2 ports detected
[    0.928972] USB Universal Host Controller Interface driver v3.0
[    0.935257] Initializing USB Mass Storage driver...
[    1.167836] usb 1-1: new high speed USB device using fsl-ehci and address 2
[    1.175150] fsl-ehci fsl-ehci.0: fatal error
[    1.179467] fsl-ehci fsl-ehci.0: HC died; cleaning up
[    1.184585] hub 1-0:1.0: cannot reset port 1 (err = -19)
[    1.189934] hub 1-0:1.0: cannot disable port 1 (err = -19)
[    1.195465] hub 1-0:1.0: cannot reset port 1 (err = -19)
[    1.200809] hub 1-0:1.0: cannot disable port 1 (err = -19)
[    1.206327] hub 1-0:1.0: cannot reset port 1 (err = -19)
[    1.211666] hub 1-0:1.0: cannot disable port 1 (err = -19)
[    1.217189] hub 1-0:1.0: cannot reset port 1 (err = -19)
[    1.222527] hub 1-0:1.0: cannot disable port 1 (err = -19)
[    1.228044] hub 1-0:1.0: cannot disable port 1 (err = -19)
[    1.233558] hub 1-0:1.0: hub_port_status failed (err = -19)
[    1.239246] usbcore: registered new interface driver usb-storage


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
