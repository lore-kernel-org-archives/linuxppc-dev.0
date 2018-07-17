Return-Path: <jallen@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VVy05nF9zF3HZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 05:40:56 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6HJd0nb046268
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 15:40:54 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k9pg08ru9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 15:40:53 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.ibm.com>;
 Tue, 17 Jul 2018 15:40:52 -0400
From: John Allen <jallen@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com
Subject: [PATCH v2 0/2] powerpc/pseries: Improve serialization of PRRN events
Date: Tue, 17 Jul 2018 14:40:46 -0500
Message-Id: <20180717194048.3057-1-jallen@linux.ibm.com>
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
