Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w31CV5zMDzDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 20:59:50 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3CAwZdR035315
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 06:59:38 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29seq8jxp3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 06:59:38 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 20:59:35 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3CAxNn253477436
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 20:59:31 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3CAwt0V019117
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 20:58:55 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] powerpc: a few kprobe fixes and refactoring
Date: Wed, 12 Apr 2017 16:28:23 +0530
Message-Id: <cover.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v1:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1334843.html

For v2, this series has been re-ordered and rebased on top of
powerpc/next so as to make it easier to resolve conflicts with -tip. No
other changes.

- Naveen


Naveen N. Rao (5):
  kprobes: convert kprobe_lookup_name() to a function
  powerpc: kprobes: fix handling of function offsets on ABIv2
  powerpc: introduce a new helper to obtain function entry points
  powerpc: kprobes: factor out code to emulate instruction into a helper
  powerpc: kprobes: emulate instructions on kprobe handler re-entry

 arch/powerpc/include/asm/code-patching.h |  37 ++++++++++
 arch/powerpc/include/asm/kprobes.h       |  53 --------------
 arch/powerpc/kernel/kprobes.c            | 119 +++++++++++++++++++++++++------
 arch/powerpc/kernel/optprobes.c          |   6 +-
 include/linux/kprobes.h                  |   1 +
 kernel/kprobes.c                         |  21 +++---
 6 files changed, 147 insertions(+), 90 deletions(-)

-- 
2.12.1
