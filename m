Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPG1d0S0DzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 01:38:28 +1000 (AEST)
Received: from pps.filterd (m0075420.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u57FXtbq028861
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jun 2016 11:38:26 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23duqske8j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jun 2016 11:38:26 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 7 Jun 2016 21:08:22 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 1ADE7394005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 21:08:19 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u57FcIsU15991022
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jun 2016 21:08:18 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u57FakKs009989
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jun 2016 21:08:17 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, mpe@ellerman.id.au
Cc: Matt Evans <matt@ozlabs.org>, Denis Kirjanov <kda@linux-powerpc.org>,
 Paul Mackerras <paulus@samba.org>, Alexei Starovoitov <ast@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: [PATCH 3/6] ppc: bpf/jit: Introduce rotate immediate instructions
Date: Tue,  7 Jun 2016 19:02:20 +0530
In-Reply-To: <cover.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <7189f933a997dcb069272880e5529bf87e031323.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
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
Cc: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Alexei Starovoitov <ast@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-opcode.h |  2 ++
 arch/powerpc/net/bpf_jit.h            | 20 +++++++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 1d035c1..fd8d640 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -272,6 +272,8 @@
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
2.8.2
