Return-Path: <ravi.bangoria@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40q5FH4jxkzF0Vv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 14:21:23 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4L4J42O113839
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 00:21:20 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j3hvb1k34-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 00:21:20 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.ibm.com>;
 Mon, 21 May 2018 05:21:18 +0100
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: mpe@ellerman.id.au, mikey@neuling.org
Cc: benh@kernel.crashing.org, paulus@samba.org,
 naveen.n.rao@linux.vnet.ibm.com, matthew.brown.dev@gmail.com,
 cyrilbur@gmail.com, anton@samba.org, sandipan@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 0/3] powerpc/sstep: Fix kernel crash if VSX is not present
Date: Mon, 21 May 2018 09:51:05 +0530
Message-Id: <20180521042108.8318-1-ravi.bangoria@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a next version to RFC patch:
  https://lkml.org/lkml/2018/5/16/36

kbuild test robot reported the following build failure with RFC.

   error: unused variable 'type' [-Werror=unused-variable]
     int type;
         ^~~~

I've fixed it along with following changes.

1st patch introduces a new macro to simplify code a bit.
2nd patch fixes the kernel crash when VSX is not supported
    or disabled.
3rd patch fixes emulate_step() tests

Ravi Bangoria (3):
  powerpc/sstep: Introduce GETTYPE macro
  powerpc/sstep: Fix kernel crash if VSX is not present
  powerpc/sstep: Fix emulate_step test if VSX not present

 arch/powerpc/include/asm/sstep.h     |  2 ++
 arch/powerpc/kernel/align.c          |  2 +-
 arch/powerpc/lib/sstep.c             | 15 ++++++++++++---
 arch/powerpc/lib/test_emulate_step.c | 21 +++++++++++++++------
 4 files changed, 30 insertions(+), 10 deletions(-)

-- 
2.16.2
