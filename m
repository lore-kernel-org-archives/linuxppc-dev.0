Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZVNg1kzBzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 02:26:58 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5MGOcoe113429
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 12:26:56 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23qd1h98g6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 12:26:56 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 22 Jun 2016 21:56:52 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 257AFE0061
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 22:00:34 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5MGQoXv2687318
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 21:56:50 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5MGQesW024560
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 21:56:49 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: "Matt Evans" <matt@ozlabs.org>, Denis Kirjanov <kda@linux-powerpc.org>,
 "Paul Mackerras" <paulus@samba.org>, "Alexei Starovoitov" <ast@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>,
 "Ananth N Mavinakayanahalli" <ananth@in.ibm.com>,
 Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
Subject: [PATCHv2 0/7] eBPF JIT for PPC64
Date: Wed, 22 Jun 2016 21:55:00 +0530
Message-Id: <cover.1466612260.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v2 changes:
  - Patch 1 is new and is cc'ed -stable
  - Patch 7 has 3 changes:
    - Include asm/kprobes.h to resolve a build error reported by Michael
    Ellerman
    - Remove check for fp in bpf_int_jit_compile() as suggested by Daniel
    Borkmann
    - Fix a crash on Cell processor reported by Michael Ellerman by
    changing image to be a u8 pointer for proper size calculation.


Earlier cover letter:
Implement extended BPF JIT for ppc64. We retain the classic BPF JIT for
ppc32 and move ppc64 BE/LE to use the new JIT. Classic BPF filters will
be converted to extended BPF (see convert_filter()) and JIT'ed with the
new compiler.

Most of the existing macros are retained and fixed/enhanced where
appropriate. Patches 1-4 are geared towards this.

Patch 5 breaks out the classic BPF JIT specifics into a separate
bpf_jit32.h header file, while retaining all the generic instruction
macros in bpf_jit.h.

Patch 6 implements eBPF JIT for ppc64.

Since the RFC patchset [1], powerpc JIT has now gained support for skb
access helpers and now passes all tests in test_bpf.ko. Review comments
on the RFC patches have been addressed (use of an ABI macro [2] and use
of bpf_jit_binary_alloc()), along with a few other generic fixes and
updates.

Prominent TODOs:
 - implement BPF tail calls
 - support for BPF constant blinding

Please note that patch [2] is a pre-requisite for this patchset, and is
not yet upstream.


- Naveen

[1] http://thread.gmane.org/gmane.linux.kernel/2188694
[2] http://thread.gmane.org/gmane.linux.ports.ppc.embedded/96514


Naveen N. Rao (7):
  ppc bpf/jit: Disable classic BPF JIT on ppc64le
  ppc: bpf/jit: Fix/enhance 32-bit Load Immediate implementation
  ppc: bpf/jit: Optimize 64-bit Immediate loads
  ppc: bpf/jit: Introduce rotate immediate instructions
  ppc: bpf/jit: A few cleanups
  ppc: bpf/jit: Isolate classic BPF JIT specifics into a separate header
  ppc: ebpf/jit: Implement JIT compiler for extended BPF

 arch/powerpc/Kconfig                  |   3 +-
 arch/powerpc/include/asm/asm-compat.h |   2 +
 arch/powerpc/include/asm/ppc-opcode.h |  22 +-
 arch/powerpc/net/Makefile             |   4 +
 arch/powerpc/net/bpf_jit.h            | 235 ++++-----
 arch/powerpc/net/bpf_jit32.h          | 139 +++++
 arch/powerpc/net/bpf_jit64.h          | 102 ++++
 arch/powerpc/net/bpf_jit_asm.S        |   2 +-
 arch/powerpc/net/bpf_jit_asm64.S      | 180 +++++++
 arch/powerpc/net/bpf_jit_comp.c       |  10 +-
 arch/powerpc/net/bpf_jit_comp64.c     | 954 ++++++++++++++++++++++++++++++++++
 11 files changed, 1502 insertions(+), 151 deletions(-)
 create mode 100644 arch/powerpc/net/bpf_jit32.h
 create mode 100644 arch/powerpc/net/bpf_jit64.h
 create mode 100644 arch/powerpc/net/bpf_jit_asm64.S
 create mode 100644 arch/powerpc/net/bpf_jit_comp64.c

-- 
2.8.2
