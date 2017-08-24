Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xddh71S1DzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 08:07:34 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7OM6GOl126924
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 18:07:32 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cj5bnx5c7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 18:07:31 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 24 Aug 2017 16:07:31 -0600
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: nfont@linux.vnet.ibm.com,
 Michael Bringmann from Kernel Team <mbringm@us.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V10 0/2] powerpc/dlpar: Correct display of hot-add/hot-remove
 CPUs and memory
Date: Thu, 24 Aug 2017 17:07:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <db1b23c1-67bc-fb0f-51f9-af4bc564d9ef@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: mwb@linux.vnet.ibm.com
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: nfont@linux.vnet.ibm.com
Cc: mwb@linux.vnet.ibm.com
Subject: [PATCH V10 0/2] powerpc/dlpar: Correct display of hot-add/hot-remove CPUs and memory

On Power systems with shared configurations of CPUs and memory, there
are some issues with association of additional CPUs and memory to nodes
when hot-adding resources.  These patches address some of those problems.

powerpc/numa: Correct the currently broken capability to set the
topology for shared CPUs in LPARs.  At boot time for shared CPU
lpars, the topology for each shared CPU is set to node zero, however,
this is now updated correctly using the Virtual Processor Home Node
(VPHN) capabilities information provided by the pHyp. The VPHN handling
in Linux is disabled, if PRRN handling is present.

Also, update initialization checks for device-tree attributes to
independently recognize PRRN or VPHN usage.

Finally, try to distinguish the VPHN code from the NUMA code better,
and move relevant functions to another file.

powerpc/nodes: On systems like PowerPC which allow 'hot-add' of CPU
or memory resources, it may occur that the new resources are to be
inserted into nodes that were not used for these resources at bootup.
In the kernel, any node that is used must be defined and initialized
at boot.

This patch extracts the value of the 'min_common_depth' element from
the "rtas" device tree property "ibm,max-associativity-domains" to use
as the maximum number of nodes to setup as possibly available in the
system.  [The 'min_common_depth' element is calculated from memory
associations found while loading all of the configured memory into
the system data structures at boot.]  This new setting will override
the instruction,

    nodes_and(node_possible_map, node_possible_map, node_online_map);

presently seen in the function arch/powerpc/mm/numa.c:initmem_init().

If the property is not present at boot, no operation will be performed
to define or enable additional nodes.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Michael Bringmann (2):
  powerpc/numa: Update CPU topology when VPHN enabled
  powerpc/nodes: Ensure enough nodes avail for operations
---
Changes in V10:
  -- Reorganize VPHN code
  -- Revise index used with property "ibm,max-associativity-domains"
