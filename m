Return-Path: <linuxppc-dev+bounces-24153-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE10C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 22:35:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzcj471kXz304Q;
	Tue, 14 Jul 2026 08:35:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783971623;
	cv=none; b=OpN4qIAklrCK37mtytIPPtnglUzkMqzJ9zgyxkDZw6qO1qajIPbH9HsDk87Rrz310ZTBuyqtSrkZDHVRt0VepY1IxO/jsHMYz7qQiyv0xMh36o2sNe070ZRhfhylovLlHmRYZ3FYqSBQhequinrA8/g8qbzoeYHt25Rh5L6t0ZNr1e/21O19ODDu7dK2/uUawjROgBxrkG2BZHjPA3JimfXiRwQs9SF8K0lpEplh81niDpPPCUQGQhQYrizftWJPkdOd3ejk/HhUlmjIo8Rzpq6ZEXLVW+bTgZzR4Jc99mEEFdMoEjVUP/yegE5SgYcKXY6kvK1C5mtR53SLT/i4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783971623; c=relaxed/relaxed;
	bh=FbghttrpgSK5b8Xdtw86Vlcl4tgPfJ678kl/v9nlCUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CVVkyFlrlMQ8zXAIlAk3xzFv8xQEcb1JrBxJOlZOX7VxBuLYT6bHA7yuMwAB4AjjodKOk+UiyNbv0jVK7m5yC4qDQ9wKH4rdUL1DjjY3ymPhip1lI9sgyhuEijMNrjXf0eMkOkI8O+ciHERlqmkP1mvpcejnkUi1TaAMYmZCIFxdxiIYCZ8Y1xiEhyE1wicZVCA2IAZsV13tsEOKy0Vnio7WOfs55Ayu8OxVJLAdiubZWklw6/H3NaKBW7S2lk8dyMB7FHZF0QUCh2RUnN87imfirL1YjNgF3R1/sqDMamE+br9C407rQvQxjz82wtiYMS8S0BFGc6ImKyL8nPTF0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=0sec.ai; dkim=temperror header.d=0sec.ai header.i=@0sec.ai header.a=rsa-sha256 header.s=google header.b=TVcOxG0X; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=doruk@0sec.ai; receiver=lists.ozlabs.org) smtp.mailfrom=0sec.ai
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: lists.ozlabs.org;
	dkim=temperror header.d=0sec.ai header.i=@0sec.ai header.a=rsa-sha256 header.s=google header.b=TVcOxG0X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=0sec.ai (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=doruk@0sec.ai; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzXpZ13pCz304Q
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:40:22 +1000 (AEST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-47df440fcd5so1934954f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 12:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783971614; x=1784576414; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FbghttrpgSK5b8Xdtw86Vlcl4tgPfJ678kl/v9nlCUw=;
        b=TVcOxG0XakIB64J0FaakiMit5c7JU4ay90Jba7wr066MTOe1u64JW7xWFwPINpdU9a
         GC4PEZJLL3raR80KkB5IDPAzgYP+32QclWn8oerZEA9Oe/iAUK0mXUzkNXfP+fjFwBKn
         saJtlFl3Lzs3OiZCPT3TaBd1rfX0f1POq0L0USm5X4b9wyNcRwzF0Rt7EGUvJzDpiPnt
         sPVtyAdQMIZUAadKYQCtfU6kP9dlp3bQZpVbmFjW72Pef9h4T25g1/YsFdJd03pjejtP
         yr1rQ2d/zgyBOVz3houcFYHYGTpAIsEKCxm0lGmp5o+UNLbsUdHuXD+dzWHh7FKsXLJb
         aYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971614; x=1784576414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FbghttrpgSK5b8Xdtw86Vlcl4tgPfJ678kl/v9nlCUw=;
        b=JNue6zwNz1+Tba/8pcED/h6x5ao18EOgainh9ALEpg5se/XJfTJevBmtp9Q7eRe+CH
         vJkSmYH+BLg4uyX3sZ2OJWBkhVrYMr7Qf4oQSmzgU12js19RNjTkTYoSiyqYhnv/VP/D
         EuzXtrH+N4I6zIutC8EY1kut5OxW8K15RS8Ve0yH0qooteexFeSZ3HfKaKGG7pIwndOO
         cQpn1AjY8opTwKOs+6MHN+L82jyRA6rsv7OSeHFuvQ2mjZQLrx8sJZbcLhrTY1CT9QHD
         BFL4hqETOskzR7f0LYNxWID7dAoPZz41qRo41IqVuTDVdkeNJqW06pLKWteRfAXFLrt8
         PU3w==
X-Forwarded-Encrypted: i=1; AHgh+RoeTFhX19vsLSVeDBFChpXUHrj1vbzM/+DsvRfOhQOxTS1dzzLtlgd39XNbxHZF8hmA//oCyCIcR0rxba4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YySwcHbDX3tUSex98TivfSZShWJX2D04KVlnCjAcPp/RXhEuWb8
	+DenOiIOS19IG27eYbD2T/oITNL5oBsKWe7iL4lIiRD9+Qt8mIily3j7YDqYpYixeae+
X-Gm-Gg: AfdE7cmeHxdw2ES1HaAUgr97Ag1lfokp51ZDjVLeJBstMQkTOjzru5zo5xAnv03WZ65
	KBGvYew5n4B4XT3GyQXXmNoS5hZ6xylrSzKm3lzDdAiDoQfbqgPM1RPGIM/y4lYJY/0qlgqUqXJ
	OjqvZwNA4p8JZ+Q1y/57u4wiIDwZuXGWK2dED7LfUt2vIsOgqNJvtN/KQ4dlhYZ+xSAGeG6h/LB
	WTSoL7ZViYpCKbgQqj3czp2D7n4AYw6wBwsCL/qCKuRbjMqNBdQIRrpK6kSxXSJN0Vl7452AUhq
	J9oZHZ/O/+4M9D63vZexeazRgo8dVRj/BD1W6EKeVvadZycuU/gTjX/e0CQSeIRhkKw5u5rfTN1
	Mk5/nQ1LX6d3ll28vhgPbRmjOl2X+vAhrVWMF8K+BztqJXTtyEFcjLSxHygd08uM7Eb3E4tvDdA
	69a2hZwxAHnuCmmtA3qMpqZUfzplIDkAS+ehf2jQCi3aBNapPynCIuvw3Qm26DA/CJ7moMyu7Pm
	VObosBT/gVFWj9dJP45UQw40xhi1Jf2ff4=
X-Received: by 2002:a05:6000:240b:b0:475:f100:3607 with SMTP id ffacd0b85a97d-47f2dd02d0cmr13200382f8f.54.1783971614013;
        Mon, 13 Jul 2026 12:40:14 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c4320sm1648928f8f.32.2026.07.13.12.40.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 12:40:13 -0700 (PDT)
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
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH net 0/3] net: don't read an unset MAC header on the raw/qdisc-bypass TX path
Date: Mon, 13 Jul 2026 21:40:07 +0200
Message-ID: <20260713194010.54642-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
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

On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path, skb->mac_header
is left unset when ndo_start_xmit() runs, so eth_hdr(skb) resolves ~64KB out of
bounds. Commit f5089008f90c ("macsec: don't read an unset MAC header in
macsec_encrypt()") fixed one instance; these three are the same class in other
TX/.xmit paths, each reading eth_hdr(skb)->h_dest. On TX the L2 header is at
skb->data, so use skb_eth_hdr() (a no-op on normal TX where mac_header is set).

Found by static analysis (0sec); verified against source, not runtime-reproduced.
Confirmed by an independent cross-check that mac_header is unset on the bypass
path (__dev_direct_xmit does not reset it). More siblings exist (sja1105 shared
TX/RX helper, atlantic PTP path) and will follow separately.


Doruk Tan Ozturk (3):
  net: dsa: tag_ocelot_8021q: don't read an unset MAC header on transmit
  net: dsa: tag_ksz: don't read an unset MAC header in lan937x_xmit()
  ibmveth: don't read an unset MAC header on transmit

 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 net/dsa/tag_ksz.c                  | 2 +-
 net/dsa/tag_ocelot_8021q.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.43.0


