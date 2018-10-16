Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC4FC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 03:27:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D50220869
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 03:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP1QgmQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D50220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Z12m6yr7zDqdv
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 14:27:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DP1QgmQN";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="DP1QgmQN"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YzzW3919zF3W0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 13:39:35 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id f8-v6so10235696plb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 19:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Q0blMRhqNPiCrzvXWEp+FPb/ePWbrdIXRWW/hT0vdeE=;
 b=DP1QgmQNl4zcZHGFUSVn67XJmv+bzF7wA++eucggGjHLvC/xflvaZKZgBJrjNmg8iR
 +xt/u8sJKOk/cGSOajk5sjO05MmIxcEyynU7c9c9qsXzGNbakiCZb5EEiM05bT8suB74
 cCo5d2miRLJKziGOLn/gyQpQ1DlTaVXaWRwglQ5HYV/RHvlBdRJxVk2E2zUlDTxPKjgo
 Yguxx1RAYQjF+wDm208bmBTM8dfDFGkFe/BHZTzSey5m/4vBtAWehRif5XxWLWONG6En
 tclOpvl444eYVavzt4293e8Cy9VhOlKYxxbkOs4Q2WBGPT3nhLhEy8ONzKzlE1UHBkUk
 OEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Q0blMRhqNPiCrzvXWEp+FPb/ePWbrdIXRWW/hT0vdeE=;
 b=q9S7q02tS0VUvfGC1+yYiKcu0QYb45fv7/cce2tGoEre7IqJw+raLJuVyp9ybmYgpU
 HVih9OSG6PMLC5SyjpvgkvTu1LvU0rypRld2eknhrEJP+EfsgUPe1mUuhe6g2Fhs0F6P
 0j9ArwXNlnrzoECDgP8T8lvABllbElXM3ZXs1/c7Z9ePYS7OlKXIC/rRr7UG+cCgj3XI
 1Fs98FO5aKDvdtyo9FttaegBOimpAhiz/DDR3LgaP/rLdKZ4QGZZCcP0ZnBeuIYDkkFZ
 vy7CbWK+UZRaS4PSElG7SpwvT3FOAzQCeAxs0trcGfUfienSzxInovW46WSlXnDnrkhE
 L2JQ==
X-Gm-Message-State: ABuFfoiWh+S378UyQFtqqDJCSDHFMaMq8yqBoqZixbCS9xWlV2Jh/Uxn
 VsSH8ifmHYWHfYDxr3Q0510=
X-Google-Smtp-Source: ACcGV61n9QxQLxzubFxAmrh48bRRDs3KINsn6QIhT8tU9RN1M+EiqIeGdUNcfh81GZ4W+RKqziEqkw==
X-Received: by 2002:a17:902:369:: with SMTP id
 96-v6mr19392242pld.36.1539657573685; 
 Mon, 15 Oct 2018 19:39:33 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 15 Oct 2018 19:39:33 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v4 18/18] of: unittest: initialize args before calling
 of_*parse_*()
Date: Mon, 15 Oct 2018 19:37:38 -0700
Message-Id: <1539657458-24401-19-git-send-email-frowand.list@gmail.com>
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

Callers of of_irq_parse_one() blindly use the pointer args.np
without checking whether of_irq_parse_one() had an error and
thus did not set the value of args.np.  Initialize args to
zero so that using the format "%pOF" to show the value of
args.np will show "(null)" when of_irq_parse_one() has an
error.  This prevents the dereference of a random value.

Make the same fix for callers of of_parse_phandle_with_args()
and of_parse_phandle_with_args_map().

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 785985bdbfa6..5f4db23e4752 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -375,6 +375,7 @@ static void __init of_unittest_parse_phandle_with_args(void)
 	for (i = 0; i < 8; i++) {
 		bool passed = true;
 
+		memset(&args, 0, sizeof(args));
 		rc = of_parse_phandle_with_args(np, "phandle-list",
 						"#phandle-cells", i, &args);
 
@@ -428,6 +429,7 @@ static void __init of_unittest_parse_phandle_with_args(void)
 	}
 
 	/* Check for missing list property */
+	memset(&args, 0, sizeof(args));
 	rc = of_parse_phandle_with_args(np, "phandle-list-missing",
 					"#phandle-cells", 0, &args);
 	unittest(rc == -ENOENT, "expected:%i got:%i\n", -ENOENT, rc);
@@ -436,6 +438,7 @@ static void __init of_unittest_parse_phandle_with_args(void)
 	unittest(rc == -ENOENT, "expected:%i got:%i\n", -ENOENT, rc);
 
 	/* Check for missing cells property */
+	memset(&args, 0, sizeof(args));
 	rc = of_parse_phandle_with_args(np, "phandle-list",
 					"#phandle-cells-missing", 0, &args);
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
@@ -444,6 +447,7 @@ static void __init of_unittest_parse_phandle_with_args(void)
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 
 	/* Check for bad phandle in list */
+	memset(&args, 0, sizeof(args));
 	rc = of_parse_phandle_with_args(np, "phandle-list-bad-phandle",
 					"#phandle-cells", 0, &args);
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
@@ -452,6 +456,7 @@ static void __init of_unittest_parse_phandle_with_args(void)
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 
 	/* Check for incorrectly formed argument list */
+	memset(&args, 0, sizeof(args));
 	rc = of_parse_phandle_with_args(np, "phandle-list-bad-args",
 					"#phandle-cells", 1, &args);
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
@@ -502,6 +507,7 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 	for (i = 0; i < 8; i++) {
 		bool passed = true;
 
+		memset(&args, 0, sizeof(args));
 		rc = of_parse_phandle_with_args_map(np, "phandle-list",
 						    "phandle", i, &args);
 
@@ -559,21 +565,25 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 	}
 
 	/* Check for missing list property */
+	memset(&args, 0, sizeof(args));
 	rc = of_parse_phandle_with_args_map(np, "phandle-list-missing",
 					    "phandle", 0, &args);
 	unittest(rc == -ENOENT, "expected:%i got:%i\n", -ENOENT, rc);
 
 	/* Check for missing cells,map,mask property */
+	memset(&args, 0, sizeof(args));
 	rc = of_parse_phandle_with_args_map(np, "phandle-list",
 					    "phandle-missing", 0, &args);
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 
 	/* Check for bad phandle in list */
+	memset(&args, 0, sizeof(args));
 	rc = of_parse_phandle_with_args_map(np, "phandle-list-bad-phandle",
 					    "phandle", 0, &args);
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 
 	/* Check for incorrectly formed argument list */
+	memset(&args, 0, sizeof(args));
 	rc = of_parse_phandle_with_args_map(np, "phandle-list-bad-args",
 					    "phandle", 1, &args);
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
@@ -780,7 +790,7 @@ static void __init of_unittest_parse_interrupts(void)
 	for (i = 0; i < 4; i++) {
 		bool passed = true;
 
-		args.args_count = 0;
+		memset(&args, 0, sizeof(args));
 		rc = of_irq_parse_one(np, i, &args);
 
 		passed &= !rc;
@@ -801,7 +811,7 @@ static void __init of_unittest_parse_interrupts(void)
 	for (i = 0; i < 4; i++) {
 		bool passed = true;
 
-		args.args_count = 0;
+		memset(&args, 0, sizeof(args));
 		rc = of_irq_parse_one(np, i, &args);
 
 		/* Test the values from tests-phandle.dtsi */
@@ -854,6 +864,7 @@ static void __init of_unittest_parse_interrupts_extended(void)
 	for (i = 0; i < 7; i++) {
 		bool passed = true;
 
+		memset(&args, 0, sizeof(args));
 		rc = of_irq_parse_one(np, i, &args);
 
 		/* Test the values from tests-phandle.dtsi */
-- 
Frank Rowand <frank.rowand@sony.com>

