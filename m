Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD01C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 22:19:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCB42086A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 22:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCB42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xXh60MYszF37V
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 09:19:02 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xXWC0nstzF3bx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 09:11:19 +1100 (AEDT)
Received: by mail-ot1-f67.google.com with SMTP id 81so22753398otj.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 14:11:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/G7/uyz7QXf7tbLsILQzDHnS++eVzTBhhnns0VhMoTU=;
 b=JqcUdJuKS7vnD2COw3iziwRsYtk8532IabCxcyFBh3MX39ubVZMrIsaGNsNi7gyzEQ
 q6ByfQb101y9y3tZsABDFkfTXb6M48CgRmsR30HMnsnBOx1q5IXr6a68/BSdEJbGATvc
 JdEGcwNAaXPqowRtS8aZHqOyGMdSruUeVimLyUHjm4HjKnDsE6w2Ez043e5BAFzSU6fb
 7QwpUG0mF52jK/VeBzzmtBtwDxEiNSrbstpedCcMzopI6YfsS927Pwnd/hEZDWLu0tWu
 Y2uqH8GekLgga5pDWjnVB4tpO/vn+ppbe+KZaXbgBiOk0iJQNgtil8vlEUms0aaD3oiC
 lBJA==
X-Gm-Message-State: AGRZ1gJDL1LgntS8EQL8in+QjCpgbaqtboUUBQNBsgkdVnhRGhaf9ClR
 sWAHQ25Ixjq9Lrys+GThyA==
X-Google-Smtp-Source: AJdET5cWuhY2KdZgilsbDi9ELt6Qu3qVpFGjMszfurOkQ2/mGAYfFrz93y19BKkVbvz8nyiLfYcfyA==
X-Received: by 2002:a9d:75da:: with SMTP id c26mr7966790otl.39.1542406276903; 
 Fri, 16 Nov 2018 14:11:16 -0800 (PST)
Received: from localhost.localdomain (mobile-166-173-57-127.mycingular.net.
 [166.173.57.127]) by smtp.googlemail.com with ESMTPSA id
 p204-v6sm12142631oib.25.2018.11.16.14.11.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 Nov 2018 14:11:16 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] misc: cxl: Use device_type helpers to access the node type
Date: Fri, 16 Nov 2018 16:11:02 -0600
Message-Id: <20181116221104.23024-6-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
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
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Remove directly accessing device_node.type pointer and use the accessors
instead. This will eventually allow removing the type pointer.

Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/misc/cxl/pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index b66d832d3233..c79ba1c699ad 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1718,7 +1718,6 @@ int cxl_slot_is_switched(struct pci_dev *dev)
 {
 	struct device_node *np;
 	int depth = 0;
-	const __be32 *prop;
 
 	if (!(np = pci_device_to_OF_node(dev))) {
 		pr_err("cxl: np = NULL\n");
@@ -1727,8 +1726,7 @@ int cxl_slot_is_switched(struct pci_dev *dev)
 	of_node_get(np);
 	while (np) {
 		np = of_get_next_parent(np);
-		prop = of_get_property(np, "device_type", NULL);
-		if (!prop || strcmp((char *)prop, "pciex"))
+		if (!of_node_is_type(np, "pciex"))
 			break;
 		depth++;
 	}
-- 
2.19.1

