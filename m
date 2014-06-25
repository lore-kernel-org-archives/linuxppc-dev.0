Return-Path: <kda@linux-powerpc.org>
Received: from mail-la0-f44.google.com (mail-la0-f44.google.com
 [209.85.215.44])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C2011A0017
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 03:59:53 +1000 (EST)
Received: by mail-la0-f44.google.com with SMTP id ty20so1028507lab.17
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 10:59:49 -0700 (PDT)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: netdev@vger.kernel.org
Subject: [PATCH v2 2/2] powerpc: bpf: Fix the broken LD_VLAN_TAG_PRESENT test
Date: Wed, 25 Jun 2014 21:34:57 +0400
Message-Id: <1403717697-3911-2-git-send-email-kda@linux-powerpc.org>
In-Reply-To: <1403717697-3911-1-git-send-email-kda@linux-powerpc.org>
References: <1403717697-3911-1-git-send-email-kda@linux-powerpc.org>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have to return the boolean here if the tag presents
or not, not just ANDing the TCI with the mask which results to:

[  709.412097] test_bpf: #18 LD_VLAN_TAG_PRESENT
[  709.412245] ret 4096 != 1
[  709.412332] ret 4096 != 1
[  709.412333] FAIL (2 times)

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
---
 arch/powerpc/net/bpf_jit_comp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 892167b..82e82ca 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -394,10 +394,12 @@ static int bpf_jit_build_body(struct sk_filter *fp, u32 *image,
 
 			PPC_LHZ_OFFS(r_A, r_skb, offsetof(struct sk_buff,
 							  vlan_tci));
-			if (code == (BPF_ANC | SKF_AD_VLAN_TAG))
+			if (code == (BPF_ANC | SKF_AD_VLAN_TAG)) {
 				PPC_ANDI(r_A, r_A, ~VLAN_TAG_PRESENT);
-			else
+			} else {
 				PPC_ANDI(r_A, r_A, VLAN_TAG_PRESENT);
+				PPC_SRWI(r_A, r_A, 12);
+			}
 			break;
 		case BPF_ANC | SKF_AD_QUEUE:
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
-- 
2.0.0
