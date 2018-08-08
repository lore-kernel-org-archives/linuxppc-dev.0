Return-Path: <jallen@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lwKp3ZCPzDrWq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 01:29:34 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w78FOCfx002395
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Aug 2018 11:29:32 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kqyjstecg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Aug 2018 11:29:32 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.ibm.com>;
 Wed, 8 Aug 2018 11:29:30 -0400
From: John Allen <jallen@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: nfont@linux.vnet.ibm.com, desnesn@linux.vnet.ibm.com
Subject: [PATCH v3 0/2] powerpc/pseries: Improve serialization of PRRN events
Date: Wed,  8 Aug 2018 10:29:24 -0500
Message-Id: <20180808152926.28842-1-jallen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stress testing has uncovered issues with handling continuously queued PRRN
events. Running PRRN events in this way can seriously load the system given
the sheer volume of dlpar being handled. This patchset ensures that PRRN
events are handled more synchronously, only allowing the PRRN handler to
queue a single dlpar event at any given time.  Additionally, it ensures
that rtas polling continues normally when multiple PRRN events are queued
simultaneously.

v3:
  -Scrap the PRRN mutex as it only replicates existing workqueue behavior.
v2:
  -Unlock prrn_lock when PRRN operations are complete, not after handler is
   scheduled.
  -Remove call to flush_work, the previous broken method of serializing
   PRRN events.

John Allen (2):
  powerpc/pseries: Avoid blocking rtas polling handling multiple PRRN
    events
  powerpc/pseries: Wait for completion of hotplug events during PRRN
    handling

 arch/powerpc/kernel/rtasd.c               | 10 +++++++---
 arch/powerpc/platforms/pseries/mobility.c |  5 ++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.17.1
