Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41HW9M2v8ZzF1xl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2018 08:12:38 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5TMAeSC066024
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 18:12:36 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jwst5y72m-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 18:12:36 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 29 Jun 2018 18:12:35 -0400
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH v02 0/5] powerpc/migration: Affinity fix for memory
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 29 Jun 2018 17:12:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <adc67a97-b800-b533-7993-516fc254b6a2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The migration of LPARs across Power systems affects many attributes
including that of the associativity of memory blocks.  The patches
in this set execute when a system is coming up fresh upon a migration
target.  They are intended to,

* Recognize changes to the associativity of memory recorded in
  internal data structures when compared to the latest copies in
  the device tree (e.g. ibm,dynamic-memory, ibm,dynamic-memory-v2).
* Recognize changes to the associativity mapping (e.g. ibm,
  associativity-lookup-arrays), locate all assigned memory blocks
  corresponding to each changed row, and readd all such blocks.
* Generate calls to other code layers to reset the data structures
  related to associativity of memory.
* Re-register the 'changed' entities into the target system.
  Re-registration of memory blocks mostly entails acting as if they
  have been newly hot-added into the target system.

This code builds upon features introduced in a previous patch set
that updates CPUs for affinity changes that may occur during LPM.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Michael Bringmann (5):
  powerpc/drmem: Export 'dynamic-memory' loader
  powerpc/drmem: Add internal_flags feature
  migration/memory: Add hotplug flags READD_MULTIPLE
  migration/memory: Evaluate LMB assoc changes
  migration/memory: Support 'ibm,dynamic-memory-v2'
---
Changes in v02:
  -- Change operation to tag changed LMBs in DRMEM array instead
     of queuing a potentially huge number of structures.
  -- Added another hotplug queue event for CPU/memory operations
  -- Added internal_flags feature to DRMEM
  -- Improve the patch description language for the patch set.
