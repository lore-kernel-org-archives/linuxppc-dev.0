Return-Path: <srs0=b8ek=3p=linux.vnet.ibm.com=sachinp@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzsbl4fBqzDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 18:06:27 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vzsbl3yJMz8sxT
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 18:06:27 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vzsbl0qt3z9s7s
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2017 18:06:26 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v37840sm062947
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2017 04:06:22 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29p61qtn2h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 07 Apr 2017 04:06:21 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sachinp@linux.vnet.ibm.com>;
 Fri, 7 Apr 2017 18:06:19 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v37868BV42074284
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2017 18:06:16 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3785hDa003001
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2017 18:05:44 +1000
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: kselftest:lost_exception_test failure with 4.11.0-rc5
Date: Fri, 7 Apr 2017 13:35:26 +0530
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Message-Id: <2868072E-9D12-4BE0-94F6-FE9C33A3766F@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have run into few instances where the lost_exception_test from
powerpc kselftest fails with SIGABRT. Following o/p is against
4.11.0-rc5. The failure is intermittent. 

When the test fails it is killed due to SIGABRT.

# ./lost_exception_test 
test: lost_exception
tags: git_version:unknown
Binding to cpu 8
main test running as pid 9208
EBB Handler is at 0x10003dcc
!! killing lost_exception
ebb_state:
  ebb_count    = 191529
  spurious     = 0
  negative     = 0
  no_overflow  = 0
  pmc[1] count = 0x0
  pmc[2] count = 0x0
  pmc[3] count = 0x0
  pmc[4] count = 0x4c1b707
  pmc[5] count = 0x0
  pmc[6] count = 0x0
HW state:
MMCR0 0x0000000080000080 FC PMAO 
MMCR2 0x0000000000000000
EBBHR 0x0000000010003dcc
BESCR 0x8000000100000000 GE PMAE 
PMC1  0x0000000000000000
PMC2  0x0000000000000000
PMC3  0x0000000000000000
PMC4  0x0000000080000000
PMC5  0x0000000088d4f0c8
PMC6  0x000000001e49da22
SIAR  0x00003fffad60a608
!! child died by signal 6
failure: lost_exception
#

Thanks
-Sachin
