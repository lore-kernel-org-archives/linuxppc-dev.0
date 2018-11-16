Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE01C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 22:08:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 997A92086A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 22:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997A92086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xXRS1RsRzF3fP
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 09:08:04 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xXP41QylzF3q4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 09:05:59 +1100 (AEDT)
Received: by mail-oi1-f195.google.com with SMTP id x202so9483552oif.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 14:05:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ix8cP0wCHZeC/8dXIYOuLIsYXZGQ5ByO8TLiKaNRW6A=;
 b=LRl0BhJptv3QMh8qUMxUskbOhO42V9HVcGFbgKyW2IYrgWNX1hiN20QVMJh/dhLDCO
 3CYItTo92Y6Zp7gpb+hguZLuHRBdFW6Z1e565Pb6+IuRT+mo12gJInylbUTeyrmidmgY
 yRv8fhHjh+O6brXt/Fzyyo+GqNv1iil5jw63kvML/1OacSFSPqT5mIjQRFE4jY82X18E
 eO8JREGtGtSo8MYAmzhmdmQPKd1yMq257IraZ7byoOziva0uY2QA7YDY0AnbcK5zA2f5
 6jc93dnqwoTHuFAtIcQBpSEPr9mu8z5lvCpw+G4VTCJU2iA2SRvKU/yACqytmspRpb06
 HSPA==
X-Gm-Message-State: AGRZ1gKXPmE1ilunkwEay9Lso2vxwzqNZLmrssrbEbx5ezeIGqKNiaeN
 pF8Q82AkU+S9RdvO6pAy1Q==
X-Google-Smtp-Source: AJdET5dWAlyw9dQNJ01NmZEVcGJb1ngmkYFLUKKBDVDguZVokV56SJD0WI0696LJyEdJzyun0JaKcg==
X-Received: by 2002:aca:4202:: with SMTP id p2-v6mr1888048oia.41.1542405957801; 
 Fri, 16 Nov 2018 14:05:57 -0800 (PST)
Received: from localhost.localdomain (mobile-166-173-57-127.mycingular.net.
 [166.173.57.127])
 by smtp.googlemail.com with ESMTPSA id w5sm2316587oif.48.2018.11.16.14.05.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 Nov 2018 14:05:57 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: [PATCH] macintosh: windfarm: Another convert to using %pOFn instead
 of device_node.name
Date: Fri, 16 Nov 2018 16:05:39 -0600
Message-Id: <20181116220540.17222-3-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116220540.17222-1-robh@kernel.org>
References: <20181116220540.17222-1-robh@kernel.org>
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
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Convert the open coded iterating thru child nodes to
for_each_child_of_node() while we're here.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/macintosh/windfarm_fcu_controls.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/windfarm_fcu_controls.c b/drivers/macintosh/windfarm_fcu_controls.c
index fab7a21e9577..2b3ca628a650 100644
--- a/drivers/macintosh/windfarm_fcu_controls.c
+++ b/drivers/macintosh/windfarm_fcu_controls.c
@@ -425,18 +425,18 @@ static void wf_fcu_lookup_fans(struct wf_fcu_priv *pv)
 		{ "CPU B 2",		"cpu-fan-b-1",		},
 		{ "CPU B 3",		"cpu-fan-c-1",		},
 	};
-	struct device_node *np = NULL, *fcu = pv->i2c->dev.of_node;
+	struct device_node *np, *fcu = pv->i2c->dev.of_node;
 	int i;
 
 	DBG("Looking up FCU controls in device-tree...\n");
 
-	while ((np = of_get_next_child(fcu, np)) != NULL) {
+	for_each_child_of_node(fcu, np) {
 		int id, type = -1;
 		const char *loc;
 		const char *name;
 		const u32 *reg;
 
-		DBG(" control: %s, type: %s\n", np->name, np->type);
+		DBG(" control: %pOFn, type: %s\n", np, of_node_get_device_type(np));
 
 		/* Detect control type */
 		if (!strcmp(np->type, "fan-rpm-control") ||
-- 
2.19.1

