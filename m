Return-Path: <SRS0=qQPY=NV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA39CC43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 19:28:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33BCB20892
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 19:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="ZLKjTAKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BCB20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42sn9l12NwzF2HT
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Nov 2018 06:28:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="ZLKjTAKs";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=rere.qmqm.pl
 (client-ip=91.227.64.183; helo=rere.qmqm.pl;
 envelope-from=mirq-linux@rere.qmqm.pl; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="ZLKjTAKs";
 dkim-atps=neutral
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42smhV2BJfzF3Zj
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Nov 2018 06:06:18 +1100 (AEDT)
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with ESMTPSA id 42smVT494Tzq9;
 Sat, 10 Nov 2018 19:57:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1541876257; bh=VCh6R86qmMZYogx16YtN7dV1PcbueAGoAZwrdAIG+J8=;
 h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
 b=ZLKjTAKssQ0Sd/cLYTgbmXt+w3Itc3yrjnFIcxkUF17WE/ZYLcCuTOy4uZIMQxTh+
 Z2nMG9hHgS0zB4cf0PuWt5BYvKN4X6CshtuAKdkOneiZ9gN+wkNjC26X4hvkcLopxM
 /UmAW5/LqCZfVmVmHeiiyvNjDY6VsBUb0r0axvvZs8fGP4k9gaZLxnswF82S+hFBsX
 JEV20p6Cwo4UQFmEbPWnWYPh42ZR5Tn4qHUKhvoIQ+Ar7Py+E1BlhIakWDbLRaTqwX
 L4/eMX7BrdnYH73rLQJmMZ2vMiMdMc+VzMZuqVIuxJnpInnG0l3Hssx3wgki4voO4D
 lM3aNKDBFxejw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at mail
Date: Sat, 10 Nov 2018 19:58:36 +0100
Message-Id: <c2d068eea7da53242e12b750306af96e74cfae66.1541876179.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH net-next 6/6] net: remove VLAN_TAG_PRESENT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: netdev@vger.kernel.org
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mips@linux-mips.org, Daniel Borkmann <daniel@iogearbox.net>,
 James Hogan <jhogan@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Replace VLAN_TAG_PRESENT with single bit flag and free up
VLAN.CFI overload. Now VLAN.CFI is visible in networking stack
and can be passed around intact.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 arch/mips/net/bpf_jit.c          |  3 ---
 arch/powerpc/net/bpf_jit_comp.c  |  3 ---
 arch/sparc/net/bpf_jit_comp_32.c |  4 ----
 include/linux/if_vlan.h          | 11 ++++++-----
 include/linux/skbuff.h           | 16 +++++++++-------
 lib/test_bpf.c                   | 14 ++++++++------
 net/core/filter.c                |  6 ------
 7 files changed, 23 insertions(+), 34 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index de4c6372ad9a..3a0e34f4e615 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -1164,9 +1164,6 @@ static int build_body(struct jit_ctx *ctx)
 						  vlan_tci) != 2);
 			off = offsetof(struct sk_buff, vlan_tci);
 			emit_half_load_unsigned(r_A, r_skb, off, ctx);
-#ifdef VLAN_TAG_PRESENT
-			emit_andi(r_A, r_A, (u16)~VLAN_TAG_PRESENT, ctx);
-#endif
 			break;
 		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
 			ctx->flags |= SEEN_SKB | SEEN_A;
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index dc4a2f54e829..91d223cf512b 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -383,9 +383,6 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 
 			PPC_LHZ_OFFS(r_A, r_skb, offsetof(struct sk_buff,
 							  vlan_tci));
-#ifdef VLAN_TAG_PRESENT
-			PPC_ANDI(r_A, r_A, ~VLAN_TAG_PRESENT);
-#endif
 			break;
 		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
 			PPC_LBZ_OFFS(r_A, r_skb, PKT_VLAN_PRESENT_OFFSET());
diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
index 48f3c04dd179..84cc8f7f83e9 100644
--- a/arch/sparc/net/bpf_jit_comp_32.c
+++ b/arch/sparc/net/bpf_jit_comp_32.c
@@ -553,10 +553,6 @@ void bpf_jit_compile(struct bpf_prog *fp)
 				break;
 			case BPF_ANC | SKF_AD_VLAN_TAG:
 				emit_skb_load16(vlan_tci, r_A);
-#ifdef VLAN_TAG_PRESENT
-				emit_loadimm(~VLAN_TAG_PRESENT, r_TMP);
-				emit_and(r_A, r_TMP, r_A);
-#endif
 				break;
 			case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
 				__emit_skb_load8(__pkt_vlan_present_offset, r_A);
diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 1be5230921b5..7a541eadf78e 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -66,7 +66,6 @@ static inline struct vlan_ethhdr *vlan_eth_hdr(const struct sk_buff *skb)
 #define VLAN_PRIO_MASK		0xe000 /* Priority Code Point */
 #define VLAN_PRIO_SHIFT		13
 #define VLAN_CFI_MASK		0x1000 /* Canonical Format Indicator */
-#define VLAN_TAG_PRESENT	VLAN_CFI_MASK
 #define VLAN_VID_MASK		0x0fff /* VLAN Identifier */
 #define VLAN_N_VID		4096
 
@@ -78,8 +77,8 @@ static inline bool is_vlan_dev(const struct net_device *dev)
         return dev->priv_flags & IFF_802_1Q_VLAN;
 }
 
-#define skb_vlan_tag_present(__skb)	((__skb)->vlan_tci & VLAN_TAG_PRESENT)
-#define skb_vlan_tag_get(__skb)		((__skb)->vlan_tci & ~VLAN_TAG_PRESENT)
+#define skb_vlan_tag_present(__skb)	((__skb)->vlan_present)
+#define skb_vlan_tag_get(__skb)		((__skb)->vlan_tci)
 #define skb_vlan_tag_get_id(__skb)	((__skb)->vlan_tci & VLAN_VID_MASK)
 #define skb_vlan_tag_get_prio(__skb)	(((__skb)->vlan_tci & VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT)
 
@@ -480,7 +479,7 @@ static inline struct sk_buff *vlan_insert_tag_set_proto(struct sk_buff *skb,
  */
 static inline void __vlan_hwaccel_clear_tag(struct sk_buff *skb)
 {
-	skb->vlan_tci = 0;
+	skb->vlan_present = 0;
 }
 
 /**
@@ -492,6 +491,7 @@ static inline void __vlan_hwaccel_clear_tag(struct sk_buff *skb)
  */
 static inline void __vlan_hwaccel_copy_tag(struct sk_buff *dst, const struct sk_buff *src)
 {
+	dst->vlan_present = src->vlan_present;
 	dst->vlan_proto = src->vlan_proto;
 	dst->vlan_tci = src->vlan_tci;
 }
@@ -526,7 +526,8 @@ static inline void __vlan_hwaccel_put_tag(struct sk_buff *skb,
 					  __be16 vlan_proto, u16 vlan_tci)
 {
 	skb->vlan_proto = vlan_proto;
-	skb->vlan_tci = VLAN_TAG_PRESENT | vlan_tci;
+	skb->vlan_tci = vlan_tci;
+	skb->vlan_present = 1;
 }
 
 /**
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 99f38779332c..b9aa0d1b21cf 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -777,6 +777,14 @@ struct sk_buff {
 	__u8			encap_hdr_csum:1;
 	__u8			csum_valid:1;
 
+#ifdef __BIG_ENDIAN_BITFIELD
+#define PKT_VLAN_PRESENT_BIT	7
+#else
+#define PKT_VLAN_PRESENT_BIT	0
+#endif
+#define PKT_VLAN_PRESENT_OFFSET()	offsetof(struct sk_buff, __pkt_vlan_present_offset)
+	__u8			__pkt_vlan_present_offset[0];
+	__u8			vlan_present:1;
 	__u8			csum_complete_sw:1;
 	__u8			csum_level:2;
 	__u8			csum_not_inet:1;
@@ -784,8 +792,8 @@ struct sk_buff {
 #ifdef CONFIG_IPV6_NDISC_NODETYPE
 	__u8			ndisc_nodetype:2;
 #endif
+
 	__u8			ipvs_property:1;
-
 	__u8			inner_protocol_type:1;
 	__u8			remcsum_offload:1;
 #ifdef CONFIG_NET_SWITCHDEV
@@ -816,12 +824,6 @@ struct sk_buff {
 	__u32			priority;
 	int			skb_iif;
 	__u32			hash;
-#define PKT_VLAN_PRESENT_BIT	4	// CFI (12-th bit) in TCI
-#ifdef __BIG_ENDIAN
-#define PKT_VLAN_PRESENT_OFFSET()	offsetof(struct sk_buff, vlan_tci)
-#else
-#define PKT_VLAN_PRESENT_OFFSET()	(offsetof(struct sk_buff, vlan_tci) + 1)
-#endif
 	__be16			vlan_proto;
 	__u16			vlan_tci;
 #if defined(CONFIG_NET_RX_BUSY_POLL) || defined(CONFIG_XPS)
diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index aa22bcaec1dc..f3e570722a7e 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -39,6 +39,7 @@
 #define SKB_HASH	0x1234aaab
 #define SKB_QUEUE_MAP	123
 #define SKB_VLAN_TCI	0xffff
+#define SKB_VLAN_PRESENT	1
 #define SKB_DEV_IFINDEX	577
 #define SKB_DEV_TYPE	588
 
@@ -725,8 +726,8 @@ static struct bpf_test tests[] = {
 		CLASSIC,
 		{ },
 		{
-			{ 1, SKB_VLAN_TCI & ~VLAN_TAG_PRESENT },
-			{ 10, SKB_VLAN_TCI & ~VLAN_TAG_PRESENT }
+			{ 1, SKB_VLAN_TCI },
+			{ 10, SKB_VLAN_TCI }
 		},
 	},
 	{
@@ -739,8 +740,8 @@ static struct bpf_test tests[] = {
 		CLASSIC,
 		{ },
 		{
-			{ 1, !!(SKB_VLAN_TCI & VLAN_TAG_PRESENT) },
-			{ 10, !!(SKB_VLAN_TCI & VLAN_TAG_PRESENT) }
+			{ 1, SKB_VLAN_PRESENT },
+			{ 10, SKB_VLAN_PRESENT }
 		},
 	},
 	{
@@ -5289,8 +5290,8 @@ static struct bpf_test tests[] = {
 #endif
 		{ },
 		{
-			{  1, !!(SKB_VLAN_TCI & VLAN_TAG_PRESENT) },
-			{ 10, !!(SKB_VLAN_TCI & VLAN_TAG_PRESENT) }
+			{  1, SKB_VLAN_PRESENT },
+			{ 10, SKB_VLAN_PRESENT }
 		},
 		.fill_helper = bpf_fill_maxinsns6,
 		.expected_errcode = -ENOTSUPP,
@@ -6493,6 +6494,7 @@ static struct sk_buff *populate_skb(char *buf, int size)
 	skb->hash = SKB_HASH;
 	skb->queue_mapping = SKB_QUEUE_MAP;
 	skb->vlan_tci = SKB_VLAN_TCI;
+	skb->vlan_present = SKB_VLAN_PRESENT;
 	skb->vlan_proto = htons(ETH_P_IP);
 	dev_net_set(&dev, &init_net);
 	skb->dev = &dev;
diff --git a/net/core/filter.c b/net/core/filter.c
index c151b906df53..10acbc00ff6c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -301,9 +301,6 @@ static u32 convert_skb_access(int skb_field, int dst_reg, int src_reg,
 		/* dst_reg = *(u16 *) (src_reg + offsetof(vlan_tci)) */
 		*insn++ = BPF_LDX_MEM(BPF_H, dst_reg, src_reg,
 				      offsetof(struct sk_buff, vlan_tci));
-#ifdef VLAN_TAG_PRESENT
-		*insn++ = BPF_ALU32_IMM(BPF_AND, dst_reg, ~VLAN_TAG_PRESENT);
-#endif
 		break;
 	case SKF_AD_VLAN_TAG_PRESENT:
 		*insn++ = BPF_LDX_MEM(BPF_B, dst_reg, src_reg, PKT_VLAN_PRESENT_OFFSET());
@@ -6152,9 +6149,6 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 		*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
 				      bpf_target_off(struct sk_buff, vlan_tci, 2,
 						     target_size));
-#ifdef VLAN_TAG_PRESENT
-		*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg, ~VLAN_TAG_PRESENT);
-#endif
 		break;
 
 	case offsetof(struct __sk_buff, cb[0]) ...
-- 
2.19.1

