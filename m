Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A1A31A0179
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Nov 2014 17:27:35 +1100 (AEDT)
Received: from mail-la0-f48.google.com (mail-la0-f48.google.com
 [209.85.215.48])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AB20814012A
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2014 17:27:33 +1100 (AEDT)
Received: by mail-la0-f48.google.com with SMTP id gq15so7244135lab.35
 for <linuxppc-dev@ozlabs.org>; Sun, 09 Nov 2014 22:27:30 -0800 (PST)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: netdev@vger.kernel.org
Subject: [PATCH v2 net-next] PPC: bpf_jit_comp: add SKF_AD_HATYPE instruction
Date: Mon, 10 Nov 2014 08:59:43 +0300
Message-Id: <1415599183-3883-1-git-send-email-kda@linux-powerpc.org>
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

Add BPF extension SKF_AD_HATYPE to ppc JIT to check
the hw type of the interface

Before:
[   57.723666] test_bpf: #20 LD_HATYPE
[   57.723675] BPF filter opcode 0020 (@0) unsupported
[   57.724168] 48 48 PASS

After:
[  103.053184] test_bpf: #20 LD_HATYPE 7 6 PASS

CC: Alexei Starovoitov<alexei.starovoitov@gmail.com>
CC: Daniel Borkmann<dborkman@redhat.com>
CC: Philippe Bergheaud<felix@linux.vnet.ibm.com>
Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>

v2: address Alexei's comments
---
 arch/powerpc/net/bpf_jit_comp.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index d110e28..d3fa80d 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -361,6 +361,11 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 							    protocol));
 			break;
 		case BPF_ANC | SKF_AD_IFINDEX:
+		case BPF_ANC | SKF_AD_HATYPE:
+			BUILD_BUG_ON(FIELD_SIZEOF(struct net_device,
+						ifindex) != 4);
+			BUILD_BUG_ON(FIELD_SIZEOF(struct net_device,
+						type) != 2);
 			PPC_LD_OFFS(r_scratch1, r_skb, offsetof(struct sk_buff,
 								dev));
 			PPC_CMPDI(r_scratch1, 0);
@@ -368,14 +373,18 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 				PPC_BCC(COND_EQ, addrs[ctx->pc_ret0]);
 			} else {
 				/* Exit, returning 0; first pass hits here. */
-				PPC_BCC_SHORT(COND_NE, (ctx->idx*4)+12);
+				PPC_BCC_SHORT(COND_NE, ctx->idx * 4 + 12);
 				PPC_LI(r_ret, 0);
 				PPC_JMP(exit_addr);
 			}
-			BUILD_BUG_ON(FIELD_SIZEOF(struct net_device,
-						  ifindex) != 4);
-			PPC_LWZ_OFFS(r_A, r_scratch1,
+			if (code == (BPF_ANC | SKF_AD_IFINDEX)) {
+				PPC_LWZ_OFFS(r_A, r_scratch1,
 				     offsetof(struct net_device, ifindex));
+			} else {
+				PPC_LHZ_OFFS(r_A, r_scratch1,
+				     offsetof(struct net_device, type));
+			}
+
 			break;
 		case BPF_ANC | SKF_AD_MARK:
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, mark) != 4);
-- 
2.1.0
