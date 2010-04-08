Return-Path: <elison.niven@matrixcomsec.com>
Received: from mail.urlwebserver.com (unknown [74.86.58.248])
	by ozlabs.org (Postfix) with ESMTP id 5F5ECB7D1B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Apr 2010 17:09:39 +1000 (EST)
Received: from Internet10 [192.168.50.52] by Proxy+ with ESMTP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Apr 2010 12:25:24 +0530
From: "Elison Niven" <elison.niven@matrixcomsec.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: No userspace processes scheduled for execution when ethernet link
	state changes
Date: Thu, 8 Apr 2010 12:25:24 +0530
Message-Id: <20100408122524@dummy.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi List,

I am using linux 2.6.22 on a MPC8358E custom board.

I use a simple userspace process that periodically (100 ms) calls an ioctl
to a watchdog driver to toggle its pin state.

The problem is that when I insert or remove the Ethernet cable, this process
is not scheduled for execution. The watchdog IC resets the board if a pulse
is not received in 1.2 seconds.

I am clueless as to where to look in - the vitesse (PHY) driver or the
ucc_geth driver or the kernel scheduler.

I have tried modifying the priority of the process but there are no changes
to this behavior.

Then I wrote another driver that uses a kernel timer, that periodically (100
ms) toggles the pin state. In this case, I have observed on an oscilloscope
that the pulses are regular even when the Ethernet cable is inserted or
removed.

It means that the kernel itself is not in a waiting state when the cable is
inserted or removed but *however* (as per my observations) it does not
schedule all userspace processes for the next 1 - 2 seconds.

Well, ofcourse an alternate solution to implementing the watchdog on my
board would be to toggle the watchdog pin using a kernel timer.

But, Why the userspace process is not getting its time share to execute?
Please throw some light as to where to look? Is this issue known or could it
be my board-specific?

Thanks,
Elison
