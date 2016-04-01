Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbxjB2kC8zDqDV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 21:01:02 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 1 Apr 2016 20:00:58 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C65A53578056
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 21:00:53 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u31A0jQ258654812
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 21:00:53 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u31A0KIL002312
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 21:00:21 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: oss@buserror.net, Matt Evans <matt@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, Alexei Starovoitov <ast@fb.com>,
 "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: [RFC PATCH 3/6] ppc: bpf/jit: Introduce rotate immediate instructions
Date: Fri,  1 Apr 2016 15:28:28 +0530
Message-Id: <3fa6d5f242ed57ed213f9c99e2eb431e0c7d274a.1459504223.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1459504222.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1459504222.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1459504222.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1459504222.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since we will be using the rotate immediate instructions for extended
BPF JIT, let's introduce macros for the same. And since the shift
immediate operations use the rotate immediate instructions, let's redo
those macros to use the newly introduced instructions.

Cc: Matt Evans <matt@ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Alexei Starovoitov <ast@fb.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-opcode.h |  2 ++
 arch/powerpc/net/bpf_jit.h            | 20 +++++++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 7ab04fc..95fd811 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -271,6 +271,8 @@
 #define __PPC_SH(s)	__PPC_WS(s)
 #define __PPC_MB(s)	(((s) & 0x1f) << 6)
 #define __PPC_ME(s)	(((s) & 0x1f) << 1)
+#define __PPC_MB64(s)	(__PPC_MB(s) | ((s) & 0x20))
+#define __PPC_ME64(s)	__PPC_MB64(s)
 #define __PPC_BI(s)	(((s) & 0x1f) << 16)
 #define __PPC_CT(t)	(((t) & 0x0f) << 21)
 
diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 4c1e055..95d0e38 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -210,18 +210,20 @@ DECLARE_LOAD_FUNC(sk_load_byte_msh);
 				     ___PPC_RS(a) | ___PPC_RB(s))
 #define PPC_SRW(d, a, s)	EMIT(PPC_INST_SRW | ___PPC_RA(d) |	      \
 				     ___PPC_RS(a) | ___PPC_RB(s))
+#define PPC_RLWINM(d, a, i, mb, me)	EMIT(PPC_INST_RLWINM | ___PPC_RA(d) | \
+					___PPC_RS(a) | __PPC_SH(i) |	      \
+					__PPC_MB(mb) | __PPC_ME(me))
+#define PPC_RLDICR(d, a, i, me)		EMIT(PPC_INST_RLDICR | ___PPC_RA(d) | \
+					___PPC_RS(a) | __PPC_SH(i) |	      \
+					__PPC_ME64(me) | (((i) & 0x20) >> 4))
+
 /* slwi = rlwinm Rx, Ry, n, 0, 31-n */
-#define PPC_SLWI(d, a, i)	EMIT(PPC_INST_RLWINM | ___PPC_RA(d) |	      \
-				     ___PPC_RS(a) | __PPC_SH(i) |	      \
-				     __PPC_MB(0) | __PPC_ME(31-(i)))
+#define PPC_SLWI(d, a, i)	PPC_RLWINM(d, a, i, 0, 31-(i))
 /* srwi = rlwinm Rx, Ry, 32-n, n, 31 */
-#define PPC_SRWI(d, a, i)	EMIT(PPC_INST_RLWINM | ___PPC_RA(d) |	      \
-				     ___PPC_RS(a) | __PPC_SH(32-(i)) |	      \
-				     __PPC_MB(i) | __PPC_ME(31))
+#define PPC_SRWI(d, a, i)	PPC_RLWINM(d, a, 32-(i), i, 31)
 /* sldi = rldicr Rx, Ry, n, 63-n */
-#define PPC_SLDI(d, a, i)	EMIT(PPC_INST_RLDICR | ___PPC_RA(d) |	      \
-				     ___PPC_RS(a) | __PPC_SH(i) |	      \
-				     __PPC_MB(63-(i)) | (((i) & 0x20) >> 4))
+#define PPC_SLDI(d, a, i)	PPC_RLDICR(d, a, i, 63-(i))
+
 #define PPC_NEG(d, a)		EMIT(PPC_INST_NEG | ___PPC_RT(d) | ___PPC_RA(a))
 
 /* Long jump; (unconditional 'branch') */
-- 
2.7.4
