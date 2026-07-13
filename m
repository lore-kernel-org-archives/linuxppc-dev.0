Return-Path: <linuxppc-dev+bounces-24151-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8383C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 22:34:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzcgL05lRz2xWY;
	Tue, 14 Jul 2026 08:34:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783971622;
	cv=none; b=nN/YvLYS6FijBCh8C98xGvZVkwQLFDgZYO8WUEMHfZIMQSer7FvGIO4T+eqLptHfIeZ2OSNKqW0PGKLorHVU7DnyeBUT2qNlQ82FSiwATPvVwxxKT1+FVKECJsG4vw5Qv9uzjgpcu2HfRvcnqwXkxpb54HBxpIFyh3XOIO4c+0Smfc8y9CtvEqA3DhYro/Ru/y9Ft/te9IMy+GcOHUJnI5OeOv1vqSHlGY7LSh2fsqmYs6/AZoLGMcQPCZA12H59tImzBpOo5moSICsNdvjk5LshNemlaTzc2rK8PvG9gFOJF5F69sjs56tR20BHacvJPzUpNocGPHA95Escbkr/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783971622; c=relaxed/relaxed;
	bh=2Anq+ZgEfX5t6X9Q7TePAbPIwtsyngsq62Z1m8/YM/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSHKQLzze679RNlwDi3ASMx/wd3dTySuiyLSzT5AFWdjVSx80ilB2uNOMuY1s3i2RfHFljl7OFNTheWq3Xq7F2W5MFDx2tf5JwbLIrMmkdCY/oSF1hd/IroJQw4vpxqPtl7k52ib1D32szLa83sENVNwf5WWA0V8EhR3cKQlFxZv4o4918fK2vJKLb3I7WAoHiKL9Ts3i4b844PEsrHUvLGzAtaIkurPVqN6fqfTxw+vtk/RX3snbAIlyR1Y4XzqO87erOSuCOEQ7JU8MlStHqaHiGdPxP+0Q028C9m3hbv33rjQFh+FXYsPTH4O9FOWEEA2LRT2BKDvjJ4YtFIGHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=0sec.ai; dkim=temperror header.d=0sec.ai header.i=@0sec.ai header.a=rsa-sha256 header.s=google header.b=fPxMVcvH; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=doruk@0sec.ai; receiver=lists.ozlabs.org) smtp.mailfrom=0sec.ai
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: lists.ozlabs.org;
	dkim=temperror header.d=0sec.ai header.i=@0sec.ai header.a=rsa-sha256 header.s=google header.b=fPxMVcvH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=0sec.ai (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=doruk@0sec.ai; receiver=lists.ozlabs.org)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzXpY2CDVz3046
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:40:20 +1000 (AEST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso2183919f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 12:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783971618; x=1784576418; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Anq+ZgEfX5t6X9Q7TePAbPIwtsyngsq62Z1m8/YM/k=;
        b=fPxMVcvHcISegy2VjxE31LTx5Ept0lJBAWEKMr6vc6ewwDBR3DRfaIVhR/i8RPr66l
         Q/FxU9C2wbWiZ1suss6vdJY9bnG14+w++HpZ/2jAQc+zoI8tAZ1sk8TKumSch9tDdfeR
         nydxC5VYqvb6XmD0X/kY1/5/OJ04VzGE3yANWwO98NAVAiTTCEJzLh5K588g8TZvAv3U
         dAUJCLpZL7d8hjCkq7NSACxfYovgbuAauAL/4V/WT0c7+xix2O5ON5CJi+LKwZpe2fzi
         91x6K89RnwnXtWPcWQv9R4kG7kR1QWYnnrdHZ55eNh8pV1uBAbJn4HIxH7Ud4BGvHeJS
         aneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971618; x=1784576418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Anq+ZgEfX5t6X9Q7TePAbPIwtsyngsq62Z1m8/YM/k=;
        b=Bb14O7ty95djSJM2zHCtCCCKv0bv5mJNFE0mEgoBuq4fQV0w306mqe0L4UA616yrZE
         d2IG/mjccNWTNwytFQu6dDpwPYv6M4Ql2k3a7xLcmkthaORlvOSVdgF0azEtnG2YU/8w
         n+ZyXCFoqr5NtLxsT/hW132zpSqDNyUewKYpzJXxbgIbpMPa4cFj4pTPoiYal7aJ+Cps
         8jCpzfgV+rghvCnRjtqGSblI5+f80udsZPtzrIeKJREglPPZeGVgJDpKYSvRRsdJRb1g
         aZVmC22CI8m8yKCN4S9JRBcVN0WcZKZ3mKhMqLuhliZGb7iPsoxtG2GE7s/2pMTy74TD
         rgOA==
X-Forwarded-Encrypted: i=1; AHgh+Rp8+nLYGl/ucKOVesFr+oCJ6qrYR996mMwbTdWYczAREIcnL3hBtbaxRF7esKIVLShTnsauftZ2eBaKQO0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx1QTL4WzbgDGf7tTFu0ZDT7nMvfPovcKVBklq7PN6lsFiG8E+9
	vohzeVh1UcZrC013HDXzfetalmJrVAi4PsnHsVcVeCEC7mDHoI3Ve5dqj+6jXJTxeShO
X-Gm-Gg: AfdE7cnk5b7Z+sfaRjYF02ARndLRovPpwClMrOVeDoGsb4sn7SVt2TRVT6uEE1tD6bD
	EB7vWf/ppktvx11cWhhDWykxA0Ok144EzeYFw5dBu7tBreVU+nG81TAvcAlnEik3706nXL5L+37
	Np+uPOOWN3yG+Cf5LsPEkFegyOJStvHNd29nCwHgi3sg3Z/ltHVHLqZ2sz+TTdPWZH/kTqEJ7OM
	dwxc3I+0QHS/KbEkinvrqvsPvylDs9ULizHzZwicjhiKqoO1GFu191VbMG1OnJ6DO2kw4CjCYwR
	1mQM5D8sptUaDg4cQzY5Q4fcgbFvScZiQbME9sgG5DIOpKLE6r70hVL520k4LaBxyvD9abSPCN8
	445dov5PXh7BikXWoRsTvKWj9x5yY/Fabk/mJchlBvvErH3w6GBCQey4RJD4TE3PLx9gZa6E05T
	jIJyJ8blgFJDRr7knQvVLQD5tsE0Z7t4brHO5SFzfzDxdwyu1p9+lZVEe4T/HH8DcdEpsHurYrg
	4SmEs7oVVXocEDcAtnIe4X2q8t/8mw1Out3h70eOs7kVg==
X-Received: by 2002:a05:6000:2908:b0:46d:9871:1a44 with SMTP id ffacd0b85a97d-47f2dcc5c1amr11070214f8f.32.1783971617968;
        Mon, 13 Jul 2026 12:40:17 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c4320sm1648928f8f.32.2026.07.13.12.40.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 12:40:17 -0700 (PDT)
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
Subject: [PATCH net 2/3] net: dsa: tag_ksz: don't read an unset MAC header in lan937x_xmit()
Date: Mon, 13 Jul 2026 21:40:09 +0200
Message-ID: <20260713194010.54642-3-doruk@0sec.ai>
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

lan937x_xmit() reads the Ethernet header via eth_hdr(skb) to test the
destination address. The sibling xmit paths in this file (ksz8795_xmit,
ksz9477_xmit, ksz9893_xmit) already use skb_eth_hdr(); lan937x_xmit() is
the lone hold-out.

On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path the skb
reaches ndo_start_xmit() with the MAC header unset, so eth_hdr(skb)
resolves to skb->head + (u16)~0 and the read is out of bounds.

On the TX path the L2 header is at skb->data, so use skb_eth_hdr(), as
done for the same class by
commit f5089008f90c ("macsec: don't read an unset MAC header in macsec_encrypt()")
and commit 96cc4b69581d ("macvlan: do not assume mac_header is set in macvlan_broadcast()").

Fixes: 092f875131dc ("net: dsa: tag_ksz: add tag handling for Microchip LAN937x")
Cc: stable@vger.kernel.org
Found by 0sec automated security-research tooling (https://0sec.ai).
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/dsa/tag_ksz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index 67fa89f102e0..4f74336ae396 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -430,7 +430,7 @@ static struct sk_buff *lan937x_xmit(struct sk_buff *skb,
 	u16 queue_mapping = skb_get_queue_mapping(skb);
 	u8 prio = netdev_txq_to_tc(dev, queue_mapping);
 	struct dsa_port *dp = dsa_user_to_port(dev);
-	const struct ethhdr *hdr = eth_hdr(skb);
+	const struct ethhdr *hdr = skb_eth_hdr(skb);
 	__be16 *tag;
 	u16 val;
 
-- 
2.43.0


