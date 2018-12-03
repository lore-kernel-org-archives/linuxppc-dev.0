Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89693C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:45:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110EE20864
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110EE20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4380SR1cq5zDqGl
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 09:45:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.195; helo=mail-oi1-f195.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437ysH1VwvzDqNL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 08:33:07 +1100 (AEDT)
Received: by mail-oi1-f195.google.com with SMTP id a77so12343578oii.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 13:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BgwOjYGaUM4jacGS7tw342B/DTF9EbMnkpVRYFr+pqY=;
 b=CMoyCMlgW+OE0ATGg7a46WQ0oxG8m2x2PlxDgMaadnYhP9uVkijSJH7sit/PgTy/17
 NbTiVAnDh5Nb4ZWE8XfRb/voFvpZDZGv8zhOmff+WWf6NYz/252w/pOK8C0D362t/H5/
 M+lKwQZQrf0nykgNaOxcmQItZnUyFchygOkN+A29tA1uQoLLwM4T8H/ifUXealJatKuj
 6LqhmQxyruFd56mP1p1mo+4RSlBIVDTTjmq6BqvmaPAPMyhnBXJKkHcOAsljHG0nMquU
 Zxdq7i2Hkp/qBXoZtARRPUgQ9VZfxxFo6jv5zfUbXVt/zGORmRtl6Aby6skVgwMLE9HD
 spGA==
X-Gm-Message-State: AA+aEWbBW2/iWMPE+5RPukWV3J87xDFwp+MASn0Stujhan24s+obbuzA
 BgaftRNiaCKfTdoN0NROrg==
X-Google-Smtp-Source: AFSGD/VgCUDrNHBT/uGjxuTWorLqCSCE7WshaNATuumRyWinarPM3J+GZiUM/gI/C1Xz4hhKTjWr0g==
X-Received: by 2002:aca:e283:: with SMTP id z125mr10414602oig.23.1543872785413; 
 Mon, 03 Dec 2018 13:33:05 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.33.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:33:04 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 33/34] dt-bindings: arm: Add missing Xilinx boards
Date: Mon,  3 Dec 2018 15:32:22 -0600
Message-Id: <20181203213223.16986-34-robh@kernel.org>
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
Cc: Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 Michal Simek <michal.simek@xilinx.com>, Grant Likely <grant.likely@arm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Michal Simek <michal.simek@xilinx.com>

Add missing description for Ultra96, zcu104, zcu106 and zcu111.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/xilinx.yaml       | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
index 64cd21b737af..c73b1f5c7f49 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.yaml
+++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
@@ -70,6 +70,14 @@ properties:
           - const: xlnx,zynqmp-zcu100
           - const: xlnx,zynqmp
 
+      - description: Xilinx 96boards compatible board Ultra96
+        items:
+          - const: avnet,ultra96-rev1
+          - const: avnet,ultra96
+          - const: xlnx,zynqmp-zcu100-revC
+          - const: xlnx,zynqmp-zcu100
+          - const: xlnx,zynqmp
+
       - description: Xilinx evaluation board zcu102
         items:
           - enum:
@@ -79,4 +87,28 @@ properties:
           - const: xlnx,zynqmp-zcu102
           - const: xlnx,zynqmp
 
+      - description: Xilinx evaluation board zcu104
+        items:
+          - enum:
+              - xlnx,zynqmp-zcu104-revA
+              - xlnx,zynqmp-zcu104-rev1.0
+          - const: xlnx,zynqmp-zcu104
+          - const: xlnx,zynqmp
+
+      - description: Xilinx evaluation board zcu106
+        items:
+          - enum:
+              - xlnx,zynqmp-zcu106-revA
+              - xlnx,zynqmp-zcu106-rev1.0
+          - const: xlnx,zynqmp-zcu106
+          - const: xlnx,zynqmp
+
+      - description: Xilinx evaluation board zcu111
+        items:
+          - enum:
+              - xlnx,zynqmp-zcu111-revA
+              - xlnx,zynqmp-zcu11-rev1.0
+          - const: xlnx,zynqmp-zcu111
+          - const: xlnx,zynqmp
+
 ...
-- 
2.19.1

