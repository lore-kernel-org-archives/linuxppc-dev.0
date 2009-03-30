Return-Path: <vbendeb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.232])
	by ozlabs.org (Postfix) with ESMTP id 537B3DDE22
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 07:04:40 +1100 (EST)
MIME-Version: 1.0
Sender: vbendeb@gmail.com
Date: Mon, 30 Mar 2009 13:04:38 -0700
Message-ID: <f608b67d0903301304t58028e88t6ba6d4f9b030ef88@mail.gmail.com>
Subject: Setting eth interface oper state from user space
From: vb <vb@vsbe.com>
To: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm debugging a fairly awkward system, where the ehernet controller
and the phy device connected to the controller's mac are completely
independent. (this is in the 2.6.25 tree, btw).

The phy device interface is through SysFs attributes, there is no
interrupts, link state is polled by a user space thread.

When I try using this new ethernet interface, it's never in the
operational 'running' state, so it never gets used.

I see that many drivers use netif_carrier_on() to set oper state, but
this is invoked from the driver code in the kernel.

Is there a recommended way of controlling the interface operstate from
user space? Or maybe someone has a suggestion on how to do this in the
cleanest possible way?

As always, any hints/comments will be highly appreciated,
TIA,
Vadim
