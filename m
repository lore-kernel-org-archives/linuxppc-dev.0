Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421k4t6gtbzF37r
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 12:36:14 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7V2T9qL117557
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 22:36:12 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m6qxk1qcx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 22:36:12 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 30 Aug 2018 22:36:11 -0400
Subject: [PATCH v4 0/2] powerpc/pseries: Improve serialization of PRRN events
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: johnallen3991@gmail.com, desnesn@linux.vnet.ibm.com,
 haren@linux.vnet.ibm.com
Date: Thu, 30 Aug 2018 21:15:07 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153568164555.2146.11463040249853453135.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
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
events are handled more synchronously. It also updates dlpar invocation
so that it can be done directly instead of waiting on a workqueue.

-Nathan
---
v4:
  -Update patch 1/2 to remove prrn workqueue
  -Replace patch 2/2 to allow for direct dlpar invocation
v3:
  -Scrap the PRRN mutex as it only replicates existing workqueue behavior.
v2:
  -Unlock prrn_lock when PRRN operations are complete, not after handler is
   scheduled.
  -Remove call to flush_work, the previous broken method of serializing
   PRRN events.

Nathan Fontenot (2):
      powerpc/pseries: Remove prrn_work workqueue
      powerpc/pseries:Remove unneeded uses of dlpar work queue


 arch/powerpc/kernel/rtasd.c               |   17 ++-----------
 arch/powerpc/platforms/pseries/dlpar.c    |   37 +++++++----------------------
 arch/powerpc/platforms/pseries/mobility.c |   18 +++++---------
 arch/powerpc/platforms/pseries/pseries.h  |    5 ++--
 arch/powerpc/platforms/pseries/ras.c      |    2 +-
 5 files changed, 22 insertions(+), 57 deletions(-)
