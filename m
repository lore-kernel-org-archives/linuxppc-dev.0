Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4VZH2Sf1zDvSs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 02:05:43 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9RF3wcx104334
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 11:05:40 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26bg8agex4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 11:05:39 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 27 Oct 2016 11:05:39 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 3B0AB6E803C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 11:05:12 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9RF5FMZ8389020
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 15:05:36 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83C49AE06A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 11:05:36 -0400 (EDT)
Received: from powerkvm6.aus.stglabs.ibm.com (unknown [9.40.192.78])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP id 721F1AE05C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 11:05:36 -0400 (EDT)
Received: from powerkvm6.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by powerkvm6.aus.stglabs.ibm.com (Postfix) with ESMTP id 056D9C248071
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 17:06:52 -0500 (CDT)
Subject: [PATCH V8 0/8] powerpc/devtree: Add support for 2 new DRC properties
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 25 Oct 2016 17:06:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20161025220606.188611.30959.stgit@powerkvm6.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Several properties in the DRC device tree format are replaced by
more compact representations to allow, for example, for the encoding
of vast amounts of memory, and or reduced duplication of information
in related data structures.

"ibm,drc-info": This property, when present, replaces the following
four properties: "ibm,drc-indexes", "ibm,drc-names", "ibm,drc-types"
and "ibm,drc-power-domains".  This property is defined for all
dynamically reconfigurable platform nodes.  The "ibm,drc-info" elements
are intended to provide a more compact representation, and reduce some
search overhead.

"ibm,dynamic-memory-v2": This property replaces the "ibm,dynamic-memory"
node representation within the "ibm,dynamic-reconfiguration-memory"
property provided by the BMC.  This element format is intended to provide
a more compact representation of memory, especially, for systems with
massive amounts of RAM.  To simplify portability, this property is
converted to the "ibm,dynamic-memory" property during system boot.

"ibm,architecture.vec": Bidirectional communication mechanism between
the host system and the front end processor indicating what features
the host system supports and what features the front end processor will
actually provide.  In this case, we are indicating that the host system
can support the new device tree structures "ibm,drc-info" and
"ibm,dynamic-memory-v2".

[V1: Initial presentation of PAPR 2.7 changes to device tree.]
[V2: Revise constant names.  Fix some syntax errors.  Improve comments.]
[V3: Revise tests for presence of new properties to always scan devicetree
     instead of depending upon architecture vec, due to reboot issues.]
[V4: Rearrange some code changes in patches to better match application,
     and other code cleanup.]
[V5: Resynchronize patches.]
[V6: Resync to latest kernel commit code]
[V7: Correct mail threading]
[v8: Insert more useful variable names]

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

---

Michael Bringmann (8):
  powerpc/firmware: Add definitions for new firmware features.
  powerpc/memory: Parse new memory property to register blocks.
  powerpc/memory: Parse new memory property to initialize structures.
  pseries/hotplug init: Convert new DRC memory property for hotplug runtime
  pseries/drc-info: Search new DRC properties for CPU indexes
  hotplug/drc-info: Add code to search new devtree properties
  powerpc: Check arch.vec earlier during boot for memory features
  powerpc: Enable support for new DRC devtree properties


 arch/powerpc/include/asm/firmware.h             |    5 -
 arch/powerpc/include/asm/prom.h                 |   38 ++++-
 arch/powerpc/kernel/prom.c                      |  103 +++++++++++--
 arch/powerpc/kernel/prom_init.c                 |    3 
 arch/powerpc/mm/numa.c                          |  168 ++++++++++++++++++--
 arch/powerpc/platforms/pseries/Makefile         |    4 
 arch/powerpc/platforms/pseries/firmware.c       |    2 
 arch/powerpc/platforms/pseries/hotplug-memory.c |   93 +++++++++++
 arch/powerpc/platforms/pseries/pseries_energy.c |  189 ++++++++++++++++++++---
 drivers/pci/hotplug/rpadlpar_core.c             |   13 +-
 drivers/pci/hotplug/rpaphp.h                    |    4 
 drivers/pci/hotplug/rpaphp_core.c               |  109 ++++++++++---
 12 files changed, 628 insertions(+), 103 deletions(-)
