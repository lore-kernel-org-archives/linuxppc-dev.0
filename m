Return-Path: <SRS0=37tr=TD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FB0C43219
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 14:32:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3E5205ED
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 14:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3E5205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=true.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44wZMm41gWzDqW0
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 May 2019 00:32:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=true.cz
 (client-ip=178.217.244.18; helo=smtp-out.xnet.cz; envelope-from=ynezz@true.cz;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=true.cz
Received: from smtp-out.xnet.cz (smtp-out.xnet.cz [178.217.244.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44wZGz0XQszDqZD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2019 00:27:55 +1000 (AEST)
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
 (Authenticated sender: petr@true.cz)
 by smtp-out.xnet.cz (Postfix) with ESMTPSA id BBF064ADA;
 Fri,  3 May 2019 16:27:51 +0200 (CEST)
Received: by meh.true.cz (OpenSMTPD) with ESMTP id a47c137c;
 Fri, 3 May 2019 16:27:50 +0200 (CEST)
From: =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
To: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v4 10/10] powerpc: tsi108: support of_get_mac_address new
 ERR_PTR error
Date: Fri,  3 May 2019 16:27:15 +0200
Message-Id: <1556893635-18549-11-git-send-email-ynezz@true.cz>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556893635-18549-1-git-send-email-ynezz@true.cz>
References: <1556893635-18549-1-git-send-email-ynezz@true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>,
 Frank Rowand <frowand.list@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There was NVMEM support added to of_get_mac_address, so it could now return
ERR_PTR encoded error values, so we need to adjust all current users of
of_get_mac_address to this new fact.

Signed-off-by: Petr Štetiar <ynezz@true.cz>
---

 Changes since v3:

  * IS_ERR_OR_NULL -> IS_ERR

 arch/powerpc/sysdev/tsi108_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/tsi108_dev.c b/arch/powerpc/sysdev/tsi108_dev.c
index 1f1af12..c92dcac 100644
--- a/arch/powerpc/sysdev/tsi108_dev.c
+++ b/arch/powerpc/sysdev/tsi108_dev.c
@@ -105,7 +105,7 @@ static int __init tsi108_eth_of_init(void)
 		}
 
 		mac_addr = of_get_mac_address(np);
-		if (mac_addr)
+		if (!IS_ERR(mac_addr))
 			memcpy(tsi_eth_data.mac_addr, mac_addr, 6);
 
 		ph = of_get_property(np, "mdio-handle", NULL);
-- 
1.9.1

