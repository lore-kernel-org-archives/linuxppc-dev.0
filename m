Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y67V91SZMzDqks
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 05:53:52 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v93InNGZ091394
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Oct 2017 14:53:49 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dcg3a8d8j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Oct 2017 14:53:49 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 3 Oct 2017 14:53:48 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v93Irl9e37027858
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Oct 2017 18:53:47 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 663C92804A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 14:53:40 -0400 (EDT)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP id 3D38228041
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 14:53:40 -0400 (EDT)
Subject: [PATCH0/8] Support for ibm,dynamic-memory-v2 device tree property
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 03 Oct 2017 13:39:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <150705593139.7318.5934648279979743833.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
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
tree property format. The goal is to provide a data set of LMB information
so that consumners of this data do not need to understand and provide
multiple parsing routines for the supported device tree property formats.

The first two patches update the of_get_assoc_arrays() and
of_get_usable_memory() routines to look up the device node for the
properties they parse. This is needed because the calling routines for
these two functions will not have the device node to pass in in
subsequent patches.

The third patch adds a new kernel structure, struct drmem_lmb, that
is used to represent each of the possible LMBs specified in the
ibm,dynamic-reconfiguration* device tree properties. The patch adds code
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
suppport for ibm,dynamic-memory-v2.


-Nathan
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
 arch/powerpc/kernel/prom.c                      |  126 +++---
 arch/powerpc/kernel/prom_init.c                 |    1 
 arch/powerpc/mm/Makefile                        |    2 
 arch/powerpc/mm/drmem.c                         |  324 ++++++++++++++
 arch/powerpc/mm/numa.c                          |  183 ++------
 arch/powerpc/platforms/pseries/firmware.c       |    1 
 arch/powerpc/platforms/pseries/hotplug-memory.c |  522 +++++++++--------------
 10 files changed, 743 insertions(+), 530 deletions(-)
 create mode 100644 arch/powerpc/include/asm/drmem.h
 create mode 100644 arch/powerpc/mm/drmem.c
