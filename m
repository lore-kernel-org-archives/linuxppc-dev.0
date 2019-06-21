Return-Path: <SRS0=Jsh9=UU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4809C43613
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jun 2019 05:05:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210262070B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jun 2019 05:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="CRhhg7dm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210262070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fossix.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45VRTb4RZRzDqX0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jun 2019 15:05:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=fossix.org
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=santosh@fossix.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=fossix.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=fossix-org.20150623.gappssmtp.com
 header.i=@fossix-org.20150623.gappssmtp.com header.b="CRhhg7dm"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45VRGn6yyDzDqSh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2019 14:56:17 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id p10so2752966pgn.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2019 21:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fossix-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XB8JDWrvxOU6U9PteJneZ99ibbyNeJLhwtOQI5zxxaE=;
 b=CRhhg7dmGd3nKvafdYJ6wBfnvSnw3mS1bDkU+WCigkWC+kmHVqKzJcO3If4xXMj+0k
 yDeNA1lceHl+9UuqoFrip9eoT5jl12OzQ2Wlftda04oiG90Xu88zaG08Pom2TZa1uiK9
 KEHGY/R6W0HLUNFWbMQiGA20GS+DR9rWF/gmfqunaLM+OzvDqg1j/MFZadRG1NZ6oXx3
 oyB4MY6qmmiYWc2BaUtwg5zweZ+8xIo8fy6JhFoq3xYt6dhQc5LK1TlIWpc4Hqpj5kVN
 4/Qclosm4tANySofIuGiJLAQul92rR1FWJVc2YMg++4NLUd8yjafb7+CiF2KsSUJe9EO
 aOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XB8JDWrvxOU6U9PteJneZ99ibbyNeJLhwtOQI5zxxaE=;
 b=PYysnmLWIr2P9FVfrxWAtiDqMFsNOBsFUbGUl6zTsynVW58VM2vx3cFmCKSsZfKxSC
 7DSc+wKQdBmgp/4RJNX4ijJlzaB/QBMphp9Jo58ybX8vtmX+tbV0bePBcvX/YmqiWcjZ
 92aNT9HzYjRnj0HYW4Gu6vKsf24XBJgYD7AxQEipVHOurcyceAfhtHZfF2ukiyf8aZxO
 A67uT7C8t9G8DunYeZrYpp7kTS9PRbDNolyErrQOFyn9HziN3zIrXvxGtL0zzsStV3VV
 axY3aLBf+kYMPbDmSj0CvN6Bmke9p+OwyxeWug+AI41J2WUANMfNYmQ/FZOXojOVl78j
 wyqQ==
X-Gm-Message-State: APjAAAWfwLAtPo1HJbGnY7+fmJ/vdRemrRTpi3K2IMnfRsHdPNZBn+Lf
 tnI8ZGNwYKGKQy+64mBr81xb7W1+2dghxQ==
X-Google-Smtp-Source: APXvYqznG53ZPqWbj3hbHyOGptWYuwJVbFQmP4Md6wbtb+v9Qy6h2pplSBGGORXr/JT9tirvEFHeLg==
X-Received: by 2002:a63:d84e:: with SMTP id k14mr16397146pgj.234.1561092976049; 
 Thu, 20 Jun 2019 21:56:16 -0700 (PDT)
Received: from santosiv.in.ibm.com ([129.41.84.77])
 by smtp.gmail.com with ESMTPSA id q131sm1392069pfq.157.2019.06.20.21.56.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 20 Jun 2019 21:56:15 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 04/13] powerpc/mce: Move machine_check_ue_event() call
Date: Fri, 21 Jun 2019 10:25:46 +0530
Message-Id: <7431d510d810672663428a607b2cc230f2caebc6.1561020760.git.santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1561020760.git.santosh@fossix.org>
References: <cover.1561020760.git.santosh@fossix.org>
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chandan Rajendra <chandan@linux.vnet.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Reza Arbab <arbab@linux.ibm.com>

Move the call site of machine_check_ue_event() slightly later in the MCE
codepath. No functional change intended--this is prep for a later patch
to conditionally skip the call.

Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
---
 arch/powerpc/kernel/mce.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 24d350a934e4..0ab171b41ede 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -156,7 +156,6 @@ void save_mce_event(struct pt_regs *regs, long handled,
 		if (phys_addr != ULONG_MAX) {
 			mce->u.ue_error.physical_address_provided = true;
 			mce->u.ue_error.physical_address = phys_addr;
-			machine_check_ue_event(mce);
 		}
 	}
 	return;
@@ -656,4 +655,8 @@ void machine_check_notify(struct pt_regs *regs)
 		return;
 
 	blocking_notifier_call_chain(&mce_notifier_list, 0, &evt);
+
+	if (evt.error_type == MCE_ERROR_TYPE_UE &&
+	    evt.u.ue_error.physical_address_provided)
+		machine_check_ue_event(&evt);
 }
-- 
2.20.1

