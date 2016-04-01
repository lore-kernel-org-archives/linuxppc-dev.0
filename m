Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbxjN64hlzDqJ9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 21:01:12 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 1 Apr 2016 20:01:10 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4C4D83578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 21:01:00 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u31A0qH79437216
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 21:01:00 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u31A0QOI002487
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 21:00:27 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: oss@buserror.net, Matt Evans <matt@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, Alexei Starovoitov <ast@fb.com>,
 "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: [RFC PATCH 4/6] ppc: bpf/jit: A few cleanups
Date: Fri,  1 Apr 2016 15:28:29 +0530
Message-Id: <e695173a02be5c643be7c7fe16a40b67ca6216bc.1459504224.git.naveen.n.rao@linux.vnet.ibm.com>
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

1. Per the ISA, ADDIS actually uses RT, rather than RS. Though
the result is the same, make the usage clear.
2. The multiply instruction used is a 32-bit multiply. Rename PPC_MUL()
to PPC_MULW() to make the same clear.
3. PPC_STW[U] take the entire 16-bit immediate value and do not require
word-alignment, per the ISA. Change the macros to use IMM_L().
4. A few white-space cleanups to satisfy checkpatch.pl.

Cc: Matt Evans <matt@ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Alexei Starovoitov <ast@fb.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit.h      | 13 +++++++------
 arch/powerpc/net/bpf_jit_comp.c |  8 ++++----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 95d0e38..9041d3f 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -83,7 +83,7 @@ DECLARE_LOAD_FUNC(sk_load_byte_msh);
  */
 #define IMM_H(i)		((uintptr_t)(i)>>16)
 #define IMM_HA(i)		(((uintptr_t)(i)>>16) +			      \
-				 (((uintptr_t)(i) & 0x8000) >> 15))
+					(((uintptr_t)(i) & 0x8000) >> 15))
 #define IMM_L(i)		((uintptr_t)(i) & 0xffff)
 
 #define PLANT_INSTR(d, idx, instr)					      \
@@ -99,16 +99,16 @@ DECLARE_LOAD_FUNC(sk_load_byte_msh);
 #define PPC_MR(d, a)		PPC_OR(d, a, a)
 #define PPC_LI(r, i)		PPC_ADDI(r, 0, i)
 #define PPC_ADDIS(d, a, i)	EMIT(PPC_INST_ADDIS |			      \
-				     ___PPC_RS(d) | ___PPC_RA(a) | IMM_L(i))
+				     ___PPC_RT(d) | ___PPC_RA(a) | IMM_L(i))
 #define PPC_LIS(r, i)		PPC_ADDIS(r, 0, i)
 #define PPC_STD(r, base, i)	EMIT(PPC_INST_STD | ___PPC_RS(r) |	      \
 				     ___PPC_RA(base) | ((i) & 0xfffc))
 #define PPC_STDU(r, base, i)	EMIT(PPC_INST_STDU | ___PPC_RS(r) |	      \
 				     ___PPC_RA(base) | ((i) & 0xfffc))
 #define PPC_STW(r, base, i)	EMIT(PPC_INST_STW | ___PPC_RS(r) |	      \
-				     ___PPC_RA(base) | ((i) & 0xfffc))
+				     ___PPC_RA(base) | IMM_L(i))
 #define PPC_STWU(r, base, i)	EMIT(PPC_INST_STWU | ___PPC_RS(r) |	      \
-				     ___PPC_RA(base) | ((i) & 0xfffc))
+				     ___PPC_RA(base) | IMM_L(i))
 
 #define PPC_LBZ(r, base, i)	EMIT(PPC_INST_LBZ | ___PPC_RT(r) |	      \
 				     ___PPC_RA(base) | IMM_L(i))
@@ -174,13 +174,14 @@ DECLARE_LOAD_FUNC(sk_load_byte_msh);
 #define PPC_CMPWI(a, i)		EMIT(PPC_INST_CMPWI | ___PPC_RA(a) | IMM_L(i))
 #define PPC_CMPDI(a, i)		EMIT(PPC_INST_CMPDI | ___PPC_RA(a) | IMM_L(i))
 #define PPC_CMPLWI(a, i)	EMIT(PPC_INST_CMPLWI | ___PPC_RA(a) | IMM_L(i))
-#define PPC_CMPLW(a, b)		EMIT(PPC_INST_CMPLW | ___PPC_RA(a) | ___PPC_RB(b))
+#define PPC_CMPLW(a, b)		EMIT(PPC_INST_CMPLW | ___PPC_RA(a) |	      \
+					___PPC_RB(b))
 
 #define PPC_SUB(d, a, b)	EMIT(PPC_INST_SUB | ___PPC_RT(d) |	      \
 				     ___PPC_RB(a) | ___PPC_RA(b))
 #define PPC_ADD(d, a, b)	EMIT(PPC_INST_ADD | ___PPC_RT(d) |	      \
 				     ___PPC_RA(a) | ___PPC_RB(b))
-#define PPC_MUL(d, a, b)	EMIT(PPC_INST_MULLW | ___PPC_RT(d) |	      \
+#define PPC_MULW(d, a, b)	EMIT(PPC_INST_MULLW | ___PPC_RT(d) |	      \
 				     ___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_MULHWU(d, a, b)	EMIT(PPC_INST_MULHWU | ___PPC_RT(d) |	      \
 				     ___PPC_RA(a) | ___PPC_RB(b))
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 2d66a84..6012aac 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -161,14 +161,14 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 			break;
 		case BPF_ALU | BPF_MUL | BPF_X: /* A *= X; */
 			ctx->seen |= SEEN_XREG;
-			PPC_MUL(r_A, r_A, r_X);
+			PPC_MULW(r_A, r_A, r_X);
 			break;
 		case BPF_ALU | BPF_MUL | BPF_K: /* A *= K */
 			if (K < 32768)
 				PPC_MULI(r_A, r_A, K);
 			else {
 				PPC_LI32(r_scratch1, K);
-				PPC_MUL(r_A, r_A, r_scratch1);
+				PPC_MULW(r_A, r_A, r_scratch1);
 			}
 			break;
 		case BPF_ALU | BPF_MOD | BPF_X: /* A %= X; */
@@ -184,7 +184,7 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 			}
 			if (code == (BPF_ALU | BPF_MOD | BPF_X)) {
 				PPC_DIVWU(r_scratch1, r_A, r_X);
-				PPC_MUL(r_scratch1, r_X, r_scratch1);
+				PPC_MULW(r_scratch1, r_X, r_scratch1);
 				PPC_SUB(r_A, r_A, r_scratch1);
 			} else {
 				PPC_DIVWU(r_A, r_A, r_X);
@@ -193,7 +193,7 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 		case BPF_ALU | BPF_MOD | BPF_K: /* A %= K; */
 			PPC_LI32(r_scratch2, K);
 			PPC_DIVWU(r_scratch1, r_A, r_scratch2);
-			PPC_MUL(r_scratch1, r_scratch2, r_scratch1);
+			PPC_MULW(r_scratch1, r_scratch2, r_scratch1);
 			PPC_SUB(r_A, r_A, r_scratch1);
 			break;
 		case BPF_ALU | BPF_DIV | BPF_K: /* A /= K */
-- 
2.7.4
