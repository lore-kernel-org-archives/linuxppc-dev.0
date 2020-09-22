Return-Path: <SRS0=QuHT=C7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C657CC2D0E2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2020 10:02:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2302084C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2020 10:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVbjsAJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2302084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BwcLD3ktQzDqwF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2020 20:02:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::442;
 helo=mail-wr1-x442.google.com; envelope-from=nico.vince@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=SVbjsAJ0; dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bwb3j14VHzDqm6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2020 19:04:44 +1000 (AEST)
Received: by mail-wr1-x442.google.com with SMTP id m6so16189855wrn.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2020 02:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:reply-to;
 bh=+4XpQvtWXPyTznpGAkELP/n7lzSxC14odmmMx4vJPug=;
 b=SVbjsAJ0lWAiA2xI9F50MwEk6p08jujYjGl79GAah+H/jsP1VaIl/Q/T8OqTw0HjLb
 BhzRPEdRcfsyyD/60fOMmfevb2aoDxE/9VDD3hrCIwJZnQFaukBsbL76JheYyN3lPjmG
 bcOnDKPhe3//S0PN+6NBHwemosnlunB525QZH4IS1LucVhKL5i5EZo6WLU4Y4aOlqyUJ
 fywP5HxHiLW8FUKr/0vY1Ijsvfaqamlj4mRVmiwhZjtfiOPrS6YKSs6qT/GKUclbrdPZ
 FgNwUm4hnZ52rGaNgRti0WwZopwrDnQFZRX27rLU41Ba1hset9/Qgdgo22ROuWuKQtp9
 vDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+4XpQvtWXPyTznpGAkELP/n7lzSxC14odmmMx4vJPug=;
 b=o/joAyrJVJhi0aTRz4YZBWueTnYJ4v6EqDradAAeWlC3DZA3xF8xQbWiFGy80xvemq
 rLUvOmJE4skdtZT6ObCd0EffWLjKWL4S3WqHk5rDIQR69gcDHfuBHz/LbmNIqgr1XL8N
 RDz3OD6sjOAtSD77uUCH56DoBLF7JOofau98Emn2DWUsiq8j3/79ZPaI/EqzZFW/2uGU
 Yz9Z036az03MgC6TmAopmoaeArONy16m3+A//eU4QySVq8Sp0AGRNxna6k+F7yvtZ4Wk
 H0VCPTAjXdHN7ShPcd+LdDF4VnWd5vfeTbKu3K/FIpIzCIiH05SKiacyAzuooZejFy1X
 AiMQ==
X-Gm-Message-State: AOAM533ba8Dxz9kCK5QmTVJ4PH6sASN4IViTyiswijzj4vXVRJy1DrRh
 WAL2RjwFiK4cG5kHdluI6pE=
X-Google-Smtp-Source: ABdhPJxf58HxG1Bf12cBrhsl/LUrq4fECwilAh8SGkmqljX2a0mJoLjdwuBSSmuJxGo/P+mTh/Q4Tg==
X-Received: by 2002:adf:f34f:: with SMTP id e15mr3959591wrp.387.1600765479573; 
 Tue, 22 Sep 2020 02:04:39 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:287:860:29d1:d0a8:b1c3:1cbf])
 by smtp.gmail.com with ESMTPSA id
 n3sm3428741wmn.28.2020.09.22.02.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 02:04:39 -0700 (PDT)
From: nico.vince@gmail.com
X-Google-Original-From: nicolas.vincent@vossloh.com
To: jochen@scram.de
Subject: [PATCH] i2c: cpm: Fix i2c_ram structure
Date: Tue, 22 Sep 2020 11:04:00 +0200
Message-Id: <20200922090400.6282-1-nicolas.vincent@vossloh.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Tue, 22 Sep 2020 19:59:57 +1000
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
Reply-To: nicolas.vincent@vossloh.com
Cc: Nicolas VINCENT <nicolas.vincent@vossloh.com>,
 linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Nicolas VINCENT <nicolas.vincent@vossloh.com>

the i2c_ram structure is missing the sdmatmp field mentionned in
datasheet for MPC8272 at paragraph 36.5. With this field missing, the
hardware would write past the allocated memory done through
cpm_muram_alloc for the i2c_ram structure and land in memory allocated
for the buffers descriptors corrupting the cbd_bufaddr field. Since this
field is only set during setup(), the first i2c transaction would work
and the following would send data read from an arbitrary memory
location.

Signed-off-by: Nicolas VINCENT <nicolas.vincent@vossloh.com>
---
 drivers/i2c/busses/i2c-cpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 1213e1932ccb..c5700addbf65 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -64,7 +64,8 @@ struct i2c_ram {
 	uint    txtmp;		/* Internal */
 	char    res1[4];	/* Reserved */
 	ushort  rpbase;		/* Relocation pointer */
-	char    res2[2];	/* Reserved */
+	char    res2[6];	/* Reserved */
+	uint    sdmatmp;	/* Internal */
 };
 
 #define I2COM_START	0x80
-- 
2.17.1

