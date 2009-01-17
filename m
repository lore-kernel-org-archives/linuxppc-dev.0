Return-Path: <mikpe@user.it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9F7EDDF22
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Jan 2009 10:02:58 +1100 (EST)
Date: Sat, 17 Jan 2009 23:46:57 +0100 (MET)
Message-Id: <200901172246.n0HMkvrv004832@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: benh@kernel.crashing.org
Subject: [BUG] 2.6.28-git12: "powerpc/pci: Reserve legacy regions on PCI"
	broke my G3
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 2.6.29-rc kernels hang during boot on my PowerMac G3 (Beige).
The last messages I see on the console are

Kernel command line: ramdisk_size=8192
irq: Found primary Apple PIC /pci/mac-io for 64 irqs
irq: System has 64 possible interrupts

and then it hangs until I reboot it. Unfortunately I don't have a serial cable
compatible with the G3's serial port so I can't set up a serial console.

Eventually I narrowed the cause down to "powerpc/pci: Reserve legacy regions on PCI"
(commit c1f343028d35ba4e88cd4a3c44e0d8b8a84264ee) in 2.6.28-git12. Reverting that
from 2.6.29-rc2 results in a kernel that boots ok and works reliably.

The problem seems system specific as both my G5 and my G4 had no problems at all
with 2.6.29-rc1.

/Mikael
