Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DAAC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:05:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D322D20879
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D322D20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4398q16hqxzDqtV
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 07:05:17 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4398Vn1dp2zDqSv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 06:51:13 +1100 (AEDT)
Received: by mail-oi1-f195.google.com with SMTP id j21so18612737oii.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 11:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9ctNxvuyPF5iqgO7AZYmXgEh7unI6vGdlJZ+SjG9Pu4=;
 b=ZmsA9fIHHZFx8P4k+0Q/6Hie503txhC+uKTOxiDCGQdw4TtcL5DDodNV4AbS68G66z
 yrsH0ucT1SH9yRX4m6Z/AGI1gBXhcuqknOuYvXnI3I1QmEis3Q1Dfc7WX6q2xXO01OQu
 0dEry2mB3Bxtd0iFNBhMBSiSUs9bnnwIbw4QjaPFGKqIDZ9+awnOJ+jzVs3sVIbBM+mb
 T8NX7Kv1k0CcpmB4xDknxLJiiPqbjeA9Wc/527zCCBaiBHBJ4Y/aCKE8ISqOooZcbgwZ
 3HNGkNXSBi5l39/GmFpMZYgDv6bQkUJAtXp3xHq/pjqI6h8rJCu3qemLaF/b5/NSBX2i
 MnIg==
X-Gm-Message-State: AA+aEWZ1Ie6H5QYOdbmcSd+rdMTYorZmU5d99L0q7xVto5U7oBryAvWy
 quEHVIgumalBhQfLZ05Y4Q==
X-Google-Smtp-Source: AFSGD/UQFuqODoTBBhlJKDYvPvLymfufJzQnVu/VHssTq1BrKjuv7zqncceA/oBeLnr1nJBE1jjr2g==
X-Received: by 2002:a54:4f1d:: with SMTP id e29mr15009889oiy.310.1544039471399; 
 Wed, 05 Dec 2018 11:51:11 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 11:51:10 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Use of_node_name_eq for node name comparisons
Date: Wed,  5 Dec 2018 13:50:34 -0600
Message-Id: <20181205195050.4759-18-robh@kernel.org>
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
Cc: Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/hotplug/rpaphp_core.c | 2 +-
 drivers/pci/of.c                  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index bcd5d357ca23..7697d9c92b98 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -354,7 +354,7 @@ int rpaphp_add_slot(struct device_node *dn)
 	const int *indexes, *names, *types, *power_domains;
 	char *name, *type;
 
-	if (!dn->name || strcmp(dn->name, "pci"))
+	if (!of_node_name_eq(dn, "pci"))
 		return 0;
 
 	/* If this is not a hotplug slot, return without doing anything. */
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 4c4217d0c3f1..3d32da15c215 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -113,7 +113,7 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
 		 * a fake root for all functions of a multi-function
 		 * device we go down them as well.
 		 */
-		if (!strcmp(node->name, "multifunc-device")) {
+		if (of_node_name_eq(node, "multifunc-device")) {
 			for_each_child_of_node(node, node2) {
 				if (__of_pci_pci_compare(node2, devfn)) {
 					of_node_put(node);
-- 
2.19.1

