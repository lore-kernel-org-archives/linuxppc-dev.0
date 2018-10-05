Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C44C65BB9
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:49:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2201C2084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2201C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RchQ5xj5zDqCq
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 03:49:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.194; helo=mail-oi1-f194.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RbZg6jR4zF3T3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 02:59:23 +1000 (AEST)
Received: by mail-oi1-f194.google.com with SMTP id w81-v6so10931703oiw.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 09:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=oAFZaqX+8vbPo3z2NAIlPqO9Xe1omxZyYJn0IxY6DLE=;
 b=KrY3Gb3aihQU8dk8LELEPqmx3amwOYJ5m6Wa4fY0tjnqqVXicIbkX8hSRm7Auw/AtR
 ksnNX5bgc140psOs40z69xKCjwxQlPiU6y5WQIN+VJHIpF5nRDc9E1CxnqoF8j7zbBhQ
 p2m2oQIsqnCXtsax9pjAnjPZJcaoj0C4B4SWHFQ2pK4LeeD7BzL/WpEgywLpILJl2FtN
 JriujmW1hegr+xo2AvXi3PmfnRi+3JSkE4SeGYwjtO51CNBRNMnNbtGdcU9neejHNPrp
 IJMbV8fXTkh8NXR2pWSULdyL9FPEKNT7JIhObMuuMen6jyqVL2vEOQVVSDDQVM6+95w1
 HOww==
X-Gm-Message-State: ABuFfohVS8w0STK+k7/c2yV2SE4bMT5NjRWvBftShET84C9y/Ookohlb
 FxEwBkz1KR2ksTbZtaiefw==
X-Google-Smtp-Source: ACcGV60B6X+4yA6qXr5ZDoMUN4bCw5rooQYIL09v05uFaMcVvOdTvjZNDinqx6gk7DjE2u02EZ+HOA==
X-Received: by 2002:aca:d785:: with SMTP id
 o127-v6mr5659408oig.33.1538758761826; 
 Fri, 05 Oct 2018 09:59:21 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 u63-v6sm2904328ota.75.2018.10.05.09.59.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 09:59:21 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 22/36] dt-bindings: arm: Convert FSL board/soc bindings to
 json-schema
Date: Fri,  5 Oct 2018 11:58:34 -0500
Message-Id: <20181005165848.3474-23-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Tom Rini <trini@konsulko.com>,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert Freescale SoC bindings to DT schema format using json-schema.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/armadeus.txt      |   6 -
 Documentation/devicetree/bindings/arm/bhf.txt |   6 -
 .../bindings/arm/compulab-boards.txt          |  25 ---
 Documentation/devicetree/bindings/arm/fsl.txt | 185 ------------------
 .../devicetree/bindings/arm/fsl.yaml          | 166 ++++++++++++++++
 .../devicetree/bindings/arm/i2se.txt          |  22 ---
 .../devicetree/bindings/arm/olimex.txt        |  10 -
 .../devicetree/bindings/arm/technologic.txt   |  23 ---
 8 files changed, 166 insertions(+), 277 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/armadeus.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/bhf.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/compulab-boards.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/fsl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/fsl.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/i2se.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/olimex.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/technologic.txt

diff --git a/Documentation/devicetree/bindings/arm/armadeus.txt b/Documentation/devicetree/bindings/arm/armadeus.txt
deleted file mode 100644
index 9821283ff516..000000000000
--- a/Documentation/devicetree/bindings/arm/armadeus.txt
+++ /dev/null
@@ -1,6 +0,0 @@
-Armadeus i.MX Platforms Device Tree Bindings
------------------------------------------------
-
-APF51: i.MX51 based module.
-Required root node properties:
-    - compatible = "armadeus,imx51-apf51", "fsl,imx51";
diff --git a/Documentation/devicetree/bindings/arm/bhf.txt b/Documentation/devicetree/bindings/arm/bhf.txt
deleted file mode 100644
index 886b503caf9c..000000000000
--- a/Documentation/devicetree/bindings/arm/bhf.txt
+++ /dev/null
@@ -1,6 +0,0 @@
-Beckhoff Automation Platforms Device Tree Bindings
---------------------------------------------------
-
-CX9020 Embedded PC
-Required root node properties:
-    - compatible = "bhf,cx9020", "fsl,imx53";
diff --git a/Documentation/devicetree/bindings/arm/compulab-boards.txt b/Documentation/devicetree/bindings/arm/compulab-boards.txt
deleted file mode 100644
index 42a10285af9c..000000000000
--- a/Documentation/devicetree/bindings/arm/compulab-boards.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-CompuLab SB-SOM is a multi-module baseboard capable of carrying:
- - CM-T43
- - CM-T54
- - CM-QS600
- - CL-SOM-AM57x
- - CL-SOM-iMX7
-modules with minor modifications to the SB-SOM assembly.
-
-Required root node properties:
-    - compatible = should be "compulab,sb-som"
-
-Compulab CL-SOM-iMX7 is a miniature System-on-Module (SoM) based on
-Freescale i.MX7 ARM Cortex-A7 System-on-Chip.
-
-Required root node properties:
-    - compatible = "compulab,cl-som-imx7", "fsl,imx7d";
-
-Compulab SBC-iMX7 is a single board computer based on the
-Freescale i.MX7 system-on-chip. SBC-iMX7 is implemented with
-the CL-SOM-iMX7 System-on-Module providing most of the functions,
-and SB-SOM-iMX7 carrier board providing additional peripheral
-functions and connectors.
-
-Required root node properties:
-    - compatible = "compulab,sbc-imx7", "compulab,cl-som-imx7", "fsl,imx7d";
diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
deleted file mode 100644
index 1e775aaa5c5b..000000000000
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ /dev/null
@@ -1,185 +0,0 @@
-Freescale i.MX Platforms Device Tree Bindings
------------------------------------------------
-
-i.MX23 Evaluation Kit
-Required root node properties:
-    - compatible = "fsl,imx23-evk", "fsl,imx23";
-
-i.MX25 Product Development Kit
-Required root node properties:
-    - compatible = "fsl,imx25-pdk", "fsl,imx25";
-
-i.MX27 Product Development Kit
-Required root node properties:
-    - compatible = "fsl,imx27-pdk", "fsl,imx27";
-
-i.MX28 Evaluation Kit
-Required root node properties:
-    - compatible = "fsl,imx28-evk", "fsl,imx28";
-
-i.MX51 Babbage Board
-Required root node properties:
-    - compatible = "fsl,imx51-babbage", "fsl,imx51";
-
-i.MX53 Automotive Reference Design Board
-Required root node properties:
-    - compatible = "fsl,imx53-ard", "fsl,imx53";
-
-i.MX53 Evaluation Kit
-Required root node properties:
-    - compatible = "fsl,imx53-evk", "fsl,imx53";
-
-i.MX53 Quick Start Board
-Required root node properties:
-    - compatible = "fsl,imx53-qsb", "fsl,imx53";
-
-i.MX53 Smart Mobile Reference Design Board
-Required root node properties:
-    - compatible = "fsl,imx53-smd", "fsl,imx53";
-
-i.MX6 Quad Armadillo2 Board
-Required root node properties:
-    - compatible = "fsl,imx6q-arm2", "fsl,imx6q";
-
-i.MX6 Quad SABRE Lite Board
-Required root node properties:
-    - compatible = "fsl,imx6q-sabrelite", "fsl,imx6q";
-
-i.MX6 Quad SABRE Smart Device Board
-Required root node properties:
-    - compatible = "fsl,imx6q-sabresd", "fsl,imx6q";
-
-i.MX6 Quad SABRE Automotive Board
-Required root node properties:
-    - compatible = "fsl,imx6q-sabreauto", "fsl,imx6q";
-
-i.MX6SLL EVK board
-Required root node properties:
-    - compatible = "fsl,imx6sll-evk", "fsl,imx6sll";
-
-Generic i.MX boards
--------------------
-
-No iomux setup is done for these boards, so this must have been configured
-by the bootloader for boards to work with the generic bindings.
-
-i.MX27 generic board
-Required root node properties:
-    - compatible = "fsl,imx27";
-
-i.MX51 generic board
-Required root node properties:
-    - compatible = "fsl,imx51";
-
-i.MX53 generic board
-Required root node properties:
-    - compatible = "fsl,imx53";
-
-i.MX6q generic board
-Required root node properties:
-    - compatible = "fsl,imx6q";
-
-Freescale Vybrid Platform Device Tree Bindings
-----------------------------------------------
-
-For the Vybrid SoC familiy all variants with DDR controller are supported,
-which is the VF5xx and VF6xx series. Out of historical reasons, in most
-places the kernel uses vf610 to refer to the whole familiy.
-The compatible string "fsl,vf610m4" is used for the secondary Cortex-M4
-core support.
-
-Required root node compatible property (one of them):
-    - compatible = "fsl,vf500";
-    - compatible = "fsl,vf510";
-    - compatible = "fsl,vf600";
-    - compatible = "fsl,vf610";
-    - compatible = "fsl,vf610m4";
-
-Freescale LS1021A Platform Device Tree Bindings
-------------------------------------------------
-
-Required root node compatible properties:
-  - compatible = "fsl,ls1021a";
-
-Freescale ARMv8 based Layerscape SoC family Device Tree Bindings
-----------------------------------------------------------------
-
-LS1012A SoC
-Required root node properties:
-    - compatible = "fsl,ls1012a";
-
-LS1012A ARMv8 based RDB Board
-Required root node properties:
-    - compatible = "fsl,ls1012a-rdb", "fsl,ls1012a";
-
-LS1012A ARMv8 based FRDM Board
-Required root node properties:
-    - compatible = "fsl,ls1012a-frdm", "fsl,ls1012a";
-
-LS1012A ARMv8 based QDS Board
-Required root node properties:
-    - compatible = "fsl,ls1012a-qds", "fsl,ls1012a";
-
-LS1043A SoC
-Required root node properties:
-    - compatible = "fsl,ls1043a";
-
-LS1043A ARMv8 based RDB Board
-Required root node properties:
-    - compatible = "fsl,ls1043a-rdb", "fsl,ls1043a";
-
-LS1043A ARMv8 based QDS Board
-Required root node properties:
-    - compatible = "fsl,ls1043a-qds", "fsl,ls1043a";
-
-LS1046A SoC
-Required root node properties:
-    - compatible = "fsl,ls1046a";
-
-LS1046A ARMv8 based QDS Board
-Required root node properties:
-    - compatible = "fsl,ls1046a-qds", "fsl,ls1046a";
-
-LS1046A ARMv8 based RDB Board
-Required root node properties:
-    - compatible = "fsl,ls1046a-rdb", "fsl,ls1046a";
-
-LS1088A SoC
-Required root node properties:
-    - compatible = "fsl,ls1088a";
-
-LS1088A ARMv8 based QDS Board
-Required root node properties:
-    - compatible = "fsl,ls1088a-qds", "fsl,ls1088a";
-
-LS1088A ARMv8 based RDB Board
-Required root node properties:
-    - compatible = "fsl,ls1088a-rdb", "fsl,ls1088a";
-
-LS2080A SoC
-Required root node properties:
-    - compatible = "fsl,ls2080a";
-
-LS2080A ARMv8 based Simulator model
-Required root node properties:
-    - compatible = "fsl,ls2080a-simu", "fsl,ls2080a";
-
-LS2080A ARMv8 based QDS Board
-Required root node properties:
-    - compatible = "fsl,ls2080a-qds", "fsl,ls2080a";
-
-LS2080A ARMv8 based RDB Board
-Required root node properties:
-    - compatible = "fsl,ls2080a-rdb", "fsl,ls2080a";
-
-LS2088A SoC
-Required root node properties:
-    - compatible = "fsl,ls2088a";
-
-LS2088A ARMv8 based QDS Board
-Required root node properties:
-    - compatible = "fsl,ls2088a-qds", "fsl,ls2088a";
-
-LS2088A ARMv8 based RDB Board
-Required root node properties:
-    - compatible = "fsl,ls2088a-rdb", "fsl,ls2088a";
diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
new file mode 100644
index 000000000000..5241fa92e3d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -0,0 +1,166 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/fsl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX Platforms Device Tree Bindings
+
+maintainers:
+  - Shawn Guo <shawn.guo@freescale.com>
+  - Shaohui Xie <Shaohui.Xie@nxp.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: i.MX23 based Boards
+        items:
+          - enum:
+              - fsl,imx23-evk
+              - olimex,imx23-olinuxino
+          - const: fsl,imx23
+
+      - description: i.MX25 Product Development Kit
+        items:
+          - enum:
+              - fsl,imx25-pdk
+          - const: fsl,imx25
+
+      - description: i.MX27 Product Development Kit
+        items:
+          - enum:
+              - fsl,imx27-pdk
+          - const: fsl,imx27
+
+      - description: i.MX28 based Boards
+        items:
+          - enum:
+              - fsl,imx28-evk
+              - i2se,duckbill
+              - i2se,duckbill-2
+              - technologic,imx28-ts4600
+          - const: fsl,imx28
+      - items:
+          - enum:
+              - i2se,duckbill-2-485
+              - i2se,duckbill-2-enocean
+              - i2se,duckbill-2-spi
+          - const: i2se,duckbill-2
+          - const: fsl,imx28
+
+      - description: i.MX51 Babbage Board
+        items:
+          - enum:
+              - armadeus,imx51-apf51
+              - fsl,imx51-babbage
+              - technologic,imx51-ts4800
+          - const: fsl,imx51
+
+      - description: i.MX53 Boards
+        items:
+          - enum:
+              - bhf,cx9020
+              - fsl,imx53-ard
+              - fsl,imx53-evk
+              - fsl,imx53-qsb
+              - fsl,imx53-smd
+          - const: fsl,imx53
+
+      - description: i.MX6Q based Boards
+        items:
+          - enum:
+              - fsl,imx6q-arm2
+              - fsl,imx6q-sabrelite
+              - fsl,imx6q-sabresd
+              - fsl,imx6q-sabreauto
+              - technologic,imx6q-ts4900
+              - technologic,imx6q-ts7970
+          - const: fsl,imx6q
+
+      - description: i.MX6DL based Boards
+        items:
+          - enum:
+              - technologic,imx6dl-ts4900
+              - technologic,imx6dl-ts7970
+          - const: fsl,imx6dl
+
+      - description: i.MX6SLL based Boards
+        items:
+          - enum:
+              - fsl,imx6sll-evk
+          - const: fsl,imx6sll
+
+      - description:
+          Compulab SBC-iMX7 is a single board computer based on the
+          Freescale i.MX7 system-on-chip. SBC-iMX7 is implemented with
+          the CL-SOM-iMX7 System-on-Module providing most of the functions,
+          and SB-SOM-iMX7 carrier board providing additional peripheral
+          functions and connectors.
+        items:
+          - const: compulab,sbc-imx7
+          - const: compulab,cl-som-imx7
+          - const: fsl,imx7d
+
+      - description:
+          Freescale Vybrid Platform Device Tree Bindings
+
+          For the Vybrid SoC familiy all variants with DDR controller are supported,
+          which is the VF5xx and VF6xx series. Out of historical reasons, in most
+          places the kernel uses vf610 to refer to the whole familiy.
+          The compatible string "fsl,vf610m4" is used for the secondary Cortex-M4
+          core support.
+        items:
+          - enum:
+              - fsl,vf500
+              - fsl,vf510
+              - fsl,vf600
+              - fsl,vf610
+              - fsl,vf610m4
+
+      - description: LS1021A based Boards
+        items:
+          - enum:
+              - fsl,ls1012a-rdb
+              - fsl,ls1012a-frdm
+              - fsl,ls1012a-qds
+          - const: fsl,ls1021a
+
+      - description: LS1043A based Boards
+        items:
+          - enum:
+              - fsl,ls1043a-rdb
+              - fsl,ls1043a-qds
+          - const: fsl,ls1043a
+
+      - description: LS1046A based Boards
+        items:
+          - enum:
+              - fsl,ls1046a-qds
+              - fsl,ls1046a-rdb
+          - const: fsl,ls1046a
+
+      - description: LS1088A based Boards
+        items:
+          - enum:
+              - fsl,ls1088a-qds
+              - fsl,ls1088a-rdb
+          - const: fsl,ls1088a
+
+      - description: LS2080A based Boards
+        items:
+          - enum:
+              - fsl,ls2080a-simu
+              - fsl,ls2080a-qds
+              - fsl,ls2080a-rdb
+          - const: fsl,ls2080a
+
+      - description: LS2088A based Boards
+        items:
+          - enum:
+              - fsl,ls2088a-qds
+              - fsl,ls2088a-rdb
+          - const: fsl,ls2088a
+
+...
diff --git a/Documentation/devicetree/bindings/arm/i2se.txt b/Documentation/devicetree/bindings/arm/i2se.txt
deleted file mode 100644
index dbd54a3aa07d..000000000000
--- a/Documentation/devicetree/bindings/arm/i2se.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-I2SE Device Tree Bindings
--------------------------
-
-Duckbill Board
-Required root node properties:
-    - compatible = "i2se,duckbill", "fsl,imx28";
-
-Duckbill 2 Board
-Required root node properties:
-    - compatible = "i2se,duckbill-2", "fsl,imx28";
-
-Duckbill 2 485 Board
-Required root node properties:
-    - compatible = "i2se,duckbill-2-485", "i2se,duckbill-2", "fsl,imx28";
-
-Duckbill 2 EnOcean Board
-Required root node properties:
-    - compatible = "i2se,duckbill-2-enocean", "i2se,duckbill-2", "fsl,imx28";
-
-Duckbill 2 SPI Board
-Required root node properties:
-    - compatible = "i2se,duckbill-2-spi", "i2se,duckbill-2", "fsl,imx28";
diff --git a/Documentation/devicetree/bindings/arm/olimex.txt b/Documentation/devicetree/bindings/arm/olimex.txt
deleted file mode 100644
index d726aeca56be..000000000000
--- a/Documentation/devicetree/bindings/arm/olimex.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-Olimex Device Tree Bindings
----------------------------
-
-SAM9-L9260 Board
-Required root node properties:
-    - compatible = "olimex,sam9-l9260", "atmel,at91sam9260";
-
-i.MX23 Olinuxino Low Cost Board
-Required root node properties:
-    - compatible = "olimex,imx23-olinuxino", "fsl,imx23";
diff --git a/Documentation/devicetree/bindings/arm/technologic.txt b/Documentation/devicetree/bindings/arm/technologic.txt
deleted file mode 100644
index f1cedc00dcab..000000000000
--- a/Documentation/devicetree/bindings/arm/technologic.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Technologic Systems Platforms Device Tree Bindings
---------------------------------------------------
-
-TS-4600 is a System-on-Module based on the Freescale i.MX28 System-on-Chip.
-It can be mounted on a carrier board providing additional peripheral connectors.
-Required root node properties:
-	- compatible = "technologic,imx28-ts4600", "fsl,imx28"
-
-TS-4800 board
-Required root node properties:
-	- compatible = "technologic,imx51-ts4800", "fsl,imx51";
-
-TS-4900 is a System-on-Module based on the Freescale i.MX6 System-on-Chip.
-It can be mounted on a carrier board providing additional peripheral connectors.
-Required root node properties:
-	- compatible = "technologic,imx6dl-ts4900", "fsl,imx6dl"
-	- compatible = "technologic,imx6q-ts4900", "fsl,imx6q"
-
-TS-7970 is a System-on-Module based on the Freescale i.MX6 System-on-Chip.
-It can be mounted on a carrier board providing additional peripheral connectors.
-Required root node properties:
-	- compatible = "technologic,imx6dl-ts7970", "fsl,imx6dl"
-	- compatible = "technologic,imx6q-ts7970", "fsl,imx6q"
-- 
2.17.1

