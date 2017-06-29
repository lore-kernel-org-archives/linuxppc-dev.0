Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wz6cS102ZzDr4T
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 03:49:43 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5THmoXb021541
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 13:49:38 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bd1dtf2r5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 13:49:37 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 30 Jun 2017 03:49:35 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5THnW202032026
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 03:49:32 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5THnWSE030275
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 03:49:32 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 0/7] powerpc: build out kprobes blacklist -- series 3
Date: Thu, 29 Jun 2017 23:19:13 +0530
Message-Id: <cover.1498755960.git.naveen.n.rao@linux.vnet.ibm.com>
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

Changes since v4:
  - Patch 5 changed to move system_call_exit() symbol before the mtmsrd,
    along with an explanation for its placement.
  - Patch 7 reverted to previous version moving the new symbol before
    the mtmsrd as well.
  - All other patches remain unchanged from v4.

v4:
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg120106.html

(*) series 2:
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg117562.html


- Naveen


Naveen N. Rao (7):
  powerpc64/elfv1: Only dereference function descriptor for non-text
    symbols
  powerpc/64s: Convert .L__replay_interrupt_return to a local label
  powerpc/64s: Blacklist system_call() and system_call_common() from
    kprobes
  powerpc/64s: Move system_call() symbol to just after setting MSR_EE
  powerpc/64s: Un-blacklist system_call() from kprobes
  powerpc/64s: Blacklist functions invoked on a trap
  powerpc/64s: Blacklist rtas entry/exit from kprobes

 arch/powerpc/include/asm/code-patching.h | 10 +++-
 arch/powerpc/kernel/entry_64.S           | 87 +++++++++++++++++++++-----------
 arch/powerpc/kernel/exceptions-64s.S     |  6 ++-
 arch/powerpc/kernel/traps.c              |  3 ++
 4 files changed, 73 insertions(+), 33 deletions(-)

-- 
2.13.1
