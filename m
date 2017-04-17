Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6Hkf3ZjNzDqFV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 05:04:42 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3HJ3q8h165213
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 15:04:33 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29vwu0prx7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 15:04:32 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 17 Apr 2017 13:04:31 -0600
Subject: [PATCH V3 0/5] powerpc/devtree: Add support for 'ibm,
 dynamic-memory-v2' property
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: ltc-virtual-io@lists.linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com
Date: Mon, 17 Apr 2017 14:04:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149245584013.50044.3035847055561514147.stgit@powerkvm6.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"ibm,dynamic-memory-v2": This property replaces the "ibm,dynamic-memory"
node representation within the "ibm,dynamic-reconfiguration-memory"
node provided by the BMC.  This element format is intended to provide
a more compact representation of memory, especially, for systems with
massive amounts of RAM.  To simplify portability, this property is
converted to the "ibm,dynamic-memory" property during system boot.

"ibm,architecture.vec": Bidirectional communication mechanism between
the host system and the front end processor indicating what features
the host system supports and what features the front end processor will
actually provide.  In this case, we are indicating that the host system
can support the new device tree structure "ibm,dynamic-memory-v2".

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Michael Bringmann (5):
  powerpc: Check arch.vec earlier during boot for memory features
  powerpc/memory: Parse new memory property to register blocks.
  powerpc/memory: Parse new memory property to initialize structures.
  pseries/hotplug init: Convert new DRC memory property for hotplug runtime
  powerpc: Enable support for new 'ibm,dynamic-memory-v2' devtree property
---
Changes in V3:
  -- Add missing of_node_put() calls.

 arch/powerpc/include/asm/firmware.h             |    4 
 arch/powerpc/include/asm/prom.h                 |   33 +++-
 arch/powerpc/kernel/prom.c                      |  131 +++++++++++---
 arch/powerpc/kernel/prom_init.c                 |    2 
 arch/powerpc/mm/numa.c                          |  213 ++++++++++++++++++-----
 arch/powerpc/platforms/pseries/Makefile         |    4 
 arch/powerpc/platforms/pseries/firmware.c       |    1 
 arch/powerpc/platforms/pseries/hotplug-memory.c |  104 +++++++++++
 8 files changed, 406 insertions(+), 86 deletions(-)

--
Signature
