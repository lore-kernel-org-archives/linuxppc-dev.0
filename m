Return-Path: <linuxppc-dev+bounces-23855-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEECC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 23:26:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwZ493S50z30FB;
	Thu, 09 Jul 2026 09:26:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783519242;
	cv=none; b=Pfc9xG1wYFu/D5ZTAHQ3ej7S7AfpCbanEMp8GGmZYzOxOFWyDKOq4fhiuHa4g4ie9sawyEMNC0LtE6C+QaXGrItsFnhJEJ3YKgsDkgJXVRHVd26kXZG2U400Eu/G5yRjv/UEBS70a6kpotKF9P7onyy6tYJQlVrp6ryv2/2+YeU+HytfGPn1QvGiySJiEYNEHo7L41TWd0qvhn6OmctK+eQynv7dYYB4gs8z8oNCkdC3iLJHzAstLzwwuEfFAStpLjmnUDMHPNhz13K6ncnhH9ETNaDKeNlWisLHzUafpESpVb1VO/y0Ikp/ER5XxcE1y0RY57Iq2p0IoNnvzuLY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783519242; c=relaxed/relaxed;
	bh=5DmjQgW3kXkl7gsQ3tf7hddlR8zWgSIQC4xe4ne2oMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RxuVHWDllYz6qyzilAzfpcMkdD4L9buvPyrFvw8BGme2/+q54XQFWTEmVL41ZqcI4FORuPhPCuIktfnWPGEdySt1ClnbdjD/45UCBU39l4LOaUftDt/L2zjjfGS8t5EWx4U98zq5e0KpRZEyRcS1MhgzqZd2kvQnO8nA4q+zXA9OopHK036z4WKmpIWr/flC0Q6Ep/hfCGsq5aTSYKfXVtJAIKsQ7pzQI+0nwxdWT+w/OLwChOFhLZR/yolirEp1TSkWYtGM2FmRpyr3QpesnkyuLkc6jFlyuK05YilQ+j8wV5xGp27fBHqi4dOdLzpFWLnPEdgR2v0GUyeBgmB6Yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DL9/0ADr; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ahmed.tiba@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DL9/0ADr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ahmed.tiba@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwKVx2lTVz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 00:00:41 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F19821D14;
	Wed,  8 Jul 2026 07:00:05 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72BF83F66F;
	Wed,  8 Jul 2026 07:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783519210; bh=ujtvU7LprUxcCzb2hvF5oCOwYA6AWFKVIooatgIUI6k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DL9/0ADrXTgPRwWZ0fw7vXx6EfteyKhiCqQjEKWs3v2DBKQlc/Da6uZttUQFp/LY4
	 8VZC9rqcKiV6Iri1RBPbBnQ99owdYjM9BrE7YYP9vOJxUHQ8tTUhKttINucoZyy9la
	 hakVXYuWwV8IgV15eVngaq6fo7wU60k0mXIgB0gQ=
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Wed, 08 Jul 2026 14:59:08 +0100
Subject: [PATCH v7 09/10] dt-bindings: firmware: add arm,ras-cper
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
Message-Id: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-9-8b3a85216cef@arm.com>
References: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
In-Reply-To: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
 Saket Dumbre <saket.dumbre@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, 
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Ahmed Tiba <ahmed.tiba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-cxl@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-edac@vger.kernel.org, 
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783519157; l=2751;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=ujtvU7LprUxcCzb2hvF5oCOwYA6AWFKVIooatgIUI6k=;
 b=Gs4t+MsvttxseomDAnXwF06hV3REDmQizgOBhPYG63oph2IcrPrVCuFaq0BY8Sp0RD2FjaZxx
 uL3GzSWfxysDPdcVPHRvAoSGepp3nQAY/bV1v6vKsnkeD2mPKGUWd8C
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

Describe the DeviceTree node that exposes the Arm firmware-first CPER
provider and hook the file into MAINTAINERS so the binding has an
owner.

The initial user is the upstream zena-css platform, validated so far
on FVP.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 .../devicetree/bindings/firmware/arm,ras-cper.yaml | 52 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 +++
 2 files changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml b/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
new file mode 100644
index 000000000000..23d54008230d
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/arm,ras-cper.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm RAS CPER provider
+
+maintainers:
+  - Ahmed Tiba <ahmed.tiba@arm.com>
+
+description:
+  Arm Reliability, Availability and Serviceability (RAS) firmware can expose
+  a firmware-first CPER error source directly via DeviceTree. Firmware
+  provides the CPER Generic Error Status block and notifies the OS through
+  an interrupt.
+
+properties:
+  compatible:
+    const: arm,ras-cper
+
+  memory-region:
+    items:
+      - description:
+          CPER Generic Error Status block exposed by firmware.
+      - description:
+          Firmware-owned ack buffer. Firmware watches bit 0 and expects the
+          OS to set it once the current status block has been consumed
+          before the CPER buffer is overwritten.
+
+  interrupts:
+    maxItems: 1
+    description:
+      Interrupt used to signal that a new status record is ready.
+
+required:
+  - compatible
+  - memory-region
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    error-handler {
+      compatible = "arm,ras-cper";
+      memory-region = <&ras_cper_buffer>, <&ras_cper_ack>;
+      interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index f37a81950e25..951342f11e6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22521,6 +22521,11 @@ M:	Alexandre Bounine <alex.bou9@gmail.com>
 S:	Maintained
 F:	drivers/rapidio/
 
+RAS ERROR STATUS
+M:	Ahmed Tiba <ahmed.tiba@arm.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
+
 RAS INFRASTRUCTURE
 M:	Tony Luck <tony.luck@intel.com>
 M:	Borislav Petkov <bp@alien8.de>

-- 
2.43.0


