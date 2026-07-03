Return-Path: <linuxppc-dev+bounces-23515-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A13C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:40:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQcK28SZz2yfS;
	Sat, 04 Jul 2026 06:40:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783085950;
	cv=none; b=cBlxMC/AsQDnnXR00Rz68OxIBZb05niWUXmjEHIqyE9me4gL1BlDBlBbz2yWf5hSXfX0w7rgzubrBCWOO97v67ynjq/0Qv5nftqKT/rYpMj1Xs0Uj5Jy9VoCcjyz9v9ZXjxKFS27/C1n6YWcSLttVEWP5x4+xjuYYFKG697oka6Eizd/K/KgDTHA6vVOLfbgAbvXswGGcsenXAMf6KiOvBleyDJi/qR4MdKgid1yUawO36szZj5rBEMdfJS0Q78eeIRUuAkTYEF2egpturBOT1ReKf8nF+GtK9wKiC0AH1hKrXi8dGjzCO1YKW6urB9otyZqXX+7Ox0SowHCQtcwxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783085950; c=relaxed/relaxed;
	bh=E52SW4XqtJoq9qS1jAqfgrmebSDwDyOVpfeH7ZNhlUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NGulhp94ByiVV1pMM+80W764KgkIk0g3srhmMjGsRryyu2FWfMOY7uqSQ5oBz0gUe/6mA1IwaO/ic1pYQS7EPGLveR1m94ncbrZHzIVu4PNgbhkQ2yNrmQ58ZWpRS0V+xuUNkmnE4+NHmb5omB7dKLv0iZ0RiuhPF5kBPcwVPDeyKhJMJJ6xjYjTO0no2zssqjM+EiWuNWJssbuqiNtlzACmOmKpPrcUq8LBwSJq5IEy4GK/QmQuad6CO5wgUOVRy/6OTBc49N6KSYy4qz5zlohy1aRol2ADGrv+ygd9kZOkQP9vE3DjJ46Wcp2VCqI22Ynxd60JAlYz16oEBww3gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=tDCOxZDq; dkim-atps=neutral; spf=pass (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=tDCOxZDq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsFGN17Cpz2xwM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 23:39:07 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C001D1A0E1D;
	Fri,  3 Jul 2026 13:30:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 95ABA60300;
	Fri,  3 Jul 2026 13:30:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC44B104C957A;
	Fri,  3 Jul 2026 15:30:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783085436; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=E52SW4XqtJoq9qS1jAqfgrmebSDwDyOVpfeH7ZNhlUE=;
	b=tDCOxZDqVXARAuKzMXuq3kiXCmEhFB7JegdyyYato/C4JbHy7/oGi8CB8v8+jLrUo0Fh+P
	CjtJ9J+OmCqQ58fn1IGWPQWY1FVCtwRHlGqEymkEeZGcuxMLvPbl+MaLeugzldvI+bCg10
	cd3G+fmfvWDT0HZLy35Tfw1f/cjXgk+XuhFwyqH4+5pJrPEzikkLvLfOO9da0v4dT5hEAv
	p019ZS6Qa+ZttQHObeldd3Zv5uoAjRwcjpBmuUpmEZSMOJNXCwhPbB167MbIX/PHn0eKSy
	5uM7wpikjxccpDUP7f5mvAT7OLiVWlCWeFwLNxaR71J529cRUrKs1N1eWgrtZA==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Fri, 03 Jul 2026 15:30:12 +0200
Subject: [PATCH 04/12] dt-bindings: soc: fsl: qe: Add support of IRQ in QE
 GPIO
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
Message-Id: <20260703-qe-pic-gpios-v1-4-6c3e706e27dc@bootlin.com>
References: <20260703-qe-pic-gpios-v1-0-6c3e706e27dc@bootlin.com>
In-Reply-To: <20260703-qe-pic-gpios-v1-0-6c3e706e27dc@bootlin.com>
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
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783085423; l=4322;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=+jkkvPCCKjh7ZaI+1VoXZ0vON5WrLxvcDsm31VeIbGw=;
 b=nLIzbXGRyeN1pfqKgkrV+BDJiN+CFCw+/qtSDWeh1TZG9ruG2ogd+zu7Dg0DrAhpCOI93couN
 22aKR5ewAM4Dv9Izhv9SgtaUDR1HQO6l1urXfO/ntBBEhwxNIl2dHTN
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Some QE GPIO pins have an associated interrupt line in the QE PIC to
signal state changes on the pin.  Add the corresponding
interrupt-controller / nexus properties to the QE GPIO binding.

Because the GPIO controller does not perform any interrupt handling
itself, a nexus node (interrupt-map) is used to map each GPIO line
supporting IRQ to the parent QE PIC interrupt domain.

As the QE PIC can be configured to generate an interrupt on either a
high-to-low transition or any change in signal state, three
interrupt-map entries are needed per GPIO pin that can yield an
interrupt (falling, both, and the "none" case which defaults to both in
QE PIC).  This overhead is necessary because the interrupt-map-pass-thru
property is not part of the DT specification.

The interrupt-map property is optional: it is not required for GPIO
banks that have no interrupt capable GPIO line (e.g. port D on MPC8323),
or when interrupt functionality is not used.

Update the example to show a scenario where each bank supports a
different numbers of IRQs, or no IRQs at all.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 .../bindings/gpio/fsl,mpc8323-qe-pario-bank.yaml   | 69 +++++++++++++++++++++-
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/fsl,mpc8323-qe-pario-bank.yaml b/Documentation/devicetree/bindings/gpio/fsl,mpc8323-qe-pario-bank.yaml
index 1af99339ff40..0c849a5698f4 100644
--- a/Documentation/devicetree/bindings/gpio/fsl,mpc8323-qe-pario-bank.yaml
+++ b/Documentation/devicetree/bindings/gpio/fsl,mpc8323-qe-pario-bank.yaml
@@ -27,6 +27,17 @@ properties:
   "#gpio-cells":
     const: 2
 
+  "#address-cells":
+    const: 0
+
+  "#interrupt-cells":
+    const: 2
+
+  interrupt-map:
+    description: |
+      Specifies the mapping of GPIO lines to the parent interrupt controller, as the
+      GPIO controller does not do interrupt handling itself.
+
 required:
   - compatible
   - reg
@@ -37,9 +48,61 @@ additionalProperties: false
 
 examples:
   - |
-    gpio-controller@1400 {
-        compatible = "fsl,mpc8360-qe-pario-bank", "fsl,mpc8323-qe-pario-bank";
-        reg = <0x1400 0x18>;
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pic: interrupt-controller {
+      interrupt-controller;
+      #address-cells = <0>;
+      #interrupt-cells = <2>;
+    };
+
+    gpio-controller@1418 {
+        #gpio-cells = <2>;
+        #address-cells = <0>;
+        #interrupt-cells = <2>;
+        compatible = "fsl,mpc8323-qe-pario-bank";
+        reg = <0x1418 0x18>;
         gpio-controller;
+        interrupt-map = <
+          7 IRQ_TYPE_EDGE_FALLING  &pic 4 IRQ_TYPE_EDGE_FALLING
+          7 IRQ_TYPE_EDGE_BOTH     &pic 4 IRQ_TYPE_EDGE_BOTH
+          7 0                      &pic 4 IRQ_TYPE_NONE
+
+          9 IRQ_TYPE_EDGE_FALLING  &pic 5 IRQ_TYPE_EDGE_FALLING
+          9 IRQ_TYPE_EDGE_BOTH     &pic 5 IRQ_TYPE_EDGE_BOTH
+          9 0                      &pic 5 IRQ_TYPE_NONE
+
+          25 IRQ_TYPE_EDGE_FALLING &pic 6 IRQ_TYPE_EDGE_FALLING
+          25 IRQ_TYPE_EDGE_BOTH    &pic 6 IRQ_TYPE_EDGE_BOTH
+          25 0                     &pic 6 IRQ_TYPE_NONE
+
+          27 IRQ_TYPE_EDGE_FALLING &pic 7 IRQ_TYPE_EDGE_FALLING
+          27 IRQ_TYPE_EDGE_BOTH    &pic 7 IRQ_TYPE_EDGE_BOTH
+          27 0                     &pic 7 IRQ_TYPE_NONE
+        >;
+    };
+
+    gpio-controller@1430 {
         #gpio-cells = <2>;
+        #address-cells = <0>;
+        #interrupt-cells = <2>;
+        compatible = "fsl,mpc8323-qe-pario-bank";
+        reg = <0x1430 0x18>;
+        gpio-controller;
+        interrupt-map = <
+          24 IRQ_TYPE_EDGE_FALLING &pic 8 IRQ_TYPE_EDGE_FALLING
+          24 IRQ_TYPE_EDGE_BOTH    &pic 8 IRQ_TYPE_EDGE_BOTH
+          24 0                     &pic 8 IRQ_TYPE_NONE
+
+          29 IRQ_TYPE_EDGE_FALLING &pic 9 IRQ_TYPE_EDGE_FALLING
+          29 IRQ_TYPE_EDGE_BOTH    &pic 9 IRQ_TYPE_EDGE_BOTH
+          29 0                     &pic 9 IRQ_TYPE_NONE
+        >;
+    };
+
+    gpio-controller@1448 {
+        #gpio-cells = <2>;
+        compatible = "fsl,mpc8323-qe-pario-bank";
+        reg = <0x1448 0x18>;
+        gpio-controller;
     };

-- 
2.55.0


