Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vrgny3Bl4zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 02:20:22 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2QFIVeN113582
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Mar 2017 11:20:10 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29dmpgfyvm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Mar 2017 11:20:10 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Sun, 26 Mar 2017 09:20:09 -0600
Subject: [PATCH 0/4] powerpc/devtree: Add support for 'ibm, drc-info' property
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: ltc-virtual-io@lists.linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Date: Sun, 26 Mar 2017 10:20:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149054150088.117828.8160636606733671116.stgit@powerkvm6.aus.stglabs.ibm.com>
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

"ibm,architecture.vec": Bidirectional communication mechanism between
the host system and the front end processor indicating what features
the host system supports and what features the front end processor will
actually provide.  In this case, we are indicating that the host system
can support the new device tree structure "ibm,drc-info".

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

---

Michael Bringmann (4):
  powerpc/firmware: Add definitions for new drc-info firmware feature.
  pseries/drc-info: Search new DRC properties for CPU indexes
  hotplug/drc-info: Add code to search new devtree property
  powerpc: Enable support for new DRC devtree property

 arch/powerpc/include/asm/firmware.h             |    3 
 arch/powerpc/include/asm/prom.h                 |    8 +
 arch/powerpc/kernel/prom_init.c                 |    1 
 arch/powerpc/platforms/pseries/firmware.c       |    1 
 arch/powerpc/platforms/pseries/of_helpers.c     |   79 ++++++++++++
 arch/powerpc/platforms/pseries/pseries_energy.c |  150 +++++++++++++++++++----
 drivers/pci/hotplug/rpadlpar_core.c             |   13 +-
 drivers/pci/hotplug/rpaphp.h                    |    4 -
 drivers/pci/hotplug/rpaphp_core.c               |  109 +++++++++++++----
 9 files changed, 306 insertions(+), 62 deletions(-)
