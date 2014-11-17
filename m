Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB1841A01A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 07:35:47 +1100 (AEDT)
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
 [209.85.215.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BB3B414011B
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2014 07:35:46 +1100 (AEDT)
Received: by mail-la0-f53.google.com with SMTP id pn19so2047799lab.26
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2014 12:35:43 -0800 (PST)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: netdev@vger.kernel.org
Subject: [PATCH net-next] PPC: bpf_jit_comp: Unify BPF_MOD | BPF_X and BPF_DIV
 | BPF_X
Date: Mon, 17 Nov 2014 23:07:41 +0300
Message-Id: <1416254861-3879-1-git-send-email-kda@linux-powerpc.org>
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 Denis Kirjanov <kda@linux-powerpc.org>, Daniel Borkmann <dborkman@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reduce duplicated code by unifying
BPF_ALU | BPF_MOD | BPF_X and BPF_ALU | BPF_DIV | BPF_X

CC: Alexei Starovoitov<alexei.starovoitov@gmail.com>
CC: Daniel Borkmann<dborkman@redhat.com>
CC: Philippe Bergheaud<felix@linux.vnet.ibm.com>
Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
---
 arch/powerpc/net/bpf_jit_comp.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index d3fa80d..1ca125b 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -181,6 +181,7 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 			}
 			break;
 		case BPF_ALU | BPF_MOD | BPF_X: /* A %= X; */
+		case BPF_ALU | BPF_DIV | BPF_X: /* A /= X; */
 			ctx->seen |= SEEN_XREG;
 			PPC_CMPWI(r_X, 0);
 			if (ctx->pc_ret0 != -1) {
@@ -190,9 +191,13 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 				PPC_LI(r_ret, 0);
 				PPC_JMP(exit_addr);
 			}
-			PPC_DIVWU(r_scratch1, r_A, r_X);
-			PPC_MUL(r_scratch1, r_X, r_scratch1);
-			PPC_SUB(r_A, r_A, r_scratch1);
+			if (code == (BPF_ALU | BPF_MOD | BPF_X)) {
+				PPC_DIVWU(r_scratch1, r_A, r_X);
+				PPC_MUL(r_scratch1, r_X, r_scratch1);
+				PPC_SUB(r_A, r_A, r_scratch1);
+			} else {
+				PPC_DIVWU(r_A, r_A, r_X);
+			}
 			break;
 		case BPF_ALU | BPF_MOD | BPF_K: /* A %= K; */
 			PPC_LI32(r_scratch2, K);
@@ -200,22 +205,6 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 			PPC_MUL(r_scratch1, r_scratch2, r_scratch1);
 			PPC_SUB(r_A, r_A, r_scratch1);
 			break;
-		case BPF_ALU | BPF_DIV | BPF_X: /* A /= X; */
-			ctx->seen |= SEEN_XREG;
-			PPC_CMPWI(r_X, 0);
-			if (ctx->pc_ret0 != -1) {
-				PPC_BCC(COND_EQ, addrs[ctx->pc_ret0]);
-			} else {
-				/*
-				 * Exit, returning 0; first pass hits here
-				 * (longer worst-case code size).
-				 */
-				PPC_BCC_SHORT(COND_NE, (ctx->idx*4)+12);
-				PPC_LI(r_ret, 0);
-				PPC_JMP(exit_addr);
-			}
-			PPC_DIVWU(r_A, r_A, r_X);
-			break;
 		case BPF_ALU | BPF_DIV | BPF_K: /* A /= K */
 			if (K == 1)
 				break;
-- 
2.1.0
