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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACD6C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 06:31:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8184D20840
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 06:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyGengfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8184D20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rr0L3BKCzF3Lv
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 17:31:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GyGengfF";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="GyGengfF"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rqSr71MMzF3X7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 17:07:56 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id q19-v6so446809pll.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 22:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=K0G5ldEhUnAa9Adg3Ykauulu7tP5kKPiQXQBmq8Ci54=;
 b=GyGengfF4r+F6asZqVV0RIuWosYb+PTwn1Hnll60FKXM+xgX/fw+Y7+6VrSxr/acgC
 VW5FTQabdQWKfyB9CCMRGBUIY3qqPKevLNOnb8P4tizXqIpa+9twrfNBn34EguvcaXh7
 bxKlkFuVz4ScfCEnIPi/HuRdTxCQnC24Ug18nH3+RYfkkFG6EXji8An1DKa9Rd8uFOSV
 50dzbu46DNmCpdUstn7iDYBLpMXChGE3UNOO4MSc0SZKAbkGXNT9tmVwWTm/0QirIfUj
 xncZha37TRV/iQ71SW1IPLg07gWec8+aPkrn4jxrzx50KjkqMOaoMtJD5UFR4CYj8rmh
 XETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=K0G5ldEhUnAa9Adg3Ykauulu7tP5kKPiQXQBmq8Ci54=;
 b=IGlbOuJy3u1qT1CLnoBj6/9GuwELckCmpqIs7Sc+sHGdGbCNwyCl99tR1S82oQuBSf
 LL8wU7dmCQ9nNeHsJmzqGIe0cPH/BU4KMjhKH3oT5x9zirOUh1Ik8ks97nr/ZnVyUH8O
 Rj1ztUIJGEctV86hI5CZ1dSVBgJvTVDOYCnatH/h961IPBiTw7WHB3TRXLjkSROl7GP8
 Nzrko01i59e7/19nxu0/EnZuYWLuubw7ralkFVuWPb9bjVgMTy1HC4aQWVga77Gv/bQn
 FD6xWCzwMOTNHG+jiRb2Tp3xhi084kcPiEUdN1UOLJcm9sLIz/dRxRp/JuR0gz1nk13x
 8ywQ==
X-Gm-Message-State: AGRZ1gKyIlHnxRCeqjbrzMQh2K5NbkUj1AcL8SJ7JE+7ENwbKzccRPoP
 b0wG9sPTpiN0anuJv8PhaO8=
X-Google-Smtp-Source: AJdET5dg1gI1x4SrVHakNV8rO3gyOag14IpapzARfQW9eP+9EZi1alq2Hq8c2aMO3UeXBQF3phBAaw==
X-Received: by 2002:a17:902:544:: with SMTP id
 62-v6mr7263115plf.73.1541743675427; 
 Thu, 08 Nov 2018 22:07:55 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id c70-v6sm6620722pfg.97.2018.11.08.22.07.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 08 Nov 2018 22:07:54 -0800 (PST)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v7 09/17] of: overlay: make all pr_debug() and pr_err()
 messages unique
Date: Thu,  8 Nov 2018 22:05:57 -0800
Message-Id: <1541743565-23163-10-git-send-email-frowand.list@gmail.com>
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

Make overlay.c debug and error messages unique so that they can be
unambiguously found by grep.

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 72bf00adb9c8..c8f88b0836a3 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -507,7 +507,7 @@ static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
 	for_each_property_of_node(overlay_symbols_node, prop) {
 		ret = add_changeset_property(ovcs, target, prop, 1);
 		if (ret) {
-			pr_debug("Failed to apply prop @%pOF/%s, err=%d\n",
+			pr_debug("Failed to apply symbols prop @%pOF/%s, err=%d\n",
 				 target->np, prop->name, ret);
 			return ret;
 		}
@@ -551,7 +551,8 @@ static int build_changeset(struct overlay_changeset *ovcs)
 		ret = build_changeset_next_level(ovcs, &target,
 						 fragment->overlay);
 		if (ret) {
-			pr_debug("apply failed '%pOF'\n", fragment->target);
+			pr_debug("fragment apply failed '%pOF'\n",
+				 fragment->target);
 			return ret;
 		}
 	}
@@ -564,7 +565,8 @@ static int build_changeset(struct overlay_changeset *ovcs)
 		ret = build_changeset_symbols_node(ovcs, &target,
 						   fragment->overlay);
 		if (ret) {
-			pr_debug("apply failed '%pOF'\n", fragment->target);
+			pr_debug("symbols fragment apply failed '%pOF'\n",
+				 fragment->target);
 			return ret;
 		}
 	}
@@ -873,7 +875,7 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 
 	ret = __of_changeset_apply_notify(&ovcs->cset);
 	if (ret)
-		pr_err("overlay changeset entry notify error %d\n", ret);
+		pr_err("overlay apply changeset entry notify error %d\n", ret);
 	/* notify failure is not fatal, continue */
 
 	list_add_tail(&ovcs->ovcs_list, &ovcs_list);
@@ -1132,7 +1134,7 @@ int of_overlay_remove(int *ovcs_id)
 
 	ret = __of_changeset_revert_notify(&ovcs->cset);
 	if (ret)
-		pr_err("overlay changeset entry notify error %d\n", ret);
+		pr_err("overlay remove changeset entry notify error %d\n", ret);
 	/* notify failure is not fatal, continue */
 
 	*ovcs_id = 0;
-- 
Frank Rowand <frank.rowand@sony.com>

