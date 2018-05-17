Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mhRQ3fvLzF1dH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 16:36:50 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4H6aSP2045606
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 02:36:48 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j14bbgpka-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 02:36:44 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Thu, 17 May 2018 07:35:53 +0100
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: ast@kernel.org, daniel@iogearbox.net
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH bpf 0/6] bpf: enhancements for multi-function programs
Date: Thu, 17 May 2018 12:05:42 +0530
Message-Id: <20180517063548.6373-1-sandipan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series introduces the following:

[1] Support for bpf-to-bpf function calls in the powerpc64 JIT compiler.

[2] Provide a way for resolving function calls because of the way JITed
    images are allocated in powerpc64.

[3] Fix to get JITed instruction dumps for multi-function programs from
    the bpf system call.

Sandipan Das (6):
  bpf: support 64-bit offsets for bpf function calls
  bpf: powerpc64: add JIT support for multi-function programs
  bpf: get kernel symbol addresses via syscall
  tools: bpf: sync bpf uapi header
  tools: bpftool: resolve calls without using imm field
  bpf: fix JITed dump for multi-function programs via syscall

 arch/powerpc/net/bpf_jit_comp64.c | 79 ++++++++++++++++++++++++++++++++++-----
 include/uapi/linux/bpf.h          |  2 +
 kernel/bpf/syscall.c              | 56 ++++++++++++++++++++++++---
 kernel/bpf/verifier.c             | 22 +++++++----
 tools/bpf/bpftool/prog.c          | 31 +++++++++++++++
 tools/bpf/bpftool/xlated_dumper.c | 24 ++++++++----
 tools/bpf/bpftool/xlated_dumper.h |  2 +
 tools/include/uapi/linux/bpf.h    |  2 +
 8 files changed, 189 insertions(+), 29 deletions(-)

-- 
2.14.3
