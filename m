Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbxhv1TPjzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 21:00:47 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 1 Apr 2016 20:00:42 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B96E72CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 21:00:25 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u31A0HTF3146058
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 21:00:25 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u319xqs7001103
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 20:59:52 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: oss@buserror.net, "Matt Evans" <matt@ozlabs.org>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Paul Mackerras" <paulus@samba.org>, "Alexei Starovoitov" <ast@fb.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Ananth N Mavinakayanahalli" <ananth@in.ibm.com>
Subject: [RFC PATCH 0/6] eBPF JIT for PPC64
Date: Fri,  1 Apr 2016 15:28:25 +0530
Message-Id: <cover.1459504222.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement extended BPF JIT for ppc64. We retain the classic BPF JIT for
ppc32 and move ppc64 BE/LE to use the new JIT. Classic BPF filters will
be converted to extended BPF (see convert_filter()) and JIT'ed with the
new compiler.

Most of the existing macros are retained and fixed/enhanced where
appropriate. Patches 1-4 are geared towards this.

Patch 5 breaks out the classic BPF JIT specifics into a separate
bpf_jit32.h header file, while retaining all the generic instruction
macros in bpf_jit.h. Most of these macros can potentially be generalized
and moved to more common code (tagged with a TODO in patch 6).

Patch 6 implements eBPF JIT for ppc64.

This is still *early* *RFC* and there are still a few instruction
classes to be JIT'ed. I am posting this in advance so as to get early
feedback. Kindly review the same and if possible, try it out and let me
know how it goes!


- Naveen

Naveen N. Rao (6):
  ppc: bpf/jit: Fix/enhance 32-bit Load Immediate implementation
  ppc: bpf/jit: Optimize 64-bit Immediate loads
  ppc: bpf/jit: Introduce rotate immediate instructions
  ppc: bpf/jit: A few cleanups
  ppc: bpf/jit: Isolate classic BPF JIT specifics into a separate header
  ppc: ebpf/jit: Implement JIT compiler for extended BPF

 arch/powerpc/include/asm/ppc-opcode.h |  21 +-
 arch/powerpc/net/Makefile             |   4 +
 arch/powerpc/net/bpf_jit.h            | 251 +++++------
 arch/powerpc/net/bpf_jit32.h          | 140 ++++++
 arch/powerpc/net/bpf_jit64.h          |  58 +++
 arch/powerpc/net/bpf_jit_asm.S        |   2 +-
 arch/powerpc/net/bpf_jit_comp.c       |  10 +-
 arch/powerpc/net/bpf_jit_comp64.c     | 828 ++++++++++++++++++++++++++++++++++
 8 files changed, 1163 insertions(+), 151 deletions(-)
 create mode 100644 arch/powerpc/net/bpf_jit32.h
 create mode 100644 arch/powerpc/net/bpf_jit64.h
 create mode 100644 arch/powerpc/net/bpf_jit_comp64.c

-- 
2.7.4
