Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wC82Z2fD3zDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 02:35:18 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3PGXsx2020383
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 12:35:13 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a244n25vj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 12:35:13 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 26 Apr 2017 02:35:10 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3PGYx9Q38928428
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 02:35:07 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3PGYTFo013668
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 02:34:30 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/4] powerpc: build out kprobes blacklist
Date: Tue, 25 Apr 2017 22:04:05 +0530
Message-Id: <cover.1493137432.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is the second in the series of patches to build out an appropriate
kprobes blacklist. This series blacklists system_call() and functions
involved when handling the trap itself. Not everything is covered, but
this is the first set of functions that I have tested with. More
patches to follow once I expand my tests.

I have converted many labels into private -- these are labels that I
felt are not necessary to read stack traces. If any of those are
important to have, please let me know.

- Naveen

Naveen N. Rao (4):
  powerpc/kprobes: cleanup system_call_common and blacklist it from
    kprobes
  powerpc/kprobes: un-blacklist system_call() from kprobes
  powerpc/kprobes: blacklist functions invoked on a trap
  powerpc/kprobes: blacklist functions involved when returning from
    exception

 arch/powerpc/kernel/entry_64.S       | 94 +++++++++++++++++++-----------------
 arch/powerpc/kernel/exceptions-64s.S |  1 +
 arch/powerpc/kernel/time.c           |  3 ++
 arch/powerpc/kernel/traps.c          |  3 ++
 arch/powerpc/platforms/pseries/dtl.c |  2 +
 5 files changed, 60 insertions(+), 43 deletions(-)

-- 
2.12.1
