Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7Qv51Z6zzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 01:30:56 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JFTQpI141881
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 11:30:54 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29x78e348p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 11:30:53 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 20 Apr 2017 01:30:51 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3JFUevm51970252
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 01:30:48 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3JFUBKm026726
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 01:30:12 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] powerpc: kprobes: blacklist exception vectors
Date: Wed, 19 Apr 2017 20:59:50 +0530
Message-Id: <cover.1492614257.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is the first of a series of patches to build up a suitable kprobes
blacklist. This series only blacklists the exception vectors.

While I have more patches in the works to blacklist other symbols, I
wanted to get some early feedback on these two patches to ensure that
the approach is ok. So, I'm posting these right away.

I'd especially appreciate a review of the first patch and feedback on
whether it does the right thing with/without relocation. My tests
didn't reveal any issues.


Thanks,
Naveen

Naveen N. Rao (2):
  powerpc: kprobes: blacklist exception handlers
  powerpc: kprobes: blacklist exception common handlers

 arch/powerpc/include/asm/head-64.h  | 1 +
 arch/powerpc/include/asm/sections.h | 1 +
 arch/powerpc/kernel/kprobes.c       | 9 +++++++++
 arch/powerpc/kernel/vmlinux.lds.S   | 2 ++
 4 files changed, 13 insertions(+)

-- 
2.12.1
