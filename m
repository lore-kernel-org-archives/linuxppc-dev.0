Return-Path: <SRS0=uvk8=DP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25034C4363A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2020 14:29:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5637221D41
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2020 14:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5637221D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C6YW257zwzDqSl
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2020 01:29:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C6YP80w5WzDqWW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2020 01:24:27 +1100 (AEDT)
Received: by mail-ot1-f67.google.com with SMTP id m11so5589337otk.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2020 07:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cbwKFYHPbp5GTNdG4T4mKLQORc21DXouN8jvpsAfWQE=;
 b=nhV8SkCFXZh1ZyxTGfrvpvZvvEJUiRAFW2TaytrY+HEQyPLbxNL+F8HDvzOXBtYWig
 DkFR85rz0dAvBRVVAQjmtnO5HGMSTYVR2aDKJoNcUiZ8oN31sdXys4jEMa6tptZGq+wo
 wQTM6eSYGGoahO0g3y36PwzYChPlz0Z/3oxOmVdn5Mzxl1eNW/HaUMCU/ogb87uan7kH
 tTh6MWGdNsLEQxbLaWdhmYiGjGg/P1iihIDSc+mcCvBG2vjabnAjjAq8MuUQn0P1mjY5
 ceWojRiHgK+ip3EHYJhv7LgZKp+rXlKczlFimalPuBCXYnQmZK2gVkTt9Xs+HBgLUn5K
 TpMA==
X-Gm-Message-State: AOAM531NZIpXqX+lGcV3jERYOBeDxgeERT1B9CeIyPjli5df6AxwzbSU
 9O8D+rIFthFVYrGilZZKxw==
X-Google-Smtp-Source: ABdhPJx5CFACMyMhsVj5wqDOr7VXjzKJ25j6nM0arqd7ipXHZQY8NH6go4gbElQF585d0rhOybv0Hg==
X-Received: by 2002:a9d:7c87:: with SMTP id q7mr5365330otn.140.1602167063432; 
 Thu, 08 Oct 2020 07:24:23 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id r131sm4880609oig.50.2020.10.08.07.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 07:24:21 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: powerpc: Add a schema for the 'sleep'
 property
Date: Thu,  8 Oct 2020 09:24:19 -0500
Message-Id: <20201008142420.2083861-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Document the PowerPC specific 'sleep' property as a schema. It is
currently only documented in booting-without-of.rst which is getting
removed.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/powerpc/sleep.yaml    | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/powerpc/sleep.yaml

diff --git a/Documentation/devicetree/bindings/powerpc/sleep.yaml b/Documentation/devicetree/bindings/powerpc/sleep.yaml
new file mode 100644
index 000000000000..6494c7d08b93
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/sleep.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/powerpc/sleep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PowerPC sleep property
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+description: |
+  Devices on SOCs often have mechanisms for placing devices into low-power
+  states that are decoupled from the devices' own register blocks.  Sometimes,
+  this information is more complicated than a cell-index property can
+  reasonably describe.  Thus, each device controlled in such a manner
+  may contain a "sleep" property which describes these connections.
+
+  The sleep property consists of one or more sleep resources, each of
+  which consists of a phandle to a sleep controller, followed by a
+  controller-specific sleep specifier of zero or more cells.
+
+  The semantics of what type of low power modes are possible are defined
+  by the sleep controller.  Some examples of the types of low power modes
+  that may be supported are:
+
+   - Dynamic: The device may be disabled or enabled at any time.
+   - System Suspend: The device may request to be disabled or remain
+     awake during system suspend, but will not be disabled until then.
+   - Permanent: The device is disabled permanently (until the next hard
+     reset).
+
+  Some devices may share a clock domain with each other, such that they should
+  only be suspended when none of the devices are in use.  Where reasonable,
+  such nodes should be placed on a virtual bus, where the bus has the sleep
+  property.  If the clock domain is shared among devices that cannot be
+  reasonably grouped in this manner, then create a virtual sleep controller
+  (similar to an interrupt nexus, except that defining a standardized
+  sleep-map should wait until its necessity is demonstrated).
+
+select: true
+
+properties:
+  sleep:
+    $ref: /schemas/types.yaml#definitions/phandle-array
+
+additionalProperties: true
-- 
2.25.1

