Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A11AC2BDEB
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Nov 2004 18:09:31 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 24 Nov 2004 18:09:05 +1100
Message-Id: <1101280145.4511.4.camel@gaston>
Mime-Version: 1.0
Cc: gentoo-ppc-user@gentoo.org
Subject: TEST: Sleep patch #5
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, here's the 5th version of the sleep patch for ATI based albooks &
iBook G4. Other machine users, please test too as it may cause
regressions (or improvements) as well.

Not many changes since last version, I don't know why sometimes, the
panel doesn't come back properly (though a new sleep cycle tends to fix
it) and I have no fix for the USB issues. However, I added some hacks to
the cache flush code based on what Apple does in Darwin that may help
make the thing more robust, and I added a hook mecanism that allow the
video to be restored _very_ early on wakeup, pretty much before
everything else, thus making it easier to spot & debug crashes on
wakeup.

There are still pending issues, like cpufreq on some machines will
"think" it's running at full speed on wakeup while it's in fact running
at slow speed (thankfully not the opposite), I will try to fix those in
the next iteration.

http://gate.crashing.org/~benh/albook-ibookg4-sleep-5.diff

Ben.
