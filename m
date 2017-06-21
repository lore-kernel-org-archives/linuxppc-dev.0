Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtD530xnvzDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:39:02 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5LIcZOg004323
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 14:38:59 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b7p1kjs78-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 14:38:59 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 22 Jun 2017 04:38:56 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5LIcroh2163052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:38:53 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5LIcqPf017644
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:38:53 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 0/6] powerpc: build out kprobes blacklist -- series 3
Date: Thu, 22 Jun 2017 00:08:36 +0530
Message-Id: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is the third in the series of patches to build out an appropriate
kprobes blacklist for powerpc. Since posting the second series (*),
there have been related changes to the code and I have brought that
series forward to account for those changes. As such, all patches from
the second series are included in this patchset.

This patchset now ensures that the newly added multiple kprobes test in
the ftrace testsuite passes on powerpc64. Tested on both Elfv1 and
Elfv2.

Changes since series 2 v2:
  - Patches 1, 2 and 6 are new.
  - Patch 3 now additionally converts syscall_restore_math() to a local
    symbol.
  - Patch 5 additionally blacklists __replay_interrupt.

(*)
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg117562.html


- Naveen


Naveen N. Rao (6):
  powerpc64/elfv1: Validate function pointer address in the function
    descriptor
  powerpc/64s: Convert .L__replay_interrupt_return to a local label
  powerpc/64s: Blacklist system_call() and system_call_common() from
    kprobes
  powerpc/64s: Un-blacklist system_call() from kprobes
  powerpc/64s: Blacklist functions invoked on a trap
  powerpc/64s: Blacklist rtas entry/exit from kprobes

 arch/powerpc/include/asm/code-patching.h | 10 +++-
 arch/powerpc/kernel/entry_64.S           | 81 ++++++++++++++++++--------------
 arch/powerpc/kernel/exceptions-64s.S     |  6 ++-
 arch/powerpc/kernel/traps.c              |  3 ++
 4 files changed, 63 insertions(+), 37 deletions(-)

-- 
2.13.1
