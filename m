Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E69C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:28:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13A720864
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13A720864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43805b4ZGvzDqST
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 09:28:51 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 437ys62CRYzDqGp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 08:32:58 +1100 (AEDT)
Received: by mail-oi1-f195.google.com with SMTP id x23so12358341oix.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 13:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RoLiDVuqvYANZ1flcAwjENqg+ADf2CNBEHOQ2CuYDWM=;
 b=PjuQBKcLYOoklXYyuvSSCgd2kIooy/BZAyJmvGGnBww+IwjwtY25JfdBRkdin3IAYO
 KeBWcPvl9qO6Vdm+lzIvlpXzMgC/pnwsXRHM2DWCCPuaZFzdhV4GjsUOo4FgMi8CpqFL
 dRgvp9BcHup2yvxyJyQE6M4YZiHchORshlmd1JTSwMjlIAl+dvX/qBrd0ITSy3P2IcO4
 ayZgfwKe0J/hniE1Xu0MP70VOfZL4DhAqGHm+iD6dDjplrmmW2wATfYgLpoRr3RwC/R7
 XkorDRmg8E6DmIDG2F1V9PnqTe83PqjDT311zFVRRek2biJ4dIjf3D6TmhAuMNBuN5NO
 Ro2Q==
X-Gm-Message-State: AA+aEWbbysv4I3caXNKOYStR0S30odz1aI6leH/cHfFQ93jM4z8O9wkC
 4l3YBOvI6cnadyiI3R3ShQ==
X-Google-Smtp-Source: AFSGD/VJlx1PDBZmcmB/SGQ6RsJ+otqbwoIYa3j7R2bskbvkocxhm0ynECKqW7DVQTmQOycr/0tgTQ==
X-Received: by 2002:aca:5bc3:: with SMTP id
 p186mr10568213oib.130.1543872776478; 
 Mon, 03 Dec 2018 13:32:56 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:55 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/34] dt-bindings: arm: renesas: Move 'renesas,
 prr' binding to its own doc
Date: Mon,  3 Dec 2018 15:32:14 -0600
Message-Id: <20181203213223.16986-26-robh@kernel.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>,
 Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 linux-renesas-soc@vger.kernel.org, Grant Likely <grant.likely@arm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In preparation to convert board-level bindings to json-schema, move
various misc SoC bindings out to their own file.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/renesas,prr.txt   | 20 +++++++++++++++++++
 .../devicetree/bindings/arm/shmobile.txt      | 18 -----------------
 2 files changed, 20 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/renesas,prr.txt

diff --git a/Documentation/devicetree/bindings/arm/renesas,prr.txt b/Documentation/devicetree/bindings/arm/renesas,prr.txt
new file mode 100644
index 000000000000..08e482e953ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/renesas,prr.txt
@@ -0,0 +1,20 @@
+Renesas Product Register
+
+Most Renesas ARM SoCs have a Product Register or Boundary Scan ID Register that
+allows to retrieve SoC product and revision information.  If present, a device
+node for this register should be added.
+
+Required properties:
+  - compatible: Must be one of:
+    "renesas,prr"
+    "renesas,bsid"
+  - reg: Base address and length of the register block.
+
+
+Examples
+--------
+
+	prr: chipid@ff000044 {
+		compatible = "renesas,prr";
+		reg = <0 0xff000044 0 4>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 58c4256d37a3..5f18ce9cdbb8 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -149,21 +149,3 @@ Boards:
     compatible = "renesas,v3msk", "renesas,r8a77970"
   - Wheat (RTP0RC7792ASKB0000JE)
     compatible = "renesas,wheat", "renesas,r8a7792"
-
-
-Most Renesas ARM SoCs have a Product Register or Boundary Scan ID Register that
-allows to retrieve SoC product and revision information.  If present, a device
-node for this register should be added.
-
-Required properties:
-  - compatible: Must be "renesas,prr" or "renesas,bsid"
-  - reg: Base address and length of the register block.
-
-
-Examples
---------
-
-	prr: chipid@ff000044 {
-		compatible = "renesas,prr";
-		reg = <0 0xff000044 0 4>;
-	};
-- 
2.19.1

