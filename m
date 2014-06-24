Return-Path: <kda@linux-powerpc.org>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 798A81A0224
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 20:24:25 +1000 (EST)
Received: by mail-lb0-f173.google.com with SMTP id s7so116406lbd.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 03:24:21 -0700 (PDT)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: netdev@vger.kernel.org
Subject: [PATCH 2/2] powerpc: bpf: Fix the broken LD_VLAN_TAG_PRESENT test
Date: Tue, 24 Jun 2014 13:59:29 +0400
Message-Id: <1403603969-24436-2-git-send-email-kda@linux-powerpc.org>
In-Reply-To: <1403603969-24436-1-git-send-email-kda@linux-powerpc.org>
References: <1403603969-24436-1-git-send-email-kda@linux-powerpc.org>
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
or not, not jusr ORing the TCI with the mask which results to:

[  709.412097] test_bpf: #18 LD_VLAN_TAG_PRESENT
[  709.412245] ret 4096 != 1
[  709.412332] ret 4096 != 1
[  709.412333] FAIL (2 times)
---
 arch/powerpc/net/bpf_jit_comp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index af0ed4d..a3d8f58 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -394,8 +394,10 @@ static int bpf_jit_build_body(struct sk_filter *fp, u32 *image,
 							  vlan_tci));
 			if (code == (BPF_ANC | SKF_AD_VLAN_TAG))
 				PPC_ANDI(r_A, r_A, ~VLAN_TAG_PRESENT);
-			else
+			else {
 				PPC_ANDI(r_A, r_A, VLAN_TAG_PRESENT);
+				PPC_SRWI(r_A, r_A, 12);
+			}
 			break;
 		case BPF_ANC | SKF_AD_QUEUE:
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
-- 
2.0.0
