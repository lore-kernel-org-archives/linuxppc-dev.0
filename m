Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33483C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:24:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CFF8206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFF8206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43800L4sv2zDqRF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 09:24:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.193; helo=mail-oi1-f193.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437ys515qPzDq7k
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 08:32:57 +1100 (AEDT)
Received: by mail-oi1-f193.google.com with SMTP id w13so12346657oiw.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 13:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=USAM970tvclh48GvuKr2JMil5AVOSm8JykCR9Y8j6lw=;
 b=TgIVmzkRRBs7d9mEM0d8ZKUxLmV/QV0ghPknQb+wZyXsctds593QafTNoD8poBtuLX
 3+TvtRA4ohuHPdWyJ42B0YWw695bQlkcfinNaosWX5zJmwEpqUZtea5tPvghVwgAcd9L
 KwppRNJrhgC72s3tgpPyTy0sivw7i80Zrceq83xkb7+5seCcm/06Gh8ilqxcsWPY+UYS
 J7a8DxMqg8ZPYTxKBcujq6C8P/U5ZpzO8hR03qwFSzsy1/nrjTCutPmZ4AYL3dbai6CS
 tUwpwzWSmOkGQxjUoLf+iDrrZXCReOu6JhBw/+fMOTscMy++7obJiMI56vCy4uBbR6aB
 2l5w==
X-Gm-Message-State: AA+aEWbIvOMMQlPv8QLfzuimrDLk5IqkF1YLKuRfwysLOsin4wOuc5+w
 rkXbWXsjwcPS8cJE2bdvog==
X-Google-Smtp-Source: AFSGD/Xktk2U2twPW7Qw1S6wLmY3IXowQtviN2j59bV5WQlwCEsWD7H8kcK0B0mDkOQCI+YQFnrXvw==
X-Received: by 2002:aca:d056:: with SMTP id h83mr11417070oig.67.1543872775234; 
 Mon, 03 Dec 2018 13:32:55 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:54 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/34] dt-bindings: arm: Convert Rockchip board/soc
 bindings to json-schema
Date: Mon,  3 Dec 2018 15:32:13 -0600
Message-Id: <20181203213223.16986-25-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <kumar.gala@linaro.org>,
 arm@kernel.org, Sean Hudson <darknighte@darknighte.com>,
 Frank Rowand <frowand.list@gmail.com>, linux-rockchip@lists.infradead.org,
 Grant Likely <grant.likely@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert Rockchip SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/rockchip.txt      | 240 -----------------
 .../devicetree/bindings/arm/rockchip.yaml     | 251 ++++++++++++++++++
 2 files changed, 251 insertions(+), 240 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/rockchip.txt
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip.yaml

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
deleted file mode 100644
index 0cc71236d639..000000000000
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ /dev/null
@@ -1,240 +0,0 @@
-Rockchip platforms device tree bindings
----------------------------------------
-
-- 96boards RK3399 Ficus (ROCK960 Enterprise Edition)
-    Required root node properties:
-      - compatible = "vamrs,ficus", "rockchip,rk3399";
-
-- 96boards RK3399 Rock960 (ROCK960 Consumer Edition)
-    Required root node properties:
-      - compatible = "vamrs,rock960", "rockchip,rk3399";
-
-- Amarula Vyasa RK3288 board
-    Required root node properties:
-      - compatible = "amarula,vyasa-rk3288", "rockchip,rk3288";
-
-- Asus Tinker board
-    Required root node properties:
-      - compatible = "asus,rk3288-tinker", "rockchip,rk3288";
-
-- Asus Tinker board S
-    Required root node properties:
-      - compatible = "asus,rk3288-tinker-s", "rockchip,rk3288";
-
-- Kylin RK3036 board:
-    Required root node properties:
-      - compatible = "rockchip,kylin-rk3036", "rockchip,rk3036";
-
-- MarsBoard RK3066 board:
-    Required root node properties:
-      - compatible = "haoyu,marsboard-rk3066", "rockchip,rk3066a";
-
-- bq Curie 2 tablet:
-    Required root node properties:
-      - compatible = "mundoreader,bq-curie2", "rockchip,rk3066a";
-
-- ChipSPARK Rayeager PX2 board:
-    Required root node properties:
-      - compatible = "chipspark,rayeager-px2", "rockchip,rk3066a";
-
-- Radxa Rock board:
-    Required root node properties:
-      - compatible = "radxa,rock", "rockchip,rk3188";
-
-- Radxa Rock2 Square board:
-    Required root node properties:
-      - compatible = "radxa,rock2-square", "rockchip,rk3288";
-
-- Rikomagic MK808 v1 board:
-    Required root node properties:
-      - compatible = "rikomagic,mk808", "rockchip,rk3066a";
-
-- Firefly Firefly-RK3288 board:
-    Required root node properties:
-      - compatible = "firefly,firefly-rk3288", "rockchip,rk3288";
-    or
-      - compatible = "firefly,firefly-rk3288-beta", "rockchip,rk3288";
-
-- Firefly Firefly-RK3288 Reload board:
-    Required root node properties:
-      - compatible = "firefly,firefly-rk3288-reload", "rockchip,rk3288";
-
-- Firefly Firefly-RK3399 board:
-    Required root node properties:
-      - compatible = "firefly,firefly-rk3399", "rockchip,rk3399";
-
-- Firefly roc-rk3328-cc board:
-    Required root node properties:
-      - compatible = "firefly,roc-rk3328-cc", "rockchip,rk3328";
-
-- Firefly ROC-RK3399-PC board:
-    Required root node properties:
-      - compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
-
-- ChipSPARK PopMetal-RK3288 board:
-    Required root node properties:
-      - compatible = "chipspark,popmetal-rk3288", "rockchip,rk3288";
-
-- Netxeon R89 board:
-    Required root node properties:
-      - compatible = "netxeon,r89", "rockchip,rk3288";
-
-- GeekBuying GeekBox:
-    Required root node properties:
-      - compatible = "geekbuying,geekbox", "rockchip,rk3368";
-
-- Google Bob (Asus Chromebook Flip C101PA):
-    Required root node properties:
-	compatible = "google,bob-rev13", "google,bob-rev12",
-		     "google,bob-rev11", "google,bob-rev10",
-		     "google,bob-rev9", "google,bob-rev8",
-		     "google,bob-rev7", "google,bob-rev6",
-		     "google,bob-rev5", "google,bob-rev4",
-		     "google,bob", "google,gru", "rockchip,rk3399";
-
-- Google Brain (dev-board):
-    Required root node properties:
-      - compatible = "google,veyron-brain-rev0", "google,veyron-brain",
-		     "google,veyron", "rockchip,rk3288";
-
-- Google Gru (dev-board):
-    Required root node properties:
-      - compatible = "google,gru-rev15", "google,gru-rev14",
-		     "google,gru-rev13", "google,gru-rev12",
-		     "google,gru-rev11", "google,gru-rev10",
-		     "google,gru-rev9", "google,gru-rev8",
-		     "google,gru-rev7", "google,gru-rev6",
-		     "google,gru-rev5", "google,gru-rev4",
-		     "google,gru-rev3", "google,gru-rev2",
-		     "google,gru", "rockchip,rk3399";
-
-- Google Jaq (Haier Chromebook 11 and more):
-    Required root node properties:
-      - compatible = "google,veyron-jaq-rev5", "google,veyron-jaq-rev4",
-		     "google,veyron-jaq-rev3", "google,veyron-jaq-rev2",
-		     "google,veyron-jaq-rev1", "google,veyron-jaq",
-		     "google,veyron", "rockchip,rk3288";
-
-- Google Jerry (Hisense Chromebook C11 and more):
-    Required root node properties:
-      - compatible = "google,veyron-jerry-rev7", "google,veyron-jerry-rev6",
-		     "google,veyron-jerry-rev5", "google,veyron-jerry-rev4",
-		     "google,veyron-jerry-rev3", "google,veyron-jerry",
-		     "google,veyron", "rockchip,rk3288";
-
-- Google Kevin (Samsung Chromebook Plus):
-    Required root node properties:
-      - compatible = "google,kevin-rev15", "google,kevin-rev14",
-		     "google,kevin-rev13", "google,kevin-rev12",
-		     "google,kevin-rev11", "google,kevin-rev10",
-		     "google,kevin-rev9", "google,kevin-rev8",
-		     "google,kevin-rev7", "google,kevin-rev6",
-		     "google,kevin", "google,gru", "rockchip,rk3399";
-
-- Google Mickey (Asus Chromebit CS10):
-    Required root node properties:
-      - compatible = "google,veyron-mickey-rev8", "google,veyron-mickey-rev7",
-		     "google,veyron-mickey-rev6", "google,veyron-mickey-rev5",
-		     "google,veyron-mickey-rev4", "google,veyron-mickey-rev3",
-		     "google,veyron-mickey-rev2", "google,veyron-mickey-rev1",
-		     "google,veyron-mickey-rev0", "google,veyron-mickey",
-		     "google,veyron", "rockchip,rk3288";
-
-- Google Minnie (Asus Chromebook Flip C100P):
-    Required root node properties:
-      - compatible = "google,veyron-minnie-rev4", "google,veyron-minnie-rev3",
-		     "google,veyron-minnie-rev2", "google,veyron-minnie-rev1",
-		     "google,veyron-minnie-rev0", "google,veyron-minnie",
-		     "google,veyron", "rockchip,rk3288";
-
-- Google Pinky (dev-board):
-    Required root node properties:
-      - compatible = "google,veyron-pinky-rev2", "google,veyron-pinky",
-		     "google,veyron", "rockchip,rk3288";
-
-- Google Speedy (Asus C201 Chromebook):
-    Required root node properties:
-      - compatible = "google,veyron-speedy-rev9", "google,veyron-speedy-rev8",
-		     "google,veyron-speedy-rev7", "google,veyron-speedy-rev6",
-		     "google,veyron-speedy-rev5", "google,veyron-speedy-rev4",
-		     "google,veyron-speedy-rev3", "google,veyron-speedy-rev2",
-		     "google,veyron-speedy", "google,veyron", "rockchip,rk3288";
-
-- mqmaker MiQi:
-    Required root node properties:
-      - compatible = "mqmaker,miqi", "rockchip,rk3288";
-
-- Phytec phyCORE-RK3288: Rapid Development Kit
-    Required root node properties:
-     - compatible = "phytec,rk3288-pcm-947", "phytec,rk3288-phycore-som", "rockchip,rk3288";
-
-- Pine64 Rock64 board:
-    Required root node properties:
-    - compatible = "pine64,rock64", "rockchip,rk3328";
-
-- Pine64 RockPro64 board:
-    Required root node properties:
-    - compatible = "pine64,rockpro64", "rockchip,rk3399";
-
-- Rockchip PX3 Evaluation board:
-    Required root node properties:
-      - compatible = "rockchip,px3-evb", "rockchip,px3", "rockchip,rk3188";
-
-- Rockchip PX5 Evaluation board:
-    Required root node properties:
-      - compatible = "rockchip,px5-evb", "rockchip,px5", "rockchip,rk3368";
-
-- Rockchip PX30 Evaluation board:
-    Required root node properties:
-      - compatible = "rockchip,px30-evb", "rockchip,px30";
-
-- Rockchip RV1108 Evaluation board
-    Required root node properties:
-      - compatible = "rockchip,rv1108-evb", "rockchip,rv1108";
-
-- Rockchip RK3368 evb:
-    Required root node properties:
-      - compatible = "rockchip,rk3368-evb-act8846", "rockchip,rk3368";
-
-- Rockchip R88 board:
-    Required root node properties:
-      - compatible = "rockchip,r88", "rockchip,rk3368";
-
-- Rockchip RK3228 Evaluation board:
-    Required root node properties:
-     - compatible = "rockchip,rk3228-evb", "rockchip,rk3228";
-
-- Rockchip RK3229 Evaluation board:
-     - compatible = "rockchip,rk3229-evb", "rockchip,rk3229";
-
-- Rockchip RK3288 Fennec board:
-    Required root node properties:
-     - compatible = "rockchip,rk3288-fennec", "rockchip,rk3288";
-
-- Rockchip RK3328 evb:
-    Required root node properties:
-      - compatible = "rockchip,rk3328-evb", "rockchip,rk3328";
-
-- Rockchip RK3399 evb:
-    Required root node properties:
-      - compatible = "rockchip,rk3399-evb", "rockchip,rk3399";
-
-- Rockchip RK3399 Sapphire board standalone:
-    Required root node properties:
-      - compatible = "rockchip,rk3399-sapphire", "rockchip,rk3399";
-
-- Rockchip RK3399 Sapphire Excavator board:
-    Required root node properties:
-      - compatible = "rockchip,rk3399-sapphire-excavator", "rockchip,rk3399";
-
-- Theobroma Systems RK3368-uQ7 Haikou Baseboard:
-    Required root node properties:
-      - compatible = "tsd,rk3368-uq7-haikou", "rockchip,rk3368";
-
-- Theobroma Systems RK3399-Q7 Haikou Baseboard:
-    Required root node properties:
-      - compatible = "tsd,rk3399-q7-haikou", "rockchip,rk3399";
-
-- Tronsmart Orion R68 Meta
-    Required root node properties:
-      - compatible = "tronsmart,orion-r68-meta", "rockchip,rk3368";
diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
new file mode 100644
index 000000000000..3d30ec9adcd3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -0,0 +1,251 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/rockchip.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip platforms device tree bindings
+
+maintainers:
+  - Beniamino Galvani <b.galvani@gmail.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - amarula,vyasa-rk3288
+              - asus,rk3288-tinker
+              - asus,rk3288-tinker-s
+              - radxa,rock2-square
+              - chipspark,popmetal-rk3288
+              - netxeon,r89
+              - firefly,firefly-rk3288
+              - firefly,firefly-rk3288-beta
+              - firefly,firefly-rk3288-reload
+              - mqmaker,miqi
+              - rockchip,rk3288-fennec
+          - const: rockchip,rk3288
+
+      - description: Phytec phyCORE-RK3288 Rapid Development Kit
+        items:
+          - const: phytec,rk3288-pcm-947
+          - const: phytec,rk3288-phycore-som
+          - const: rockchip,rk3288
+
+      - description: Google Mickey (Asus Chromebit CS10)
+        items:
+          - const: google,veyron-mickey-rev8
+          - const: google,veyron-mickey-rev7
+          - const: google,veyron-mickey-rev6
+          - const: google,veyron-mickey-rev5
+          - const: google,veyron-mickey-rev4
+          - const: google,veyron-mickey-rev3
+          - const: google,veyron-mickey-rev2
+          - const: google,veyron-mickey-rev1
+          - const: google,veyron-mickey-rev0
+          - const: google,veyron-mickey
+          - const: google,veyron
+          - const: rockchip,rk3288
+
+      - description: Google Minnie (Asus Chromebook Flip C100P)
+        items:
+          - const: google,veyron-minnie-rev4
+          - const: google,veyron-minnie-rev3
+          - const: google,veyron-minnie-rev2
+          - const: google,veyron-minnie-rev1
+          - const: google,veyron-minnie-rev0
+          - const: google,veyron-minnie
+          - const: google,veyron
+          - const: rockchip,rk3288
+
+      - description: Google Pinky (dev-board)
+        items:
+          - const: google,veyron-pinky-rev2
+          - const: google,veyron-pinky
+          - const: google,veyron
+          - const: rockchip,rk3288
+
+      - description: Google Speedy (Asus C201 Chromebook)
+        items:
+          - const: google,veyron-speedy-rev9
+          - const: google,veyron-speedy-rev8
+          - const: google,veyron-speedy-rev7
+          - const: google,veyron-speedy-rev6
+          - const: google,veyron-speedy-rev5
+          - const: google,veyron-speedy-rev4
+          - const: google,veyron-speedy-rev3
+          - const: google,veyron-speedy-rev2
+          - const: google,veyron-speedy
+          - const: google,veyron
+          - const: rockchip,rk3288
+
+      - description: Google Jaq (Haier Chromebook 11 and more)
+        items:
+          - const: google,veyron-jaq-rev5
+          - const: google,veyron-jaq-rev4
+          - const: google,veyron-jaq-rev3
+          - const: google,veyron-jaq-rev2
+          - const: google,veyron-jaq-rev1
+          - const: google,veyron-jaq
+          - const: google,veyron
+          - const: rockchip,rk3288
+
+      - description: Google Jerry (Hisense Chromebook C11 and more)
+        items:
+          - const: google,veyron-jerry-rev7
+          - const: google,veyron-jerry-rev6
+          - const: google,veyron-jerry-rev5
+          - const: google,veyron-jerry-rev4
+          - const: google,veyron-jerry-rev3
+          - const: google,veyron-jerry
+          - const: google,veyron
+          - const: rockchip,rk3288
+
+      - description: Google Brain (dev-board)
+        items:
+          - const: google,veyron-brain-rev0
+          - const: google,veyron-brain
+          - const: google,veyron
+          - const: rockchip,rk3288
+
+      - items:
+          - enum:
+              - rockchip,kylin-rk3036
+          - const: rockchip,rk3036
+
+      - items:
+          - enum:
+              - haoyu,marsboard-rk3066
+              - mundoreader,bq-curie2
+              - chipspark,rayeager-px2
+              - rikomagic,mk80
+          - const: rockchip,rk3066a
+
+      - items:
+          - enum:
+              - radxa,rock
+          - const: rockchip,rk3188
+
+      - items:
+          - const: rockchip,px3-evb
+          - const: rockchip,px3
+          - const: rockchip,rk3188
+
+      - items:
+          - enum:
+              - firefly,roc-rk3328-cc
+              - pine64,rock64
+              - rockchip,rk3328-evb
+          - const: rockchip,rk3328
+
+      - items:
+          - enum:
+              - geekbuying,geekbox
+              - rockchip,rk3368-evb-act8846
+              - rockchip,r88
+              - tsd,rk3368-uq7-haikou
+              - tronsmart,orion-r68-meta
+          - const: rockchip,rk3368
+
+      - items:
+          - enum:
+              - geekbuying,geekbox
+              - rockchip,rk3368-evb-act8846
+              - rockchip,r88
+              - tsd,rk3368-uq7-haikou
+              - tronsmart,orion-r68-meta
+          - const: rockchip,rk3368
+
+      - items:
+          - const: rockchip,px5-evb
+          - const: rockchip,px5
+          - const: rockchip,rk3368
+
+      - items:
+          - enum:
+              - firefly,firefly-rk3399
+              - firefly,roc-rk3399-pc
+              - pine64,rockpro64
+              - rockchip,rk3399-evb
+              - rockchip,rk3399-sapphire
+              - rockchip,rk3399-sapphire-excavator
+              - tsd,rk3399-q7-haikou
+              - vamrs,ficus
+              - vamrs,rock960 # 96boards RK3399 Rock960 (ROCK960 Consumer Edition)
+          - const: rockchip,rk3399
+
+      - description: Google Bob (Asus Chromebook Flip C101PA)
+        items:
+          - const: google,bob-rev13
+          - const: google,bob-rev12
+          - const: google,bob-rev11
+          - const: google,bob-rev10
+          - const: google,bob-rev9
+          - const: google,bob-rev8
+          - const: google,bob-rev7
+          - const: google,bob-rev6
+          - const: google,bob-rev5
+          - const: google,bob-rev4
+          - const: google,bob
+          - const: google,gru
+          - const: rockchip,rk3399
+
+      - description: Google Gru (dev-board)
+        items:
+          - const: google,gru-rev15
+          - const: google,gru-rev14
+          - const: google,gru-rev13
+          - const: google,gru-rev12
+          - const: google,gru-rev11
+          - const: google,gru-rev10
+          - const: google,gru-rev9
+          - const: google,gru-rev8
+          - const: google,gru-rev7
+          - const: google,gru-rev6
+          - const: google,gru-rev5
+          - const: google,gru-rev4
+          - const: google,gru-rev3
+          - const: google,gru-rev2
+          - const: google,gru
+          - const: rockchip,rk3399
+
+      - description: Google Kevin (Samsung Chromebook Plus)
+        items:
+          - const: google,kevin-rev15
+          - const: google,kevin-rev14
+          - const: google,kevin-rev13
+          - const: google,kevin-rev12
+          - const: google,kevin-rev11
+          - const: google,kevin-rev10
+          - const: google,kevin-rev9
+          - const: google,kevin-rev8
+          - const: google,kevin-rev7
+          - const: google,kevin-rev6
+          - const: google,kevin
+          - const: google,gru
+          - const: rockchip,rk3399
+
+      - items:
+          - enum:
+              - rockchip,px30-evb
+          - const: rockchip,px30
+
+      - items:
+          - enum:
+              - rockchip,rv1108-evb
+          - const: rockchip,rv1108
+
+      - items:
+          - enum:
+              - rockchip,rk3228-evb
+          - const: rockchip,rk3228
+
+      - items:
+          - enum:
+              - rockchip,rk3229-evb
+          - const: rockchip,rk3229
+...
-- 
2.19.1

