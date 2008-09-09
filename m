Return-Path: <jbrower@signalogic.com>
Received: from nuntius.signalogic.com
	(adsl-64-219-188-225.dsl.rcsntx.swbell.net [64.219.188.225])
	by ozlabs.org (Postfix) with ESMTP id 0AA82DDF95
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Sep 2008 08:19:49 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by nuntius.signalogic.com (Postfix) with ESMTP id 6C6FB12880F9
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Sep 2008 17:06:58 -0500 (CDT)
Received: from nuntius.signalogic.com ([127.0.0.1])
	by localhost (/bin/uname -n [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP
	id 21382-08 for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Sep 2008 17:06:48 -0500 (CDT)
Received: from signalogic.com (unknown [10.0.0.83])
	by nuntius.signalogic.com (Postfix) with ESMTP id 13BD112880F1
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Sep 2008 17:06:47 -0500 (CDT)
Message-ID: <48C6F217.406CFDC0@signalogic.com>
Date: Tue, 09 Sep 2008 17:00:56 -0500
From: Jeff Brower <jbrower@signalogic.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: driver replacements for kmalloc and __pa()
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

We have inherited an older driver that uses kmalloc() and vtophys (which resolves to
the __pa() macro) to create memory accessible by an external PCI device doing bus
master read/writes.  The driver works Ok on several x86 machines, but is failing on a
PPC board (MPC7447/8) running Gentoo Linux 2.6.9.  After looking at PCI bus analyzer
captures, it seems the physical address the driver is giving to the PCI device is
invalid, so the device ends up reading/writing incorrect memory areas.

What are the up-to-date APIs we should be using for DMA memory allocation and
virtual-to-physical address translation?  We have another driver for another device
that's working fine on this board and it uses pci_alloc_consistent().  What about
bus_space_vaddr()?  I'm hoping to get a recommendation for what's currently
appropriate and most future-proof for drivers that depend on external PCI DMA.

Any suggestions welcome.  Thanks.

-Jeff
