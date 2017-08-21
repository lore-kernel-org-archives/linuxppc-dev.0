Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbnJl19nBzDrJh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 07:44:22 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7LLiIhi073121
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 17:44:21 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cg25b989j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 17:44:20 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 21 Aug 2017 15:44:15 -0600
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: nfont@linux.vnet.ibm.com, Michael Bringmann <mwb@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V9 0/2] powerpc/dlpar: Correct display of hot-add/hot-remove
 CPUs and memory
Date: Mon, 21 Aug 2017 16:44:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <9e5050e1-e0cc-0e0e-7b31-5dcb38b307f4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Power systems with shared configurations of CPUs and memory, there
are some issues with association of additional CPUs and memory to nodes
when hot-adding resources.  These patches address some of those problems.

powerpc/numa: Correct the currently broken capability to set the
topology for shared CPUs in LPARs.  At boot time for shared CPU
lpars, the topology for each shared CPU is set to node zero, however,
this is now updated correctly using the Virtual Processor Home Node
(VPHN) capabilities information provided by the pHyp. The VPHN handling
in Linux is disabled, if PRRN handling is present.

powerpc/nodes: On systems like PowerPC which allow 'hot-add' of CPU
or memory resources, it may occur that the new resources are to be
inserted into nodes that were not used for these resources at bootup.
In the kernel, any node that is used must be defined and initialized
at boot.

This patch extracts the value of the lowest domain level (number of
allocable resources) from the "rtas" device tree property
"ibm,max-associativity-domains" to use as the maximum number of nodes
to setup as possibly available in the system.  This new setting will
override the instruction,

    nodes_and(node_possible_map, node_possible_map, node_online_map);

presently seen in the function arch/powerpc/mm/numa.c:initmem_init().

If the property is not present at boot, no operation will be performed
to define or enable additional nodes.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Michael Bringmann (2):
  powerpc/numa: Update CPU topology when VPHN enabled
  powerpc/nodes: Ensure enough nodes avail for operations
---
Changes in V9:
  -- Calculate number of nodes via property "ibm,max-associativity-domains"
