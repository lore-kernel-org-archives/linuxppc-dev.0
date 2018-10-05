Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB03C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:31:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC7E213A2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC7E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RcHb2DBCzF3cH
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 03:31:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.66; helo=mail-ot1-f66.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RbZR1PpJzF3Tc
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 02:59:11 +1000 (AEST)
Received: by mail-ot1-f66.google.com with SMTP id h26-v6so13360468otl.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 09:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PPgzQVjusYgNqChRktE3KOIpcteqC2FE8uYi4ggIVGg=;
 b=VD4N3TUDpREeM3kZT+/ZnSAuAmoKl0SWXDgQ3Gc0W6R2QiQI+f9m0Lit+icn1j3Bks
 0Dc7lFUKCpjTvtEvOFi9+0iqKPVOOnsIg+bJq5obja0QzuwDjMR+rW9iA6Yica9jy9fq
 CsICLnje/BUsbkx0XITpk7NMtkkKYGe6pzXsiCSGa/QReYhkDZVMZH9AWbiIDCMoIDm0
 z/sbLcMzi9+WKunlbZpM0ON3fg8029OWfE9E0uTRQb48afpWW+uV3JiuCRNIc8GzC+f3
 ncdjLr2QM9nWCLCey6aV9sE6tJO7GEOHeYaPUojw7cz4dhin81it2z0vRwDOjlc4qJSh
 9ERQ==
X-Gm-Message-State: ABuFfojZlG4ZSBL7/NMqYcsLvmPUEwoO94r1uI8aCdJ+KTWf4CJq87a2
 NGgJ9DLNHyx2sxhfehp0ag==
X-Google-Smtp-Source: ACcGV61BCesp56qNrgjdDp+HA62v2KoQmcvOOrIilfXctCihLaasYGZoW1vKiPeOmIHnS15n9M/5Qw==
X-Received: by 2002:a9d:1723:: with SMTP id i35mr7447888ota.223.1538758749111; 
 Fri, 05 Oct 2018 09:59:09 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 u63-v6sm2904328ota.75.2018.10.05.09.59.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 09:59:08 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/36] dt-bindings: arm: Convert PMU binding to json-schema
Date: Fri,  5 Oct 2018 11:58:25 -0500
Message-Id: <20181005165848.3474-14-robh@kernel.org>
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
 Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert ARM PMU binding to DT schema format using json-schema.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/pmu.txt | 70 --------------
 .../devicetree/bindings/arm/pmu.yaml          | 96 +++++++++++++++++++
 2 files changed, 96 insertions(+), 70 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/pmu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/pmu.yaml

diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
deleted file mode 100644
index 13611a8199bb..000000000000
--- a/Documentation/devicetree/bindings/arm/pmu.txt
+++ /dev/null
@@ -1,70 +0,0 @@
-* ARM Performance Monitor Units
-
-ARM cores often have a PMU for counting cpu and cache events like cache misses
-and hits. The interface to the PMU is part of the ARM ARM. The ARM PMU
-representation in the device tree should be done as under:-
-
-Required properties:
-
-- compatible : should be one of
-	"apm,potenza-pmu"
-	"arm,armv8-pmuv3"
-	"arm,cortex-a73-pmu"
-	"arm,cortex-a72-pmu"
-	"arm,cortex-a57-pmu"
-	"arm,cortex-a53-pmu"
-	"arm,cortex-a35-pmu"
-	"arm,cortex-a17-pmu"
-	"arm,cortex-a15-pmu"
-	"arm,cortex-a12-pmu"
-	"arm,cortex-a9-pmu"
-	"arm,cortex-a8-pmu"
-	"arm,cortex-a7-pmu"
-	"arm,cortex-a5-pmu"
-	"arm,arm11mpcore-pmu"
-	"arm,arm1176-pmu"
-	"arm,arm1136-pmu"
-	"brcm,vulcan-pmu"
-	"cavium,thunder-pmu"
-	"qcom,scorpion-pmu"
-	"qcom,scorpion-mp-pmu"
-	"qcom,krait-pmu"
-- interrupts : 1 combined interrupt or 1 per core. If the interrupt is a per-cpu
-               interrupt (PPI) then 1 interrupt should be specified.
-
-Optional properties:
-
-- interrupt-affinity : When using SPIs, specifies a list of phandles to CPU
-                       nodes corresponding directly to the affinity of
-		       the SPIs listed in the interrupts property.
-
-                       When using a PPI, specifies a list of phandles to CPU
-		       nodes corresponding to the set of CPUs which have
-		       a PMU of this type signalling the PPI listed in the
-		       interrupts property, unless this is already specified
-		       by the PPI interrupt specifier itself (in which case
-		       the interrupt-affinity property shouldn't be present).
-
-                       This property should be present when there is more than
-		       a single SPI.
-
-
-- qcom,no-pc-write : Indicates that this PMU doesn't support the 0xc and 0xd
-                     events.
-
-- secure-reg-access : Indicates that the ARMv7 Secure Debug Enable Register
-		      (SDER) is accessible. This will cause the driver to do
-		      any setup required that is only possible in ARMv7 secure
-		      state. If not present the ARMv7 SDER will not be touched,
-		      which means the PMU may fail to operate unless external
-		      code (bootloader or security monitor) has performed the
-		      appropriate initialisation. Note that this property is
-		      not valid for non-ARMv7 CPUs or ARMv7 CPUs booting Linux
-		      in Non-secure state.
-
-Example:
-
-pmu {
-        compatible = "arm,cortex-a9-pmu";
-        interrupts = <100 101>;
-};
diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
new file mode 100644
index 000000000000..0dbb9e0566af
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Performance Monitor Units
+
+maintainers:
+  - Mark Rutland <mark.rutland@arm.com>
+  - Will Deacon <will.deacon@arm.com>
+description: |+
+  ARM cores often have a PMU for counting cpu and cache events like cache misses
+  and hits. The interface to the PMU is part of the ARM ARM. The ARM PMU
+  representation in the device tree should be done as under:-
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apm,potenza-pmu
+          - arm,armv8-pmuv3
+          - arm,cortex-a73-pmu
+          - arm,cortex-a72-pmu
+          - arm,cortex-a57-pmu
+          - arm,cortex-a53-pmu
+          - arm,cortex-a35-pmu
+          - arm,cortex-a17-pmu
+          - arm,cortex-a15-pmu
+          - arm,cortex-a12-pmu
+          - arm,cortex-a9-pmu
+          - arm,cortex-a8-pmu
+          - arm,cortex-a7-pmu
+          - arm,cortex-a5-pmu
+          - arm,arm11mpcore-pmu
+          - arm,arm1176-pmu
+          - arm,arm1136-pmu
+          - brcm,vulcan-pmu
+          - cavium,thunder-pmu
+          - qcom,scorpion-pmu
+          - qcom,scorpion-mp-pmu
+          - qcom,krait-pmu
+  interrupts:
+    oneOf:
+      - maxItems: 1
+      - minItems: 2
+        maxItems: 8
+        description: 1 interrupt per core.
+
+  interrupts-extended:
+    $ref: '#/properties/interrupts'
+
+  interrupt-affinity:
+    description:
+      When using SPIs, specifies a list of phandles to CPU
+      nodes corresponding directly to the affinity of
+      the SPIs listed in the interrupts property.
+
+      When using a PPI, specifies a list of phandles to CPU
+      nodes corresponding to the set of CPUs which have
+      a PMU of this type signalling the PPI listed in the
+      interrupts property, unless this is already specified
+      by the PPI interrupt specifier itself (in which case
+      the interrupt-affinity property shouldn't be present).
+
+      This property should be present when there is more than
+      a single SPI.
+
+  qcom,no-pc-write:
+    type: boolean
+    description:
+      Indicates that this PMU doesn't support the 0xc and 0xd events.
+
+  secure-reg-access:
+    type: boolean
+    description:
+      Indicates that the ARMv7 Secure Debug Enable Register
+      (SDER) is accessible. This will cause the driver to do
+      any setup required that is only possible in ARMv7 secure
+      state. If not present the ARMv7 SDER will not be touched,
+      which means the PMU may fail to operate unless external
+      code (bootloader or security monitor) has performed the
+      appropriate initialisation. Note that this property is
+      not valid for non-ARMv7 CPUs or ARMv7 CPUs booting Linux
+      in Non-secure state.
+
+required:
+  - compatible
+
+oneOf:
+  - required:
+      - interrupts
+  - required:
+      - interrupts-extended
+
+...
-- 
2.17.1

