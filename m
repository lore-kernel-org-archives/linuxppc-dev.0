Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zTXt0gbzzF0mQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 06:03:57 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w53K3gXt112670
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Jun 2018 16:03:53 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jc8m34ggx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Jun 2018 16:03:53 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Sun, 3 Jun 2018 14:03:52 -0600
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [RFC v9 0/4] powerpc/hotplug: Update affinity for migrated CPUs
To: linuxppc-dev@lists.ozlabs.org
Date: Sun, 3 Jun 2018 15:03:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <95c97180-37b7-85da-a82f-17dbc73f5ed6@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Testing delayed due to internal SAN problems.]

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

Michael Bringmann (4):
  hotplug/cpu: Conditionally acquire/release DRC index
  hotplug/cpu: Add operation queuing function
  hotplug/dlpar/cpu: Provide CPU readd operation
  mobility/numa: Ensure numa update does not overlap
---
Changes in RFC:
  -- Restructure and rearrange content of patches to co-locate
     similar or related modifications
  -- Rename pseries_update_drconf_cpu to pseries_update_cpu
  -- Simplify code to update CPU nodes during mobility checks.
     Remove functions to generate extra HP_ELOG messages in favor
     of direct function calls to dlpar_cpu_readd_by_index.
  -- Revise code order in dlpar_cpu_readd_by_index() to present
     more appropriate error codes from underlying layers of the
     implementation.
  -- Add hotplug device lock around all property updates
  -- Schedule all CPU updates as workqueue operations
  -- Rebase to 4.17-rc5 kernel
  -- Various code cleanups and compaction
