Return-Path: <linux@dominikbrodowski.net>
Received: from linta.de (isilmar.linta.de [213.133.102.198])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9F2DDE2A4
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 19:14:52 +1000 (EST)
Date: Thu, 17 Jul 2008 11:14:44 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linuxppc-dev@ozlabs.org
Subject: [bugme-daemon@bugzilla.kernel.org: [Bug 7306] Yenta-socket causes
	oops on insertion of any PCMCIA card]
Message-ID: <20080717091444.GA22596@isilmar.linta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

on an Apple Powerbook G3 (Lombard) with a PPC 740 running at 333 MHz, the
PCI host bridge is condigured to allow "downstream" devices to use iomem

0xfd000000 - 0xfdffffff

However, when using it for PCMCIA purposes, there's a machine check. Any
ideas on why this PCI host bridge is mis-configured, and how to resolve this
issue (besides adding reserved=0xfd000000,0xffffff as kernel boot option)?

Best,
	Dominik


----- Forwarded message from bugme-daemon@bugzilla.kernel.org -----

Subject: [Bug 7306] Yenta-socket causes oops on insertion of any PCMCIA card
To: linux-pcmcia@lists.infradead.org
From: bugme-daemon@bugzilla.kernel.org
Date: Thu, 17 Jul 2008 01:45:44 -0700 (PDT)

http://bugzilla.kernel.org/show_bug.cgi?id=7306





------- Comment #17 from linux@brodo.de  2008-07-17 01:45 -------
Now this contains interesting information:

pcmcia: parent PCI bridge Memory window: 

means the PCI host bridge is configured to allow "downstream" devices to use
this memory area. However, when the PCMCIA socket tries to do so, you get the
machine check. So my question would be to the powerpc folks: why is the PCI
host bridge configured this way, even if this memory area is not usable?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.

_______________________________________________
Linux PCMCIA reimplementation list
http://lists.infradead.org/mailman/listinfo/linux-pcmcia

----- End forwarded message -----
