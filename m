Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqvCQ4Jv2zF1TM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 07:52:18 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1QKq4wj068676
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 15:52:15 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gcp1wgj84-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 15:52:15 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 26 Feb 2018 13:52:14 -0700
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC v2 0/3] powerpc/hotplug: Fix affinity assoc for LPAR migration
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Mon, 26 Feb 2018 14:51:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <9cf9df97-6934-c9b5-4f07-417fad6e43d1@linux.vnet.ibm.com>
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
  -- Make use of drmem accessor functions to read dynamic memory
     properties.
  -- Change section of a support function + variable from __init 
     to normal runtime to make them visible to migration code.
