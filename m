Return-Path: <SRS0=IADO=FO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3208C4167B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 09:13:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52AD23B99
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 09:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52AD23B99
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baikalelectronics.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cs7Vf73z8zDqnT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 20:12:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=baikalelectronics.ru (client-ip=87.245.175.226;
 helo=mail.baikalelectronics.ru;
 envelope-from=sergey.semin@baikalelectronics.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=baikalelectronics.ru
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com
 [87.245.175.226])
 by lists.ozlabs.org (Postfix) with ESMTP id 4Cs7Rx23CgzDqhN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2020 20:10:37 +1100 (AEDT)
From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
To: Mathias Nyman <mathias.nyman@intel.com>, Felipe Balbi <balbi@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>
Subject: [PATCH v6 01/19] dt-bindings: usb: usb-hcd: Detach generic USB
 controller properties
Date: Thu, 10 Dec 2020 12:09:25 +0300
Message-ID: <20201210090944.16283-2-Sergey.Semin@baikalelectronics.ru>
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
 Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
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

There can be three distinctive types of the USB controllers: USB hosts,
USB peripherals/gadgets and USB OTG, which can switch from one role to
another. In order to have that hierarchy handled in the DT binding files,
we need to collect common properties in a common DT schema and specific
properties in dedicated schemas. Seeing the usb-hcd.yaml DT schema is
dedicated for the USB host controllers only, let's move some common
properties from there into the usb.yaml schema. So the later would be
available to evaluate all currently supported types of the USB
controllers.

While at it add an explicit "additionalProperties: true" into the
usb-hcd.yaml as setting the additionalProperties/unevaluateProperties
properties is going to be get mandatory soon.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v4:
- This is a new patch created as a result of the comment left
  by Chunfeng Yun in v3

Changelog v5:
- Discard duplicated additionalProperties property definition.
---
 .../devicetree/bindings/usb/usb-hcd.yaml      | 14 ++-------
 .../devicetree/bindings/usb/usb.yaml          | 29 +++++++++++++++++++
 2 files changed, 31 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/usb.yaml

diff --git a/Documentation/devicetree/bindings/usb/usb-hcd.yaml b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
index b545b087b342..81f3ad1419d8 100644
--- a/Documentation/devicetree/bindings/usb/usb-hcd.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
@@ -9,18 +9,8 @@ title: Generic USB Host Controller Device Tree Bindings
 maintainers:
   - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 
-properties:
-  $nodename:
-    pattern: "^usb(@.*)?"
-
-  phys:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    description:
-      List of all the USB PHYs on this HCD
-
-  phy-names:
-    description:
-      Name specifier for the USB PHY
+allOf:
+  - $ref: usb.yaml#
 
 additionalProperties: true
 
diff --git a/Documentation/devicetree/bindings/usb/usb.yaml b/Documentation/devicetree/bindings/usb/usb.yaml
new file mode 100644
index 000000000000..941ad59fbac5
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/usb.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/usb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic USB Controller Device Tree Bindings
+
+maintainers:
+  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+
+select: false
+
+properties:
+  $nodename:
+    pattern: "^usb(@.*)?"
+
+  phys:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      List of all the USB PHYs on this HCD
+
+  phy-names:
+    description:
+      Name specifier for the USB PHY
+
+additionalProperties: true
+
+...
-- 
2.29.2

