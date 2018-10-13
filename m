Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF1BC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 05:30:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC9520877
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 05:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laCzalge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC9520877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XCvg5h83zDqCH
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 16:30:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="laCzalge";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="laCzalge"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XC7b5MRvzF3Tq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 15:55:23 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id f8-v6so6836304plb.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 21:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PMEoU3Gz26JMyroIsJaDweM2uFKnZxU+TruAPOzAvDQ=;
 b=laCzalgeYZJRzC6FMlo4fpiPie/6r4Hc6a54c2Uj5Hy4Tm/eJIIPeV8VYqS8RF6hra
 O6Sd6K448eGR9X3uAylMFx1KvM71hnf2ozfenx51hRbBkSAJ6Qci6OR0lVnD2LgXg+b+
 XyRzB+Zu2fsCRgO1McEDf2qQaMo946NU8/B3R6XxQkuzlm+5YptElzE0cowc83msF67f
 dHgEKVPRvqBhwepF8w3OLN65+hVj95YJgOghfwuvh7f6V5qGd8cj5RgkD8GCgomwVsD5
 B8HnEls8H+wOP44MonWpzw2cWxSk4YCeeyOrx9iCnZjtOsmkKPATNgrwwc72c7Kj8geJ
 btuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PMEoU3Gz26JMyroIsJaDweM2uFKnZxU+TruAPOzAvDQ=;
 b=o5/U5uft7Fwmc55zlz6psyyl/W5ZCWWY5RaTr9DlYxtncqCPQ/u0SqCOiRvp+xLgIz
 +IGdVWwTKd7ND4rtQ1hQKQOYAwtecyrOzfYLK/8KDBtrdG9O3LbMgEYoLBNaD0TmUpHy
 j5OF2vDEBCyeeAylSwZsvnS4OlYkZSGWTK+tb9AgQpDZeURedlsz6fS4x1nSWrMahnRM
 lSsm3Jm1/qxJk3sITiVpvoG6BL9H9iSmuzvGIk03WimG99na01XAGiKsUh2mm7N8e+ar
 WwLhdappdBwSvDx+aziFJFXoimTU6tOmVig3h4o5IMXm7PzUAW5GJTHD/ZHM2IAkVEJ6
 xJVQ==
X-Gm-Message-State: ABuFfojm/p4MOY1/0tIYrzogUEXbFjAvNAvQr2sokwEHDwL7oiyIWBtW
 NUxY59msq0eOWNc1DbTxVWU=
X-Google-Smtp-Source: ACcGV60a+yR4EpG1SMpmYOMGAUCaS10lPN9HlFu3ryMd+1zTThUgX1zRE5ZfZNkndCb0PyND3ZFxhg==
X-Received: by 2002:a17:902:6903:: with SMTP id
 j3-v6mr4683450plk.74.1539406522244; 
 Fri, 12 Oct 2018 21:55:22 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id h87-v6sm6959462pfj.78.2018.10.12.21.55.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 12 Oct 2018 21:55:21 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2 14/18] of: unittest: remove unused
 of_unittest_apply_overlay() argument
Date: Fri, 12 Oct 2018 21:53:34 -0700
Message-Id: <1539406418-18162-15-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
References: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
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

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index efd9c947f192..6d80f474c8f2 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1419,8 +1419,7 @@ static void of_unittest_destroy_tracked_overlays(void)
 	} while (defers > 0);
 }
 
-static int __init of_unittest_apply_overlay(int overlay_nr, int unittest_nr,
-		int *overlay_id)
+static int __init of_unittest_apply_overlay(int overlay_nr, int *overlay_id)
 {
 	const char *overlay_name;
 
@@ -1453,7 +1452,7 @@ static int __init of_unittest_apply_overlay_check(int overlay_nr,
 	}
 
 	ovcs_id = 0;
-	ret = of_unittest_apply_overlay(overlay_nr, unittest_nr, &ovcs_id);
+	ret = of_unittest_apply_overlay(overlay_nr, &ovcs_id);
 	if (ret != 0) {
 		/* of_unittest_apply_overlay already called unittest() */
 		return ret;
@@ -1489,7 +1488,7 @@ static int __init of_unittest_apply_revert_overlay_check(int overlay_nr,
 
 	/* apply the overlay */
 	ovcs_id = 0;
-	ret = of_unittest_apply_overlay(overlay_nr, unittest_nr, &ovcs_id);
+	ret = of_unittest_apply_overlay(overlay_nr, &ovcs_id);
 	if (ret != 0) {
 		/* of_unittest_apply_overlay already called unittest() */
 		return ret;
-- 
Frank Rowand <frank.rowand@sony.com>

