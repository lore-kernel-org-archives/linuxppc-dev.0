Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wD9Lz33tbzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 18:38:03 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3R8YCS7006915
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 04:37:55 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a2xcmjev5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 04:37:55 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 27 Apr 2017 18:37:52 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3R8bgFr5964048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 18:37:50 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3R8bCWu030254
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 18:37:12 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/3] powerpc: build out kprobes blacklist
Date: Thu, 27 Apr 2017 14:06:51 +0530
Message-Id: <cover.1493274843.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v2 changes:
- Patches 3 and 4 from the previous series have been merged.
- Updated to no longer blacklist functions involved with stolen time
  accounting.

v1:
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg117514.html
--
This is the second in the series of patches to build out an appropriate
kprobes blacklist. This series blacklists system_call() and functions
involved when handling the trap itself. Not everything is covered, but
this is the first set of functions that I have tested with. More
patches to follow once I expand my tests.

I have converted many labels into private -- these are labels that I
felt are not necessary to read stack traces. If any of those are
important to have, please let me know.

- Naveen

Naveen N. Rao (3):
  powerpc/kprobes: cleanup system_call_common and blacklist it from
    kprobes
  powerpc/kprobes: un-blacklist system_call() from kprobes
  powerpc/kprobes: blacklist functions invoked on a trap

 arch/powerpc/kernel/entry_64.S       | 94 +++++++++++++++++++-----------------
 arch/powerpc/kernel/exceptions-64s.S |  1 +
 arch/powerpc/kernel/traps.c          |  3 ++
 3 files changed, 55 insertions(+), 43 deletions(-)

-- 
2.12.2
