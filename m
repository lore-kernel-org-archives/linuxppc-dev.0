Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 125522BDF2
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Dec 2004 16:05:55 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	gentoo-ppc-user@gentoo.org, fedora-ppc@lists.infradead.org
Content-Type: text/plain
Date: Wed, 01 Dec 2004 16:03:28 +1100
Message-Id: <1101877409.5672.2.camel@gaston>
Mime-Version: 1.0
Subject: TEST: Sleep patch #6
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(As usual, I'm cross posting several lists, please don't reply to all of them,
and CC me as I'm not subscribed to all of them neither)

Ok, here's the 6th version of the sleep patch for ATI based albooks &
iBook G4. Other machine users, please test too as it may cause
regressions (or improvements) as well.

This one fixes finally the cache flush problem that made cpufreq (on machines
using the PMU for the switch) and sleep/wake unreliable occasionally (memory
corruption would occur on some CPUs at least). It improves bits here or there
too, and adds the sungem wake-on-lan feature. 

There are still pending issues, like cpufreq on some machines will
"think" it's running at full speed on wakeup while it's in fact running
at slow speed (thankfully not the opposite). I don't think I'll fix this one
in 2.6.9, but rather in 2.6.10.

http://gate.crashing.org/~benh/albook-ibookg4-sleep-6.diff

I'll post a 2.6.10-rc2-bk* based version of the patch soon.

Ben.
