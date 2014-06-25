Return-Path: <kda@linux-powerpc.org>
Received: from mail-la0-f50.google.com (mail-la0-f50.google.com
 [209.85.215.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BD8E1A000D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 03:59:53 +1000 (EST)
Received: by mail-la0-f50.google.com with SMTP id pv20so1025919lab.37
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 10:59:48 -0700 (PDT)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: netdev@vger.kernel.org
Subject: [PATCH v2 1/2] powerpc: bpf: Use correct mask while accessing the
 VLAN tag
Date: Wed, 25 Jun 2014 21:34:56 +0400
Message-Id: <1403717697-3911-1-git-send-email-kda@linux-powerpc.org>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To get a full tag (and not just a VID) we should access the TCI
except the VLAN_TAG_PRESENT field (which means that 802.1q header
is present). Also ensure that the VLAN_TAG_PRESENT stay on its place

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
---
 arch/powerpc/net/bpf_jit_comp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 6dcdade..892167b 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -390,10 +390,12 @@ static int bpf_jit_build_body(struct sk_filter *fp, u32 *image,
 		case BPF_ANC | SKF_AD_VLAN_TAG:
 		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, vlan_tci) != 2);
+			BUILD_BUG_ON(VLAN_TAG_PRESENT != 0x1000);
+
 			PPC_LHZ_OFFS(r_A, r_skb, offsetof(struct sk_buff,
 							  vlan_tci));
 			if (code == (BPF_ANC | SKF_AD_VLAN_TAG))
-				PPC_ANDI(r_A, r_A, VLAN_VID_MASK);
+				PPC_ANDI(r_A, r_A, ~VLAN_TAG_PRESENT);
 			else
 				PPC_ANDI(r_A, r_A, VLAN_TAG_PRESENT);
 			break;
-- 
2.0.0
