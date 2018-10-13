Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EFEC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 05:39:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20272087D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 05:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBE0enLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20272087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XD6C3XrFzF3Vw
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 16:39:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EBE0enLF";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="EBE0enLF"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XC7h65gnzF3Tq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 15:55:28 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id c10-v6so6751863pgq.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 21:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=c4g80DvyuudoX+LPD+xlMBYx8TzUWy649W9bh+/3Apk=;
 b=EBE0enLFfZS00Q4vrKlNiFa455XytYgOWZqS/oM4Ln9QGgwPT/7BO13cvxIOpS/czO
 jBq/WJJoqKV3FDKdOsuk2RKrPh+jn9AbcxrBExEQFwEmUYWtnFQzBNjFHGwMH2i9j4IH
 hgeVskYmNiL5O7ayDrweoVr0Jb5VkNBwJjzl3u6H1b1YmX1P5pfPs48SV8beLyvcj2ex
 ijwDIm7+ruP8bA/mMsmmuvhm8ci47KyEdW8pgrMw0nU1btPZ5u7hhl4ZK9qs2vRLHvsP
 /aJxslL8DLNitvpH45H/jpRAOpLsNufpKrsBMnxyLZfycpJ3s6vjTDZwNhCGz45bTq4L
 gJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=c4g80DvyuudoX+LPD+xlMBYx8TzUWy649W9bh+/3Apk=;
 b=MUmT7EMJ60CM8AT/sfTT8+UR7Qpgsj7hXEP4EKkTtwgnAY2Gz9t/3Sg6KxVIhaDb0q
 gnUHvCNkPBAqw4/srvx/bUJqCkiBFAVCgRV8mj47atD6OXMMZQRbw3reYl9fQz6Y0gsK
 tkR9kYwQ7OBvHTwKhtiuIy8AAVu92DxlUH0aWmKcBw+HokJTBbh+/bt+wJ7BA2QIN62s
 X8RWSz6K2isOsTTwIFDhPU+4WpMDhRlzoprKPL6E+3WtANQRSHt8clWEpgXsVAIqxL/f
 VguwU3kQTv7/7PozUYrSQKaU1biudClkF4vSkTKdRrT/abGwGeuZOKQ7+soW0KQvNATw
 uVag==
X-Gm-Message-State: ABuFfohhbAWbg+brqpzFkYZcrBJgVz43aZr/sDVPPPcbL2qiRRp7Cs+2
 Mz6Y+WKm0LRZ6UXB+6hODpc=
X-Google-Smtp-Source: ACcGV63+XntGfxxxUG3x6CDkSZ6opwjM9Ve/81S/R175COQs/W+AWHCB8Rw/XJ3wl4fLwlWDYNwnXA==
X-Received: by 2002:a65:528b:: with SMTP id
 y11-v6mr8134116pgp.269.1539406527279; 
 Fri, 12 Oct 2018 21:55:27 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id h87-v6sm6959462pfj.78.2018.10.12.21.55.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 12 Oct 2018 21:55:26 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 18/18] of: unittest: initialize args before calling
 of_*parse_*()
Date: Fri, 12 Oct 2018 21:53:38 -0700
Message-Id: <1539406418-18162-19-git-send-email-frowand.list@gmail.com>
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

changes since v1:
   - add same fix for of_parse_phandle_with_args()
   - add same fix for of_parse_phandle_with_args_map()

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

