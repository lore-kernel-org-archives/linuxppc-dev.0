Return-Path: <SRS0=n4RZ=OS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55100C65BAF
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 22:17:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D4C2081F
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 22:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D4C2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43CgYL5VLxzDqvt
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 09:17:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sntech.de
 (client-ip=185.11.138.130; helo=gloria.sntech.de;
 envelope-from=heiko@sntech.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sntech.de
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43CgTy5n6WzDqvl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 09:14:13 +1100 (AEDT)
Received: from p54b2671c.dip0.t-ipconnect.de ([84.178.103.28]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gW7Kw-0005Uf-4N; Sun, 09 Dec 2018 23:14:06 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>
Subject: [PATCH v2.1 24/34] dt-bindings: arm: Convert Rockchip board/soc
 bindings to json-schema
Date: Sun, 09 Dec 2018 23:14:05 +0100
Message-ID: <2386212.ILKoqq0Ivo@phil>
In-Reply-To: <CAL_JsqLwSg=CWQYzvfCq9WVexU5donsF6ugib2ONNN3vvjzZXw@mail.gmail.com>
References: <20181203213223.16986-1-robh@kernel.org> <3170130.k0DT9deCHj@phil>
 <CAL_JsqLwSg=CWQYzvfCq9WVexU5donsF6ugib2ONNN3vvjzZXw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Sean Hudson <darknighte@darknighte.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Grant Likely <grant.likely@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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
[move to per-board entries and added recently added boards]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
Hi Rob,

there are boards where the description adds much value and on others
it is maybe less, but personally I'd like to keep things uniform,
as that makes reading these things easier if the format stays the
same all the time, so I've gone forward and just did the conversion

make dtbs_check did not complain about the schema it seems but I
did end up with an error later on:

FATAL ERROR: Unknown output format "yaml"
make[2]: *** [scripts/Makefile.lib:313: arch/arm/boot/dts/rk3036-evb.dt.yaml] Fehler 1

But I guess I did not mess up the schema yet.

So does it look ok that way?
Heiko

 .../devicetree/bindings/arm/rockchip.txt      | 240 ----------
 .../devicetree/bindings/arm/rockchip.yaml     | 419 ++++++++++++++++++
 2 files changed, 419 insertions(+), 240 deletions(-)
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
index 000000000000..36f4bf4b445c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -0,0 +1,419 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/rockchip.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip platforms device tree bindings
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+
+      - description: 96boards RK3399 Ficus (ROCK960 Enterprise Edition)
+        items:
+          - const: vamrs,ficus
+          - const: rockchip,rk3399
+
+      - description: 96boards RK3399 Rock960 (ROCK960 Consumer Edition)
+        items:
+          - const: vamrs,rock960
+          - const: rockchip,rk3399
+
+      - description: Amarula Vyasa RK3288
+        items:
+          - const: amarula,vyasa-rk3288
+          - const: rockchip,rk3288
+
+      - description: Asus Tinker board
+        items:
+          - const: asus,rk3288-tinker
+          - const: rockchip,rk3288
+
+      - description: Asus Tinker board S
+        items:
+          - const: asus,rk3288-tinker-s
+          - const: rockchip,rk3288
+
+      - description: bq Curie 2 tablet
+        items:
+          - const: mundoreader,bq-curie2
+          - const: rockchip,rk3066a
+
+      - description: bq Edison 2 Quad-Core tablet
+        items:
+          - const: mundoreader,bq-edison2qc
+          - const: rockchip,rk3188
+
+      - description: ChipSPARK PopMetal-RK3288
+        items:
+          - const: chipspark,popmetal-rk3288
+          - const: rockchip,rk3288
+
+      - description: ChipSPARK Rayeager PX2
+        items:
+          - const: chipspark,rayeager-px2
+          - const: rockchip,rk3066a
+
+      - description: Firefly Firefly-RK3288
+        items:
+          - const: firefly,firefly-rk3288
+          - const: rockchip,rk3288
+
+      - description: Firefly Firefly-RK3288 (beta board)
+        items:
+          - const: firefly,firefly-rk3288-beta
+          - const: rockchip,rk3288
+
+      - description: Firefly Firefly-RK3288 Reload
+        items:
+          - const: firefly,firefly-rk3288-reload
+          - const: rockchip,rk3288
+
+      - description: Firefly Firefly-RK3399
+        items:
+          - const: firefly,firefly-rk3399
+          - const: rockchip,rk3399
+
+      - description: Firefly roc-rk3328-cc
+        items:
+          - const: firefly,roc-rk3328-cc
+          - const: rockchip,rk3328
+
+      - description: Firefly ROC-RK3399-PC
+        items:
+          - const: firefly,roc-rk3399-pc
+          - const: rockchip,rk3399
+
+      - description: GeekBuying GeekBox
+        items:
+          - const: geekbuying,geekbox
+          - const: rockchip,rk3368
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
+      - description: Google Brain (dev-board)
+        items:
+          - const: google,veyron-brain-rev0
+          - const: google,veyron-brain
+          - const: google,veyron
+          - const: rockchip,rk3288
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
+      - description: Google Scarlet - Kingdisplay (Acer Chromebook Tab 10)
+        items:
+          - const: google,scarlet-rev15-sku7
+          - const: google,scarlet-rev15
+          - const: google,scarlet-rev14-sku7
+          - const: google,scarlet-rev14
+          - const: google,scarlet-rev13-sku7
+          - const: google,scarlet-rev13
+          - const: google,scarlet-rev12-sku7
+          - const: google,scarlet-rev12
+          - const: google,scarlet-rev11-sku7
+          - const: google,scarlet-rev11
+          - const: google,scarlet-rev10-sku7
+          - const: google,scarlet-rev10
+          - const: google,scarlet-rev9-sku7
+          - const: google,scarlet-rev9
+          - const: google,scarlet-rev8-sku7
+          - const: google,scarlet-rev8
+          - const: google,scarlet-rev7-sku7
+          - const: google,scarlet-rev7
+          - const: google,scarlet-rev6-sku7
+          - const: google,scarlet-rev6
+          - const: google,scarlet-rev5-sku7
+          - const: google,scarlet-rev5
+          - const: google,scarlet-rev4-sku7
+          - const: google,scarlet-rev4
+          - const: google,scarlet-rev3-sku7
+          - const: google,scarlet-rev3
+          - const: google,scarlet
+          - const: google,gru
+          - const: rockchip,rk3399
+
+      - description: Google Scarlet - Innolux display (Acer Chromebook Tab 10)
+        items:
+          - const: google,scarlet-rev15-sku6
+          - const: google,scarlet-rev15
+          - const: google,scarlet-rev14-sku6
+          - const: google,scarlet-rev14
+          - const: google,scarlet-rev13-sku6
+          - const: google,scarlet-rev13
+          - const: google,scarlet-rev12-sku6
+          - const: google,scarlet-rev12
+          - const: google,scarlet-rev11-sku6
+          - const: google,scarlet-rev11
+          - const: google,scarlet-rev10-sku6
+          - const: google,scarlet-rev10
+          - const: google,scarlet-rev9-sku6
+          - const: google,scarlet-rev9
+          - const: google,scarlet-rev8-sku6
+          - const: google,scarlet-rev8
+          - const: google,scarlet-rev7-sku6
+          - const: google,scarlet-rev7
+          - const: google,scarlet-rev6-sku6
+          - const: google,scarlet-rev6
+          - const: google,scarlet-rev5-sku6
+          - const: google,scarlet-rev5
+          - const: google,scarlet-rev4-sku6
+          - const: google,scarlet-rev4
+          - const: google,scarlet
+          - const: google,gru
+          - const: rockchip,rk3399
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
+      - description: Haoyu MarsBoard RK3066
+        items:
+          - const: haoyu,marsboard-rk3066
+          - const: rockchip,rk3066a
+
+      - description: mqmaker MiQi
+        items:
+          - const: mqmaker,miqi
+          - const: rockchip,rk3288
+
+      - description: Netxeon R89 board
+        items:
+          - const: netxeon,r89
+          - const: rockchip,rk3288
+
+      - description: Phytec phyCORE-RK3288 Rapid Development Kit
+        items:
+          - const: phytec,rk3288-pcm-947
+          - const: phytec,rk3288-phycore-som
+          - const: rockchip,rk3288
+
+      - description: Pine64 Rock64
+        items:
+          - const: pine64,rock64
+          - const: rockchip,rk3328
+
+      - description: Pine64 RockPro64
+        items:
+          - const: pine64,rockpro64
+          - const: rockchip,rk3399
+
+      - description: Radxa Rock
+        items:
+          - const: radxa,rock
+          - const: rockchip,rk3188
+
+      - description: Radxa Rock2 Square
+        items:
+          - const: radxa,rock2-square
+          - const: rockchip,rk3288
+
+      - description: Rikomagic MK808 v1
+        items:
+          - const: rikomagic,mk808
+          - const: rockchip,rk3066a
+
+      - description: Rockchip Kylin
+        items:
+          - const: rockchip,kylin-rk3036
+          - const: rockchip,rk3036
+
+      - description: Rockchip PX3 Evaluation board
+        items:
+          - const: rockchip,px3-evb
+          - const: rockchip,px3
+          - const: rockchip,rk3188
+
+      - description: Rockchip PX30 Evaluation board
+        items:
+          - const: rockchip,px30-evb
+          - const: rockchip,px30
+
+      - description: Rockchip PX5 Evaluation board
+        items:
+          - const: rockchip,px5-evb
+          - const: rockchip,px5
+          - const: rockchip,rk3368
+
+      - description: Rockchip R88
+        items:
+          - const: rockchip,r88
+          - const: rockchip,rk3368
+
+      - description: Rockchip RK3228 Evaluation board
+        items:
+          - const: rockchip,rk3228-evb
+          - const: rockchip,rk3228
+
+      - description: Rockchip RK3288 Fennec
+        items:
+          - const: rockchip,rk3288-fennec
+          - const: rockchip,rk3288
+
+      - description: Rockchip RK3229 Evaluation board
+        items:
+          - const: rockchip,rk3229-evb
+          - const: rockchip,rk3229
+
+      - description: Rockchip RK3328 Evaluation board
+        items:
+          - const: rockchip,rk3328-evb
+          - const: rockchip,rk3328
+
+      - description: Rockchip RK3368 Evaluation board (act8846 pmic)
+        items:
+          - const: rockchip,rk3368-evb-act8846
+          - const: rockchip,rk3368
+
+      - description: Rockchip RK3399 Evaluation board
+        items:
+          - const: rockchip,rk3399-evb
+          - const: rockchip,rk3399
+
+      - description: Rockchip RK3399 Sapphire standalone
+        items:
+          - const: rockchip,rk3399-sapphire
+          - const: rockchip,rk3399
+
+      - description: Rockchip RK3399 Sapphire with Excavator Baseboard
+        items:
+          - const: rockchip,rk3399-sapphire-excavator
+          - const: rockchip,rk3399
+
+      - description: Rockchip RV1108 Evaluation board
+        items:
+          - const: rockchip,rv1108-evb
+          - const: rockchip,rv1108
+
+      - description: Theobroma Systems RK3368-uQ7 with Haikou baseboard
+        items:
+          - const: tsd,rk3368-uq7-haikou
+          - const: rockchip,rk3368
+
+      - description: Theobroma Systems RK3399-Q7 with Haikou baseboard
+        items:
+          - const: tsd,rk3399-q7-haikou
+          - const: rockchip,rk3399
+
+      - description: Tronsmart Orion R68 Meta
+        items:
+          - const: tronsmart,orion-r68-meta
+          - const: rockchip,rk3368
+...
-- 
2.19.2




