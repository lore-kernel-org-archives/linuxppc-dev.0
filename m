Return-Path: <mirq@rere.qmqm.pl>
Received: from rere.qmqm.pl (rere.qmqm.pl [84.10.57.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttXy22xMMzDqG9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 12:18:32 +1100 (AEDT)
Message-Id: <e15c116d1c4ffeeab51dd611f64404cd6556cde1.1483492355.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1483492355.git.mirq-linux@rere.qmqm.pl>
References: <cover.1483492355.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH net-next 4/6] net/bpf_jit: PPC: split VLAN_PRESENT bit
 handling from VLAN_TCI
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: netdev@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Date: Wed,  4 Jan 2017 02:18:27 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 arch/powerpc/net/bpf_jit_comp.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 7e706f36e364..22ae63fb9b7d 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -377,18 +377,19 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 							  hash));
 			break;
 		case BPF_ANC | SKF_AD_VLAN_TAG:
-		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, vlan_tci) != 2);
-			BUILD_BUG_ON(VLAN_TAG_PRESENT != 0x1000);
 
 			PPC_LHZ_OFFS(r_A, r_skb, offsetof(struct sk_buff,
 							  vlan_tci));
-			if (code == (BPF_ANC | SKF_AD_VLAN_TAG)) {
-				PPC_ANDI(r_A, r_A, ~VLAN_TAG_PRESENT);
-			} else {
-				PPC_ANDI(r_A, r_A, VLAN_TAG_PRESENT);
-				PPC_SRWI(r_A, r_A, 12);
-			}
+#ifdef VLAN_TAG_PRESENT
+			PPC_ANDI(r_A, r_A, ~VLAN_TAG_PRESENT);
+#endif
+			break;
+		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
+			PPC_LBZ_OFFS(r_A, r_skb, PKT_VLAN_PRESENT_OFFSET());
+			if (PKT_VLAN_PRESENT_BIT)
+				PPC_SRWI(r_A, r_A, PKT_VLAN_PRESENT_BIT);
+			PPC_ANDI(r_A, r_A, 1);
 			break;
 		case BPF_ANC | SKF_AD_QUEUE:
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
-- 
2.11.0
