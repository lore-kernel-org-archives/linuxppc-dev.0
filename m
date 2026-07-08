Return-Path: <linuxppc-dev+bounces-23799-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADFFC44501
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 10:16:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwDWg4Yr7z3br2;
	Wed, 08 Jul 2026 20:15:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783505759;
	cv=none; b=eGoYXMe1H2LkzszwjR1K60hV49psH7geksrazEYellvClunsVb1A9wd7NIvI/QymTc9w8HgfAfe0I1WcVIriu+shfQ9i++RfZocb0pH815RtGoSE4ovgzh//YGIKsQlfFhpOdnOAaY4SCxWjxvqK9QR5DutjcuAT6Sp5UfGeRpmKP5beDZBURlHVE/v12qa2cItAxQaCxyrtOirhAEtuHBwQWNFnIS9CdtixZIbOG8iNGevanaVbLKWe0sDEK105kdbsTqUFUxp7wZcXO3qIILY4aKlUmiMw9Xkrb901Ih1owf8ZAW8UzlbRKuttr7wIXVdZIMeB8hxTkBbeFqUXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783505759; c=relaxed/relaxed;
	bh=gllbyD/2HtgvozHzuTlZat6kunKgakiIR5E6LqVeJik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QDQptlanhp51/1qCqjUwZz8ZflGv/66vmX8yrvveuzPOQ/Hr9BjAj7b+eVRWssHwLkMx5kIg9/axaZ7031l8qT0GGk1mPDVzdyJJeo0dXPR2cG2L1VK62ZCilg1KWYlKvsJQ02Wcu5eDf083bwUJoEXoFnQ8JPPNCTzdUN54qyR2rvMzJ30wYhao25m6RZfooqijGomOm+67awbwpPARVhqIFSZDM3oE6BSUDuoDA9AxeMcMk9Ccv8CLgJATsKRsCCg8eKrYY31HC+f0/ctJgoBkh1ldQ8NuAf5Iqpj/nNZyF5saIJ9TwyDNmldj5DUhajdikYjyoRUOUzF5cAjw0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1+Cbn39r; dkim-atps=neutral; spf=pass (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1+Cbn39r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwDWf48czz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 20:15:58 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1BE5D4E40CF3;
	Wed,  8 Jul 2026 10:15:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DC24560337;
	Wed,  8 Jul 2026 10:15:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA1FC11BC3422;
	Wed,  8 Jul 2026 12:15:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783505753; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gllbyD/2HtgvozHzuTlZat6kunKgakiIR5E6LqVeJik=;
	b=1+Cbn39rOsT8Axom5KlZF+tE1wm97VeEHQ1+r8v4+xXTuW5mgS18FbA989qOzTDKCJwSlp
	dGJBJTbu4LkkEf/GGSkUJKNaQz4JcB6AEy117AbjvZo7UBj12yu6kH/jFiSDVCZU+oESge
	RYGHGpnri890IO6+PXFLc1h7Z9eyA2ee7YESPqRFhFaJs4Z5or7Md3MK5Xd69HMMlVOe2j
	NcWIZZNKQNXlA9vIrnQuAKKnyNJBciMG3oyNBAhESybpFufyHLSLFExl+PxKA9bq7IOL4D
	gYD4vbpov+igLudkxhr2LAcWorqlVCMWdozXYYetMLjZofIXtKiAt8PDGiaWCA==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Wed, 08 Jul 2026 12:15:16 +0200
Subject: [PATCH v2 03/10] dt-bindings: soc: fsl: qe: Convert QE GPIO to DT
 schema
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-qe-pic-gpios-v2-3-1972044cfbd1@bootlin.com>
References: <20260708-qe-pic-gpios-v2-0-1972044cfbd1@bootlin.com>
In-Reply-To: <20260708-qe-pic-gpios-v2-0-1972044cfbd1@bootlin.com>
To: Qiang Zhao <qiang.zhao@nxp.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Paul Louvel <paul.louvel@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Christophe Leroy <chleroy@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783505738; l=3174;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=UbSADUbnynrAq7v90IAOq4fvvknDWduKdXMMWsrHUyY=;
 b=tKtA4EbkkuSXN6lQdVp+Wy3qhyUJjWACTjUO8MesOm0NA/W8oyrzkY8p+XAf0s4kxO87GeKY4
 +MPpCNb+r/pDC3b5A3oxWJnFRRIOZYQ1A9/S1pswDFr0jMEAtOtkNM5
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

From: Christophe Leroy <christophe.leroy@csgroup.eu>

Convert QE GPIO devicetree binding to DT schema. The old binding uses
fsl,<chip>-qe-pario-bank because multiple MCP83XX SoC has support for
these GPIO banks. The best practice is to list out every <chip> instead.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 .../bindings/gpio/fsl,mpc8323-qe-pario-bank.yaml   | 45 ++++++++++++++++++++++
 .../bindings/soc/fsl/cpm_qe/qe/par_io.txt          | 26 +------------
 2 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/fsl,mpc8323-qe-pario-bank.yaml b/Documentation/devicetree/bindings/gpio/fsl,mpc8323-qe-pario-bank.yaml
new file mode 100644
index 000000000000..1af99339ff40
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/fsl,mpc8323-qe-pario-bank.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/fsl,mpc8323-qe-pario-bank.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale QUICC Engine Parallel I/O (QE PARIO) GPIO Bank
+
+maintainers:
+  - Christophe Leroy <christophe.leroy@csgroup.eu>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,mpc8360-qe-pario-bank
+              - fsl,mpc8569-qe-pario-bank
+          - const: fsl,mpc8323-qe-pario-bank
+      - const: fsl,mpc8323-qe-pario-bank
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio-controller@1400 {
+        compatible = "fsl,mpc8360-qe-pario-bank", "fsl,mpc8323-qe-pario-bank";
+        reg = <0x1400 0x18>;
+        gpio-controller;
+        #gpio-cells = <2>;
+    };
diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe/par_io.txt b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe/par_io.txt
index 09b1b05fa677..782699c14567 100644
--- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe/par_io.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe/par_io.txt
@@ -24,28 +24,4 @@ par_io@1400 {
 
 Note that "par_io" nodes are obsolete, and should not be used for
 the new device trees. Instead, each Par I/O bank should be represented
-via its own gpio-controller node:
-
-Required properties:
-- #gpio-cells : should be "2".
-- compatible : should be "fsl,<chip>-qe-pario-bank",
-  "fsl,mpc8323-qe-pario-bank".
-- reg : offset to the register set and its length.
-- gpio-controller : node to identify gpio controllers.
-
-Example:
-	qe_pio_a: gpio-controller@1400 {
-		#gpio-cells = <2>;
-		compatible = "fsl,mpc8360-qe-pario-bank",
-		"fsl,mpc8323-qe-pario-bank";
-		reg = <0x1400 0x18>;
-		gpio-controller;
-	  };
-
-	qe_pio_e: gpio-controller@1460 {
-		#gpio-cells = <2>;
-		compatible = "fsl,mpc8360-qe-pario-bank",
-			     "fsl,mpc8323-qe-pario-bank";
-		reg = <0x1460 0x18>;
-		gpio-controller;
-	  };
+via its own gpio-controller node.

-- 
2.55.0


