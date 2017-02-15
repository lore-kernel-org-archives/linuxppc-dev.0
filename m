Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNpPn2skczDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 05:55:08 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1FIrZvD111659
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 13:55:05 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28mq9fybwg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 13:55:05 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 15 Feb 2017 11:55:04 -0700
Subject: [PATCH v7 0/4] powerpc/pseries: Implement indexed-count memory hotplug
To: linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: jallen@linux.vnet.ibm.com, sahilmehta17@gmail.com,
 mdroth@linux.vnet.ibm.com, david@gibson.dropbear.id.au
Date: Wed, 15 Feb 2017 13:45:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20170215184321.11755.88199.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Indexed-count memory hotplug allows addition and removal of contiguous
lmb blocks with a single command. This update will help with memory
DLPAR for Linux KVM guests and Qemu. The management of memory in Qemu
on a per-DIMM basis currently requires that DLPAR operations are done
in a series of DLPAR request to remove an entire range of LMBs. With
the indexed-count capability a single request can be made to remove or
add a contigious block of LMBs.

This patch set also reverts a previous patch to move pseries to use the
auto-online capabilities. This has proven problematic as the device
struct for a memory block does not get updated to indicate the memory
block is online when it is added, event though it is online.

Additionally there is a patch to correct an error when building with
the MEMORY_HOTREMOVE config option not set.

-Nathan
---

Updates from v6:
Patch 1/4: New
Patch 2/4: New
Patch 3/4: Re-based to latest kernel
Patch 4/4: Re-based to latest kernel
---

Nathan Fontenot (2):
      powerpc/pseries: dlpar_memory_readd_by_index() when MEMORY_HOTREMOVE not defined
      powerpc/pseries: Revert 'Auto-online hotplugged memory'

Sahil Mehta (2):
      powerpc/pseries: Implement indexed-count hotplug memory add
      powerpc/pseries: Implement indexed-count hotplug memory remove


 arch/powerpc/configs/pseries_defconfig          |    1 
 arch/powerpc/include/asm/rtas.h                 |    2 
 arch/powerpc/platforms/pseries/dlpar.c          |   38 +++
 arch/powerpc/platforms/pseries/hotplug-memory.c |  273 +++++++++++++++++++++--
 4 files changed, 286 insertions(+), 28 deletions(-)
