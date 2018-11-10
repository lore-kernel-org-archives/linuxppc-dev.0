Return-Path: <SRS0=qQPY=NV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB4EC43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 19:19:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA46D20684
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 19:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="kJQ9CTvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA46D20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42smzX1lrZzDr42
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Nov 2018 06:19:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="kJQ9CTvN";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=rere.qmqm.pl
 (client-ip=91.227.64.183; helo=rere.qmqm.pl;
 envelope-from=mirq-linux@rere.qmqm.pl; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="kJQ9CTvN";
 dkim-atps=neutral
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42smhN3gmczF3Zh
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Nov 2018 06:06:12 +1100 (AEDT)
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with ESMTPSA id 42smVT0X23zf5;
 Sat, 10 Nov 2018 19:57:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1541876257; bh=mVtkuJmMB9DTnY2jQezAsUappvlEflWkjDeKGbqdMS0=;
 h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
 b=kJQ9CTvNJ+dWaoNyqPYIRl/tEoXSLQBozhsnBsbvPPeflS3kdu9uqWCeugMd7RJDT
 OL/a/vuEn72Rnzc8Houzf0DoEF7W2L6h+x7b78vgbw/YZwmHzgIEjNStJ+KM8xCf3T
 cSupWem/M9pjEfKPVhTTjro1bVHpBBfG8UkG68Ugt/GwJGpPDsQ8lC2fshwPNvLQLr
 14czQLFyCMZMDL5pR0MRHrncso1hnvM2EMKPtg8BZJI0woDy/0MzLQqVysI72ZKWCH
 m+CU0j0zPeuSORlarUFWfK1ti4RAHGNgcvayDhivl0Lk+U+Jz8kUZLCWxshgpHvKGx
 6DvX34EkKsTTg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at mail
Date: Sat, 10 Nov 2018 19:58:36 +0100
Message-Id: <4508dbca71009d191036155ec1a187455605577e.1541876179.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH net-next 5/6] net/bpf_jit: SPARC: split VLAN_PRESENT bit
 handling from VLAN_TCI
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
 Alexei Starovoitov <ast@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>, Paul Mackerras <paulus@samba.org>,
 James Hogan <jhogan@kernel.org>, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 arch/sparc/net/bpf_jit_comp_32.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
index a5ff88643d5c..48f3c04dd179 100644
--- a/arch/sparc/net/bpf_jit_comp_32.c
+++ b/arch/sparc/net/bpf_jit_comp_32.c
@@ -552,15 +552,18 @@ void bpf_jit_compile(struct bpf_prog *fp)
 				emit_skb_load32(hash, r_A);
 				break;
 			case BPF_ANC | SKF_AD_VLAN_TAG:
-			case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
 				emit_skb_load16(vlan_tci, r_A);
-				if (code != (BPF_ANC | SKF_AD_VLAN_TAG)) {
-					emit_alu_K(SRL, 12);
+#ifdef VLAN_TAG_PRESENT
+				emit_loadimm(~VLAN_TAG_PRESENT, r_TMP);
+				emit_and(r_A, r_TMP, r_A);
+#endif
+				break;
+			case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
+				__emit_skb_load8(__pkt_vlan_present_offset, r_A);
+				if (PKT_VLAN_PRESENT_BIT)
+					emit_alu_K(SRL, PKT_VLAN_PRESENT_BIT);
+				if (PKT_VLAN_PRESENT_BIT < 7)
 					emit_andi(r_A, 1, r_A);
-				} else {
-					emit_loadimm(~VLAN_TAG_PRESENT, r_TMP);
-					emit_and(r_A, r_TMP, r_A);
-				}
 				break;
 			case BPF_LD | BPF_W | BPF_LEN:
 				emit_skb_load32(len, r_A);
-- 
2.19.1

