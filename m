Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41PT372G3yzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 00:57:55 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w69ErkYT099450
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2018 10:57:52 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k499gjp5m-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Jul 2018 10:57:52 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 9 Jul 2018 08:57:51 -0600
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v06 0/9] powerpc/hotplug: Update affinity for migrated CPUs
Date: Mon, 9 Jul 2018 09:57:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <4e6b3582-0033-b232-3769-226ba6f68eac@linux.vnet.ibm.com>
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
  -- Rebase to 4.18-rc1 kernel
  -- Change operation to run CPU readd after end of migration store.
  -- Improve descriptive text
  -- Cleanup patch reference to outdated function
