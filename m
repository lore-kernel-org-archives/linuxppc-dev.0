Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2FBC0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 16:03:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9561220827
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 16:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RF1RoKj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9561220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pcsy5zq4zF22Z
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 03:03:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RF1RoKj9";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="RF1RoKj9"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pc40637xzF14S
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 02:27:12 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id r9-v6so4377664pgv.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 07:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gXevU2yLJlZLfcV58lfxfJxApOOyRedeEm2yYSVFiMw=;
 b=RF1RoKj9b56ji/qE+jG0GKgkmnP7aOu7eVCDxnQ0rLdSFWIaWvnGAY8USxdBEU1pnc
 BkuE9qRekDrGO/mHsnr6F9N2Zo4EGVqyDBBe/cusQy0NNgxJzRy00M9D9bFIxGNe5aDm
 J3AOYsrdcW91VY8D9FJ3bPydS6lVjuuyKWccrU4IBW0BQfOYAt8TcX52kqauKx8MDLyf
 B24wiPHCMcQuTKjXAiwZ3NEld0QO9c3HnJ9bydglZne3pY8T7pXKbdhBSinCqRmgtMM9
 LGnbm0GAxGdNfrkmpPbNuiDBCq51Zo8l+HKoM2VwKTkIB/n1FRM8RXtFwLcPoOZb5GxI
 nzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gXevU2yLJlZLfcV58lfxfJxApOOyRedeEm2yYSVFiMw=;
 b=VCImTASHyjM2fkgq5qJ+E/8NjywhwkBVlU1SWDMusMIPdG7WsJSgHiBkmcFn8T6qtq
 PO+Hrnryb1qDHJh8fvtuiVgTWgmbA2kUcait34pHm4f2mNa1mNtFdNAdj0vPZBtpxRHN
 V+y7iyvr6SlHNhHaQtJfqwJclRFm99mPR8ToCH3c6SvnutC/2wpcaKnXTc5/mlTqzj+m
 /s9qZyna1yjo3NzWiuNEesgboUJdsfwuOnyqwWyMidXNzgEMeqYGiaE2hFAmwezJZlFw
 H8UUQfLZqraTSjwqO7y+AgMBEtHnGVZ+TFXz/YiS4qZsXeaerFzRMGzEeTHHrHDgLrDy
 b1pA==
X-Gm-Message-State: AGRZ1gIYHrbNAFs54vYcEM/e0faiXXZNJ3UjP9B3T12Ti/qIGi2DUweH
 3Yf16nz6UbvzmIZuh8MQ9zo=
X-Google-Smtp-Source: AJdET5eSZaBPAahA5SnMhMZpjrw1UXLfaCpcvEZlSpPiO0D+S/eTKf/7Y2/Rbq/90PSkrl6vx69otg==
X-Received: by 2002:a63:5b1f:: with SMTP id p31mr20519904pgb.56.1541431631103; 
 Mon, 05 Nov 2018 07:27:11 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u76-v6sm37260578pfa.176.2018.11.05.07.27.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 05 Nov 2018 07:27:10 -0800 (PST)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v6 14/18] of: unittest: remove unused
 of_unittest_apply_overlay() argument
Date: Mon,  5 Nov 2018 07:25:11 -0800
Message-Id: <1541431515-25197-15-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
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

