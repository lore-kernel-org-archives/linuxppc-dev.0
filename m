Return-Path: <linuxppc-dev+bounces-21267-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795E1CD343F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 06:07:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLdHY3xn3z2xS2;
	Thu, 21 May 2026 16:07:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b132"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779343673;
	cv=none; b=Jf+MLrol9dobd9wFYJ2L3e8MGD87pHcc2XRY7Fxjaj2zzEeE4jAs932ZnA+BYM6Xx9vlKvo9Fdk7kEr79aHpamNwp1mjBxnbOoY+6A81QugFy1xWA36C0e7OrkyPD7+gullGa9+F1Apb7LzbLpmvQo8YuyPmafC/m54qY4q1GxHOPKjRdODOh6Wpez3x3M0vvPyyizMxVhkOZ5aMHXltFG966GKYn3h+oxor57OAy16OBCsfZF77Qhu8Jh8Bk3UDrRDfiZkvGRGWylVgIwAOmh414f6EvIEHsu/6RUwU7dFOGBh9wxIrsl5mf8sZsHCaqPtJoUjsf4jMgj1ohIv44g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779343673; c=relaxed/relaxed;
	bh=v/4tpqxeEoNUq/Dqf4W4r6oPmkkXtFBFoEdxmJFSLDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JTA0Wz4OCXhTnmKEjmXPdeL1UbyNcv9tJ3mBX2s65CnKe2eF+3oOWowL+ZCjbsa/JU9/m+wo5FyAbbNSC2ol4YKjIB/nbzuLR0IYVACZaG0KY/bsjlD2GgZcDFN+De79wDjqoOV4xuTO06xM9EEbNiupDTh0dNVsqYOAqTHXiVeaoJDeUlECIqOvevfmJpl29ff6kCgu7dwJ6gPc33ZnjjVSK/iwvSLH81ym9uD/HWEB138vxMBn0i4Pz+nqJNWNHm+pjyqiAVRZPYwlTD6AGXz+dgyHa8617baPrWuEbO+ke07hoTPbfTFlNMhtzB2sRl22eIqFstbUJVlWqXilOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SsLRcrYG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b132; helo=mail-yx1-xb132.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SsLRcrYG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b132; helo=mail-yx1-xb132.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com [IPv6:2607:f8b0:4864:20::b132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLdHX46BYz2xHF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 16:07:51 +1000 (AEST)
Received: by mail-yx1-xb132.google.com with SMTP id 956f58d0204a3-651bf695701so5500890d50.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 23:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779343668; x=1779948468; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v/4tpqxeEoNUq/Dqf4W4r6oPmkkXtFBFoEdxmJFSLDs=;
        b=SsLRcrYGiC/84ZoyB4M8aqgEjF9QlhbrAGQskvSlz5Ds/2VZz4vY7Q7B1J1tjGXGwZ
         hBqK3BfUObggBvdr8Zir31C5iLAYP1/4FGmOEMEEj3CxZkSxAai18rp/jd0VpZCPbGv2
         H7EZID5SeB+TP78dSvaEMHJBMYKUAK1Q5TOJQHttnDHkqUZeF9NtSRlbhdBLjHayuRgw
         xxUlK4hGwAe8Py6f10tz/tKw4vqySRp3A4prY4gpAjFIq/iNBDwbEX+nON5/GKMoQ1IK
         9YoP64F3Q1Eo5h4HLGrYUw+d3cBuRQFyb0vFv/96L3x4KJ7yp9Omg6BddxpItzGwXyb6
         K9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779343668; x=1779948468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/4tpqxeEoNUq/Dqf4W4r6oPmkkXtFBFoEdxmJFSLDs=;
        b=o3Qi6wVPxvq7rt3WX2Bss3IAieZy6UJknXadzRR+t4UJRTPsoVMwQj3F83+Nu5gxlu
         U7K4nw1orlKpB8pZAVQ5w3ROo3mCO2+3CP6SpyicLzC794Cnz4V4kdeSgveZb8Oj8rL+
         tXRJ3/MkgZzh4Y1EdUasGlOftrgz/B3IV8r8qQrARgXBX5xzCC6DP2bxSrYYUddYJLuR
         S8ZrmmjL2deIEZPC9Yu1hEnuHiTAbZgBmMWb/A9Pg5M2ruVtWLAFVB+nHLTRJ4SEuJzd
         83ksMdYb2nuekUMi6JZlzR27OwHCc3CD31uxSlTRtBIKu7QcjVXx67uPynsOE1eL+koR
         WTdg==
X-Forwarded-Encrypted: i=1; AFNElJ8i81lo8cOlxub49S6JZKTNGt3oiR9sbVR7ngC+emQlH2X+uzXvfVGPN1QjYf/HlIXHsIfHBQdKmRrLPQ8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzHZnMm/5wehCgdLZrF3lVcv7arhprjmpn/VZoQ/mOawJDzRopy
	QoVyDtqXqZ5/he6vJXXp58wT2nSsvnN8bymWS/TIFkMlE3dHqZTgpwVq
X-Gm-Gg: Acq92OF7nrYivbrOPWsx0uAxdXe3ubxdc5CvIRWhM1lOHNBfOnOjaAa8kO/zC+WQhZ2
	tPFP3/T2idSnG2khyDqo6+5AslUE1nXGrS+CXRfRf8wFvN3a9pmkRUkCHAeQLZ8gkTG1WwWi8Yh
	0minSzOITbm0dm4d4z8sq8/1XdT7XxkD7qT8GALHJTb3KBaO66jo1cQGKouGLHWb6WxuXk5jeXm
	wFL+KaM4KF3ezbexu3xGTaOSQ6PXzs8jCNX1Oce0+wUcaXDOTiKhausztQzh0UfH8WPo5PX76a5
	6ndhPrbncKD00gnGjfDm7PNsbNyaQXhbOcs3KUVw3aWz58ZEHwZgQcSSioBKPFtZ8rHq1JOl6Az
	IOx37W5j07aoZzHRkcQaDQVBbrDI1X++UxdXfwLuqyzWyJSF260e1ZfxBqVzzTJ+BpfqUFX0QVY
	Aup921L2FU4QdfHhm94zp2MNLow4C+zs/I8DYLHxupL0qIF//TCs5iurz7Tfri9+fTBc2ydpWDM
	Zi6SteLztUWg3qxwjyZMIvsN2KfF7CC5eo=
X-Received: by 2002:a05:690e:120d:b0:65e:b97:771c with SMTP id 956f58d0204a3-65eae0ca72cmr1176525d50.42.1779343667896;
        Wed, 20 May 2026 23:07:47 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0dbcda4bsm10325235d50.18.2026.05.20.23.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 23:07:46 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next] net: ucc_geth: Batch RX packets before stack handoff
Date: Wed, 20 May 2026 23:07:29 -0700
Message-ID: <20260521060729.2293222-1-rosenp@gmail.com>
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

Speedup tested with bidirectional iperf3 on a Watchguard Firebox T15-W.

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

It would be nice to use napi_gro_receive, but the tradeoff is lower
routing performance. There is no support for hardware checksum offload,
which really hurts routing performance.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: add extra info in description
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


