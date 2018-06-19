Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418wr41CqBzF0WP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 15:04:51 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5J5420I006330
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 01:04:49 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jpna83vqc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 01:04:49 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Tue, 19 Jun 2018 06:04:47 +0100
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com,
 npiggin@gmail.com, mpe@ellerman.id.au,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH 0/3] powernv/cpuidle Device-tree parsing cleanup 
Date: Tue, 19 Jun 2018 10:34:25 +0530
Message-Id: <1529384668-27548-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Device-tree parsed multiple time in powernv cpuidle and powernv
hotplug code. 

First to identify supported flags, secondly, to identify deepest_state
and first deep state, Thirdly , during cpudidle init to find the available
idle states. Any change in device-tree format will lead to make changes in
these 3 places.

This series adds code to parse device tree once and save in global structure.

Akshay Adiga (3):
  powernv/cpuidle: Parse dt idle properties into global structure
  cpuidle/powernv: Change platform init to avoid reparsing dt
  powernv/cpuidle: Use parsed device tree values for cpuidle_init

 arch/powerpc/include/asm/cpuidle.h    |  16 +++
 arch/powerpc/platforms/powernv/idle.c | 214 +++++++++++++++++++++-------------
 drivers/cpuidle/cpuidle-powernv.c     |  49 +++++---
 3 files changed, 182 insertions(+), 97 deletions(-)

-- 
2.5.5
