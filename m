Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F393367C6F
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Nov 2006 21:54:50 +1100 (EST)
Subject: Re: [Fwd: [Bug 7431] New: ohci1394 Oops after a rmmod/modprobe cycle]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <454DBFE7.3090800@s5r6.in-berlin.de>
References: <454DBFE7.3090800@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 21:54:43 +1100
Message-Id: <1162724083.28571.235.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Gioele Barabucci <dev@gioelebarabucci.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-11-05 at 11:41 +0100, Stefan Richter wrote:
> Hi list,
> there was a bug report on ohci1394 which seems to be related to the
> platform-specific code in the driver. Additional details were posted on
> linux1394-user:
> http://thread.gmane.org/gmane.linux.kernel.firewire.user/focus=2120
> Subject: "strange interaction: ohci1394 and backlight on iBook"
> Any ideas? Thanks,

The machine check means basically that the chip didn't respond on the
PCI bus. The most probable cause is that something is wrong with the
platform code that switches the chip clock on/off or with the PCI D
state change.

One thing you can check is wether that's always called properly,
especially when starting the chip. Another possibly might be that the
chip needs some time after the clocks are restored to be back online,
thus you might need a delay after the platform code and/or the PCI D
state change before you start poking at registers.

A couple of thing to make sure of:

 - On init, call platform code first to bring clocks back up, then only
do the PCI D state transition to D0 (maybe with a delay)

 - On rmmod or suspend, call the platform code last, after the D3 state
transition (if any), and make sure the chip's been properly stopped
first.

It might also be useful if there isn't some sort of bad interaction with
sungem which on the same PCI bus and has similar clock control as I've
heard about possible issues on some older chips. Thus, the user could
verify that sungem is allways up and running (link on) during the test
and check if that makes any difference.

Cheers,
Ben.
