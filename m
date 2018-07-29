Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41djvW3YR9zF12F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 23:18:47 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6TDIgJM021043
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 09:18:44 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kh5s03sgy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 09:18:44 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Sun, 29 Jul 2018 07:18:43 -0600
To: linuxppc-dev@lists.ozlabs.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH v08 0/5] powerpc/hotplug: Update affinity for migrated CPUs
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Sun, 29 Jul 2018 08:18:34 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <9573dc30-01ad-2650-c247-28df08875cef@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The migration of LPARs across Power systems affects many attributes
including that of the associativity of CPUs.  The patches in this
set execute when a system is coming up fresh upon a migration target.
They are intended to,

* Recognize changes to the associativity of CPUs recorded in internal
  data structures when compared to the latest copies in the device tree.
* Generate calls to other code layers to reset the data structures
  related to associativity of the CPUs.
* Re-register the 'changed' entities into the target system.
  Re-registration of CPUs mostly entails acting as if they have been
  newly hot-added into the target system.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Michael Bringmann (9):
  hotplug/cpu: Conditionally acquire/release DRC index
  hotplug/cpu: Add operation queuing function
  hotplug/cpu: Provide CPU readd operation
  mobility/numa: Ensure numa update does not overlap
  numa: Disable/enable arch_update_cpu_topology
  pmt/numa: Disable arch_update_cpu_topology during CPU readd
  powerpc/rtas: Allow disabling rtas_event_scan
  hotplug/rtas: No rtas_event_scan during PMT update
  hotplug/pmt: Update topology after PMT
---
Changes in patch:
  -- Restructure and rearrange content of patches to co-locate
     similar or related modifications
  -- Rename pseries_update_drconf_cpu to pseries_update_processor
  -- Simplify code to update CPU nodes during mobility checks.
     Remove functions to generate extra HP_ELOG messages in favor
     of direct function calls to dlpar_cpu_readd_by_index.
  -- Revise code order in dlpar_cpu_readd_by_index() to present
     more appropriate error codes from underlying layers of the
     implementation.
  -- Add hotplug device lock around all property updates
  -- Add call to rebuild_sched_domains in case of changes
  -- Various code cleanups and compaction
  -- Rebase to 4.18 kernel
  -- Change operation to run CPU readd after end of migration store.
  -- Improve descriptive text
  -- Cleanup patch reference to outdated function
  -- Code cleanup a 'acquire_drc' check in dlpar_cpu_add.
  -- Code cleanup a 'release_drc' check in dlpar_cpu_remove.
  -- Add more information to patch descriptions.
  -- More code cleanup
  -- Rearrange call to rebuild_sched_domains to allow removal
     of some locking code.
