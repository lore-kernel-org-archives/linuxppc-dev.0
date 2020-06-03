Return-Path: <SRS0=sLSx=7Q=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E31C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 21:30:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB464206E6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 21:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB464206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=longchamp.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49chrv5RvkzDqhK
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 07:30:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.221.65; helo=mail-wr1-f65.google.com;
 envelope-from=valentin.longchamp@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=longchamp.me
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49chq14jkqzDqc3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2020 07:28:29 +1000 (AEST)
Received: by mail-wr1-f65.google.com with SMTP id l10so3881409wrr.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2020 14:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yqk0FVZ/D5PwLrGDFJgkdVnK/uadJaMYeZjNAeD1XNo=;
 b=LQdDkgg4DDPrHJpOcpfDgv0v4qrxjc3IS3uVt0bYjmNttd7x9R2Z8hK6ziM4t8sPYU
 xuyw7Gf353o9k/gFvZSoNktM9aSECj3uUu78Tq52CCT4gZpleP9ytLaVXrV2IWJzSsd8
 E/qg4Op8RAeP1tm4DtuIwPzEDDfPPEgsxvGtf3P8FAWAI9JGKu5CMdy9Ck5/Bz+s2a0q
 Ta+9EIW5VF/ppYjiJCLmRWhWlRnoU4lJOUwA/eLzW+WZImJUyNLPBbDeYkcyrVE11CY2
 45CTKLMUJ91EujmeP51rfIYyXTXedumBZqY7erMHU9K42+ArTVrzIDib3ZsyLCHFGCjY
 jKFA==
X-Gm-Message-State: AOAM531CAXT4qHRTaix0cty95khGtOpJxTVAxDqiJmVMAE8evd4bX7Kz
 YlAHvYYkw++81Ag1lgC9WTY=
X-Google-Smtp-Source: ABdhPJwVyVWtHeupxCIKvT11fO03o9CCm5TElNLYwioF9aqGQeDDtJoTfowJt0QAmVHmFalhOy4eaw==
X-Received: by 2002:a5d:4b47:: with SMTP id w7mr1209655wrs.234.1591219705444; 
 Wed, 03 Jun 2020 14:28:25 -0700 (PDT)
Received: from zenbook-val.localdomain (bbcs-65-74.pub.wingo.ch. [144.2.65.74])
 by smtp.gmail.com with ESMTPSA id z9sm4364583wmi.41.2020.06.03.14.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 14:28:24 -0700 (PDT)
From: Valentin Longchamp <valentin@longchamp.me>
To: netdev@vger.kernel.org
Subject: [PATCH] net: ethernet: freescale: remove unneeded include for ucc_geth
Date: Wed,  3 Jun 2020 23:28:23 +0200
Message-Id: <20200603212823.12501-1-valentin@longchamp.me>
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
Cc: kuba@kernel.org, Valentin Longchamp <valentin@longchamp.me>,
 linuxppc-dev@lists.ozlabs.org, leoyang.li@nxp.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

net/sch_generic.h does not need to be included, remove it.

Signed-off-by: Valentin Longchamp <valentin@longchamp.me>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 552e7554a9f8..db791f60b884 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -42,7 +42,6 @@
 #include <soc/fsl/qe/ucc.h>
 #include <soc/fsl/qe/ucc_fast.h>
 #include <asm/machdep.h>
-#include <net/sch_generic.h>
 
 #include "ucc_geth.h"
 
-- 
2.25.1

