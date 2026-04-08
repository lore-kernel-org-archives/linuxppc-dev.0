Return-Path: <linuxppc-dev+bounces-19505-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4B51073CA3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 12:03:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frMBd1l8sz2yjx;
	Wed, 08 Apr 2026 22:02:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775649753;
	cv=none; b=K823eEQlGGb8t7zj3H4rrY4jsGk7weGA2OW64+yfcfXBHBYkgGY0PRzjzV3forRO1/Fw+3wSRjsIzn+W141uQASePnt7B2TpJhjDCrGI8ZRBK1F5ijBVThjR+vLauxzhVq4yEJhRffgwG+K0JRXydW4ejDkkqSI0oRX7ogEDA70ZP4MD/Irh/w6ZAW9mg1UTbkM/8lEH9td3AJWU3uJYd4bzADlzsVhLCXp4O8K8ixiZsA/SME6MqXjBYjh4wVTdjaWKqi4LUVP/2A8ONq69gTRFjjt4PJp7fVBMrSEjaI95hIljqDLO7lusWZIPNfCoImFu2818MHGSoC3wlFdYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775649753; c=relaxed/relaxed;
	bh=Q3dbB2q+3EGiEdHuQW3UFthejsHpGEStr/Ch17qN9iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naKRIB+clDmT+B721f24sC0I125g8ToQvOngU0vaqu9fQsEfsqpC5dXEn1/jicjpMgEPptHMyc5KBf8PVTOv7rqo8EpC3Gjz8yCk9PhfzgjQn0AO4u2vFjqu6fFjXg17BWt7araE6kWuKbHMsQ4/ur5PiKXZvKYrSRgrt3dQ4CPwjBxNrX97DLUyx4CwbJAZU5dPrK5/8/iepbrrINcWusGsefJcRrbpjRXXZ6nRNNx3jvZ6bFb4NoPmKDmKsO/lf5dNJ4scQEis/oh/soAWPSihKavGoR6k2tCE3N69BK0CIWLH0TO8eBmjkGBDhxzzFLq1wNiX0Gh3Zrz1xUrqFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hxwtjc5i; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hxwtjc5i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frMBc3scxz2yks
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 22:02:32 +1000 (AEST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-82cd6614a90so2723258b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 05:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775649750; x=1776254550; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3dbB2q+3EGiEdHuQW3UFthejsHpGEStr/Ch17qN9iY=;
        b=Hxwtjc5iHoT7RZLGpX8Ux4EjYknxJNRWGOM0gRA/gW8l+hROtI2DdmEq73yfX7w5XM
         NcbXWbkUeelRSHWD5FcvlJz/6IA2i9EdlqvgT5i++Qy2Qw4yabAUF+pDS0i0ee3XK+/0
         JPIiZbe+fD72hxD3vBVGTBX00XcKnpcNa3F67MGyixIC8UUuMDLFlbTEj13k3Sa7WlbT
         fiARmCQX7wnCcDa8PcHjI1RUq4XsYP+T8Ejtd323bpic5CpBIXP+eWn8tDjFarXiu546
         hiy0GxHfvRqx8x6xC7KpjPruIqHxa5oBwRg/HlPoFUQqZ3BzcFR8Z+IgTow3rZzrwVqW
         gKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775649750; x=1776254550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q3dbB2q+3EGiEdHuQW3UFthejsHpGEStr/Ch17qN9iY=;
        b=BdfYCAaXDKdSIYg0l3rGa/0ebNA4WQjPR/I7rOZNNRCmZzhIkWhVo/UmO0RMn2wpUA
         VLVWZoUEGVQWicsId77HfoK9n2uPDHIZ94lsaU3XfkI3OzaU8/oo3r5f6i5FF/Rz9P45
         vwtz1y5+/X2uyZiXbLkw/9xZ/5rJSGYyr1T6+U4sMIsd+ZS+Bl8i3Cr74uTJYvutecUf
         5K3pt4mFeqY7IdB45fZoDO57c4Vn9mJpklpnTPQJPFSRvnE1ehbJ0aJjpS/c5zVUthlm
         TkxBIE1qG5P+SVU65YMXGLo05+NZAED+wvvv9mt0jkwYy9q8agQYTgIeXqv54aBqP440
         MlOA==
X-Gm-Message-State: AOJu0YyyM6ZbsU6N5YWziCA/7jrtWLAUXCjU47P1Gxi8OgROoCvaoN5A
	kGcanfoLeeRxQXm1Q3T0T38W3UizcdG6pOlB8YOQI/79VIcCc0vse/M5d0BT8Q==
X-Gm-Gg: AeBDietVuQ6oHnak/buyYTuKjtFtjoE0cjLgi7Fi8dNJLTJUyc1IkVXloGt/aDhABb2
	P1hKeUOXJRYIKcl1aodis7Rg0NFA24wwyJ5mC2T1Iq7JwUThMn6zlfR6ol2l8t4WoRJJLN6YPp1
	h02v8RgLGTP///5b/HWg2Kli+SeDHufOFn2UJ+Q6vUjRRZawKZobACddZlHhYoSb/SZNWDE6hRE
	xsXlZMPQb1ZRZTvkn+ojLa3WHq43bYVXxY20THjfA2EOyIQl/nEwpYOpdiFbceA2rrnLwAkSk+b
	jpSTa63Xbb2KgwxIvvenry1OMl/qjp+FEgpc4alyY0eRBTE+Uuq6bkzNJpoOtO/8KRVEPuVHyzR
	iDu83GjslSYTVMmgil/1Rj6Dk7OWbaZz9Wc0QtsKnHS5Xt+ZlMO8djXVn7DMhQCzB1tAOZ0IdCq
	oI1s3KFygn99iZQ4f0qCCG8/94dZXfH5ltT4n7f10CnPhU
X-Received: by 2002:a05:6a00:1405:b0:82c:2480:4e3d with SMTP id d2e1a72fcca58-82d0da44765mr19104719b3a.9.1775649750053;
        Wed, 08 Apr 2026 05:02:30 -0700 (PDT)
Received: from Mac.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3e169sm21209322b3a.18.2026.04.08.05.02.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Apr 2026 05:02:29 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 09/10] pseries/papr-hvpipe: Fix style and checkpatch issues in enable_hvpipe_IRQ()
Date: Wed,  8 Apr 2026 17:31:39 +0530
Message-ID: <8e9de6c5a96b66f4ee8ed6801684ae0222dc6752.1775648406.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1775648406.git.ritesh.list@gmail.com>
References: <cover.1775648406.git.ritesh.list@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While at it let's also fix the similar style issue in
enable_hvpipe_IRQ() function. This also fixes a minor checkpatch warning
which I got due to an extra space before " ==".

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 5d04d1fa4370..c708869ca732 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -693,20 +693,19 @@ static int __init enable_hvpipe_IRQ(void)
 	struct device_node *np;
 
 	hvpipe_check_exception_token = rtas_function_token(RTAS_FN_CHECK_EXCEPTION);
-	if (hvpipe_check_exception_token  == RTAS_UNKNOWN_SERVICE)
+	if (hvpipe_check_exception_token == RTAS_UNKNOWN_SERVICE)
 		return -ENODEV;
 
 	/* hvpipe events */
 	np = of_find_node_by_path("/event-sources/ibm,hvpipe-msg-events");
-	if (np != NULL) {
-		request_event_sources_irqs(np, hvpipe_event_interrupt,
-					"HPIPE_EVENT");
-		of_node_put(np);
-	} else {
-		pr_err("Can not enable hvpipe event IRQ\n");
+	if (!np) {
+		pr_err("No device node found, could not enable hvpipe event IRQ\n");
 		return -ENODEV;
 	}
 
+	request_event_sources_irqs(np, hvpipe_event_interrupt, "HPIPE_EVENT");
+	of_node_put(np);
+
 	return 0;
 }
 
-- 
2.39.5


