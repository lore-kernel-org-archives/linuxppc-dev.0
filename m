Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7CE582C02EF
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2013 01:17:42 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 1 Mar 2013 07:17:40 -0700
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 90B83C9001A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2013 09:17:36 -0500 (EST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r21EHTX7087844
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 09:17:32 -0500
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r21EHQ0G007760
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 07:17:28 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 0/22] EEH support for PowerNV platform
Date: Fri,  1 Mar 2013 22:16:58 +0800
Message-Id: <1362147440-14096-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Initially, the series of patches is built based on 3.8+

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

We don't have existing utility (e.g. errinjct) to test the patchset. In order
to conduct the test, you need copy over the eeh-debug.c to PowerNV platform
directory and change the makefile accordingly. Please contact me to get the
eeh-debug.c if you want run the test case. After that, you need write P7IOC
registers explicitly to trigger frozen PE or fenced PHB explicitly as the
following example shows. The patchset has been verified on Firebird-L machine
where I have 2 Emulex ethernet card on PHB#6. I keep pinging to one of the
ethernet cards from external and then use following commands to produce frozen
PE or fenced PHB errors. Eventually, the errors can be recovered and the ethernet
card is reachable after temporary connection lost.

Trigger frozen PE:

	echo "0xD10 0x0000000002000000" > /proc/IODA/PHB6/REG
	sleep 1
	echo "0xD10 0x0000000000000000" > /proc/IODA/PHB6/REG

Trigger fenced PHB:

	echo "0xD10 0x8000000000000000" > /proc/IODA/PHB6/REG

---

arch/powerpc/include/asm/eeh.h                 |   29 ++-
arch/powerpc/include/asm/eeh_event.h           |    6 +-
arch/powerpc/include/asm/opal.h                |  110 +++++-
arch/powerpc/kernel/rtas_pci.c                 |    3 +-
arch/powerpc/platforms/powernv/Makefile        |    1 +
arch/powerpc/platforms/powernv/eeh-ioda.c      |  516 ++++++++++++++++++++++++
arch/powerpc/platforms/powernv/eeh-powernv.c   |  373 +++++++++++++++++
arch/powerpc/platforms/powernv/opal-wrappers.S |    2 +
arch/powerpc/platforms/powernv/opal.c          |    6 +
arch/powerpc/platforms/powernv/pci-err.c       |  474 ++++++++++++++++++++++
arch/powerpc/platforms/powernv/pci-ioda.c      |   13 +-
arch/powerpc/platforms/powernv/pci-p5ioc2.c    |    6 +-
arch/powerpc/platforms/powernv/pci.c           |   42 ++-
arch/powerpc/platforms/powernv/pci.h           |   22 +-
arch/powerpc/platforms/pseries/eeh.c           |   61 +++-
arch/powerpc/platforms/pseries/eeh_dev.c       |   35 ++
arch/powerpc/platforms/pseries/eeh_event.c     |   12 +-
arch/powerpc/platforms/pseries/eeh_pe.c        |   31 ++-
18 files changed, 1697 insertions(+), 45 deletions(-)
create mode 100644 arch/powerpc/platforms/powernv/eeh-ioda.c
create mode 100644 arch/powerpc/platforms/powernv/eeh-powernv.c
create mode 100644 arch/powerpc/platforms/powernv/pci-err.c

Thanks,
Gavin
