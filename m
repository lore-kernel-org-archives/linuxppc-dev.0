Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 85790DDE1C
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 23:16:21 +1100 (EST)
Subject: time accounting problem (powerpc only?)
From: Johannes Berg <johannes@sipsolutions.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 23 Nov 2007 11:46:56 +0100
Message-Id: <1195814816.4149.94.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On my powerbook, with NO_HZ and HIGH_RES_TIMERS, I observed recently
that powernowd would not ever switch between CPU speeds.

Doing some scripting to read /proc/stat every half second and print the
differences, I get output like this on a mostly idle system:

# for reference:
# [user, nice, system, idle, iowait, irq, softirq, steal, guest]

[4, 0, 3, 46, 0, 264, 0, 0, 0]
[5, 0, 4, 41, 0, 266, 0, 0, 0]
[4, 0, 7, 37, 0, 299, 0, 0, 0]

Now starting an empty while (1) loop, I see:

[53, 0, 1, 0, 0, 243, 0, 0, 0]
[53, 0, 2, 0, 0, 224, 0, 0, 0]
[45, 0, 7, 0, 0, 249, 0, 0, 0]

As you can see, the "irq" time is very high so that "user" (mostly my
CPU burning program) only accounts for maybe 15%. This leads to
powernowd thinking that all is fine and no switching is required. Also,
the whole stuff leads to top(1) displaying about 80-90% "hi" (hard irq?
calculated as irq - softirq?) time.

Does anybody have an idea why the irq time is so high? And no, I don't
think it can actually be true, I'm seeing maybe 500 interrupts/second
(most due to USB).

johannes
