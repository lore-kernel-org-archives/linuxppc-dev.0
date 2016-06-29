Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfY3d6hFLzDqw3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 16:41:17 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rfY3d1FWKz9t0X
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 16:41:17 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5T6d5Bg102981
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 02:41:15 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23v09pr0mm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 02:41:15 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 29 Jun 2016 16:41:12 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 217962BB0057
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 16:41:10 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5T6fAbL21037136
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 16:41:10 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5T6f9mQ019238
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 16:41:09 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: anton@samba.org, mikey@neuling.org
Subject: [RFC 0/3] Enable MSR_TM lazily
Date: Wed, 29 Jun 2016 16:34:33 +1000
Message-Id: <20160629063436.10003-1-cyrilbur@gmail.com>
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
TM: http://patchwork.ozlabs.org/patch/631959/
I have pushed a branch to github to help with reviews:
https://github.com/cyrilbur-ibm/linux/tree/tm_lazy

Cyril Bur (3):
  selftests/powerpc: Add test to check TM ucontext creation
  powerpc: tm: Add TM Unavailable Exception
  powerpc: tm: Enable transactional memory (TM) lazily for userspace

 arch/powerpc/include/asm/processor.h               |   1 +
 arch/powerpc/kernel/process.c                      |  30 ++++--
 arch/powerpc/kernel/traps.c                        |  33 +++++++
 .../selftests/powerpc/tm/tm-signal-context-chk.c   | 102 +++++++++++++++++++++
 4 files changed, 158 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk.c

-- 
2.9.0
