Return-Path: <SRS0=ZiU1=LZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E3EC11F67
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Jul 2021 22:58:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3AB46140E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Jul 2021 22:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3AB46140E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GGDCx4wLLz2yWr
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Jul 2021 08:58:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=luna.linkmauve.fr;
 envelope-from=linkmauve@linkmauve.fr; receiver=<UNKNOWN>)
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net
 [82.65.109.163])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GGDBz4YnSz303h
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jul 2021 08:58:03 +1000 (AEST)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
 id B6836F40828; Fri,  2 Jul 2021 00:57:54 +0200 (CEST)
From: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Subject: [PATCH v3 2/5] dt-bindings: nintendo-otp: Document the Wii and Wii U
 OTP support
Date: Fri,  2 Jul 2021 00:57:40 +0200
Message-Id: <20210701225743.14631-3-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210701225743.14631-1-linkmauve@linkmauve.fr>
References: <20210519095044.4109-1-linkmauve@linkmauve.fr>
 <20210701225743.14631-1-linkmauve@linkmauve.fr>
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
Cc: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Ash Logan <ash@heyquark.com>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Both of these consoles use the exact same two registers, even at the
same address, but the Wii U has eight banks of 128 bytes memory while
the Wii only has one, hence the two compatible strings.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 .../bindings/nvmem/nintendo-otp.yaml          | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml b/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
new file mode 100644
index 000000000000..c39bd64b03b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/nintendo-otp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nintendo Wii and Wii U OTP Device Tree Bindings
+
+description: |
+  This binding represents the OTP memory as found on a Nintendo Wii or Wii U,
+  which contains common and per-console keys, signatures and related data
+  required to access peripherals.
+
+  See https://wiiubrew.org/wiki/Hardware/OTP
+
+maintainers:
+  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - nintendo,hollywood-otp
+      - nintendo,latte-otp
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    otp@d8001ec {
+        compatible = "nintendo,latte-otp";
+        reg = <0x0d8001ec 0x8>;
+    };
+
+...
-- 
2.32.0

