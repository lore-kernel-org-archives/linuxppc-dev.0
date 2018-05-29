Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wCrk5W4DzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 22:36:22 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4TCYjvp084078
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 08:36:20 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j95avcpp7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 08:36:19 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 29 May 2018 13:36:17 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Masami Hiramatsu <mhiramat@kernel.org>, Josef Bacik <jbacik@fb.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] error-injection: simplify code and powerpc support
Date: Tue, 29 May 2018 18:06:01 +0530
Message-Id: <cover.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The first patch simplifies code around function error-injection by 
limiting the need for arch-specific helpers. The second patch adds 
support for powerpc.

- Naveen

Naveen N. Rao (2):
  error-injection: Simplify arch specific helpers
  powerpc: Add support for function error injection

 arch/powerpc/Kconfig                       |  1 +
 arch/powerpc/include/asm/error-injection.h |  9 +++++++++
 arch/powerpc/include/asm/ptrace.h          |  5 +++++
 arch/x86/include/asm/error-injection.h     |  6 +-----
 arch/x86/lib/Makefile                      |  1 -
 arch/x86/lib/error-inject.c                | 20 --------------------
 include/asm-generic/error-injection.h      |  6 ++++++
 include/linux/error-injection.h            |  1 +
 kernel/fail_function.c                     |  2 +-
 kernel/trace/bpf_trace.c                   |  2 +-
 lib/error-inject.c                         |  8 ++++++++
 11 files changed, 33 insertions(+), 28 deletions(-)
 create mode 100644 arch/powerpc/include/asm/error-injection.h
 delete mode 100644 arch/x86/lib/error-inject.c

-- 
2.17.0
