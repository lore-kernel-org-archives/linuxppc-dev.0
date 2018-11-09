Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0945C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 06:40:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 293E020825
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 06:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAujfMeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293E020825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rrBd3ZZwzF3Mw
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 17:40:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YAujfMeZ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YAujfMeZ"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rqSx4wNSzF3XC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 17:08:01 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id z17-v6so411948pgv.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 22:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gXevU2yLJlZLfcV58lfxfJxApOOyRedeEm2yYSVFiMw=;
 b=YAujfMeZBDiK49TuXnYnJAuAm5X27MPYHr3ARKEs1fpH917SxQKYSSoisf5iE/U0p2
 fJLRq7zzdG+NL3ZQaU/7YjIh1SrZQBGHqmho6L+0Mt+kSnBDF2CL/A2LDmlpWw0Ws041
 6TM+m9nRPaRKsxNMhns8uZ52aClxptk07YymUubrXs4VIAf23bEKBCzTz5J5pESSbLKv
 u3XfR4z2iUK5OrouBrCKoxRaABVJuhNypekipVQSw5mOjRKoviAeM0C5hu4eYbFKaXy4
 9uwunJU1xpUQ8to3i+O3YqQ1pKSOPZtPPovBNkX28s+67/uDzxtB04kKUAD958erTgPn
 HcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gXevU2yLJlZLfcV58lfxfJxApOOyRedeEm2yYSVFiMw=;
 b=NizPyohu6usQDoIct/M0528Gu7Tv0Anyh+5pcgoSUS8Z+BoUw3J7xAgFwhIkzTJvEF
 EPgtbvqyVPC8Wm3RIDIPabw1loVo3cyewlRSAzJWH2RNgsYH1onRvvgf6PmHMLAa9Q5y
 +XxF27/AH+ZpYL1JsfuiofSk19bF0CuuqLnZC9PnzrNcUm2wur8i64UD5Z8+QIs6+XzU
 77obxfCkbshLCc7Qit6pdGMRk0Sgko2jE7HudovuIYrnc23QIoxV6D5WuY7erZEXSp5P
 nD8/kdEdFKYkdy1jVkyZPYS2TLhPzKIMfoBB3FALfnxgCi8Iy2Y6WLC7l9cyafSCcQs1
 hNCQ==
X-Gm-Message-State: AGRZ1gJz2UlhzUyINDVL2t/19kbtv5mKdmL7MLcrGKGOHD0thlFMGBYu
 tl80efDHwwgWx7IO/yddOllK5Bss
X-Google-Smtp-Source: AJdET5cQNyBJ72uuudRNukYEWYSEF50nnZicsd3BCZ0erdA9BtBT8GR3tycpeBXO8o5uzXkrISg47Q==
X-Received: by 2002:a62:b615:: with SMTP id
 j21-v6mr7756923pff.199.1541743680158; 
 Thu, 08 Nov 2018 22:08:00 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id c70-v6sm6620722pfg.97.2018.11.08.22.07.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 08 Nov 2018 22:07:59 -0800 (PST)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v7 13/17] of: unittest: remove unused
 of_unittest_apply_overlay() argument
Date: Thu,  8 Nov 2018 22:06:01 -0800
Message-Id: <1541743565-23163-14-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
References: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
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
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Frank Rowand <frank.rowand@sony.com>

Argument unittest_nr is not used in of_unittest_apply_overlay(),
remove it.

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index f0139d1e8b63..14838b21ec6a 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1433,8 +1433,7 @@ static void of_unittest_destroy_tracked_overlays(void)
 	} while (defers > 0);
 }
 
-static int __init of_unittest_apply_overlay(int overlay_nr, int unittest_nr,
-		int *overlay_id)
+static int __init of_unittest_apply_overlay(int overlay_nr, int *overlay_id)
 {
 	const char *overlay_name;
 
@@ -1467,7 +1466,7 @@ static int __init of_unittest_apply_overlay_check(int overlay_nr,
 	}
 
 	ovcs_id = 0;
-	ret = of_unittest_apply_overlay(overlay_nr, unittest_nr, &ovcs_id);
+	ret = of_unittest_apply_overlay(overlay_nr, &ovcs_id);
 	if (ret != 0) {
 		/* of_unittest_apply_overlay already called unittest() */
 		return ret;
@@ -1503,7 +1502,7 @@ static int __init of_unittest_apply_revert_overlay_check(int overlay_nr,
 
 	/* apply the overlay */
 	ovcs_id = 0;
-	ret = of_unittest_apply_overlay(overlay_nr, unittest_nr, &ovcs_id);
+	ret = of_unittest_apply_overlay(overlay_nr, &ovcs_id);
 	if (ret != 0) {
 		/* of_unittest_apply_overlay already called unittest() */
 		return ret;
-- 
Frank Rowand <frank.rowand@sony.com>

