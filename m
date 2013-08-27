Return-Path: <murzin.v@gmail.com>
Received: from mail-la0-x22d.google.com (mail-la0-x22d.google.com
 [IPv6:2a00:1450:4010:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 688DD2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 04:50:32 +1000 (EST)
Received: by mail-la0-f45.google.com with SMTP id eh20so3926626lab.32
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 11:50:26 -0700 (PDT)
From: Vladimir Murzin <murzin.v@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ppc: bpf_jit: support MOD operation
Date: Wed, 28 Aug 2013 02:49:52 +0400
Message-Id: <1377643792-10327-1-git-send-email-murzin.v@gmail.com>
Cc: dborkman@redhat.com, paulus@samba.org, davem@davemloft.net,
 Vladimir Murzin <murzin.v@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit b6069a9570 (filter: add MOD operation) added generic
support for modulus operation in BPF.

This patch brings JIT support for PPC64

Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index bf56e33..96f24dc 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -193,6 +193,28 @@ static int bpf_jit_build_body(struct sk_filter *fp, u32 *image,
 				PPC_MUL(r_A, r_A, r_scratch1);
 			}
 			break;
+		case BPF_S_ALU_MOD_X: /* A %= X; */
+			ctx->seen |= SEEN_XREG;
+			PPC_CMPWI(r_X, 0);
+			if (ctx->pc_ret0 != -1) {
+				PPC_BCC(COND_EQ, addrs[ctx->pc_ret0]);
+			} else {
+				PPC_BCC_SHORT(COND_NE, (ctx->idx*4)+12);
+				PPC_LI(r_ret, 0);
+				PPC_JMP(exit_addr);
+			}
+			PPC_DIVWU(r_scratch1, r_A, r_X);
+			PPC_MUL(r_scratch1, r_X, r_scratch1);
+			PPC_SUB(r_A, r_A, r_scratch1);
+			break;
+		case BPF_S_ALU_MOD_K: /* A %= K; */
+#define r_scratch2 (r_scratch1 + 1)
+			PPC_LI32(r_scratch2, K);
+			PPC_DIVWU(r_scratch1, r_A, r_scratch2);
+			PPC_MUL(r_scratch1, r_scratch2, r_scratch1);
+			PPC_SUB(r_A, r_A, r_scratch1);
+#undef r_scratch2
+			break;
 		case BPF_S_ALU_DIV_X: /* A /= X; */
 			ctx->seen |= SEEN_XREG;
 			PPC_CMPWI(r_X, 0);
-- 
1.8.1.5
