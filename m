Return-Path: <SRS0=WT2w=V6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CDDC19759
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2019 00:11:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2F02084C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2019 00:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRxylKkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2F02084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4606yM2LPSzDqvZ
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2019 10:11:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=jniethe5@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="DRxylKkW"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4606vz6SnSzDqpL
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2019 10:09:03 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id t16so34954735pfe.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Aug 2019 17:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D6oKvKKtd2mdWhdvhvbSVPHKK5O5uXEl/mQdtU+h1c0=;
 b=DRxylKkWE5heSulMvaL2ZY4CBWrFN9s9v3s6qYmVc7yB4WTc3/M2YYeSVJr5gVnsu6
 +wEvPpF+8nxBCm27CzEk3RNpB2PxsD5izIx1/t2RHiOBk8uesTEnr01S9y6FfUZ8oPme
 LLQUs9aSsB0Sr2v2wFZ927FiLHY5XLHjs/mkEkTHw30coY9xAk9wQZqN4ehMDsj7z3cu
 fhhXA/Ax38OavUvsVYhPBVX3bKRSFFjaA3esEPgYsYp8Mnnfz9krvl7xgHY7pQIpqWhC
 JL6+9SaGmzmBLEMyhyA2WGXi0/33Skt5+g4ZUOj8Ol2+ldX2ZNxPRS+mgNb7vnEVS2Oq
 AGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D6oKvKKtd2mdWhdvhvbSVPHKK5O5uXEl/mQdtU+h1c0=;
 b=R1mqLXijprzTeYpkYJso4JFuKmPwVkcvqe45w+3zO1vRwGNMwhyy6/MRhFjFaURSp6
 J8F24zzbjz+3kNq4RdcuNSCeWYsE9A5qIb04dzABqh/BOsSH0+SFlbRtn1LE1MLlSp/v
 ERgZtsdjFeT0VCYO/CujxWMCoZ+nMpEn4t5k4r0wE6QKAmPZeECUBZGMzkLn2iI/W3Uv
 DrFfXyhUGoqA+Va6u4t6EpmfK0A70ueljJJoB6y6S7mzEOf0+0leoSsqjoQ7mpv0+00y
 l9DJ1Q9Is4H6o4tbhhcRde83xe3nJhvoBirmSiGeCReOHloBu8ROQU/dZ4Bw05kcvQPf
 M3rQ==
X-Gm-Message-State: APjAAAU+9qLNAFo/nBbyIQXhpEzV+qqS7Mm/rhYgbpScddn0JSVYsWGx
 S3utnMDVgdrq+YJnVmC21stYB41v
X-Google-Smtp-Source: APXvYqx+QzFEXpRFBsQeyaiMA3rw95+OygsqcBuPG/XCen+9t3pwmhDdUvrbCJLp+EHoHLjybLk5tg==
X-Received: by 2002:a17:90a:9bca:: with SMTP id
 b10mr1417355pjw.90.1564704539951; 
 Thu, 01 Aug 2019 17:08:59 -0700 (PDT)
Received: from pasglop.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id f8sm40263894pgd.58.2019.08.01.17.08.57
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 17:08:59 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/xive: Update comment referencing magic loads from an
 ESB
Date: Fri,  2 Aug 2019 10:08:35 +1000
Message-Id: <20190802000835.26191-1-jniethe5@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Jordan Niethe <jniethe5@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The comment above xive_esb_read() references magic loads from an ESB as
described xive.h. This has been inaccurate since commit 12c1f339cd49
("powerpc/xive: Move definition of ESB bits") which moved the
description. Update the comment to reference the new location of the
description in xive-regs.h

Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
 arch/powerpc/sysdev/xive/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 1cdb39575eae..083f657091d7 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -185,7 +185,7 @@ static u32 xive_scan_interrupts(struct xive_cpu *xc, bool just_peek)
 
 /*
  * This is used to perform the magic loads from an ESB
- * described in xive.h
+ * described in xive-regs.h
  */
 static notrace u8 xive_esb_read(struct xive_irq_data *xd, u32 offset)
 {
-- 
2.20.1

