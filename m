Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ypLCg6f5gzDrpq
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Dec 2017 04:01:51 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB1Grxe0113744
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Dec 2017 12:01:49 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ek8wgqfep-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Dec 2017 12:01:48 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 1 Dec 2017 12:01:48 -0500
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 vB1H1l8q53215422
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Dec 2017 17:01:47 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2800AC03A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 12:02:44 -0500 (EST)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP id BB154AC03F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 12:02:44 -0500 (EST)
Subject: [PATCH V3 0/9] powerpc: Support for ibm,dynamic-memory-v2
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 01 Dec 2017 10:46:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <151214667699.64022.17601877129884655591.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set provides a series of updates to de-couple the LMB
information provided in the device tree property from the device
tree property format. This eases the ability to support a new
format for the dynamic memory property, ibm,dynamic-memory-v2.

This series of patches consolidates the routines for parsing the
LMB device tree properties into a new file, powerpc/mm/drmem.c,
and provides the ability to retrieve LMB information without having
to know the backing device tree format.

To do this, a set of routines are introduced that will walk the
device tree property and make a call back for each LMB represented
in the device tree. These are to be used by init routines during
boot, currently in prom.c and numa.c.

A late_initcall is used to allocate and initialize a LMB array to
provide a common data structure of per-LMB data. This array provides
a data structure to retrieve LMB information without knowing the
backing tree format. This is used in numa.c and pseries/hotplug-memory.c.

This is a big design change from the first two version of the patch set
that attempted to allocate the LMB array with bootmem very early.
Testing showed that this allocation can fail which pushed the change
to the current design.

To support memory hotplug needing to update the device tree, a
common routine is introduced to create a new copy of the device
tree property in the proper format.

The first three patches update the of_get_assoc_arrays(),
of_get_usable_memory(), and of_drconf_to_nid_single() routines
to do device tree lookups for information they need instead of having
the nodes/properties passed in. These are updates needed for later
changes.

The fourth patch adds the walk_drmem_lmbs_early() routine to provide
parsing of the flattened device tree and make a per-LMB call back,
used in prom.c

The fifth patch provides a walk_drmem_lmbs() routine to parse the
device tree and provide a per-LMB call back, used in numa.c. This
also allocates and initializes the LMB array, and updates numa.c
to use the array.

The sixth patch updates pseries hotplug code new LMB array data 
instead of parsing the device tree directly and introduces the
common routine to create a new device tree property.

The seventh patch moves the of_drconf_cell struct to drmem.h where it
fits better than prom.h

The eighth patch introduces support for the ibm,dynamic-memory-v2
property format by updating the new drmem.c code to be able to parse
and create this new device tree format.

The last patch in the series updates the architecture vector to indicate
support for ibm,dynamic-memory-v2.

-Nathan
---

Nathan Fontenot (9):
      powerpc/numa: Look up device node in of_get_assoc_arrays()
      powerpc/numa: Look up device node in of_get_usable_memory()
      powerpc/numa: Look up associativity array in of_drconf_to_nid_single
      powerpc/mm: Separate ibm,dynamic-memory data from DT format
      powerpc/numa: Update numa code use walk_drmem_lmbs
      powerpc/pseries: Update memory hotplug code to use drmem LMB array
      powerpc: Move of_drconf_cell struct to asm/drmem.h
      powerpc/drmem: Add support for ibm,dynamic-memory-v2 property
      powerpc: Enable support of ibm,dynamic-memory-v2


 arch/powerpc/include/asm/drmem.h                |  100 ++++
 arch/powerpc/include/asm/firmware.h             |    3 
 arch/powerpc/include/asm/prom.h                 |   17 -
 arch/powerpc/kernel/prom.c                      |  114 ++---
 arch/powerpc/kernel/prom_init.c                 |    1 
 arch/powerpc/mm/Makefile                        |    2 
 arch/powerpc/mm/drmem.c                         |  438 +++++++++++++++++++
 arch/powerpc/mm/numa.c                          |  252 +++--------
 arch/powerpc/platforms/pseries/firmware.c       |    1 
 arch/powerpc/platforms/pseries/hotplug-memory.c |  522 +++++++++--------------
 10 files changed, 864 insertions(+), 586 deletions(-)
 create mode 100644 arch/powerpc/include/asm/drmem.h
 create mode 100644 arch/powerpc/mm/drmem.c
