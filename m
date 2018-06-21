Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41B2lM37RbzF12T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 10:34:39 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5L0Xgva025603
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 20:34:36 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jr01nar7m-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 20:34:36 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 20 Jun 2018 18:34:36 -0600
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH 0/3] powerpc/migration: Affinity fix for memory
Date: Wed, 20 Jun 2018 19:34:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <c7b0c1e5-7adf-299b-646f-6988b1fa0f8b@linux.vnet.ibm.com>
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

Michael Bringmann (3):
  powerpc/drmem: Export 'dynamic-memory' loader
  migration/memory: Evaluate LMB assoc changes
  migration/memory: Support 'ibm,dynamic-memory-v2'
