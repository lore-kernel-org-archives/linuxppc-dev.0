Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804BAC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:00:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0488E20850
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0488E20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4398k10m0DzDr0m
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 07:00:57 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4398Vb2RFYzDqSv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 06:51:03 +1100 (AEDT)
Received: by mail-oi1-f195.google.com with SMTP id x23so18635341oix.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 11:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SJ9ws45Vv3vAPydB9eOaRCa8LnZGc1t7yjxAlBirVB0=;
 b=BcjG3WKMf4WFYsPt1lFek2iVnjmJ89r5xWCoANiaZH5hbM84w1cWEr549lteSgVmSw
 R3gAoors8f8Hdf4EiCxP+3lonGkaPJHz5vt34fc2h4Fei8x3bIfMgjIXcdP1Q+DA0Rhc
 dVuiV9F3+De8TGi9M7j6tLm2jM3KOlHkLf4pRnWvfNKNYZc7Rr8Q+qYdylkBnSPF0+w2
 MDcsaPPLGBKTApdalur3XLM5ymgTGTm0dUg+6QBfbe790OnElh0BhBv91i0gVFWOk62E
 Ui7HXG9T1bLZdv5p4UYh1yhC6xuHovRiuIsDc6Rs+RUQaDzYLPFt7Xa0gzqZjZpUae1F
 jgog==
X-Gm-Message-State: AA+aEWbnkUyBCSu46eSbUhA0Jq5fSeJlhvivhGjje5+Pmvy+xstbO/zW
 l8N+pAwdNzDN5ToCDSTvYw==
X-Google-Smtp-Source: AFSGD/X7aKQeZVng8JR2Bng8ewJcNCzuYa1uBshwFTyi0QJEfHBCA2uykUhLxJDIWg2UCxw4bvZniA==
X-Received: by 2002:aca:da02:: with SMTP id r2mr15033923oig.66.1544039461139; 
 Wed, 05 Dec 2018 11:51:01 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 11:51:00 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ide: Use of_node_name_eq for node name comparisons
Date: Wed,  5 Dec 2018 13:50:25 -0600
Message-Id: <20181205195050.4759-9-robh@kernel.org>
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
Cc: linux-ide@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-ide@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/ide/pmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index c5b902b86b44..ec46aa84d18d 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -1045,7 +1045,7 @@ static int pmac_ide_setup_device(pmac_ide_hwif_t *pmif, struct ide_hw *hw)
 		d.port_ops = &pmac_ide_ata4_port_ops;
 		d.udma_mask = ATA_UDMA5;
 	} else if (of_device_is_compatible(np, "keylargo-ata")) {
-		if (strcmp(np->name, "ata-4") == 0) {
+		if (of_node_name_eq(np, "ata-4")) {
 			pmif->kind = controller_kl_ata4;
 			d.port_ops = &pmac_ide_ata4_port_ops;
 			d.udma_mask = ATA_UDMA4;
-- 
2.19.1

