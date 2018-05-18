Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nShV4L6zzF29w
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 22:50:50 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4IChsls061529
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 08:50:47 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j1w8xdf1t-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 08:50:47 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Fri, 18 May 2018 13:50:46 +0100
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: ast@kernel.org, daniel@iogearbox.net
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 naveen.n.rao@linux.vnet.ibm.com, mpe@ellerman.id.au,
 jakub.kicinski@netronome.com
Subject: [PATCH bpf v2 0/6] bpf: enhancements for multi-function programs
Date: Fri, 18 May 2018 18:20:33 +0530
Message-Id: <20180518125039.6500-1-sandipan@linux.vnet.ibm.com>
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

v2:
 - Incorporate review comments from Jakub

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
 tools/bpf/bpftool/prog.c          | 29 ++++++++++++++
 tools/bpf/bpftool/xlated_dumper.c | 10 ++++-
 tools/bpf/bpftool/xlated_dumper.h |  2 +
 tools/include/uapi/linux/bpf.h    |  2 +
 8 files changed, 179 insertions(+), 23 deletions(-)

-- 
2.14.3
