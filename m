Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EA8391A006B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 06:51:00 +1100 (AEDT)
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com
 [209.85.217.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 159F814007B
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2014 06:50:59 +1100 (AEDT)
Received: by mail-lb0-f169.google.com with SMTP id 10so4754264lbg.28
 for <linuxppc-dev@ozlabs.org>; Sun, 26 Oct 2014 12:50:55 -0700 (PDT)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: netdev@vger.kernel.org
Subject: [PATCH] PPC: bpf_jit_comp: add SKF_AD_PKTTYPE instruction
Date: Sun, 26 Oct 2014 22:23:26 +0300
Message-Id: <1414351406-4122-1-git-send-email-kda@linux-powerpc.org>
Cc: linuxppc-dev@ozlabs.org, Denis Kirjanov <kda@linux-powerpc.org>,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cc: Matt Evans <matt@ozlabs.org>
Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
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
