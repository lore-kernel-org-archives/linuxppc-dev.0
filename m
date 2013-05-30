Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3D65E2C008C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 18:24:16 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 30 May 2013 02:24:13 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2F45C19D8041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 02:24:03 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4U8OA06390594
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 02:24:10 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4U8OAqT005242
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 02:24:10 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 00/23] powerpc/eeh: Enhance converting EEH dev
Date: Thu, 30 May 2013 16:23:42 +0800
Message-Id: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
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

We will have exported debugfs entries ("/sys/kernel/debug/powerpc/EEH/PHBx"),
which allows you to control the 0xD10 register in order to force errors like
frozen PE and fenced PHB for testing purpose. The following example is usualy
what I'm using to control that register. The patchset has been verified on
Firebird-L machine where I have 2 Emulex ethernet card on PHB#0. I keep pinging
to one of the ethernet cards (eth0) from external and then use following commands
to produce frozen PE or fenced PHB errors. Eventually, the errors can be recovered
and the ethernet card is reachable after temporary connection lost.

Trigger frozen PE:

	echo 0x0000000002000000 > /sys/kernel/debug/powerpc/EEH/PHB0
	sleep 1
	echo 0x0 > /sys/kernel/debug/powerpc/EEH/PHB0

Trigger fenced PHB:

	echo 0x8000000000000000 > /sys/kernel/debug/powerpc/EEH/PHB0

Change log
==========

v1 -> v2:
	* Rebase to 3.10.RC3
	* Don't fetch PE state for the case of fenced PHB. It usually takes long
	  time and possiblly incurs softlock warning. It requires the corresponding
	  changes for the underly firmware
	* Add debugfs entries so that we can inject errors like frozen PE and
	  fenced PHB for testing purpose

---

arch/powerpc/include/asm/eeh.h                 |   29 +-
arch/powerpc/include/asm/eeh_event.h           |    6 +-
arch/powerpc/include/asm/opal.h                |  116 ++++-
arch/powerpc/kernel/rtas_pci.c                 |    3 +-
arch/powerpc/platforms/powernv/Makefile        |    1 +
arch/powerpc/platforms/powernv/eeh-ioda.c      |  555 ++++++++++++++++++++++++
arch/powerpc/platforms/powernv/eeh-powernv.c   |  380 ++++++++++++++++
arch/powerpc/platforms/powernv/opal-wrappers.S |    2 +
arch/powerpc/platforms/powernv/opal.c          |    6 +
arch/powerpc/platforms/powernv/pci-err.c       |  475 ++++++++++++++++++++
arch/powerpc/platforms/powernv/pci-ioda.c      |   16 +-
arch/powerpc/platforms/powernv/pci-p5ioc2.c    |    6 +-
arch/powerpc/platforms/powernv/pci.c           |   44 ++-
arch/powerpc/platforms/powernv/pci.h           |   22 +
arch/powerpc/platforms/pseries/eeh.c           |   61 +++-
arch/powerpc/platforms/pseries/eeh_dev.c       |   35 ++
arch/powerpc/platforms/pseries/eeh_event.c     |   12 +-
arch/powerpc/platforms/pseries/eeh_pe.c        |   31 ++-
18 files changed, 1753 insertions(+), 47 deletions(-)
create mode 100644 arch/powerpc/platforms/powernv/eeh-ioda.c
create mode 100644 arch/powerpc/platforms/powernv/eeh-powernv.c
create mode 100644 arch/powerpc/platforms/powernv/pci-err.c

Thanks,
Gavin
