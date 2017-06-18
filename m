Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrNMp5bhSzDqMP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 04:45:26 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5IIhhL8001681
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Jun 2017 14:45:22 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b5wdra9x6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Jun 2017 14:45:22 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Sun, 18 Jun 2017 12:45:22 -0600
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V5 0/2] powerpc/dlpar: Correct display of hot-add/hot-remove
 CPUs and memory
Date: Sun, 18 Jun 2017 13:45:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <2a7f2a4f-5885-d186-2baf-da72ce0712b2@linux.vnet.ibm.com>
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
Changes in V5:
  -- Add 'numnodes' kernel command line option.
