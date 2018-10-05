Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFF8C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 04:52:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57232084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 04:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8OeIxic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57232084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RHSN1GM5zDqsy
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 14:52:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M8OeIxic";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="M8OeIxic"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RGc85QQNzF3Fc
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 14:14:32 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id a5-v6so4109996pgv.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Oct 2018 21:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6rXTsHTXEu0ePfav46SJfn/0WRudrcKzA2MYy/8i5Ig=;
 b=M8OeIxicV23kcfKfRr40LQOmdI4hpD/+kDesn8YVAAjltVpo1dI3FqLGaJVHSc4uWP
 nLLrT4Yxi4gx5TPfxzY+4jEjp3pUaLZgD+5YX7BlbFYNwgLgyVjBVIpRkjv7qdJsBTan
 T2gLvI3hIj5EuP8VNsEIu4q4Atzy0mObD9NjJatbIDFI0dE8bTR1wtmVkfoF2+fSVPy4
 DWdA/3dmk+36dDH7kOkO+Z9/FcTo5ResY+lbPkfYrZnZ6Mur1c7ed/DHW03gjIvaR4w/
 dcYwN+3vTawpW4lC8VcH53+mmW53+S3MePTv6hMnhAmwJo1NJxVLozLDYKl7hQ5qhjbF
 hEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6rXTsHTXEu0ePfav46SJfn/0WRudrcKzA2MYy/8i5Ig=;
 b=N7GvX7u3c4f7mFZelpnRHf5Y9mSt+sfa8isI2X8K9NWjQAwXfwS6tP/uC9sfSthCzH
 c4br+J6NHprZYy0L+xspM9GYAnERrVRl8rXnW229Y25BPOcvBnZ1Zvqwrk4Dule9TG3/
 lH5qOQOGAWlEDjOLWIAKTTsLE9bLsoxYO0BZJs9dGHeCebzT1/jQO8/27pHbKgF7qdHZ
 J5p+dZTYL0XU3Cfu0QMCB9aplnX63kGEeJ99pahWdduDXi2qSEECNsrxXezVHl6fQN7h
 nRAKLsbxnKyNzR7ni+OHw2zXylBe3DQOhDRHhbI6yKCwKgH3w0UpYHhZq8DhjLtcjL0q
 mHUQ==
X-Gm-Message-State: ABuFfogaNvx2HlfNh7Jm2o1iKWll0jFA6pzbe2lj5ZEzBd2ogq9uG6Ak
 0HdRk2f0jN3YqXvaAfGlZjE=
X-Google-Smtp-Source: ACcGV60l4DiJgSXgQsIpQlpzSGrx51ZqCYckt/Rte/iMrTnZBmL5KdiqoUETladn6nlZgQDe8/KQ6g==
X-Received: by 2002:a63:7506:: with SMTP id
 q6-v6mr8396282pgc.137.1538712870907; 
 Thu, 04 Oct 2018 21:14:30 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id n63-v6sm277975pfn.9.2018.10.04.21.14.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 04 Oct 2018 21:14:30 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 15/16] of: unittest: initialize args before calling
 of_irq_parse_one()
Date: Thu,  4 Oct 2018 21:12:46 -0700
Message-Id: <1538712767-30394-16-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
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
error and does not set args.np instead of trying to
dereference a random value.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 6d80f474c8f2..b61a33f30a56 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -780,7 +780,7 @@ static void __init of_unittest_parse_interrupts(void)
 	for (i = 0; i < 4; i++) {
 		bool passed = true;
 
-		args.args_count = 0;
+		memset(&args, 0, sizeof(args));
 		rc = of_irq_parse_one(np, i, &args);
 
 		passed &= !rc;
@@ -801,7 +801,7 @@ static void __init of_unittest_parse_interrupts(void)
 	for (i = 0; i < 4; i++) {
 		bool passed = true;
 
-		args.args_count = 0;
+		memset(&args, 0, sizeof(args));
 		rc = of_irq_parse_one(np, i, &args);
 
 		/* Test the values from tests-phandle.dtsi */
@@ -854,6 +854,7 @@ static void __init of_unittest_parse_interrupts_extended(void)
 	for (i = 0; i < 7; i++) {
 		bool passed = true;
 
+		memset(&args, 0, sizeof(args));
 		rc = of_irq_parse_one(np, i, &args);
 
 		/* Test the values from tests-phandle.dtsi */
-- 
Frank Rowand <frank.rowand@sony.com>

