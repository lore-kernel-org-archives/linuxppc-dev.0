Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E23C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:14:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D57320851
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D57320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437zmR33KzzDqP3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 09:13:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.196; helo=mail-oi1-f196.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437yrx5N6FzDqPS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 08:32:49 +1100 (AEDT)
Received: by mail-oi1-f196.google.com with SMTP id t204so12343236oie.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 13:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sPnbRFVIiMYQKirIzLX8zgOj667G6dJY549fDeFqh/4=;
 b=EsiM/CQoNIKL74ZkK+Dut5j7VtK1YlNdqiEUwO8hLTI1CmdFTc2TGh65MFGgD8wvpO
 ntZE6QUk463ggRTFoAPI7hD8TwtrIsKpWt9XzN6F/zZSRa1Ta90tJUICelw7WWXumsXP
 aV4unRz3BDLMdV1zIdbM2LCEYITSQIasMb95ss73nkTpn4XyxQKa9Xmx3qSq5JM8JLeK
 HJ5RaWjW9iMsiTLrO36vPI1oR3+gU7pKhI0ki7JlenvGN2wjeAyhm2sea3Vo2ZckpXDJ
 w9BeUyPWuUTMzn9U/nzMYaLIMJ18gDJy1h6+pgE1I34QCQjt+2ifaS1+dq6iRB/jN50E
 k0Vw==
X-Gm-Message-State: AA+aEWbiQEhmye25lShvrwXylSpBwnGoIUBHFdtFbkOAAi6qUh9Q19uE
 i00C6sIpCdsCNTnJM/is3Q==
X-Google-Smtp-Source: AFSGD/X3TOVbpCPz5reUwrZqOWV57jGlZUfCfJr8r40cTKaYdaSOMe2dXL7wOcdRdTW8QVjsvX77Hw==
X-Received: by 2002:aca:4e11:: with SMTP id c17mr10540583oib.254.1543872767801; 
 Mon, 03 Dec 2018 13:32:47 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:47 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/34] dt-bindings: arm: Convert FSL board/soc bindings to
 json-schema
Date: Mon,  3 Dec 2018 15:32:07 -0600
Message-Id: <20181203213223.16986-19-robh@kernel.org>
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
 Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
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
 .../bindings/arm/compulab-boards.txt          |  25 --
 Documentation/devicetree/bindings/arm/fsl.txt | 229 ------------------
 .../devicetree/bindings/arm/fsl.yaml          | 214 ++++++++++++++++
 .../devicetree/bindings/arm/i2se.txt          |  22 --
 .../devicetree/bindings/arm/olimex.txt        |  10 -
 .../devicetree/bindings/arm/technologic.txt   |  23 --
 8 files changed, 214 insertions(+), 321 deletions(-)
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
index 5074aeecd327..000000000000
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ /dev/null
@@ -1,229 +0,0 @@
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
-i.MX6 Quad Plus SABRE Smart Device Board
-Required root node properties:
-    - compatible = "fsl,imx6qp-sabresd", "fsl,imx6qp";
-
-i.MX6 Quad Plus SABRE Automotive Board
-Required root node properties:
-    - compatible = "fsl,imx6qp-sabreauto", "fsl,imx6qp";
-
-i.MX6 DualLite SABRE Smart Device Board
-Required root node properties:
-    - compatible = "fsl,imx6dl-sabresd", "fsl,imx6dl";
-
-i.MX6 DualLite/Solo SABRE Automotive Board
-Required root node properties:
-    - compatible = "fsl,imx6dl-sabreauto", "fsl,imx6dl";
-
-i.MX6 SoloLite EVK Board
-Required root node properties:
-    - compatible = "fsl,imx6sl-evk", "fsl,imx6sl";
-
-i.MX6 UltraLite 14x14 EVK Board
-Required root node properties:
-    - compatible = "fsl,imx6ul-14x14-evk", "fsl,imx6ul";
-
-i.MX6 UltraLiteLite 14x14 EVK Board
-Required root node properties:
-    - compatible = "fsl,imx6ull-14x14-evk", "fsl,imx6ull";
-
-i.MX6 ULZ 14x14 EVK Board
-Required root node properties:
-    - compatible = "fsl,imx6ulz-14x14-evk", "fsl,imx6ull", "fsl,imx6ulz";
-
-i.MX6 SoloX SDB Board
-Required root node properties:
-    - compatible = "fsl,imx6sx-sdb", "fsl,imx6sx";
-
-i.MX6 SoloX Sabre Auto Board
-Required root node properties:
-    - compatible = "fsl,imx6sx-sabreauto", "fsl,imx6sx";
-
-i.MX7 SabreSD Board
-Required root node properties:
-    - compatible = "fsl,imx7d-sdb", "fsl,imx7d";
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
index 000000000000..a4d625d7ff4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -0,0 +1,214 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/fsl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX Platforms Device Tree Bindings
+
+maintainers:
+  - Shawn Guo <shawnguo@kernel.org>
+  - Li Yang <leoyang.li@nxp.com>
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
+      - description: i.MX28 Duckbill 2 based Boards
+        items:
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
+      - description: i.MX53 based Boards
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
+              - fsl,imx6q-sabreauto
+              - fsl,imx6q-sabrelite
+              - fsl,imx6q-sabresd
+              - technologic,imx6q-ts4900
+              - technologic,imx6q-ts7970
+          - const: fsl,imx6q
+
+      - description: i.MX6QP based Boards
+        items:
+          - enum:
+              - fsl,imx6qp-sabreauto      # i.MX6 Quad Plus SABRE Automotive Board
+              - fsl,imx6qp-sabresd        # i.MX6 Quad Plus SABRE Smart Device Board
+          - const: fsl,imx6qp
+
+      - description: i.MX6DL based Boards
+        items:
+          - enum:
+              - fsl,imx6dl-sabreauto      # i.MX6 DualLite/Solo SABRE Automotive Board
+              - fsl,imx6dl-sabresd        # i.MX6 DualLite SABRE Smart Device Board
+              - technologic,imx6dl-ts4900
+              - technologic,imx6dl-ts7970
+          - const: fsl,imx6dl
+
+      - description: i.MX6SL based Boards
+        items:
+          - enum:
+              - fsl,imx6sl-evk            # i.MX6 SoloLite EVK Board
+          - const: fsl,imx6sl
+
+      - description: i.MX6SLL based Boards
+        items:
+          - enum:
+              - fsl,imx6sll-evk
+          - const: fsl,imx6sll
+
+      - description: i.MX6SX based Boards
+        items:
+          - enum:
+              - fsl,imx6sx-sabreauto      # i.MX6 SoloX Sabre Auto Board
+              - fsl,imx6sx-sdb            # i.MX6 SoloX SDB Board
+          - const: fsl,imx6sx
+
+      - description: i.MX6UL based Boards
+        items:
+          - enum:
+              - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
+          - const: fsl,imx6ul
+
+      - description: i.MX6ULL based Boards
+        items:
+          - enum:
+              - fsl,imx6ull-14x14-evk     # i.MX6 UltraLiteLite 14x14 EVK Board
+          - const: fsl,imx6ull
+
+      - description: i.MX6ULZ based Boards
+        items:
+          - enum:
+              - fsl,imx6ulz-14x14-evk     # i.MX6 ULZ 14x14 EVK Board
+          - const: fsl,imx6ull # This seems odd. Should be last?
+          - const: fsl,imx6ulz
+
+      - description: i.MX7D based Boards
+        items:
+          - enum:
+              - fsl,imx7d-sdb             # i.MX7 SabreSD Board
+          - const: fsl,imx7d
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
2.19.1

