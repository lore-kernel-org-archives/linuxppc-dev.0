Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6C1222C0209
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 18:34:08 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 18 Jun 2013 04:34:04 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id D0D77C90041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 04:34:01 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5I8Y2Iu297876
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 04:34:02 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5I8Y2Ol018866
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 05:34:02 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 00/31] EEH Support for PowerNV platform
Date: Tue, 18 Jun 2013 16:33:24 +0800
Message-Id: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
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

v4 -> v5:
	* Add patch [10/31] to make EEH core running with single kthread.
	* Add patch [11/31] to trace the time stamp of last error in the last
	  hour for specific PE
	* Add patch [12/31] to purge duplicate EEH events
	* Add patch [14/31] for EEH core to handle special event, which doesn't
	  have binding PE
	* Add patch [22/31] to support I/O chip next_error() backend. Almost all
	  stuff from original pci_err.c moved to eeh-ioda.c. Appropriate cleanup
	  is applied as well.
	* Changed [27/31] to allow clearing specific OPAL notifier event in the
	  cache traced by variable "last_notified_mask"
	* Changed [29/31] to register OPAL event notifier on post-initilization
	  period.
v3 -> v4:
	* Rebase to 3.10.RC5 with originally first 2 patches from v3 applied and
	  won't resend the first 2 patches again.
	* Add 2 (first) patches to move the EEH core from pSeries platform to
	  arch/powerpc/kernel and applied necessary cleanup.
	* PowerNV platform layer initialize the delay for temporarily unavailable
	  PE state to 0 and set it to default value (1 second) if necessary.
	* Change variable names according to Ben's comments.
	* Account for the maximal allowed waiting time in eeh-powernv.c::powernv_eeh_wait_state()
	* Introduce eeh_serialize_lock/unlock so that pci-err.c can inject EEH
	  event with consistent PE state (isolated/dead state). In a result,
	  pci-err.c::pci_err_seq_sem has been removed completely.
	* Introduce PE state (EEH_PE_PHB_DEAD) and the logic to remove the corresponding
	  PCI domain upon detected dead IOC or PHB, instead of panicing the system.
	* Remove unnecessary contiguous check on one specific PHB in pci-err.c::pci_err_handler().
	* Refactor functions in pci-err.c for printing PHB diag-data. The diag-data header
	  (including version/ioType) have been parsed and call into appropriate function
	  for outputing the diag-data.
	* Changelog adjustment on "OPAL notifier" according to Ben's comments.
	* Split original opal_notifier_enable() to opal_notifier_enable/disable.
	* Allow multiple clients to listen same OPAL event change in OPAL notifier.
	* OPAL notifier is tracing the event change, instead of events.
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

arch/powerpc/include/asm/eeh.h                 |   28 +-
arch/powerpc/include/asm/eeh_event.h           |    2 +
arch/powerpc/include/asm/opal.h                |  140 +++-
arch/powerpc/kernel/Makefile                   |    4 +-
arch/powerpc/kernel/eeh.c                      | 1049 ++++++++++++++++++++++++
arch/powerpc/kernel/eeh_cache.c                |  319 +++++++
arch/powerpc/kernel/eeh_dev.c                  |  112 +++
arch/powerpc/kernel/eeh_driver.c               |  648 +++++++++++++++
arch/powerpc/kernel/eeh_event.c                |  181 ++++
arch/powerpc/kernel/eeh_pe.c                   |  702 ++++++++++++++++
arch/powerpc/kernel/eeh_sysfs.c                |   75 ++
arch/powerpc/kernel/pci_hotplug.c              |  111 +++
arch/powerpc/platforms/Kconfig                 |    5 +
arch/powerpc/platforms/powernv/Makefile        |    1 +
arch/powerpc/platforms/powernv/eeh-ioda.c      |  892 ++++++++++++++++++++
arch/powerpc/platforms/powernv/eeh-powernv.c   |  419 ++++++++++
arch/powerpc/platforms/powernv/opal-wrappers.S |    3 +
arch/powerpc/platforms/powernv/opal.c          |   87 ++-
arch/powerpc/platforms/powernv/pci-ioda.c      |   38 +-
arch/powerpc/platforms/powernv/pci-p5ioc2.c    |    6 +-
arch/powerpc/platforms/powernv/pci.c           |   43 +-
arch/powerpc/platforms/powernv/pci.h           |   28 +
arch/powerpc/platforms/powernv/setup.c         |    4 +
arch/powerpc/platforms/pseries/Kconfig         |    5 -
arch/powerpc/platforms/pseries/Makefile        |    4 +-
arch/powerpc/platforms/pseries/eeh.c           |  942 ---------------------
arch/powerpc/platforms/pseries/eeh_cache.c     |  319 -------
arch/powerpc/platforms/pseries/eeh_dev.c       |  112 ---
arch/powerpc/platforms/pseries/eeh_driver.c    |  552 -------------
arch/powerpc/platforms/pseries/eeh_event.c     |  142 ----
arch/powerpc/platforms/pseries/eeh_pe.c        |  653 ---------------
arch/powerpc/platforms/pseries/eeh_pseries.c   |    3 +-
arch/powerpc/platforms/pseries/eeh_sysfs.c     |   75 --
arch/powerpc/platforms/pseries/pci_dlpar.c     |   85 --
34 files changed, 4869 insertions(+), 2920 deletions(-)
create mode 100644 arch/powerpc/kernel/eeh.c
create mode 100644 arch/powerpc/kernel/eeh_cache.c
create mode 100644 arch/powerpc/kernel/eeh_dev.c
create mode 100644 arch/powerpc/kernel/eeh_driver.c
create mode 100644 arch/powerpc/kernel/eeh_event.c
create mode 100644 arch/powerpc/kernel/eeh_pe.c
create mode 100644 arch/powerpc/kernel/eeh_sysfs.c
create mode 100644 arch/powerpc/kernel/pci_hotplug.c
create mode 100644 arch/powerpc/platforms/powernv/eeh-ioda.c
create mode 100644 arch/powerpc/platforms/powernv/eeh-powernv.c
delete mode 100644 arch/powerpc/platforms/pseries/eeh.c
delete mode 100644 arch/powerpc/platforms/pseries/eeh_cache.c
delete mode 100644 arch/powerpc/platforms/pseries/eeh_dev.c
delete mode 100644 arch/powerpc/platforms/pseries/eeh_driver.c
delete mode 100644 arch/powerpc/platforms/pseries/eeh_event.c
delete mode 100644 arch/powerpc/platforms/pseries/eeh_pe.c
delete mode 100644 arch/powerpc/platforms/pseries/eeh_sysfs.c

Thanks,
Gavin
