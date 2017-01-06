Return-Path: <jallen@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3twDwn4xnGzDqVw
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jan 2017 06:23:20 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v06JK8XR074396
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jan 2017 14:23:17 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27tb586f22-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Jan 2017 14:23:17 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.vnet.ibm.com>;
 Fri, 6 Jan 2017 12:23:16 -0700
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 00D6E3E40044
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jan 2017 12:23:12 -0700 (MST)
To: linuxppc-dev@lists.ozlabs.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>
From: John Allen <jallen@linux.vnet.ibm.com>
Subject: [PATCH v3 0/3] powerpc/pseries: Perform PRRN topology updates in
 kernel
Date: Fri, 6 Jan 2017 13:23:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <a4c3e5c2-18d8-0f01-272b-a3ae23318469@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Formerly, when we received a PRRN rtas event, device tree updating was
performed in the kernel and the actual topology updating was performed in
userspace. This was necessary as in order to update the topology for memory,
we must perform a hot remove and a subsequent hot add and until recently,
memory hotplug was not included in the kernel. Since memory hotplug is now
available, this patchset moves the PRRN topology updating into the kernel.

Changes from v1:
-Introduce patch to separate the acquire and release drc from existing
 memory hotplug
-Create new function "dlpar_memory_readd_by_index" that consolidates the
 necessary steps of memory hot remove and hot add into a single function
-Remove conversion of phandle to BE
-Since error messages are already generated in the memory hotplug code,
 remove redundant error messages in pseries_prrn_update_node. Since we no
 longer use the return code from the hotplug event, remove the
 wait_for_completion infrastructure.

Changes from v2:
-Check if a node exists before allocating memory and call of_node_put
 if the call to of_find_node_by_phandle returns successfully.

John Allen (3):
      powerpc/pseries: Make the acquire/release of the drc for memory a seperate step
      powerpc/pseries: Introduce memory hotplug READD operation
      powerpc/pseries: Update affinity for memory and cpus specified in a PRRN event

 arch/powerpc/include/asm/rtas.h                 |    1
 arch/powerpc/kernel/rtasd.c                     |    7 ++
 arch/powerpc/platforms/pseries/hotplug-memory.c |   75 +++++++++++++++++++----
 arch/powerpc/platforms/pseries/mobility.c       |   34 ++++++++++
 4 files changed, 104 insertions(+), 13 deletions(-)
