Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp18.uk.ibm.com (e06smtp18.uk.ibm.com [195.75.94.114])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp18.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9DD862C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 22:13:52 +1000 (EST)
Received: from /spool/local
 by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Tue, 24 Sep 2013 13:13:48 +0100
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: Linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: BPF JIT compiler for 64bit LE
Date: Tue, 24 Sep 2013 14:13:35 +0200
Message-Id: <1380024815-10881-1-git-send-email-felix@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This enables the Berkeley Packet Filter JIT compiler
for the PowerPC running in 64bit Little Endian.

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-opcode.h |    1 +
 arch/powerpc/net/bpf_jit.h            |   10 ++++++++++
 arch/powerpc/net/bpf_jit_64.S         |    9 ++++++++-
 arch/powerpc/net/bpf_jit_comp.c       |   17 ++---------------
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 247fa1d..23c2b63 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -154,6 +154,7 @@
 /* Misc instructions for BPF compiler */
 #define PPC_INST_LD			0xe8000000
 #define PPC_INST_LHZ			0xa0000000
+#define PPC_INST_LHBRX			0x7c00062c
 #define PPC_INST_LWZ			0x80000000
 #define PPC_INST_STD			0xf8000000
 #define PPC_INST_STDU			0xf8000001
diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 8a5dfaf..0baf2b8 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -92,6 +92,8 @@ DECLARE_LOAD_FUNC(sk_load_byte_msh);
 				     ___PPC_RA(base) | IMM_L(i))
 #define PPC_LHZ(r, base, i)	EMIT(PPC_INST_LHZ | ___PPC_RT(r) |	      \
 				     ___PPC_RA(base) | IMM_L(i))
+#define PPC_LHBRX(r, base, b)	EMIT(PPC_INST_LHBRX | ___PPC_RT(r) |	      \
+				     ___PPC_RA(base) | ___PPC_RB(b))
 /* Convenience helpers for the above with 'far' offsets: */
 #define PPC_LD_OFFS(r, base, i) do { if ((i) < 32768) PPC_LD(r, base, i);     \
 		else {	PPC_ADDIS(r, base, IMM_HA(i));			      \
@@ -186,6 +188,14 @@ DECLARE_LOAD_FUNC(sk_load_byte_msh);
 				PPC_ORI(d, d, (uintptr_t)(i) & 0xffff);	      \
 		} } while (0);
 
+#define PPC_LHBRX_OFFS(r, base, i) \
+		do { PPC_LI32(r, i); PPC_LHBRX(r, r, base); } while(0)
+#ifdef __LITTLE_ENDIAN__
+#define PPC_NTOHS_OFFS(r, base, i)	PPC_LHBRX_OFFS(r, base, i)
+#else
+#define PPC_NTOHS_OFFS(r, base, i)	PPC_LHZ_OFFS(r, base, i)
+#endif
+
 static inline bool is_nearbranch(int offset)
 {
 	return (offset < 32768) && (offset >= -32768);
diff --git a/arch/powerpc/net/bpf_jit_64.S b/arch/powerpc/net/bpf_jit_64.S
index 7d3a3b5..e76eba7 100644
--- a/arch/powerpc/net/bpf_jit_64.S
+++ b/arch/powerpc/net/bpf_jit_64.S
@@ -43,8 +43,11 @@ sk_load_word_positive_offset:
 	cmpd	r_scratch1, r_addr
 	blt	bpf_slow_path_word
 	/* Nope, just hitting the header.  cr0 here is eq or gt! */
+#ifdef __LITTLE_ENDIAN__
+	lwbrx	r_A, r_D, r_addr
+#else
 	lwzx	r_A, r_D, r_addr
-	/* When big endian we don't need to byteswap. */
+#endif
 	blr	/* Return success, cr0 != LT */
 
 	.globl	sk_load_half
@@ -56,7 +59,11 @@ sk_load_half_positive_offset:
 	subi	r_scratch1, r_HL, 2
 	cmpd	r_scratch1, r_addr
 	blt	bpf_slow_path_half
+#ifdef __LITTLE_ENDIAN__
+	lhbrx	r_A, r_D, r_addr
+#else
 	lhzx	r_A, r_D, r_addr
+#endif
 	blr
 
 	.globl	sk_load_byte
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index c427ae3..9e212f9 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -17,14 +17,8 @@
 
 #include "bpf_jit.h"
 
-#ifndef __BIG_ENDIAN
-/* There are endianness assumptions herein. */
-#error "Little-endian PPC not supported in BPF compiler"
-#endif
-
 int bpf_jit_enable __read_mostly;
 
-
 static inline void bpf_flush_icache(void *start, void *end)
 {
 	smp_wmb();
@@ -346,18 +340,11 @@ static int bpf_jit_build_body(struct sk_filter *fp, u32 *image,
 			break;
 
 			/*** Ancillary info loads ***/
-
-			/* None of the BPF_S_ANC* codes appear to be passed by
-			 * sk_chk_filter().  The interpreter and the x86 BPF
-			 * compiler implement them so we do too -- they may be
-			 * planted in future.
-			 */
 		case BPF_S_ANC_PROTOCOL: /* A = ntohs(skb->protocol); */
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
 						  protocol) != 2);
-			PPC_LHZ_OFFS(r_A, r_skb, offsetof(struct sk_buff,
-							  protocol));
-			/* ntohs is a NOP with BE loads. */
+			PPC_NTOHS_OFFS(r_A, r_skb, offsetof(struct sk_buff,
+							    protocol));
 			break;
 		case BPF_S_ANC_IFINDEX:
 			PPC_LD_OFFS(r_scratch1, r_skb, offsetof(struct sk_buff,
-- 
1.7.10.4
