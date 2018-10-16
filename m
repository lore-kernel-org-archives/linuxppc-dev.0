Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C257CC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 03:18:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D6B2083E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 03:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbnB9x9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D6B2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Z0r016mszDqSL
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 14:18:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sbnB9x9b";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="sbnB9x9b"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YzzQ2bj1zF3WG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 13:39:30 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id f26-v6so10641360pfn.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 19:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PMEoU3Gz26JMyroIsJaDweM2uFKnZxU+TruAPOzAvDQ=;
 b=sbnB9x9bvtv7VDSSAMjGXcvQrF/l5xTHVstk6hAqmIcw9mpARCvX+OSlzY+cTE4Mma
 KMS4zR9x4FmFVDJbdrcV0X/GNMauQwLPdWKTne2JC5vP7p90HgWviUHwTT1y0BR1alBK
 VZpkPZmiV/8TnDwQnAO6RGFeBtaMPw7dy9kdXbl7p53JOUCFYuu6PSINQKYFi5vgNar5
 LpXEQC+MMbhR5Zo6Hb6Gqao0AwgKg9DiysMQDx6VzLtLrkgijOaat+k7kmMI/rQu60vY
 msULaOcHlWZh3Hlzr/bop9t/+HfHVn3nizZioIcXc94bw6K9n/vgaB9TrjdlP+AIu4gf
 1hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PMEoU3Gz26JMyroIsJaDweM2uFKnZxU+TruAPOzAvDQ=;
 b=kYMvw+rjnainuSSpQRVJSNwItRnA50QdVxMUpVa8Tp+5lf876eqoOAVOnGp2ZzngTw
 iMHpy8j2XTFxnDOR2nCT3TumJKBJ6hhnjbiOBJLBbDCLEsW2VSC5Wra9o/b5QH0v2wFj
 A7KwT9yuiSWb+SjwLam1hdmHx3toRJzKDfz623bFYoKd5ixdqA2vKdtEzsuo7EduzqJY
 t6bYjzx4p/zVx3qvUUyPEyjNbEqxEOcJD/7CHCo6cB3dUYd2y2xWRW31p4Ft0OJNhjE7
 Hv8WjST6fQ9TZbB0nFh3+AraCGMun9s6OyT0BvPdAdTwSYWWcT3ubJ/YR1R1nYDA2rb9
 7/vQ==
X-Gm-Message-State: ABuFfojXmZj9VAUAlJ35ZNfoR2oEuadl5tO6n7onulUw8Zrns574AkNH
 o1TrN15Y8NqTL5Hgvq+owSU=
X-Google-Smtp-Source: ACcGV60FD4fY0+Jn0o7r8yLIuM412dd62zBkLv/B/k5hkURgwi0u29Z2lyncfamSUpkqJziuE7nGZw==
X-Received: by 2002:a62:ff09:: with SMTP id
 b9-v6mr20045355pfn.46.1539657568819; 
 Mon, 15 Oct 2018 19:39:28 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 15 Oct 2018 19:39:28 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v4 14/18] of: unittest: remove unused
 of_unittest_apply_overlay() argument
Date: Mon, 15 Oct 2018 19:37:34 -0700
Message-Id: <1539657458-24401-15-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
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

