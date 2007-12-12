Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A7DAFDDEE0
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 13:45:50 +1100 (EST)
Subject: apm_emulation regression
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain
Date: Wed, 12 Dec 2007 13:45:30 +1100
Message-Id: <1197427530.8385.59.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, ralf <ralf@linux-mips.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I only just noticed a huge regression that was introduced when we moved
PowerPC to the generic APM emulation code instead of our own. I'm in
large part to blame since I acked the patch...

Basically, what we lost is the mechanism for notifying user applications
and waiting for their ACK before proceeding to system suspend. The new
generic code will still do that ... only when the actual suspend request
initiates from an APM suspend ioctl.

For any other suspend (via our private PMU ioctl or via the sysfs
interface), userspace will -not- be notified.

That basically means X will break. That's why X broke on the latest
ubuntu until I whacked some new scripts in them to force console
switching, among other things. Possibly other apps that relied
on /dev/apm_bios to be notified of system suspend/resume broke as well.

Now the question is that is it still work trying to fix it ? That would
probably require APM emulation hooking at a fairly high level into the
generic PM code to trigger the signaling & waiting of processes before
freeze & device suspend among others...

Cheers,
Ben.
