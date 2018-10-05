Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E281C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:07:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C65220834
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C65220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Rbll2W0czDrP0
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 03:07:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RbZ61CWgzF3Td
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 02:58:53 +1000 (AEST)
Received: by mail-ot1-f67.google.com with SMTP id l1so28553otj.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 09:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=71oY5HWjvjta+vASdeqnC6CknPvTEuU3/FDPawmJ7HI=;
 b=dVWEcCL/hftqOdmgA651gX+1t3I3nzHYcOJQQyAzqxOuUacpQo3K6zufVthG5xIhs9
 SuRjowO0bqjVLZZL+gV7BSxjbTA4AfOIaR81O72o0Wn7nfTW8bM20as9dC9n36O78omQ
 d8TOIN9SEHw1UonFYfE10ADoXWjybB4D/oJ/iNZIsm6sKizVZms+rg8xL2G0N4JKhb3A
 W2Mx9pE0sBpwuzS1fkG0sJvP2RLnEvQXky2kGSlwJ1F//8yaHylcK41Owsmuz2LB2ltB
 HGm0SwoyO2NysUaX2jjWbMkXOdAFVhvvwtXHzW/KuFy8K5lOuUsK9osFftWmNC4Z+moQ
 kk8A==
X-Gm-Message-State: ABuFfojpoxqsV7oNdCRyPOVV3DGnXMj1/LhJjmbCai10zZ3KdIRGCvQe
 gA6AY6OebRnosI07O77h/A==
X-Google-Smtp-Source: ACcGV6309J0wcTnWnYW9xumd4jiVdJLzbRTItcct9QsNLZtgsD8SvKo6hrlq3RTPwwyyN1C8vgGH4g==
X-Received: by 2002:a9d:2992:: with SMTP id n18mr661801otb.54.1538758731588;
 Fri, 05 Oct 2018 09:58:51 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 u63-v6sm2904328ota.75.2018.10.05.09.58.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 09:58:51 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/36] dt-bindings: arm: alpine: Move CPU control related
 binding to cpu-enable-method/al, alpine-smp
Date: Fri,  5 Oct 2018 11:58:13 -0500
Message-Id: <20181005165848.3474-2-robh@kernel.org>
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
 Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 Frank Rowand <frowand.list@gmail.com>,
 Antoine Tenart <antoine.tenart@free-electrons.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Tsahee Zidenberg <tsahee@annapurnalabs.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

It is best practice to have 1 binding per file, so board level bindings
should be separate for various misc SoC bindings. Move the Alpine CPU
control to al,alpine-smp and we can also remove a cross reference.

Cc: Tsahee Zidenberg <tsahee@annapurnalabs.com>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/al,alpine.txt     | 72 -------------------
 .../arm/cpu-enable-method/al,alpine-smp       | 34 ++++++++-
 2 files changed, 31 insertions(+), 75 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/al,alpine.txt b/Documentation/devicetree/bindings/arm/al,alpine.txt
index f404a4f9b165..d00debe2e86f 100644
--- a/Documentation/devicetree/bindings/arm/al,alpine.txt
+++ b/Documentation/devicetree/bindings/arm/al,alpine.txt
@@ -14,75 +14,3 @@ compatible: must contain "al,alpine"
 
 	...
 }
-
-* CPU node:
-
-The Alpine platform includes cortex-a15 cores.
-enable-method: must be "al,alpine-smp" to allow smp  [1]
-
-Example:
-
-cpus {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	enable-method = "al,alpine-smp";
-
-	cpu@0 {
-		compatible = "arm,cortex-a15";
-		device_type = "cpu";
-		reg = <0>;
-	};
-
-	cpu@1 {
-		compatible = "arm,cortex-a15";
-		device_type = "cpu";
-		reg = <1>;
-	};
-
-	cpu@2 {
-		compatible = "arm,cortex-a15";
-		device_type = "cpu";
-		reg = <2>;
-	};
-
-	cpu@3 {
-		compatible = "arm,cortex-a15";
-		device_type = "cpu";
-		reg = <3>;
-	};
-};
-
-
-* Alpine CPU resume registers
-
-The CPU resume register are used to define required resume address after
-reset.
-
-Properties:
-- compatible : Should contain "al,alpine-cpu-resume".
-- reg : Offset and length of the register set for the device
-
-Example:
-
-cpu_resume {
-	compatible = "al,alpine-cpu-resume";
-	reg = <0xfbff5ed0 0x30>;
-};
-
-* Alpine System-Fabric Service Registers
-
-The System-Fabric Service Registers allow various operation on CPU and
-system fabric, like powering CPUs off.
-
-Properties:
-- compatible : Should contain "al,alpine-sysfabric-service" and "syscon".
-- reg : Offset and length of the register set for the device
-
-Example:
-
-nb_service {
-        compatible = "al,alpine-sysfabric-service", "syscon";
-        reg = <0xfb070000 0x10000>;
-};
-
-[1] arm/cpu-enable-method/al,alpine-smp
diff --git a/Documentation/devicetree/bindings/arm/cpu-enable-method/al,alpine-smp b/Documentation/devicetree/bindings/arm/cpu-enable-method/al,alpine-smp
index c2e0cc5e4cfd..35e5afb6d9ad 100644
--- a/Documentation/devicetree/bindings/arm/cpu-enable-method/al,alpine-smp
+++ b/Documentation/devicetree/bindings/arm/cpu-enable-method/al,alpine-smp
@@ -14,7 +14,28 @@ Related properties:	(none)
 
 Note:
 This enable method requires valid nodes compatible with
-"al,alpine-cpu-resume" and "al,alpine-nb-service"[1].
+"al,alpine-cpu-resume" and "al,alpine-nb-service".
+
+
+* Alpine CPU resume registers
+
+The CPU resume register are used to define required resume address after
+reset.
+
+Properties:
+- compatible : Should contain "al,alpine-cpu-resume".
+- reg : Offset and length of the register set for the device
+
+
+* Alpine System-Fabric Service Registers
+
+The System-Fabric Service Registers allow various operation on CPU and
+system fabric, like powering CPUs off.
+
+Properties:
+- compatible : Should contain "al,alpine-sysfabric-service" and "syscon".
+- reg : Offset and length of the register set for the device
+
 
 Example:
 
@@ -48,5 +69,12 @@ cpus {
 	};
 };
 
---
-[1] arm/al,alpine.txt
+cpu_resume {
+	compatible = "al,alpine-cpu-resume";
+	reg = <0xfbff5ed0 0x30>;
+};
+
+nb_service {
+        compatible = "al,alpine-sysfabric-service", "syscon";
+        reg = <0xfb070000 0x10000>;
+};
-- 
2.17.1

