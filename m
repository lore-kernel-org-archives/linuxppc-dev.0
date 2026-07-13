Return-Path: <linuxppc-dev+bounces-24152-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04500C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 22:35:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzchw3zf9z2xWY;
	Tue, 14 Jul 2026 08:35:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783971622;
	cv=none; b=fD226Oye0tc7XzisIBC1wNDZaGhd+dAg/PWtaiTM9oJBYSz+436456Tr8SoP1Ok5KpYLM1baPKb5QcsC9DSwUYcF8KvaU0TKZZapkFaxi7AclZQgDRR4kSqB104fhd1MLvs92lUmVymA4Xc4o9TIa4UHp5TnW7F1eJ5KRiffPHW02G2FxhMKPg7mpFo52lXkZr7LyEyChk6/NxP+cZNenI0uvWBHu4ZigUr3o00/tVya4nIVCFrdWDDiguEpadFxF1Ta0jTfJMke4CfwMtrccnhGd2DDCsRgjc2bRlwEUs6lmxDznSgEpG1o1/FNAgYLrFvcxG1Oh+zsHdKs8pGiVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783971622; c=relaxed/relaxed;
	bh=W7xWVihr3+KHFM8BLDbVBGdvZbVrj2tho5cLk2/xNCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qgvk7zjBVpOwjxoT54XUt+pdNpNKTS035yFN6SNr1h27wbmISBin5WXAn2D2IpiSqDOxm+24XRDVtFzMkblUfVVv/J6oNnBtPk8XtCCWHKLoDC8a/aj8MwaXeAlfEizW00zjvgX2IGLaDffPbvunIsYzKaLZwfRlJPObXutFDRmP7R55rIVX7yWf7RdjkKRuXQqEXLnXH+7/uoNPWW5qOsnXIcBO3tSpoadg+cJsW+B6GO/+8wBYCkvxqeRacRFsV7NqK9mbqMNy2e2oUyDTDJ7ctxO4tQjx6nxXQZXdWEfpRFeiWT373EVE8Lvcq4D4ugeoiuSm8y9MIll8F44IXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=0sec.ai; dkim=temperror header.d=0sec.ai header.i=@0sec.ai header.a=rsa-sha256 header.s=google header.b=PVxdJu+w; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=doruk@0sec.ai; receiver=lists.ozlabs.org) smtp.mailfrom=0sec.ai
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: lists.ozlabs.org;
	dkim=temperror header.d=0sec.ai header.i=@0sec.ai header.a=rsa-sha256 header.s=google header.b=PVxdJu+w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=0sec.ai (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=doruk@0sec.ai; receiver=lists.ozlabs.org)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzXpX2hwzz303D
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:40:19 +1000 (AEST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-47de0093c42so161432f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 12:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783971616; x=1784576416; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W7xWVihr3+KHFM8BLDbVBGdvZbVrj2tho5cLk2/xNCU=;
        b=PVxdJu+wPyfUZYyZgjZKkplV76XgrYnb9KU+bFzAcPHMx9jIEyqncqogASyeefVgnu
         Av/ksy5wn6FrNihXXHlvn83LU0pGvyhssPZEmR6uwvDzp/wkVK295VlJTrhx5ZAQA8oq
         VhLuErd9K2saylv3ruz2SgqC6RJgotcIh2OtI+SgHZBuLnSevZauHJp8JFqMN3MNT8bV
         MgTvAc4ebkoELcF5h290FQJ6Fs0p0wH/pf9s74jBDsXjc9y6SItp9AcGVSX9XcKxsoJg
         C2GJ0mxpgnAf4Pubqyfld7mGw7ZFvYCG9rCSyFpZgptwvw5QqXZhmOP7F/BOvk5L94OG
         Vuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971616; x=1784576416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W7xWVihr3+KHFM8BLDbVBGdvZbVrj2tho5cLk2/xNCU=;
        b=DQIJeMFX78kDShvMI5x21cADogPdXH/OcHsutwx/rlXLfdbBhVnG4kKIkGAh4Blgom
         DikSwuOz4JH4ELtAJ2OgA7fo9yqRyYvEVKeTCqh/H31dW+we3m7tjwpPU+CXfn37VlMJ
         LzE3qzWzB4/LBR6RdUI+NzEMnB8JleNJ8mkzJcyYHWmPnsa9kx/rrcDapGo1HAaMWKdU
         cW4Pm407B9qvzPQIr23F6giSFsE3tcibPJhl3uL4jawAy2U8Js2nNvfP6wRVlHk5NkWS
         2x830E8RhowHwq5V5uLYeT7NesjgVgyFZfFgPoYRAsimyogE/1MgjzVofbxKN5cR8dy2
         sX2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rre+a02GEPFz8QL9hkCTeht72HpnGt3xkQ69ksf8K7kseI1BJoGGEbn8KmeQQUXKCnqOI+SOI3czpDQ03M=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzRw8v3/J5OdXmMitc5MDcMB5kO4pDNND0lfLXb9AbQt841ur+a
	shbk2RCiwA/+J74yaa9HKcUkLgsk1zUyaphCd7D3pGbNd5ZAe/FiaIMlqcaZ7faq4Y7o
X-Gm-Gg: AfdE7ckAPDd+Pq/EvUfX778tgpp99OGeGpWkVj03nDZckWJCalKRTIvWCd7S93V+9O/
	kGfjnYSENOp3dx5zMjmIOEQlf/BjAya6SgrqQuDKRD4moLNM1lWHFOkmaNf6osNRhIztfqPIYCE
	r16ZOrhlH+kX51Lt/Hj+G96iEw+UXiz3CRltrWMLgRSlOjibpWVMm/9VCgYJhjcqO0rNhBQtq3C
	vPS3UyXAvFkKTQfRfeZNeXSe2PKeisvFHgc+9aKv6zG1v69Lq8bYnQ1ZRkNDFvOhWO6SsypT0mA
	nVZDOqJ91LcXDgwmCmnmMafnlYZib9uG/hdkBgcAyRCXY2AdUWmT/y92o5WzUqr6hnRwVN/kPxu
	Nby95/ywcutDKHHZ7QPCq21l27PCLUqnU05396278bIFOUpdAflzqQjzVPxuYMoV8mYmA1whaXw
	usnRUtgp90JL7n3rfptbmEEV/P6o2RvtGWsFPJhmhWm6C/Bz9uiGpMJfLnSpLa+ViLdYrEupf86
	qWpdQeGUgNsVo80uteogshQ5j+UmKvU5V4=
X-Received: by 2002:a05:6000:24c2:b0:477:6da:1b83 with SMTP id ffacd0b85a97d-47f2dcc8ab8mr11941321f8f.24.1783971616139;
        Mon, 13 Jul 2026 12:40:16 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c4320sm1648928f8f.32.2026.07.13.12.40.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 12:40:15 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Nick Child <nnac123@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH net 1/3] net: dsa: tag_ocelot_8021q: don't read an unset MAC header on transmit
Date: Mon, 13 Jul 2026 21:40:08 +0200
Message-ID: <20260713194010.54642-2-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713194010.54642-1-doruk@0sec.ai>
References: <20260713194010.54642-1-doruk@0sec.ai>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ocelot_xmit() reads the Ethernet header via eth_hdr(skb) to test the
destination address against the link-local range.

On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path the skb
reaches ndo_start_xmit() with the MAC header unset, so eth_hdr(skb)
resolves to skb->head + (u16)~0 and the read is out of bounds.

On the TX path the L2 header is at skb->data, so use skb_eth_hdr(), as
done for the same class by
commit f5089008f90c ("macsec: don't read an unset MAC header in macsec_encrypt()")
and commit 96cc4b69581d ("macvlan: do not assume mac_header is set in macvlan_broadcast()").

Fixes: 43ba33b4f143 ("net: dsa: tag_ocelot_8021q: fix inability to inject STP BPDUs into BLOCKING ports")
Cc: stable@vger.kernel.org
Found by 0sec automated security-research tooling (https://0sec.ai).
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/dsa/tag_ocelot_8021q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/tag_ocelot_8021q.c b/net/dsa/tag_ocelot_8021q.c
index f50f1cd83f16..4514026897d1 100644
--- a/net/dsa/tag_ocelot_8021q.c
+++ b/net/dsa/tag_ocelot_8021q.c
@@ -71,7 +71,7 @@ static struct sk_buff *ocelot_xmit(struct sk_buff *skb,
 	u16 queue_mapping = skb_get_queue_mapping(skb);
 	u8 pcp = netdev_txq_to_tc(netdev, queue_mapping);
 	u16 tx_vid = dsa_tag_8021q_standalone_vid(dp);
-	struct ethhdr *hdr = eth_hdr(skb);
+	struct ethhdr *hdr = skb_eth_hdr(skb);
 
 	if (ocelot_ptp_rew_op(skb) || is_link_local_ether_addr(hdr->h_dest))
 		return ocelot_defer_xmit(dp, skb);
-- 
2.43.0


