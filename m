Return-Path: <jallen@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Rw4X2fqKzDr10
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jul 2018 00:22:32 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6DEEGTf138047
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 10:22:29 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k6vqntx0h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 10:22:28 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.ibm.com>;
 Fri, 13 Jul 2018 08:22:28 -0600
From: John Allen <jallen@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com
Subject: [PATCH 0/2] powerpc/pseries: Improve serialization of PRRN events
Date: Fri, 13 Jul 2018 09:22:22 -0500
Message-Id: <20180713142224.4516-1-jallen@linux.ibm.com>
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

John Allen (2):
  pseries/prrn: Avoid blocking rtas polling handling multiple PRRN
    events
  pseries/prrn: Wait for completion of hotplug events during PRRN
    handling

 arch/powerpc/kernel/rtasd.c               | 11 ++++++++---
 arch/powerpc/platforms/pseries/mobility.c |  5 ++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.17.1
