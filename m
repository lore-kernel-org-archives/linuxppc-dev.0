Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B04A2BF07
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Nov 2004 18:00:45 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev@ozlabs.org, gentoo-ppc-user@gentoo.org
Content-Type: text/plain
Date: Fri, 19 Nov 2004 17:56:50 +1100
Message-Id: <1100847411.25521.42.camel@gaston>
Mime-Version: 1.0
Subject: TEST: Sleep suppport for iBook G4 & Aluminium PowerBooks (ATI based)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(Message cross-posted to several lists, please do _NOT_ reply to all of
them).

NOTE: Owners of _OTHER_ Apple laptops that could already sleep, like
earlier iBooks, or Titanium PowerBooks, please test this patch as well
for regression. More specifically, test if sleep still works, X/DRI, and
backlight control as I have made significant changes to radeonfb in ways
that could affect those areas.

NOTE2: This is still quite experimental, be careful if something goes
wrong (like lots of oopses or crashes on wakeup), you'd rather
hard-restart the machine right away than let corrupted memory buffers be
written back to your disk ;)
 
First, let's give credit where it's due, as a lot of the work on the
original Aluminium PowerBook sleep code was done by Paul Mackerras,
happy owner of one of these beasts, and thanks to Rob Weir too who gave
me his iBook G4 for a few days, just long enough to get the stuff
working...

So here's the new patch, it replaces the previous one for Aluminium
PowerBooks, and is still against 2.6.9. I'll do something against 2.6.10
when that one is out (it's a bit late to get that merged with Linus,
2.6.10 is in freeze mode now) and I hope to get all of that in 2.6.11.

The support for sleep on desktop G4s & dual CPU machines, including
support for "hotplug CPU" (allowing to put a CPU to sleep dynamically)
for dual machines isn't in this patch neither, it will be coming
spearately. It will only support one desktop video card at first anyway,
though it will be possible to extend that over time.

Get it at:

http://gate.crashing.org/~benh/albook-ibookg4-sleep.diff

Enjoy !

Ben.
