Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED40C64EB1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 15:35:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A10214C1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 15:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3gB+E2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A10214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439fnL6bQHzDr7Q
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 02:35:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U3gB+E2V";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="U3gB+E2V"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439fNp3bgwzDrM1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 02:17:46 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id c123so336855pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 07:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=eRW05LGiNMmDBbefAU+cS9epyHB3Rz9ajjQDrSQKvHk=;
 b=U3gB+E2VoBsumQdrW+lnR36/gk6dmj8waBDDRYJ0KoqpURPIuC2lxi9sSSXAYlNP5Z
 KdbEr4oImkuc6BaaqENuB0H/3rvSowfyAibpbiykDo7A32FiWCTkvq8vV724lkn+AZrY
 mBZEGoCqNn4RB0P6sBcJUCrejLzTwgIUKtjThM7YiBHwABqYUaJUmdN1WjpFEU/Svjdd
 50SxCXrk2Y06Z1W6N5AWy+zIzh5WaBI1ElyV6c6ndA0+1MAEFAtRn9u3rKHLR9RJb1Lr
 F9t783/vKz1PxJWouzDqqlrXE3vLsKO3F2PrgXnUV+a18Vw9v8GOQrUOTciNeXu4INjp
 9syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=eRW05LGiNMmDBbefAU+cS9epyHB3Rz9ajjQDrSQKvHk=;
 b=OKJQisBdcySLmVsehFN12BF+2qXQd4O0aFYkEQd2pMGuAmi/5KFApo9riuNy7fqyQz
 6K6ROK9RyrvWIPr/Ij+No0/eO1QHS9e73JHBSZvL1HU/bnfXKn1+Lf7klc8COfJLZyBa
 LETVy2736F3CT6ZeSNUy9HF51uffwopLGrQ29+5EBrEA6Sa4VebVxGAxXARoTuzrXg5R
 dhLSys+dg8BaZA9ml3l2mINaxLkUVVqGTGcPQsWA5M34oXCKE9ILRwQj6PNk0pETGoIU
 Cnk/4X3y0Z51i/Dw71c+KexnSUennLzUiJIJ9UAhHdCWYI/HYZ5QQVc5M/MWt9dgwZD5
 ctTA==
X-Gm-Message-State: AA+aEWan15csiqHYUjT1k8yyheYZYeclqtYUrdBiONJ6uYY8qAlMDpI6
 TW/I1f/5Ry6hX5Ie8wBpMEGS2vbG
X-Google-Smtp-Source: AFSGD/UATuhB6eExBfAFgZZMHuWWsgXq1JvcOVT6LLyTeRWG64NQIk7Tb4ziifm7OWKpM+GEoRYUdA==
X-Received: by 2002:a63:4b60:: with SMTP id k32mr24207127pgl.186.1544109464230; 
 Thu, 06 Dec 2018 07:17:44 -0800 (PST)
Received: from 192-168-1-15.tpgi.com.au (60-240-78-224.static.tpgi.com.au.
 [60.240.78.224])
 by smtp.gmail.com with ESMTPSA id v12sm821546pgg.41.2018.12.06.07.17.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 07:17:43 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 6/7] powerpc/papr_scm: Use ibm,unit-guid as the iset cookie
Date: Fri,  7 Dec 2018 02:17:13 +1100
Message-Id: <20181206151714.28494-7-oohall@gmail.com>
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

The interleave set cookie is used to determine if a label stored in the
metadata space should be applied to the current region. This is
important in the case of NVDIMMs since the firmware may change the
interleaving configuration of a DIMM which would invalidate the existing
labels. In our case the hypervisor hides those details from us so we
don't really care, but libnvdimm still requires the interleave set
cookie to be non-zero.

For our purposes we just need the set cookie to be unique and fixed for
a given PAPR SCM region and using the unit-guid (really a UUID) is fine
for this purpose.

Fixes: b5beae5e224f ("powerpc/pseries: Add driver for PAPR SCM regions")
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 871b386dd4b2..92f76c656f85 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -264,6 +264,8 @@ static int papr_scm_probe(struct platform_device *pdev)
 	uint32_t drc_index, metadata_size;
 	uint64_t blocks, block_size;
 	struct papr_scm_priv *p;
+	const char *uuid_str;
+	uint64_t uuid[2];
 	int rc;
 
 	/* check we have all the required DT properties */
@@ -282,6 +284,11 @@ static int papr_scm_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (of_property_read_string(dn, "ibm,unit-guid", &uuid_str)) {
+		dev_err(&pdev->dev, "%pOF: missing unit-guid!\n", dn);
+		return -ENODEV;
+	}
+
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
@@ -294,6 +301,11 @@ static int papr_scm_probe(struct platform_device *pdev)
 	p->block_size = block_size;
 	p->blocks = blocks;
 
+	/* We just need to ensure that set cookies are unique across */
+	uuid_parse(uuid_str, (uuid_t *) uuid);
+	p->nd_set.cookie1 = uuid[0];
+	p->nd_set.cookie2 = uuid[1];
+
 	/* might be zero */
 	p->metadata_size = metadata_size;
 	p->pdev = pdev;
-- 
2.17.2

