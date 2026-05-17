Return-Path: <linuxppc-dev+bounces-21020-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3211FCD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 May 2026 19:29:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJWG76Xhqz2xWP;
	Mon, 18 May 2026 05:29:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779046159;
	cv=none; b=MTJuje1JnqLvf5OX9kGCyQrQrjsO8zhFORjC+jARYPHYpGPRVcN4ifAIwG9k3lWn60fZeg7slz7mbhHMZnqLaWXmmWE+4+XiEJGo6qyMLkjWAujOo3P4hHG6qRyQHfweDy1rpmN2AaJ9nutC9xDB9A1DI6zUb4Y4XX2H4lOzwXNycb4LGR4gH9pe0ooyT+ET4QPmK4tRnZ/ROp1jLu0RZ7JIPCzEv4SpZ9uqBis8X2KAEMsm65RWnuDNoTiZgiehVexTMbSkcPhbKtl9EDX0F0ATpO/6f5B85EDSw4a4lIxAsT7YXutFTyEEzHbfb93jm03THtbRKZwxAhKJbL5Z2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779046159; c=relaxed/relaxed;
	bh=MBYyQ0ZMS6FoSccvFn3m6zDlGuyQLI5sKd09gEPumuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YePbIyYdbtFJYANS8PdbavS4ixF00DOe+QVHnFUUbzq2l33lOPBvMk80lW3ldKTIcfzf/SPgBgo/+OTnv1HEYilCCuCel9dzx/bSGQLtt5Ed1cVpwf7f5jnpZgMHzQOoKnP2R3rJJIa8Su3718x/Zlp3Sr2N/aNlJWGWBSMM+ODXc43QCNCcJdGcSSJ7accdRRkRcgS4H1x/+3wDPJfXtmTuHI+9OfM7L77cC+fYISEJWvqOik5jdNZsmGA2Udiz5WPNQxXrbAgGPvxp2A6ptncrXC0GamA5Raty5ZPk5LY+hT5qtpY8ILCvnCAoiar7EuVbwuKU/1I7oSRQmF28fA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QjlekuT2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QjlekuT2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJWG61WTBz2xVK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 05:29:17 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-366139223e4so657828a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2026 12:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779046155; x=1779650955; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MBYyQ0ZMS6FoSccvFn3m6zDlGuyQLI5sKd09gEPumuQ=;
        b=QjlekuT2XqIXCpJ6r7RKJuXyOhPbc/QPXn2CR0xuX11cW0UZu4BGZA1ZoRWLdv0izb
         AFSmBByolIVD57360HgbLmxGaJXjg3PYuEObX0DGhgV3t7Y0Z8SAl272CVnwR0GPaTSG
         pvNZMr3g/zwubfl/0hTzJVHUSzOW7F0D7vJLcyaDqbGAcdBQbJ2GceAfslcrSxEHVNig
         UR7TjeahKv+UFOZq0EEsitC0Fwpge3tCZfpW2U6hdUPd+T1KjEo/SOnuuIV7KFmTL4RR
         sAo25qhxooDioysozW2b3U155QF0ZG1exAfJ3pGCYGJsFVnNUYoKhwRnBPeO0dMHysHw
         SL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779046155; x=1779650955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBYyQ0ZMS6FoSccvFn3m6zDlGuyQLI5sKd09gEPumuQ=;
        b=aLSPqEoLoquBhYqg+FMNO8W4leRJ0+ZfbL0kNC3YfA/2Ln69QjjSW/0qoiDRPJ7Ejh
         rStChYELcQIQDKjy1hLACbv+1lq+G8LoDI5keoatFfCCy+K0eNRIgISb2rpkyqXtlZj8
         gSYdg21KITy8FZzYgJiSVozycG9da2532tq1vasBXxuM2SvXJK/ZM3J9ZhO3mpJtKE2u
         EOAb4jHxx+PISJXZVvIZmzMpD4ccNR2lxiFC09sYm7P0/ftuHwp4uqvtcDOQUcznVGIe
         KrzRkqIUkT8SEYf9vuUo1AliLzURzBsfh/IoUutNy5U0nUzQ1Crht+/6LkyC3Z2vSTjY
         UWlw==
X-Forwarded-Encrypted: i=1; AFNElJ+mbWIhje+OBRF8GA5NOC468isyCylLXvXeLcOqUl6CkHozrbyLGGtdnF6k8HVT/0M74diZBuDusAUr6JQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzsyd8zJILPensU8KRjrEKUwp6y9tkpow6qBR/grh9FUl712zZq
	+OUYf9trPvYgaYo49izJ5Q4aLeqKyVf7VmuDH/7e6NqFUvnYECTP1YyS
X-Gm-Gg: Acq92OGc6EvUxc+izvusK9WhtS+EAKxs9xAZArWmIjDzDYKGIYAxrnqtmxZ/jKRQza6
	oIMq8Mm5MobtNPtG/aqJGTb2Y97HVwYWg3G/UoZcVcozPARtsYrOJdjJq6A2Bks6DxNKXLreu54
	lKxxss9tGxOdc30d65Ra4R3HDERjBIQ12h2sv2KC8zPI9brUzz0tpUb8xRu0JsSklxxttnvBBLU
	UGNNe/kpY8Bxl51eECWUe73NutQQng1aCoH4mXE/HsoU+Lu5aDnzpO6KUQYJ4Wgqsu9n6vgGEAk
	UokOYKzvuW6E9UXk3w0Ul5KIB6p5wJU+ofhQa0vmy3q3zZ2Hyscp/bSYxQ326DsPvpkk5uKAQnj
	/V6Swd4i9AjDeN3IqcKASq3mnM+PcZweox+oHMoysHELokOSqfr2sW55hYXrxvi3DWpfandoavP
	QPLXF/B4iSwvTqzFw8K7Y65XjfSkX4im7/QRpqYooBrIyh2M7bnFmWojyBO1mztj9ptI03K2+Io
	zidA8Nq9YlpBX7H8L/3bppQZ4zlAf0IbYehbRYPGaRLdg==
X-Received: by 2002:a17:90b:5648:b0:35e:27ec:de0 with SMTP id 98e67ed59e1d1-36951b971e2mr11019754a91.13.1779046154970;
        Sun, 17 May 2026 12:29:14 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369572061b8sm3268188a91.3.2026.05.17.12.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 12:29:14 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: ucc_geth: Batch RX packets before stack handoff
Date: Sun, 17 May 2026 12:28:56 -0700
Message-ID: <20260517192856.3925-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Collect received skbs on a local list during RX polling and pass the
completed batch to netif_receive_skb_list(). This lets the networking
stack process packets from a poll cycle in bulk instead of handing each
skb up individually.

Speedup tested with bidirectional iperf3.

Before:

[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-10.00  sec   490 MBytes   411 Mbits/sec                  sender
[  5][TX-C]   0.00-10.01  sec   488 MBytes   409 Mbits/sec                  receiver
[  7][RX-C]   0.00-10.00  sec   176 MBytes   147 Mbits/sec  167            sender
[  7][RX-C]   0.00-10.01  sec   175 MBytes   146 Mbits/sec                  receiver

After:

[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-10.00  sec   502 MBytes   421 Mbits/sec                  sender
[  5][TX-C]   0.00-10.01  sec   501 MBytes   420 Mbits/sec                  receiver
[  7][RX-C]   0.00-10.00  sec   212 MBytes   178 Mbits/sec  148            sender
[  7][RX-C]   0.00-10.01  sec   211 MBytes   177 Mbits/sec                  receiver

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 7af4b5e3f38e..bce1079fc06a 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -2894,6 +2894,7 @@ static int ucc_geth_rx(struct ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
 	u32 bd_status;
 	u8 *bdBuffer;
 	struct net_device *dev;
+	LIST_HEAD(rx_list);
 
 	ugeth_vdbg("%s: IN", __func__);
 
@@ -2934,7 +2935,7 @@ static int ucc_geth_rx(struct ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
 
 			dev->stats.rx_bytes += length;
 			/* Send the packet up the stack */
-			netif_receive_skb(skb);
+			list_add_tail(&skb->list, &rx_list);
 		}
 
 		skb = get_new_skb(ugeth, bd);
@@ -2960,6 +2961,8 @@ static int ucc_geth_rx(struct ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
 		bd_status = in_be32((u32 __iomem *)bd);
 	}
 
+	netif_receive_skb_list(&rx_list);
+
 	ugeth->rxBd[rxQ] = bd;
 	return howmany;
 }
-- 
2.54.0


