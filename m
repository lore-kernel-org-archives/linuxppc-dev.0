Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zjCTv2WQpzDqGj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 10:41:38 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1FNdQQk084297
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 18:41:36 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g5kea19k2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 18:41:36 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 15 Feb 2018 16:41:35 -0700
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [RFC 0/3] powerpc/hotplug: Fix affinity assoc for LPAR migration
Date: Thu, 15 Feb 2018 17:40:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <80574cd2-9cef-9724-d6ce-9ff38a7e0677@linux.vnet.ibm.com>
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
  hotplug/mobility: Apply assoc lookup updates for Post Migration Topo
  postmigration/memory: Review assoc lookup array changes
  postmigration/memory: Associativity & 'ibm,dynamic-memory-v2'
---
Changes in RFC:
  -- Rename pseries_update_drconf_cpu to pseries_update_cpu
  -- Simplify code to update CPU nodes during mobility checks.
     Remove functions to generate extra HP_ELOG messages in favor
     of direct function calls to dlpar_cpu_readd_by_index, or
     dlpar_memory_readd_by_index.
  -- Move check for "cpu" node type from pseries_update_cpu to
     pseries_smp_notifier in 'hotplug-cpu.c'
  -- Remove functions 'pseries_memory_readd_by_index' and
     'pseries_cpu_readd_by_index' as no longer needed outside of
     'mobility.c'.
  -- Update patch for recent checkin compatibility
  -- Resubmit as RFC pending further integration with LMB changes
     by Nathan Fontenot
