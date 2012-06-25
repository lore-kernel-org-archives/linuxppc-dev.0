Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Michael Neuling <mikey@neuling.org>
Date: Tue, 26 Jun 2012 09:33:21 +1000
Subject: [PATCH 14/18] powerpc: start using ___PPC_RA/B/S/T where necessary
In-Reply-To: <1340667187.357853.615199632713.qpush@ale>
Message-Id: <20120625233321.B9FE5D43683@localhost.localdomain>
Cc: mikey@neuling.org, matt@ozlabs.org, linuxppc-dev@ozlabs.org,
 schwab@linux-m68k.org, Anton Blanchard <anton@samba.org>,
 Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now have ___PPC_RA/B/S/T we can use it in some places.  These are
places where we can't use the existing defines which will soon enforce
R0-R31 usage.  

The macros being changed here are being used in inline asm, which
can't convert to enforce the R0-R31 usage.

bpf_jit uses a mix of both generated and non-generated with the same
code, so just convert all these to use the ___PPC_R versions which
won't enforce R usage later.


Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/include/asm/ppc-opcode.h |   12 +--
 arch/powerpc/net/bpf_jit.h            |  104 +++++++++++++++++-----------------
 2 files changed, 58 insertions(+), 58 deletions(-)

Index: b/arch/powerpc/include/asm/ppc-opcode.h
===================================================================
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -180,13 +180,13 @@
 #define	PPC_DCBZL(a, b)		stringify_in_c(.long PPC_INST_DCBZL | \
 					__PPC_RA(a) | __PPC_RB(b))
 #define PPC_LDARX(t, a, b, eh)	stringify_in_c(.long PPC_INST_LDARX | \
-					__PPC_RT(t) | __PPC_RA(a) | \
-					__PPC_RB(b) | __PPC_EH(eh))
+					___PPC_RT(t) | ___PPC_RA(a) | \
+					___PPC_RB(b) | __PPC_EH(eh))
 #define PPC_LWARX(t, a, b, eh)	stringify_in_c(.long PPC_INST_LWARX | \
-					__PPC_RT(t) | __PPC_RA(a) | \
-					__PPC_RB(b) | __PPC_EH(eh))
+					___PPC_RT(t) | ___PPC_RA(a) | \
+					___PPC_RB(b) | __PPC_EH(eh))
 #define PPC_MSGSND(b)		stringify_in_c(.long PPC_INST_MSGSND | \
-					__PPC_RB(b))
+					___PPC_RB(b))
 #define PPC_POPCNTB(a, s)	stringify_in_c(.long PPC_INST_POPCNTB | \
 					__PPC_RA(a) | __PPC_RS(s))
 #define PPC_POPCNTD(a, s)	stringify_in_c(.long PPC_INST_POPCNTD | \
@@ -204,7 +204,7 @@
 #define PPC_WAIT(w)		stringify_in_c(.long PPC_INST_WAIT | \
 					__PPC_WC(w))
 #define PPC_TLBIE(lp,a) 	stringify_in_c(.long PPC_INST_TLBIE | \
-					       __PPC_RB(a) | __PPC_RS(lp))
+					       ___PPC_RB(a) | ___PPC_RS(lp))
 #define PPC_TLBSRX_DOT(a,b)	stringify_in_c(.long PPC_INST_TLBSRX_DOT | \
 					__PPC_RA(a) | __PPC_RB(b))
 #define PPC_TLBIVAX(a,b)	stringify_in_c(.long PPC_INST_TLBIVAX | \
Index: b/arch/powerpc/net/bpf_jit.h
===================================================================
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -75,23 +75,23 @@ DECLARE_LOAD_FUNC(sk_load_byte_msh);
 #define PPC_NOP()		EMIT(PPC_INST_NOP)
 #define PPC_BLR()		EMIT(PPC_INST_BLR)
 #define PPC_BLRL()		EMIT(PPC_INST_BLRL)
-#define PPC_MTLR(r)		EMIT(PPC_INST_MTLR | __PPC_RT(r))
-#define PPC_ADDI(d, a, i)	EMIT(PPC_INST_ADDI | __PPC_RT(d) |	      \
-				     __PPC_RA(a) | IMM_L(i))
+#define PPC_MTLR(r)		EMIT(PPC_INST_MTLR | ___PPC_RT(r))
+#define PPC_ADDI(d, a, i)	EMIT(PPC_INST_ADDI | ___PPC_RT(d) |	      \
+				     ___PPC_RA(a) | IMM_L(i))
 #define PPC_MR(d, a)		PPC_OR(d, a, a)
 #define PPC_LI(r, i)		PPC_ADDI(r, 0, i)
 #define PPC_ADDIS(d, a, i)	EMIT(PPC_INST_ADDIS |			      \
-				     __PPC_RS(d) | __PPC_RA(a) | IMM_L(i))
+				     ___PPC_RS(d) | ___PPC_RA(a) | IMM_L(i))
 #define PPC_LIS(r, i)		PPC_ADDIS(r, 0, i)
-#define PPC_STD(r, base, i)	EMIT(PPC_INST_STD | __PPC_RS(r) |	      \
-				     __PPC_RA(base) | ((i) & 0xfffc))
+#define PPC_STD(r, base, i)	EMIT(PPC_INST_STD | ___PPC_RS(r) |	      \
+				     ___PPC_RA(base) | ((i) & 0xfffc))
 
-#define PPC_LD(r, base, i)	EMIT(PPC_INST_LD | __PPC_RT(r) |	      \
-				     __PPC_RA(base) | IMM_L(i))
-#define PPC_LWZ(r, base, i)	EMIT(PPC_INST_LWZ | __PPC_RT(r) |	      \
-				     __PPC_RA(base) | IMM_L(i))
-#define PPC_LHZ(r, base, i)	EMIT(PPC_INST_LHZ | __PPC_RT(r) |	      \
-				     __PPC_RA(base) | IMM_L(i))
+#define PPC_LD(r, base, i)	EMIT(PPC_INST_LD | ___PPC_RT(r) |	      \
+				     ___PPC_RA(base) | IMM_L(i))
+#define PPC_LWZ(r, base, i)	EMIT(PPC_INST_LWZ | ___PPC_RT(r) |	      \
+				     ___PPC_RA(base) | IMM_L(i))
+#define PPC_LHZ(r, base, i)	EMIT(PPC_INST_LHZ | ___PPC_RT(r) |	      \
+				     ___PPC_RA(base) | IMM_L(i))
 /* Convenience helpers for the above with 'far' offsets: */
 #define PPC_LD_OFFS(r, base, i) do { if ((i) < 32768) PPC_LD(r, base, i);     \
 		else {	PPC_ADDIS(r, base, IMM_HA(i));			      \
@@ -105,52 +105,52 @@ DECLARE_LOAD_FUNC(sk_load_byte_msh);
 		else {	PPC_ADDIS(r, base, IMM_HA(i));			      \
 			PPC_LHZ(r, r, IMM_L(i)); } } while(0)
 
-#define PPC_CMPWI(a, i)		EMIT(PPC_INST_CMPWI | __PPC_RA(a) | IMM_L(i))
-#define PPC_CMPDI(a, i)		EMIT(PPC_INST_CMPDI | __PPC_RA(a) | IMM_L(i))
-#define PPC_CMPLWI(a, i)	EMIT(PPC_INST_CMPLWI | __PPC_RA(a) | IMM_L(i))
-#define PPC_CMPLW(a, b)		EMIT(PPC_INST_CMPLW | __PPC_RA(a) | __PPC_RB(b))
-
-#define PPC_SUB(d, a, b)	EMIT(PPC_INST_SUB | __PPC_RT(d) |	      \
-				     __PPC_RB(a) | __PPC_RA(b))
-#define PPC_ADD(d, a, b)	EMIT(PPC_INST_ADD | __PPC_RT(d) |	      \
-				     __PPC_RA(a) | __PPC_RB(b))
-#define PPC_MUL(d, a, b)	EMIT(PPC_INST_MULLW | __PPC_RT(d) |	      \
-				     __PPC_RA(a) | __PPC_RB(b))
-#define PPC_MULHWU(d, a, b)	EMIT(PPC_INST_MULHWU | __PPC_RT(d) |	      \
-				     __PPC_RA(a) | __PPC_RB(b))
-#define PPC_MULI(d, a, i)	EMIT(PPC_INST_MULLI | __PPC_RT(d) |	      \
-				     __PPC_RA(a) | IMM_L(i))
-#define PPC_DIVWU(d, a, b)	EMIT(PPC_INST_DIVWU | __PPC_RT(d) |	      \
-				     __PPC_RA(a) | __PPC_RB(b))
-#define PPC_AND(d, a, b)	EMIT(PPC_INST_AND | __PPC_RA(d) |	      \
-				     __PPC_RS(a) | __PPC_RB(b))
-#define PPC_ANDI(d, a, i)	EMIT(PPC_INST_ANDI | __PPC_RA(d) |	      \
-				     __PPC_RS(a) | IMM_L(i))
-#define PPC_AND_DOT(d, a, b)	EMIT(PPC_INST_ANDDOT | __PPC_RA(d) |	      \
-				     __PPC_RS(a) | __PPC_RB(b))
-#define PPC_OR(d, a, b)		EMIT(PPC_INST_OR | __PPC_RA(d) |	      \
-				     __PPC_RS(a) | __PPC_RB(b))
-#define PPC_ORI(d, a, i)	EMIT(PPC_INST_ORI | __PPC_RA(d) |	      \
-				     __PPC_RS(a) | IMM_L(i))
-#define PPC_ORIS(d, a, i)	EMIT(PPC_INST_ORIS | __PPC_RA(d) |	      \
-				     __PPC_RS(a) | IMM_L(i))
-#define PPC_SLW(d, a, s)	EMIT(PPC_INST_SLW | __PPC_RA(d) |	      \
-				     __PPC_RS(a) | __PPC_RB(s))
-#define PPC_SRW(d, a, s)	EMIT(PPC_INST_SRW | __PPC_RA(d) |	      \
-				     __PPC_RS(a) | __PPC_RB(s))
+#define PPC_CMPWI(a, i)		EMIT(PPC_INST_CMPWI | ___PPC_RA(a) | IMM_L(i))
+#define PPC_CMPDI(a, i)		EMIT(PPC_INST_CMPDI | ___PPC_RA(a) | IMM_L(i))
+#define PPC_CMPLWI(a, i)	EMIT(PPC_INST_CMPLWI | ___PPC_RA(a) | IMM_L(i))
+#define PPC_CMPLW(a, b)		EMIT(PPC_INST_CMPLW | ___PPC_RA(a) | ___PPC_RB(b))
+
+#define PPC_SUB(d, a, b)	EMIT(PPC_INST_SUB | ___PPC_RT(d) |	      \
+				     ___PPC_RB(a) | ___PPC_RA(b))
+#define PPC_ADD(d, a, b)	EMIT(PPC_INST_ADD | ___PPC_RT(d) |	      \
+				     ___PPC_RA(a) | ___PPC_RB(b))
+#define PPC_MUL(d, a, b)	EMIT(PPC_INST_MULLW | ___PPC_RT(d) |	      \
+				     ___PPC_RA(a) | ___PPC_RB(b))
+#define PPC_MULHWU(d, a, b)	EMIT(PPC_INST_MULHWU | ___PPC_RT(d) |	      \
+				     ___PPC_RA(a) | ___PPC_RB(b))
+#define PPC_MULI(d, a, i)	EMIT(PPC_INST_MULLI | ___PPC_RT(d) |	      \
+				     ___PPC_RA(a) | IMM_L(i))
+#define PPC_DIVWU(d, a, b)	EMIT(PPC_INST_DIVWU | ___PPC_RT(d) |	      \
+				     ___PPC_RA(a) | ___PPC_RB(b))
+#define PPC_AND(d, a, b)	EMIT(PPC_INST_AND | ___PPC_RA(d) |	      \
+				     ___PPC_RS(a) | ___PPC_RB(b))
+#define PPC_ANDI(d, a, i)	EMIT(PPC_INST_ANDI | ___PPC_RA(d) |	      \
+				     ___PPC_RS(a) | IMM_L(i))
+#define PPC_AND_DOT(d, a, b)	EMIT(PPC_INST_ANDDOT | ___PPC_RA(d) |	      \
+				     ___PPC_RS(a) | ___PPC_RB(b))
+#define PPC_OR(d, a, b)		EMIT(PPC_INST_OR | ___PPC_RA(d) |	      \
+				     ___PPC_RS(a) | ___PPC_RB(b))
+#define PPC_ORI(d, a, i)	EMIT(PPC_INST_ORI | ___PPC_RA(d) |	      \
+				     ___PPC_RS(a) | IMM_L(i))
+#define PPC_ORIS(d, a, i)	EMIT(PPC_INST_ORIS | ___PPC_RA(d) |	      \
+				     ___PPC_RS(a) | IMM_L(i))
+#define PPC_SLW(d, a, s)	EMIT(PPC_INST_SLW | ___PPC_RA(d) |	      \
+				     ___PPC_RS(a) | ___PPC_RB(s))
+#define PPC_SRW(d, a, s)	EMIT(PPC_INST_SRW | ___PPC_RA(d) |	      \
+				     ___PPC_RS(a) | ___PPC_RB(s))
 /* slwi = rlwinm Rx, Ry, n, 0, 31-n */
-#define PPC_SLWI(d, a, i)	EMIT(PPC_INST_RLWINM | __PPC_RA(d) |	      \
-				     __PPC_RS(a) | __PPC_SH(i) |	      \
+#define PPC_SLWI(d, a, i)	EMIT(PPC_INST_RLWINM | ___PPC_RA(d) |	      \
+				     ___PPC_RS(a) | __PPC_SH(i) |	      \
 				     __PPC_MB(0) | __PPC_ME(31-(i)))
 /* srwi = rlwinm Rx, Ry, 32-n, n, 31 */
-#define PPC_SRWI(d, a, i)	EMIT(PPC_INST_RLWINM | __PPC_RA(d) |	      \
-				     __PPC_RS(a) | __PPC_SH(32-(i)) |	      \
+#define PPC_SRWI(d, a, i)	EMIT(PPC_INST_RLWINM | ___PPC_RA(d) |	      \
+				     ___PPC_RS(a) | __PPC_SH(32-(i)) |	      \
 				     __PPC_MB(i) | __PPC_ME(31))
 /* sldi = rldicr Rx, Ry, n, 63-n */
-#define PPC_SLDI(d, a, i)	EMIT(PPC_INST_RLDICR | __PPC_RA(d) |	      \
-				     __PPC_RS(a) | __PPC_SH(i) |	      \
+#define PPC_SLDI(d, a, i)	EMIT(PPC_INST_RLDICR | ___PPC_RA(d) |	      \
+				     ___PPC_RS(a) | __PPC_SH(i) |	      \
 				     __PPC_MB(63-(i)) | (((i) & 0x20) >> 4))
-#define PPC_NEG(d, a)		EMIT(PPC_INST_NEG | __PPC_RT(d) | __PPC_RA(a))
+#define PPC_NEG(d, a)		EMIT(PPC_INST_NEG | ___PPC_RT(d) | ___PPC_RA(a))
 
 /* Long jump; (unconditional 'branch') */
 #define PPC_JMP(dest)		EMIT(PPC_INST_BRANCH |			      \
