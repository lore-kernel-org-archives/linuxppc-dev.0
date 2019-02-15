Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8738FC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 10:22:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD67A21A80
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 10:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rduvnx0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD67A21A80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4418T45WNxzDqg1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 21:22:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rduvnx0a"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4418RD4w4lzDqTY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 21:20:40 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id d72so4599997pga.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 02:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=tXcU30o3Wcsl1fwsiFhdiq2TjA2qKoCYc04dcXZEdDg=;
 b=rduvnx0ao3DzLygItTZJ1b+FL5hKSCgpqsqB0ifmaCVXwuKWcfRiAkrhzyF7dmjqU+
 xow9+Sa5Khk3V1pb+5iqgu7r9oHb1b/9Kd7QmN2q4M+cuqzxMwY2k1t9Ik7AFuX5Zxng
 05ltklOVDu3z7paYVHXfb9aazLlmZUt1MddGcvwUldm64zqkJTRidaI+apg/+zd+Z1bV
 9ICBKao9jZ+M7dRzMpC9XfVJCgqUvIIkS6J6aFWDuWW/1Vd9DyvQARfR/D/mhMUwvZA0
 ENAMP4Su8HJ5gXri7ChYvifKft25JShOLYZoQZAhXkpRRbZ7QsD0v8qz60pB2kLV/Fp7
 klOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=tXcU30o3Wcsl1fwsiFhdiq2TjA2qKoCYc04dcXZEdDg=;
 b=Hauvlr3g+jYDwPwM7dxr6K42CJq40RUColZd0trqwOp3pYj7NGE1KTHQHqTY/eccPj
 vlg2r9VDwJt0xmNQlB7kiuj/c2l3i0JbcXatzxQIbmsV1oG2XnXMx/8ML2hS8C8B5Waz
 LcVN48TBhZcta0H2JFvuDSmB0vXEg2DEppgKWImU4qNz4UhDlD02jfFJJHqqNdEQIwj/
 eet48pwwiaUOqxpDwTNzLjX/SwAKOF0OYBX1EKwBQpnUQ5lvYMcpJ7UlUAamIk8/hC0W
 h/pQ1ZOQTLotSez5IEVU4C2HRPquMsgPScADTvnBhmZ/2oXfFGBevS4qKyb7tS8AfLMs
 ED4Q==
X-Gm-Message-State: AHQUAuZN/N3iqtteN6LzKlcZZQhGtqnNBFBiiJqJk3J9hxImd0KfkSnO
 5ArpEwg4p7Wy+3Mu2CCcYJKvaAep
X-Google-Smtp-Source: AHgI3IayyzPgjda1X3cv40BBDJxUx1tSSfOlg7J0/BpU5i45RpnUyqpUWiEZXkDnhCXr4uwhgETxpA==
X-Received: by 2002:a63:80c7:: with SMTP id j190mr4434159pgd.357.1550226038110; 
 Fri, 15 Feb 2019 02:20:38 -0800 (PST)
Received: from roar.local0.net (115-64-240-120.tpgi.com.au. [115.64.240.120])
 by smtp.gmail.com with ESMTPSA id
 o8sm11696550pfk.139.2019.02.15.02.20.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 02:20:37 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64s/hash: Fix assert_slb_presence() use of the
 slbfee. instruction
Date: Fri, 15 Feb 2019 20:20:20 +1000
Message-Id: <20190215102020.24346-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The slbfee. instruction must have bit 24 of RB clear, failure to do
so can result in false negatives that result in incorrect assertions.

This is not obvious from the ISA v3.0B document, which only says:

    The hardware ignores the contents of RB 36:38 40:63 -- p.1032

This patch fixes the bug and also clears all other bits from PPC bit
36-63, which is good practice when dealing with reserved or ignored
bits.

Fixes: e15a4fea4d ("powerpc/64s/hash: Add some SLB debugging tests")
Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Tested-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index bc3914d54e26..5986df48359b 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -69,6 +69,11 @@ static void assert_slb_presence(bool present, unsigned long ea)
 	if (!cpu_has_feature(CPU_FTR_ARCH_206))
 		return;
 
+	/*
+	 * slbfee. requires bit 24 (PPC bit 39) be clear in RB. Hardware
+	 * ignores all other bits from 0-27, so just clear them all.
+	 */
+	ea &= ~((1UL << 28) - 1);
 	asm volatile(__PPC_SLBFEE_DOT(%0, %1) : "=r"(tmp) : "r"(ea) : "cr0");
 
 	WARN_ON(present == (tmp == 0));
-- 
2.18.0

