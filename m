Return-Path: <SRS0=qQPY=NV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB57C43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 19:11:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69CC9208E3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 19:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="HInmTtoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69CC9208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42smpJ3QqXzF3ZG
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Nov 2018 06:11:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="HInmTtoY";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=rere.qmqm.pl
 (client-ip=91.227.64.183; helo=rere.qmqm.pl;
 envelope-from=mirq-linux@rere.qmqm.pl; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="HInmTtoY";
 dkim-atps=neutral
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42smhN431fzF3Zl
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Nov 2018 06:06:12 +1100 (AEDT)
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with ESMTPSA id 42smVR4wW8zSP;
 Sat, 10 Nov 2018 19:57:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1541876255; bh=PRkyk5xKl4RPlekKn5KiNqkzSob0xFsU6yaGCiOxFq4=;
 h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
 b=HInmTtoYfISs92x+BLLHl7pFOGh9Z2+4Povha2MQ3gQOwndLa2OYBCnFnn9iRXHnV
 bcbtvB/h2VAJC7rOexnEyOxoIK2rq73IgiWnIuHK6RQsjdhvhrVIO+eDFQUn7IwHeD
 tSVpJnMpfOYhjMWo6AbY0QsIKEtL8NqXNkYeSAXK/5LMfFe8bbmIyQ8OlYJYuDhvDv
 /iDKEHoqQ+Yy3C6xjbHoDsOZJ7O0dTTntAWCdssmhVnFK2ALswoVvqrA5qSPstn51/
 ZSsimZeqgyObGKHiqavlk6kWtC6SiTjXrrhLnyPsXNdtHYkvQdEDX4ArG5E4ToUUO/
 miDYgxZV5Sh9A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at mail
Date: Sat, 10 Nov 2018 19:58:35 +0100
Message-Id: <b7fed809fc44d0b439adeb69d0fe98dd036b05e8.1541876179.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH net-next 2/6] net/bpf: split VLAN_PRESENT bit handling from
 VLAN_TCI
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

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 net/core/filter.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index e521c5ebc7d1..c151b906df53 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -296,22 +296,21 @@ static u32 convert_skb_access(int skb_field, int dst_reg, int src_reg,
 		break;
 
 	case SKF_AD_VLAN_TAG:
-	case SKF_AD_VLAN_TAG_PRESENT:
 		BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, vlan_tci) != 2);
-		BUILD_BUG_ON(VLAN_TAG_PRESENT != 0x1000);
 
 		/* dst_reg = *(u16 *) (src_reg + offsetof(vlan_tci)) */
 		*insn++ = BPF_LDX_MEM(BPF_H, dst_reg, src_reg,
 				      offsetof(struct sk_buff, vlan_tci));
-		if (skb_field == SKF_AD_VLAN_TAG) {
-			*insn++ = BPF_ALU32_IMM(BPF_AND, dst_reg,
-						~VLAN_TAG_PRESENT);
-		} else {
-			/* dst_reg >>= 12 */
-			*insn++ = BPF_ALU32_IMM(BPF_RSH, dst_reg, 12);
-			/* dst_reg &= 1 */
+#ifdef VLAN_TAG_PRESENT
+		*insn++ = BPF_ALU32_IMM(BPF_AND, dst_reg, ~VLAN_TAG_PRESENT);
+#endif
+		break;
+	case SKF_AD_VLAN_TAG_PRESENT:
+		*insn++ = BPF_LDX_MEM(BPF_B, dst_reg, src_reg, PKT_VLAN_PRESENT_OFFSET());
+		if (PKT_VLAN_PRESENT_BIT)
+			*insn++ = BPF_ALU32_IMM(BPF_RSH, dst_reg, PKT_VLAN_PRESENT_BIT);
+		if (PKT_VLAN_PRESENT_BIT < 7)
 			*insn++ = BPF_ALU32_IMM(BPF_AND, dst_reg, 1);
-		}
 		break;
 	}
 
@@ -6140,19 +6139,22 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 		break;
 
 	case offsetof(struct __sk_buff, vlan_present):
+		*target_size = 1;
+		*insn++ = BPF_LDX_MEM(BPF_B, si->dst_reg, si->src_reg,
+				      PKT_VLAN_PRESENT_OFFSET());
+		if (PKT_VLAN_PRESENT_BIT)
+			*insn++ = BPF_ALU32_IMM(BPF_RSH, si->dst_reg, PKT_VLAN_PRESENT_BIT);
+		if (PKT_VLAN_PRESENT_BIT < 7)
+			*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg, 1);
+		break;
+
 	case offsetof(struct __sk_buff, vlan_tci):
-		BUILD_BUG_ON(VLAN_TAG_PRESENT != 0x1000);
-
 		*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
 				      bpf_target_off(struct sk_buff, vlan_tci, 2,
 						     target_size));
-		if (si->off == offsetof(struct __sk_buff, vlan_tci)) {
-			*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg,
-						~VLAN_TAG_PRESENT);
-		} else {
-			*insn++ = BPF_ALU32_IMM(BPF_RSH, si->dst_reg, 12);
-			*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg, 1);
-		}
+#ifdef VLAN_TAG_PRESENT
+		*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg, ~VLAN_TAG_PRESENT);
+#endif
 		break;
 
 	case offsetof(struct __sk_buff, cb[0]) ...
-- 
2.19.1

