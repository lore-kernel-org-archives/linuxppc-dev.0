Return-Path: <jallen@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlghC5DLMzDr0W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 00:57:15 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u67Es93D111528
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 10:57:13 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xmymf4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 10:57:13 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.vnet.ibm.com>;
 Thu, 7 Jul 2016 08:57:12 -0600
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
From: John Allen <jallen@linux.vnet.ibm.com>
Subject: [PATCH 0/3] powerpc/pseries: Add pseries hotplug queue and
 PowerVM/PowerKVM use cases
Date: Thu, 7 Jul 2016 09:57:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <4cf3edf2-fc24-5989-ae5d-b451a2323cf2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series introduces a new workqueue for handling hotplug events. On
PowerKVM guests, this provides a work deferral mechanism to avoid
processing hotplug events in interrupt context. On PowerVM lpars, this
will be used to ensure that hotplug events initiated from the HMC and
from PRRN events are handled and serialized properly.

---

John Allen (3):
      powerpc/pseries: Add pseries hotplug workqueue
      powerpc/pseries: Add support for hotplug interrupt source
      powerpc/pseries: Use kernel hotplug queue for PowerVM hotplug events


 arch/powerpc/platforms/pseries/dlpar.c   |   57 +++++++++++++++++++++++++++++-
 arch/powerpc/platforms/pseries/pseries.h |    2 +
 arch/powerpc/platforms/pseries/ras.c     |   38 ++++++++++++++++++++
 3 files changed, 96 insertions(+), 1 deletion(-)

--
John Allen
