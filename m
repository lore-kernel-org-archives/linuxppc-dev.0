Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE9CC67863
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 23:25:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5488820866
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 23:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feiwn75i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5488820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42blWn2fwNzF3CH
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 10:25:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="feiwn75i";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="feiwn75i"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bkjL5V4PzF3G8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 09:48:22 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id e67-v6so5979106plb.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 15:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PMEoU3Gz26JMyroIsJaDweM2uFKnZxU+TruAPOzAvDQ=;
 b=feiwn75iOpLnPIxs4gwngqeqa/j467bmhlB2Z3uiZc+9axbLGlQhWWo1/6fZWU8ICv
 12+8OEffuHNDqGZLDFi7OgTPxddu/jLyY4SF4vrQMxBEnZQAQKPzLgqacySUHlfQIIRE
 LE6mtjBy3MrJEjCchhPX4zITZi0tJGSvTtJ4XgQqFyVQIHUzcNV05faKh2SrXGbe+Rpz
 nZIY7xucyuDVkLbGW2z0ZNIQNLG/hF1qPbFPdA3u0YtSel3Bga+33KT+3n88rgOaEKNi
 wreGa02i6qGfuXn6ceV25RTr9FflMrpZnbgj9im5D4rzA5HzIZWCu/sY48qbzeLuIhyD
 EEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PMEoU3Gz26JMyroIsJaDweM2uFKnZxU+TruAPOzAvDQ=;
 b=PnYaXb2fCfu2CA1LSuESoXHYqFOi/T3EPSj1FmSLq7F8HhuH0djDI4TvOOgDgnE2x8
 7e+sE1EmfOMJ+26DTMugoGhGrNGpZ0OCza5JPXLigFjrNnbJQtR79c6ah4C/uO4LaPdm
 EsYGOA+8CJBLaskTbZznMk21jcoOfitC9EK8xPUCHOiXSCUkBCc5gwWVSJUlxgrWwTkf
 +WrIraEiW+xMViZf/83hrn615Q05e11YEr+hl8C3cM2rPFTPXYkbsSbUt18C+8+Zl4J4
 ONSZc6yIv3OUesQtiE1wbvVth2MsKDBRY0eUnBAkpbstAZranMQlAu7PfxG2HsM4H+Mu
 Z0Zg==
X-Gm-Message-State: ABuFfoiAbJtpll8BMmy/LRCS72wF5M4wf2PNksnyR/1wRMLLiFENL5r8
 c4wuATfmO41sjkjyketQbWPyJOv6
X-Google-Smtp-Source: ACcGV62Y4tBdznBiKteTNtZjqmdZPyj36bkUeDWr8tFt7RnWlFCWjtWwgfBdAQeny6esRrZYO/SyWQ==
X-Received: by 2002:a17:902:5993:: with SMTP id
 p19-v6mr31533651pli.260.1539902901231; 
 Thu, 18 Oct 2018 15:48:21 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id v81-v6sm38129268pfj.25.2018.10.18.15.48.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 18 Oct 2018 15:48:20 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v5 14/18] of: unittest: remove unused
 of_unittest_apply_overlay() argument
Date: Thu, 18 Oct 2018 15:46:32 -0700
Message-Id: <1539902796-8382-15-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
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

