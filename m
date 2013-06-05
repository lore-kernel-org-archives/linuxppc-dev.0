Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 593902C0079
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 17:34:41 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 5 Jun 2013 01:34:37 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 4BE893E40039
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 01:34:16 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r557YSBN110780
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 01:34:28 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r557YWeB007332
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 01:34:33 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 00/27] EEH Support for PowerNV platform
Date: Wed,  5 Jun 2013 15:34:01 +0800
Message-Id: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Initially, the series of patches is built based on 3.10.RC1 and the patchset
doesn't intend to enable EEH functionality for PHB3 for now. Obviously, PHB3
EEH support on PowerNV platform is something to do in future.

The series of patches intends to support EEH for PowerNV platform. The EEH
core already supports multiple probe methods: device tree nodes and PCI
devices. For EEH on PowerNV, we're using PCI devices to do EEH probe, which
is different from the probe type used on pSeries platform. Another point I
should mention is that the overall EEH would be split up to 3 layers: EEH
core, platform layer and I/O chip layer. It would make the EEH on PowerNV
platform can achieve more flexibility and support more I/O chips in future.
Besides, the EEH event can be produced by detecting 0xFF's from reading
PCI config or I/O registers, or from interrupts dedicated for EEH error
reporting. So we have to handle the EEH error interrupts. On the other hand,
the EEH events will be processed by EEH core like pSeries platform does.

We will have exported debugfs entries ("/sys/kernel/debug/powerpc/PCIxxxx/err_injct"),
which allows you to control the 0xD10 register in order to force errors like
frozen PE and fenced PHB for testing purpose. The following example is usualy
what I'm using to control that register. The patchset has been verified on
Firebird-L machine where I have 2 Emulex ethernet card on PHB#0. I keep pinging
to one of the ethernet cards (eth0) from external and then use following commands
to produce frozen PE or fenced PHB errors. Eventually, the errors can be recovered
and the ethernet card is reachable after temporary connection lost.

Trigger frozen PE:

	echo 0x0000000002000000 > /sys/kernel/debug/powerpc/PCI0000/err_injct
	sleep 1
	echo 0x0 > /sys/kernel/debug/powerpc/PCI0000/err_injct

Trigger fenced PHB:

	echo 0x8000000000000000 > /sys/kernel/debug/powerpc/PCI0000/err_injct

Change log
==========

v2 -> v3:
	* Rebase to 3.10.RC4
	* Replace eeh_pci_dev_traverse() with pci_walk_bus()
	* Changlog adjustment to make that more clear
	* To call msleep() if possible after opal_pci_poll()
	* Make sure we have OPALv3
	* OPAL notifier so that we can register callback for the monitored events.
	  The OPAL notifier is disabled while restarting or powering off the system.
	* Make the debugfs entries something like (PCIxxxx/err_injct)
	* Split the patch so that can be backported to stable kernel
	* Allow to detect fenced PHB proactively (without interrupt)
	* Start to use opal_pci_get_phb_diag_data2()
	* Stack dump upon fenced PHB
v1 -> v2:
	* Rebase to 3.10.RC3
	* Don't fetch PE state for the case of fenced PHB. It usually takes long
	  time and possiblly incurs softlock warning. It requires the corresponding
	  changes for the underly firmware
	* Add debugfs entries so that we can inject errors like frozen PE and
	  fenced PHB for testing purpose

---

arch/powerpc/include/asm/eeh.h                 |   26 +-
arch/powerpc/include/asm/eeh_event.h           |    6 +-
arch/powerpc/include/asm/opal.h                |  138 +++++-
arch/powerpc/kernel/rtas_pci.c                 |    3 +-
arch/powerpc/platforms/powernv/Makefile        |    1 +
arch/powerpc/platforms/powernv/eeh-ioda.c      |  550 ++++++++++++++++++++++++
arch/powerpc/platforms/powernv/eeh-powernv.c   |  387 +++++++++++++++++
arch/powerpc/platforms/powernv/opal-wrappers.S |    3 +
arch/powerpc/platforms/powernv/opal.c          |   79 ++++-
arch/powerpc/platforms/powernv/pci-err.c       |  481 +++++++++++++++++++++
arch/powerpc/platforms/powernv/pci-ioda.c      |   38 ++-
arch/powerpc/platforms/powernv/pci-p5ioc2.c    |    6 +-
arch/powerpc/platforms/powernv/pci.c           |   44 ++-
arch/powerpc/platforms/powernv/pci.h           |   26 ++
arch/powerpc/platforms/powernv/setup.c         |    4 +
arch/powerpc/platforms/pseries/eeh.c           |  120 +++++-
arch/powerpc/platforms/pseries/eeh_event.c     |   12 +-
arch/powerpc/platforms/pseries/eeh_pe.c        |   31 ++-
18 files changed, 1907 insertions(+), 48 deletions(-)
create mode 100644 arch/powerpc/platforms/powernv/eeh-ioda.c
create mode 100644 arch/powerpc/platforms/powernv/eeh-powernv.c
create mode 100644 arch/powerpc/platforms/powernv/pci-err.c

Thanks,
Gavin
