Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qRDg5ttvzDqYR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 03:52:02 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4LHnBww107931
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 13:51:59 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j41bbkw7g-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 13:51:59 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 21 May 2018 13:51:58 -0400
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [RFC v5 0/6] powerpc/hotplug: Fix affinity assoc for LPAR migration
To: linuxppc-dev@lists.ozlabs.org
Date: Mon, 21 May 2018 12:51:55 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <6add12e8-acf9-228e-fa04-80e38dbb8f7c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The migration of LPARs across Power systems affects many attributes
including that of the associativity of memory blocks and CPUs.  The
patches in this set execute when a system is coming up fresh upon a
migration target.  They are intended to,

* Recognize changes to the associativity of memory and CPUs recorded
  in internal data structures when compared to the latest copies in
  the device tree (e.g. ibm,dynamic-memory, ibm,dynamic-memory-v2,
  cpus),
* Recognize changes to the associativity mapping (e.g. ibm,
  associativity-lookup-arrays), locate all assigned memory blocks
  corresponding to each changed row, and readd all such blocks.
* Generate calls to other code layers to reset the data structures
  related to associativity of the CPUs and memory.
* Re-register the 'changed' entities into the target system.
  Re-registration of CPUs and memory blocks mostly entails acting as
  if they have been newly hot-added into the target system.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Michael Bringmann (3):
  powerpc migration/drmem: Modify DRMEM code to export more features
  powerpc migration/cpu: Associativity & cpu changes
  powerpc migration/memory: Associativity & memory updates
---
Changes in RFC:
  -- Restructure and rearrange content of patches to co-locate
     similar or related modifications
  -- Rename pseries_update_drconf_cpu to pseries_update_cpu
  -- Simplify code to update CPU nodes during mobility checks.
     Remove functions to generate extra HP_ELOG messages in favor
     of direct function calls to dlpar_cpu_readd_by_index, or
     dlpar_memory_readd_by_index.
  -- Revise code order in dlpar_cpu_readd_by_index() to present
     more appropriate error codes from underlying layers of the
     implementation.
  -- Add hotplug device lock around all property updates
  -- Schedule all CPU and memory changes due to device-tree updates /
     LPAR mobility as workqueue operations
  -- Export DRMEM accessor functions to parse 'ibm,dynamic-memory-v2'
  -- Export DRMEM functions to provide user copies of LMB array
  -- Compress code using DRMEM accessor functions.
  -- Split topology timer crash fix into new patch.
  -- Modify DRMEM code to replace usages of dt_root_addr_cells, and
     dt_mem_next_cell, as these are only available at first boot.
  -- Correct a bug in DRC index selection for queued operation.
  -- Rebase to 4.17-rc5 kernel
  -- Minor code cleanups
