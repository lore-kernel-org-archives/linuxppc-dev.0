Return-Path: <SRS0=IADO=FO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA60C4361B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 09:30:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA6423D9E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 09:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA6423D9E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baikalelectronics.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cs7tw4WGlzDqpv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 20:30:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=baikalelectronics.ru (client-ip=87.245.175.226;
 helo=mail.baikalelectronics.ru;
 envelope-from=sergey.semin@baikalelectronics.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=baikalelectronics.ru
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com
 [87.245.175.226])
 by lists.ozlabs.org (Postfix) with ESMTP id 4Cs7S019kKzDqhN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2020 20:10:39 +1100 (AEDT)
From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
To: Mathias Nyman <mathias.nyman@intel.com>, Felipe Balbi <balbi@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>
Subject: [PATCH v6 08/19] dt-bindings: usb: xhci: Add Broadcom STB v2
 compatible device
Date: Thu, 10 Dec 2020 12:09:32 +0300
Message-ID: <20201210090944.16283-9-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201210090944.16283-1-Sergey.Semin@baikalelectronics.ru>
References: <20201210090944.16283-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
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
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-kernel@vger.kernel.org,
 Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
 Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
 Andy Gross <agross@kernel.org>, linux-snps-arc@lists.infradead.org,
 devicetree@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
 Serge Semin <fancer.lancer@gmail.com>,
 Serge Semin <Sergey.Semin@baikalelectronics.ru>,
 Manu Gautam <mgautam@codeaurora.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

For some reason the "brcm,xhci-brcm-v2" compatible string has been missing
in the original bindings file. Add it to the Generic xHCI Controllers DT
schema since the controller driver expects it to be supported.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/generic-xhci.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/generic-xhci.yaml b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
index 1ea1d49a8175..23d73df96ea3 100644
--- a/Documentation/devicetree/bindings/usb/generic-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
@@ -26,7 +26,9 @@ properties:
               - marvell,armada-8k-xhci
           - const: generic-xhci
       - description: Broadcom STB SoCs with xHCI
-        const: brcm,bcm7445-xhci
+        enum:
+          - brcm,xhci-brcm-v2
+          - brcm,bcm7445-xhci
       - description: Generic xHCI device
         const: xhci-platform
         deprecated: true
-- 
2.29.2

