Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 90F221A01EB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Oct 2014 17:39:45 +1100 (AEDT)
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
 [209.85.215.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B5693140081
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2014 17:39:43 +1100 (AEDT)
Received: by mail-la0-f53.google.com with SMTP id mc6so3882424lab.12
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2014 23:39:40 -0700 (PDT)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: netdev@vger.kernel.org
Subject: [PATCH v2] PPC: bpf_jit_comp: add SKF_AD_PKTTYPE instruction
Date: Thu, 30 Oct 2014 09:12:15 +0300
Message-Id: <1414649535-3956-1-git-send-email-kda@linux-powerpc.org>
Cc: linuxppc-dev@ozlabs.org, Denis Kirjanov <kda@linux-powerpc.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add BPF extension SKF_AD_PKTTYPE to ppc JIT to load
skb->pkt_type field.

Before:
[   88.262622] test_bpf: #11 LD_IND_NET 86 97 99 PASS
[   88.265740] test_bpf: #12 LD_PKTTYPE 109 107 PASS

After:
[   80.605964] test_bpf: #11 LD_IND_NET 44 40 39 PASS
[   80.607370] test_bpf: #12 LD_PKTTYPE 9 9 PASS

CC: Alexei Starovoitov<alexei.starovoitov@gmail.com>
CC: Michael Ellerman<mpe@ellerman.id.au>
Cc: Matt Evans <matt@ozlabs.org>
Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>

v2: Added test rusults
---
 arch/powerpc/include/asm/ppc-opcode.h | 1 +
 arch/powerpc/net/bpf_jit.h            | 7 +++++++
 arch/powerpc/net/bpf_jit_comp.c       | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 6f85362..1a52877 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -204,6 +204,7 @@
 #define PPC_INST_ERATSX_DOT		0x7c000127
 
 /* Misc instructions for BPF compiler */
+#define PPC_INST_LBZ			0x88000000
 #define PPC_INST_LD			0xe8000000
 #define PPC_INST_LHZ			0xa0000000
 #define PPC_INST_LHBRX			0x7c00062c
diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 9aee27c..c406aa9 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -87,6 +87,9 @@ DECLARE_LOAD_FUNC(sk_load_byte_msh);
 #define PPC_STD(r, base, i)	EMIT(PPC_INST_STD | ___PPC_RS(r) |	      \
 				     ___PPC_RA(base) | ((i) & 0xfffc))
 
+
+#define PPC_LBZ(r, base, i)	EMIT(PPC_INST_LBZ | ___PPC_RT(r) |	      \
+				     ___PPC_RA(base) | IMM_L(i))
 #define PPC_LD(r, base, i)	EMIT(PPC_INST_LD | ___PPC_RT(r) |	      \
 				     ___PPC_RA(base) | IMM_L(i))
 #define PPC_LWZ(r, base, i)	EMIT(PPC_INST_LWZ | ___PPC_RT(r) |	      \
@@ -96,6 +99,10 @@ DECLARE_LOAD_FUNC(sk_load_byte_msh);
 #define PPC_LHBRX(r, base, b)	EMIT(PPC_INST_LHBRX | ___PPC_RT(r) |	      \
 				     ___PPC_RA(base) | ___PPC_RB(b))
 /* Convenience helpers for the above with 'far' offsets: */
+#define PPC_LBZ_OFFS(r, base, i) do { if ((i) < 32768) PPC_LBZ(r, base, i);   \
+		else {	PPC_ADDIS(r, base, IMM_HA(i));			      \
+			PPC_LBZ(r, r, IMM_L(i)); } } while(0)
+
 #define PPC_LD_OFFS(r, base, i) do { if ((i) < 32768) PPC_LD(r, base, i);     \
 		else {	PPC_ADDIS(r, base, IMM_HA(i));			      \
 			PPC_LD(r, r, IMM_L(i)); } } while(0)
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index cbae2df..d110e28 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -407,6 +407,11 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 			PPC_LHZ_OFFS(r_A, r_skb, offsetof(struct sk_buff,
 							  queue_mapping));
 			break;
+		case BPF_ANC | SKF_AD_PKTTYPE:
+			PPC_LBZ_OFFS(r_A, r_skb, PKT_TYPE_OFFSET());
+			PPC_ANDI(r_A, r_A, PKT_TYPE_MAX);
+			PPC_SRWI(r_A, r_A, 5);
+			break;
 		case BPF_ANC | SKF_AD_CPU:
 #ifdef CONFIG_SMP
 			/*
-- 
2.1.0
