Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D935C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 19:18:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A4620850
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 19:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A4620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4397nX3cPmzDqW4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 06:18:56 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4397lJ0cP6zDqxV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 06:16:59 +1100 (AEDT)
Received: by mail-oi1-f196.google.com with SMTP id y23so18564207oia.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 11:16:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vJ4tevbNbxREqSgsxj5/TEpmpw/iqRFq5WUY9yVtSgM=;
 b=SXwCrik7jM34fl4Ez0P6ba7DFG2/i0aeLhi+4EK8G0fISkv5ZPFIS6XC/jzHKl4x6j
 fttfttABoXOJuGw8tDRYlA2asXjzQZPRjF0RbAakgbsa2iGxZXuV2IlecjmDmYbZ79DL
 b6FWFuxD7PKp+VTS2LzV6JbuWmy4IYrATUGjNiVI7GYrYY/bSi7zICJBHtu/LMaWykBX
 88YgVzPJNpMTe3hyHfWhEhFS1i2w5L1ELWPu5J8ooEJf7W5AowSK2GkXQZu5mCXYtZ6N
 UnBbezhrx7ESDr5owpskJLvD99XhPjcZ+AZS9ll9ABmu4mvoLIsA/r8G/onTc1662Lge
 0/gw==
X-Gm-Message-State: AA+aEWaZDYY+IYQGQcxEJ59k2UjNSxkfLBpuhqcW0wEMVu4+ZA6hwmPw
 IEUE28DCzQXI4Kd6t+E2iw==
X-Google-Smtp-Source: AFSGD/VKQ0mBEaCbGjELAaEHiAqQP6TYFXXAQ7F/F9rdi7OdwKKaDgDGEljwM50VJ2K5lSyGKgBKfA==
X-Received: by 2002:aca:88a:: with SMTP id 132mr568804oii.224.1544037417673;
 Wed, 05 Dec 2018 11:16:57 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id f18sm7355241otl.18.2018.12.05.11.16.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 11:16:56 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] misc: cxl: Use device_type helpers to access the node type
Date: Wed,  5 Dec 2018 13:16:55 -0600
Message-Id: <20181205191655.14612-1-robh@kernel.org>
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

Remove directly accessing device_type property and use the
of_node_is_type accessor instead. While not using it here, this is
part of eventually removing the struct device_node.type pointer.

Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Reword commit message as this change was using the .type ptr.

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

