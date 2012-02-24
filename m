Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AA73AB6FCB
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:38:29 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 24 Feb 2012 15:08:26 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1O9cLOI2564108
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 15:08:22 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1O9cLtV005614
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:38:21 +1100
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v4 00/21] EEH reorganization
Date: Fri, 24 Feb 2012 17:37:57 +0800
Message-Id: <1330076298-7006-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: kernel.crashing.org@shangw, shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches is going to reorganize EEH so that it could support
multiple platforms in future. The requirements were raised from the aspects.

	* The original EEH implementation only support pSeries platform, which
	  would be regarded as guest system. Platform powernv is coming and EEH
	  needs to be supported on powernv as well.
	* Different platforms might be running based on variable firmware.Further
	  more, the firmware would supply different EEH interfaces to kernel.
	  Therefore, we have to do necessary abstraction on current EEH implementation.

In order to accomodate the requirements, the series of patches have reorganized
current EEH implementation.

	* The original implementation looks not clean enough. Necessary cleanup
	  will be done in some of the patches.
	* struct eeh_ops has been introduced so that EEH core components and platform
	  dependent implementation could be split up. That make it possible for EEH
	  to be supported on multiple platforms.
	* struct eeh_dev has been introduced to replace struct pci_dn so that EEH module
	  works independently as much as possible.
	* EEH global statistics will be maintained in a collective fashion.

v1 -> v2:

	* If possible, to add "eeh_" prefix for function names.
	* The format of leading function comments won't be changed in order not to
	  break kernel document automatic generation (e.g. by "make pdfdocs").
	* The name of local variables won't be changed if there're no explicit reasons.
	* Represent the PE's state in bitmap fasion.
	* Some function names have been adjusted so that they look shorter and
	  meaningful.
	* Platform operation name has been changed to "pseries".
	* Merge those patches for cleanup if possible.
	* The line length is kept as appropriately short if possible.
	* Fixup on alignment & spacing issues.

v2 -> v3:
	* Split cleanup patch into 2: one for comment cleanup and another one for
	  renaming function names.
	* Try to use pr_warning/pr_info/pr_debug instead of printk() function call.
	* Function names are adjusted a little bit so that they looks more meaningful
	  according to comments from Michael/Ben.
	* Useful comment has been kept according to Michael's comments.
	* struct eeh_ops::set_eeh has been changed to eeh_ops::set_option.
	* struct eeh_ops::name has been changed to "char *".
	* Remove file name from the source file.
	* Copyright (C) format has been changed since "(C)" isn't encouraged to use.
	* The header files included in the source file have been sorted alphabetically.
	* eeh_platform_init() has been replaced by eeh_pseries_init() to avoid duplicate
	  functions when kernel supports multiple platforms.
	* "F/W" has been changed to "Firmware".
	* The maximal wait time to retrieve PE's state has been covered by macro.
	* It also include changes according to the minor comments from Michael.

v3 -> v4:
	* Fix some typo included in the commit messages.
	* Reduce code nesting according to Ram's suggestions.
	* Addtinal pr_warning on failure of configuring bridges.

The series of patches (v4) has been verified on Firebird-L machine. In order to carry out
the test, you have to install IBM Power Tools from IBM internal yum source. Following
command is used to force EEH check on ethernet interface, which could be recovered eventually
by EEH and device driver successfully. You could keep pinging to the blade before issuing
the following command to force EEH. You should see the network interface can't be reached for
a moment and everything will be recovered couple of seconds after the forced EEH error. At the
same time, you should see EEH error log out of system console. 

	* errinjct eeh -v -f 0 -p U78AE.001.WZS00M9-P1-C18-L1-T2 -a 0x0 -m 0x0


-------------

arch/powerpc/include/asm/device.h            |    3 -
arch/powerpc/include/asm/eeh.h               |  143 +---
arch/powerpc/include/asm/eeh_event.h         |   33 +-
arch/powerpc/include/asm/ppc-pci.h           |   89 ++-
arch/powerpc/kernel/of_platform.c            |    3 -
arch/powerpc/kernel/rtas_pci.c               |    3 -
arch/powerpc/platforms/pseries/Makefile      |    3 +-
arch/powerpc/platforms/pseries/eeh.c         | 1016 +++++++++++++++-----------
arch/powerpc/platforms/pseries/eeh_cache.c   |   44 +-
arch/powerpc/platforms/pseries/eeh_driver.c  |  213 +++---
arch/powerpc/platforms/pseries/eeh_event.c   |   55 +-
arch/powerpc/platforms/pseries/eeh_pseries.c |  565 --------------
arch/powerpc/platforms/pseries/eeh_sysfs.c   |   25 +-
arch/powerpc/platforms/pseries/msi.c         |    2 +-
arch/powerpc/platforms/pseries/pci_dlpar.c   |    3 -
arch/powerpc/platforms/pseries/setup.c       |    7 +-
include/linux/of.h                           |    3 -
17 files changed, 861 insertions(+), 1349 deletions(-)

Thanks,
Gavin
