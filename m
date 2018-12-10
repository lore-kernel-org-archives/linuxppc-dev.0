Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C4EC67839
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 16:06:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3808320672
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 16:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3808320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43D7Gm6WhYzDqJQ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 03:06:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.33.251.8; helo=13.mo4.mail-out.ovh.net;
 envelope-from=groug@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 316 seconds by postgrey-1.36 at bilbo;
 Tue, 11 Dec 2018 02:56:50 AEDT
Received: from 13.mo4.mail-out.ovh.net (13.mo4.mail-out.ovh.net [178.33.251.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43D7423PN4zDr2P
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 02:56:49 +1100 (AEDT)
Received: from player714.ha.ovh.net (unknown [10.109.159.222])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 496CE1C5524
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 16:18:20 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id 673C79E9BD0;
 Mon, 10 Dec 2018 15:18:13 +0000 (UTC)
Subject: [PATCH] ocxl: Clarify error path in setup_xsl_irq()
From: Greg Kurz <groug@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Mon, 10 Dec 2018 16:18:13 +0100
Message-ID: <154445509294.867383.14905585855902294361.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9492462115624753458
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtkedrudeghedgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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
Cc: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, stable@vger.kernel.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Implementing rollback with goto and labels is a common practice that
leads to prettier and more maintainable code. FWIW, this design pattern
is already being used in alloc_link() a few lines below in this file.

Do the same in setup_xsl_irq().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 drivers/misc/ocxl/link.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
index eed92055184d..659977a17405 100644
--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -273,9 +273,9 @@ static int setup_xsl_irq(struct pci_dev *dev, struct link *link)
 	spa->irq_name = kasprintf(GFP_KERNEL, "ocxl-xsl-%x-%x-%x",
 				link->domain, link->bus, link->dev);
 	if (!spa->irq_name) {
-		unmap_irq_registers(spa);
 		dev_err(&dev->dev, "Can't allocate name for xsl interrupt\n");
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto err_xsl;
 	}
 	/*
 	 * At some point, we'll need to look into allowing a higher
@@ -283,11 +283,10 @@ static int setup_xsl_irq(struct pci_dev *dev, struct link *link)
 	 */
 	spa->virq = irq_create_mapping(NULL, hwirq);
 	if (!spa->virq) {
-		kfree(spa->irq_name);
-		unmap_irq_registers(spa);
 		dev_err(&dev->dev,
 			"irq_create_mapping failed for translation interrupt\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto err_name;
 	}
 
 	dev_dbg(&dev->dev, "hwirq %d mapped to virq %d\n", hwirq, spa->virq);
@@ -295,15 +294,21 @@ static int setup_xsl_irq(struct pci_dev *dev, struct link *link)
 	rc = request_irq(spa->virq, xsl_fault_handler, 0, spa->irq_name,
 			link);
 	if (rc) {
-		irq_dispose_mapping(spa->virq);
-		kfree(spa->irq_name);
-		unmap_irq_registers(spa);
 		dev_err(&dev->dev,
 			"request_irq failed for translation interrupt: %d\n",
 			rc);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto err_mapping;
 	}
 	return 0;
+
+err_mapping:
+	irq_dispose_mapping(spa->virq);
+err_name:
+	kfree(spa->irq_name);
+err_xsl:
+	unmap_irq_registers(spa);
+	return rc;
 }
 
 static void release_xsl_irq(struct link *link)

