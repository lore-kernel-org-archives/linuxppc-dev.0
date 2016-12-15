Return-Path: <jallen@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfnmH3tZ6zDw6F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 09:14:23 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBFMDn8I080887
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 17:14:20 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27c3n6gern-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 17:14:19 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.vnet.ibm.com>;
 Thu, 15 Dec 2016 15:14:19 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 4559419D8042
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 15:13:36 -0700 (MST)
To: linuxppc-dev@lists.ozlabs.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>
From: John Allen <jallen@linux.vnet.ibm.com>
Subject: [PATCH v2 0/3] powerpc/pseries: Perform PRRN topology updates in
 kernel
Date: Thu, 15 Dec 2016 16:14:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <ef5af85a-5692-6a2b-8fae-5500d3880336@linux.vnet.ibm.com>
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

John Allen (3):
      powerpc/pseries: Make the acquire/release of the drc for memory a seperate step
      powerpc/pseries: Introduce memory hotplug READD operation
      powerpc/pseries: Update affinity for memory and cpus specified in a PRRN event

 arch/powerpc/include/asm/rtas.h                 |    1
 arch/powerpc/kernel/rtasd.c                     |    7 ++
 arch/powerpc/platforms/pseries/hotplug-memory.c |   75 +++++++++++++++++++----
 arch/powerpc/platforms/pseries/mobility.c       |   32 ++++++++++
 4 files changed, 102 insertions(+), 13 deletions(-)
