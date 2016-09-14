Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYvDP45nWzDsW6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 18:03:01 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8E82uXq103325
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 04:02:59 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25exb7jyq4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 04:02:58 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 14 Sep 2016 18:02:36 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 69C752CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 18:02:33 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8E82XcJ61931628
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 18:02:33 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8E82XKS006543
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 18:02:33 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: mikey@neuling.org, anton@samba.org, wei.guo.simon@gmail.com
Subject: [PATCH 0/2] Enable MSR_TM lazily
Date: Wed, 14 Sep 2016 18:02:14 +1000
Message-Id: <20160914080216.13833-1-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the kernel checks to see if the hardware is transactional
memory capable and always enables the MSR_TM bit. The problem with
this is that the TM related SPRs become available to userspace,
requiring them to be switched between processes. It turns out these
SPRs are expensive to read and write and if a thread doesn't use TM
(or worse yet isn't even TM aware) then context switching incurs this
penalty for nothing.

The solution here is to leave the MSR_TM bit disabled and enable it
more 'on demand'. Leaving MSR_TM disabled cause a thread to take a
facility unavailable fault if and when it does decide to use TM. As
with recent updates to the FPU, VMX and VSX units the MSR_TM bit will
be enabled upon taking the fault and left on for some time afterwards
as the assumption is that if a thread used TM ones it may well use it
again. The kernel will turn the MSR_TM bit off after some number of
context switches of that thread.

Performance numbers haven't been completely gathered as yet but early
runs of tools/testing/selftests/powerpc/benchmarks/context_switch
(which doesn't use TM) yields a jump from ~160000 switches per second
to ~180000 switches per second with patch 3/3 applied.

These patches will need to be applied on top of my recent rework of
TM: http://patchwork.ozlabs.org/patch/666094/ 
I have pushed a branch to github to help with reviews:
https://github.com/cyrilbur-ibm/linux/tree/tm_lazy_v1

Changes since RFC:
	Fixed my unability to use & and | correctly.
	 - Spotted by Laurent Dufour, thanks
	Dropped the selftest patch as it was merged as part of a previous
	  series

Cyril Bur (2):
  powerpc: tm: Add TM Unavailable Exception
  powerpc: tm: Enable transactional memory (TM) lazily for userspace

 arch/powerpc/include/asm/processor.h |  1 +
 arch/powerpc/kernel/process.c        | 28 +++++++++++++++++++++++-----
 arch/powerpc/kernel/traps.c          | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 5 deletions(-)

-- 
2.9.3
