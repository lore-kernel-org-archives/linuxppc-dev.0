Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23260C5CFFE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 16:33:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 751E320821
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 16:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751E320821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43D7tS1Z5hzDqbl
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 03:33:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.53.132; helo=6.mo178.mail-out.ovh.net;
 envelope-from=groug@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 3598 seconds by postgrey-1.36 at bilbo;
 Tue, 11 Dec 2018 03:31:31 AEDT
Received: from 6.mo178.mail-out.ovh.net (6.mo178.mail-out.ovh.net
 [46.105.53.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43D7r356rdzDqtm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 03:31:31 +1100 (AEDT)
Received: from player168.ha.ovh.net (unknown [10.109.143.183])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 2979A42A86
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 16:15:10 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player168.ha.ovh.net (Postfix) with ESMTPSA id F1D74986B1A;
 Mon, 10 Dec 2018 15:15:03 +0000 (UTC)
Subject: [PATCH] ocxl: Simplify free_spa()
From: Greg Kurz <groug@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Mon, 10 Dec 2018 16:15:03 +0100
Message-ID: <154445490330.866942.2430705998072942471.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9438981872892549426
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

The only users of free_spa() are alloc_link() and free_link(), and
in both cases:

- link->spa != NULL

- free_spa(link) is immediatly followed by kfree(link)

The check isn't needed, and it doesn't bring much to clear the link->spa
pointer. Drop both.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 drivers/misc/ocxl/link.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
index 31695a078485..eed92055184d 100644
--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -352,11 +352,8 @@ static void free_spa(struct link *link)
 	pr_debug("Freeing SPA for %x:%x:%x\n", link->domain, link->bus,
 		link->dev);
 
-	if (spa && spa->spa_mem) {
-		free_pages((unsigned long) spa->spa_mem, spa->spa_order);
-		kfree(spa);
-		link->spa = NULL;
-	}
+	free_pages((unsigned long) spa->spa_mem, spa->spa_order);
+	kfree(spa);
 }
 
 static int alloc_link(struct pci_dev *dev, int PE_mask, struct link **out_link)

