Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yJRf31jFVzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Oct 2017 00:36:26 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9KDYd1r065123
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 09:36:24 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dqgug3tj2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 09:36:23 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 20 Oct 2017 09:36:23 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9KDaLxs53477604
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 13:36:21 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A74F28041
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 09:36:14 -0400 (EDT)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP id 0121F2803D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 09:36:13 -0400 (EDT)
Subject: [PATCH v2 0/8] powerpc: Support ibm,dynamic-memory-v2 property
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 20 Oct 2017 08:21:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <150850568437.9118.13945089249591962212.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set provides a set of updates to de-couple the LMB information
provided in the ibm,dynamic-memory device tree property from the device
tree property format. A part of this patch series introduces a new
device tree property format for dynamic memory, ibm-dynamic-meory-v2.
By separating the device tree format from the information provided by
the device tree property consumers of this information need not know
what format is currently being used and provide multiple parsing routines
for the information.

The first two patches update the of_get_assoc_arrays() and
of_get_usable_memory() routines to look up the device node for the
properties they parse. This is needed because the calling routines for
these two functions will not have the device node to pass in in
subsequent patches.

The third patch adds a new kernel structure, struct drmem_lmb, that
is used to represent each of the possible LMBs specified in the
ibm,dynamic-memory* device tree properties. The patch adds code
to parse the property and build the LMB array data, and updates prom.c
to use this new data structure instead of parsing the device tree directly.

The fourth and fifth patches update the numa and pseries hotplug code
respectively to use the new LMB array data instead of parsing the
device tree directly.

The sixth patch moves the of_drconf_cell struct to drmem.h where it
fits better than prom.h

The seventh patch introduces support for the ibm,dynamic-memory-v2
property format by updating the new drmem.c code to be able to parse
and create this new device tree format.

The last patch in the series updates the architecture vector to indicate
support for ibm,dynamic-memory-v2.

-Nathan

Updates for V2: 
Patch 3/7: Correct build break for non-pseries builds.
Patch 4/7: Remove unused paramter to updated routines.
Patch 5/7: Correct unitiailized variable warnings

---

Nathan Fontenot (8):
      powerpc/numa: Look up device node in of_get_assoc_arrays()
      powerpc/numa: Look up device node in of_get_usable_memory()
      powerpc/mm: Separate ibm,dynamic-memory data from DT format
      powerpc/numa: Update numa code use drmem LMB array
      powerpc/pseries: Update memory hotplug code to use drmem LMB array
      powerpc: Move of_drconf_cell struct to asm/drmem.h
      powerpc/pseries: Add support for ibm,dynamic-memory-v2 property
      powerpc: Enable support of ibm,dynamic-memory-v2


 arch/powerpc/include/asm/drmem.h                |   94 ++++
 arch/powerpc/include/asm/firmware.h             |    3 
 arch/powerpc/include/asm/prom.h                 |   17 -
 arch/powerpc/kernel/prom.c                      |  128 +++---
 arch/powerpc/kernel/prom_init.c                 |    1 
 arch/powerpc/mm/Makefile                        |    2 
 arch/powerpc/mm/drmem.c                         |  324 ++++++++++++++
 arch/powerpc/mm/numa.c                          |  188 ++------
 arch/powerpc/platforms/pseries/firmware.c       |    1 
 arch/powerpc/platforms/pseries/hotplug-memory.c |  522 +++++++++--------------
 10 files changed, 746 insertions(+), 534 deletions(-)
 create mode 100644 arch/powerpc/include/asm/drmem.h
 create mode 100644 arch/powerpc/mm/drmem.c
