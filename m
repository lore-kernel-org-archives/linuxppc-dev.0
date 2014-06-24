Return-Path: <kda@linux-powerpc.org>
Received: from mail-lb0-f171.google.com (mail-lb0-f171.google.com
 [209.85.217.171])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7BA491A0244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 20:24:25 +1000 (EST)
Received: by mail-lb0-f171.google.com with SMTP id s7so115993lbd.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 03:24:20 -0700 (PDT)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: netdev@vger.kernel.org
Subject: [PATCH 1/2] powerpc: bpf: Use correct mask while accessing the VLAN
 tag
Date: Tue, 24 Jun 2014 13:59:28 +0400
Message-Id: <1403603969-24436-1-git-send-email-kda@linux-powerpc.org>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the proper mask which is 0xefff
---
 arch/powerpc/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 6dcdade..af0ed4d 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -393,7 +393,7 @@ static int bpf_jit_build_body(struct sk_filter *fp, u32 *image,
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
