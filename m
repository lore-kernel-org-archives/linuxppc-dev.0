Return-Path: <linuxppc-dev+bounces-24154-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99656C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 22:36:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzcjC1Mjxz2xWY;
	Tue, 14 Jul 2026 08:35:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783971623;
	cv=none; b=A8LMUnxR7yNPfO7CPM903+3qUkZSre1cqZLzUsDqaeU6qpNWFXH83FPoxT18W+VZNKepSsOmrl1emh/1kdwC2CCFWHLHTzDi7UTUqQJgFEfZ9t3suFM56NPZz6SF1TLvp140x8YJ+h0JX+QRnFnQB3ln4oW65sRtCYgkQCGNqTplIS/xpq5O6QntQc2nlX3HmRC6H6cPsDqaenqWkbQdosdToJ9JanAq8rdVxROaT4+Rb5/8B1K7tybyRhKaDODdAzXffb4/rM3qs2eC40GPIDDky7RN+GZkmk6b3gIUPWnn27SLR6aMtpR1annFjtZo8dSfEMQlRzFK/1IyQktxRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783971623; c=relaxed/relaxed;
	bh=8SE6mH/eebwrYuJdjdXRg/YfI81pgkyA3KxLJxVspBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6CEUIvVw3E0juWokYr9Sg3/OziUfA/aW62mRhJXEHGFcQ3IOCNvj+O/5TL9fSl7tvjFW1cmP+lmU04XQGLHjPIq8IqQ75vhiUbxg+yehAIN0XyIiyu7170ZO+bZ8YCTAJf05coOVFAZ/eAPUIQEILfjeRlVvshEjwscF4Fg4Nqq/uxW3ZYiNdgHE/X50T7LBhAfyuTalDi/REbbLl74yKwmNhnkCMeRXGl9QHfoqWqrYuAUMT1dX49AyTnPuye8JduDKUWAy84WbBOT2erMyu8pDvEYk55Qs9vPrkR3QRMWYZzPePnhPOzeuiN0kvbrgSqxLcPG/Pp83pSnpz/r1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=0sec.ai; dkim=temperror header.d=0sec.ai header.i=@0sec.ai header.a=rsa-sha256 header.s=google header.b=Pm7ePg/T; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=doruk@0sec.ai; receiver=lists.ozlabs.org) smtp.mailfrom=0sec.ai
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: lists.ozlabs.org;
	dkim=temperror header.d=0sec.ai header.i=@0sec.ai header.a=rsa-sha256 header.s=google header.b=Pm7ePg/T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=0sec.ai (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=doruk@0sec.ai; receiver=lists.ozlabs.org)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzXpZ70bJz3046
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:40:22 +1000 (AEST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-47640541585so1683253f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 12:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783971620; x=1784576420; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8SE6mH/eebwrYuJdjdXRg/YfI81pgkyA3KxLJxVspBM=;
        b=Pm7ePg/T22At/2mkaBpGONJ+XH/r2Fgn59habIlhas3lDWGTHhoYJ5VD1rybUovXbq
         vCvgeHo9oPMtQry6/xxkSKHUSnc3hMXzJz80qvTpvGnvTYJT+sCrgtbrlLpIFzcMErSE
         d1U6QpKsKDUNCw8lKfKaSe2BvS9DzvxIp9IF8xLCvxycWv9avCHqf44AbUoasEtP6W1j
         HP5rfCJqrjWKgYOZqP5DppfLmRggq0jVNc5Ds+s3EiT3d+u4eETOFN6JMM411jI4EM7g
         U/oKokhtd2FsXFp5M6OFVg4uWRt6u+BRWyfmI6fUJ9p8sa7ezJnVOjyeTai9v7UcXFs4
         jQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971620; x=1784576420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8SE6mH/eebwrYuJdjdXRg/YfI81pgkyA3KxLJxVspBM=;
        b=AqLKN7Mp20Y6FAiKWHnCJlLP5/zDq9xteQ7Cu6A6TLHDqZAdBHxYTP5moDzIqIdf3B
         pCN9sbU/sC8AjXHlAU1YsIwlCMOGQa93mHwLuIxzncprBAa4u1DrtScA2jGkJLTLOSWz
         5UEgTKBcHYNxMQQofba6uB4qE1QOIUf0ciC6l4PPiRUZd4XaWznaS4VleLfACCexrYbx
         ncLk+adf6QOFBApvlf0ByI8aYoJ8s8bh5ZEykwuKR+zKtUf+65DyMO1TQUebsFG82q+b
         JV+jvEvSYmvX1n5SYGotPWhEOZAwr3kQNlAXt71VN1B0G+FsgMog5jdJghBAF44D5m5R
         JG6w==
X-Forwarded-Encrypted: i=1; AHgh+RrRIv3CXFpzM37ybiZn7swByCUwL9ZnIwBqD7O3isHL7T4tyXic6e2QzrfLId677ZnOBE7rxmhiGbNRcmk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyc3/rvhKamdOiM5ZP9drRj5Tjc+m672EoBkHUMfdyYuIehuVZC
	i9s4AWXlbcNncCjTlAIkZ7OBKedEfgYtoAWOcgm9CQswmcbrBmuGPa2mcNNOOce/7B62
X-Gm-Gg: AfdE7clGVN2HRlEyk7msG53GFwPFDdtloTo/hgqbuS+LWWWJe74wjXkse92kdKZOtpA
	hmdsXjXAciXaDNF95nF9bkB2UpRyfh9yDOz3/NtZqt4RaMXE/+CoPDL3Sge8vZl+neLomyQJY6c
	fjvpQTXqDWuF/VpkxVDuc3GRWd70CMCN5XEWkxRnWNYUtnnwOGtt+JerASOe3G0sihqXGkXlWm4
	IDp6W0pxPSrPyoEM7sxkDKQ1W2owJhzd2SqYnb58uq4vjmi1vbF6oh/VPX3kEOlA6WKe1n838FS
	2UbpQOjtUw8OWz7W5rmUVHAClXWlJZtMq5BCqyx7cI1ywnHi/13joNqDmpDGSj4bfwK9W2F169e
	CYbixiDlzUGJRg6KlZMoDtsJYQZdsHbFhozoZd/7yblSctujF3SIWsBvZ5UHbvJRzmpP7pVt5ED
	MGvVcLd3Ih+ySwGxXwkyQcQzlxtHsQoZQfiR1+wMXziSTAPeYcpqnAzOL5x0ObPpQQ9eMIPyA9L
	+bxERTF/8PZGuOC3C9rZePtWDgGzIwFm2o=
X-Received: by 2002:a5d:5846:0:b0:474:9002:c74a with SMTP id ffacd0b85a97d-47f2dced169mr11560342f8f.35.1783971619960;
        Mon, 13 Jul 2026 12:40:19 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c4320sm1648928f8f.32.2026.07.13.12.40.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 12:40:19 -0700 (PDT)
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
Subject: [PATCH net 3/3] ibmveth: don't read an unset MAC header on transmit
Date: Mon, 13 Jul 2026 21:40:10 +0200
Message-ID: <20260713194010.54642-4-doruk@0sec.ai>
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

ibmveth_is_packet_unsupported(), called from ibmveth_start_xmit(), reads
the Ethernet header via eth_hdr(skb) to test the destination address.

On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path the skb
reaches ndo_start_xmit() with the MAC header unset, so eth_hdr(skb)
resolves to skb->head + (u16)~0 and the read is out of bounds.

On the TX path the L2 header is at skb->data, so use skb_eth_hdr(), as
done for the same class by
commit f5089008f90c ("macsec: don't read an unset MAC header in macsec_encrypt()")
and commit 96cc4b69581d ("macvlan: do not assume mac_header is set in macvlan_broadcast()").

Fixes: 6f2275433a2f ("ibmveth: Detect unsupported packets before sending to the hypervisor")
Cc: stable@vger.kernel.org
Found by 0sec automated security-research tooling (https://0sec.ai).
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 73e051d26b9d..88e8bdfbcd11 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1218,7 +1218,7 @@ static int ibmveth_is_packet_unsupported(struct sk_buff *skb,
 	struct ethhdr *ether_header;
 	int ret = 0;
 
-	ether_header = eth_hdr(skb);
+	ether_header = skb_eth_hdr(skb);
 
 	if (ether_addr_equal(ether_header->h_dest, netdev->dev_addr)) {
 		netdev_dbg(netdev, "veth doesn't support loopback packets, dropping packet.\n");
-- 
2.43.0


