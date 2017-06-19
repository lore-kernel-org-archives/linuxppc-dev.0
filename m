Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ws4rk6ZtxzDqRW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 08:09:26 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5JM9HuG082525
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 18:09:24 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b6cksq8tb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 18:09:24 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 19 Jun 2017 16:09:23 -0600
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V6 0/2] powerpc/dlpar: Correct display of hot-add/hot-remove
 CPUs and memory
Date: Mon, 19 Jun 2017 17:09:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <081bb19d-3008-842d-6872-f51fccb94139@linux.vnet.ibm.com>
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

powerpc/hotplug: On systems like PowerPC which allow 'hot-add' of CPU
or memory resources, it may occur that the new resources are to be
inserted into nodes that were not used for these resources at bootup.
In the kernel, any node that is used must be defined and initialized
at boot.  In order to meet both needs, this patch adds a new kernel
command line option (numnodes=<int>) for use by the PowerPC
architecture-specific code that defines the maximum number of nodes
that the kernel will ever need in its current hardware environment.
The boot code that initializes nodes for PowerPC will read this value
and use it to ensure that all of the desired nodes are setup in the
'node_possible_map', and elsewhere.

powerpc/numa: Correct the currently broken capability to set the
topology for shared CPUs in LPARs.  At boot time for shared CPU
lpars, the topology for each shared CPU is set to node zero, however,
this is now updated correctly using the Virtual Processor Home Node
(VPHN) capabilities information provided by the pHyp. The VPHN handling
in Linux is disabled, if PRRN handling is present.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Michael Bringmann (2):
  powerpc/hotplug: Add option to define max nodes allowing dynamic
      growth of resources.
  powerpc/numa: Update CPU topology when VPHN enabled
---
Changes in V6:
  -- Reorder some code to eliminate unused functions in conditional
       builds.
