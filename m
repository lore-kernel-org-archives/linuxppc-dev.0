Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7039FC64EB1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 15:28:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1BC20878
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 15:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULqRfeme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1BC20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439fcZ4sNDzDrDJ
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 02:27:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ULqRfeme";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ULqRfeme"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439fNg6V8ZzDrFS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 02:17:39 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id w6so285391pgl.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 07:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5x3nG9Lyyiui4XLI2PxBjk8qDJKvAVzC8LAqq0+ohpk=;
 b=ULqRfemezDUP3JKJv/3Smbqdes0+V2IjKYiER1WaR2EFDSE+uNzhuwkPJ2k2Je9iyr
 +u1lGUVJJoxV377UCpQiF2NTTPzYoFsEhezHSGOEAmfnS3pwHZJ9GXe8uPuD+uUccyxt
 MqLnFBxHUtKSRs38CV3v1eaxdXAx8nGDVN1EuPZCtMhOTmLx98+hQ/dtm0s+sDtmgdj+
 H53RWnlcawS4zVRCFHwC62yJsbgjlwceIrX2NPeqne5cy52FJULUDRVmu+cC6gxmoIcQ
 OT1IHbo4bsZh7hQ1y2BqkTeEDjtCgBZu4r/QuMUJal1GD2aYQm5zPp/maz2OQgEkXmWU
 tbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5x3nG9Lyyiui4XLI2PxBjk8qDJKvAVzC8LAqq0+ohpk=;
 b=iiBZY/yJOxbl0k3FPshMs4z4vZp3s3zUGrpx0d2MgG1tcKZvPzfiJSuMFjuM4dNYW6
 UnHr5SvmuTgu84hM+VoWNxFnSRWce4SPm8Sxr6K1/jDiwfDtcoDLyrjt6gkiCI6xkFYv
 W2RxiNxizNVcQYOjea0w7sgW7N0LFC/oy8LOSfE/GatkafBTt0A1dZ0wDWh+nwQj8RVo
 oRxMqxdkR4Ly6lqdblj26kcCSFCDwCTR1WUVLjk9xKAQBPtbQQo3Ai8m4D0O1bkIIvYe
 s0OJhwISlGO+zTod1DdvsdOD+yr+T1Jm0Ro9LR2w9nA/JSypSl0RciavO+5ecc+h2grK
 s4hw==
X-Gm-Message-State: AA+aEWYsComCsJ8uqNWSHa/fTT4pmq5UxVw92dAvd/pn1p+XKZx+2eeC
 skWfl8QJj/nKvi7K+NEwuh8FP8uN
X-Google-Smtp-Source: AFSGD/WFOK03scXVlggiGhcVqio4FuLaiVqcmS2JvLAnzA3xZLoxURjnV/CiJQzv7JuuY2pjvSAexA==
X-Received: by 2002:a63:1a0c:: with SMTP id a12mr23962984pga.157.1544109457737; 
 Thu, 06 Dec 2018 07:17:37 -0800 (PST)
Received: from 192-168-1-15.tpgi.com.au (60-240-78-224.static.tpgi.com.au.
 [60.240.78.224])
 by smtp.gmail.com with ESMTPSA id v12sm821546pgg.41.2018.12.06.07.17.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 07:17:36 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/7] powerpc/papr_scm: Update DT properties
Date: Fri,  7 Dec 2018 02:17:10 +1100
Message-Id: <20181206151714.28494-4-oohall@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181206151714.28494-1-oohall@gmail.com>
References: <20181206151714.28494-1-oohall@gmail.com>
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The ibm,unit-sizes property was originally specified as an array of two
u32s corresponding to the memory block size, and the number of blocks
available in that region. A fairly last-minute change to the SCM DT
specification was splitting that into two seperate u64 properties:
ibm,block-sizes and ibm,number-of-blocks that convey the same
information. No firmware / hypervisor that emitted the ibm,unit-size
property ever appeared in the wild.

Fixes: b5beae5e224f ("powerpc/pseries: Add driver for PAPR SCM regions")
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 390badd33547..ed1082cc1d27 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -257,8 +257,9 @@ err:	nvdimm_bus_unregister(p->bus);
 
 static int papr_scm_probe(struct platform_device *pdev)
 {
-	uint32_t drc_index, metadata_size, unit_cap[2];
 	struct device_node *dn = pdev->dev.of_node;
+	uint32_t drc_index, metadata_size;
+	uint64_t blocks, block_size;
 	struct papr_scm_priv *p;
 	int rc;
 
@@ -268,8 +269,13 @@ static int papr_scm_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	if (of_property_read_u32_array(dn, "ibm,unit-capacity", unit_cap, 2)) {
-		dev_err(&pdev->dev, "%pOF: missing unit-capacity!\n", dn);
+	if (of_property_read_u64(dn, "ibm,block-size", &block_size)) {
+		dev_err(&pdev->dev, "%pOF: missing block-size!\n", dn);
+		return -ENODEV;
+	}
+
+	if (of_property_read_u64(dn, "ibm,number-of-blocks", &blocks)) {
+		dev_err(&pdev->dev, "%pOF: missing number-of-blocks!\n", dn);
 		return -ENODEV;
 	}
 
@@ -282,8 +288,8 @@ static int papr_scm_probe(struct platform_device *pdev)
 
 	p->dn = dn;
 	p->drc_index = drc_index;
-	p->block_size = unit_cap[0];
-	p->blocks     = unit_cap[1];
+	p->block_size = block_size;
+	p->blocks = blocks;
 
 	/* might be zero */
 	p->metadata_size = metadata_size;
-- 
2.17.2

