Return-Path: <linuxppc-dev+bounces-25105-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C16C55165
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 12:39:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9pg24T7tz2yYd;
	Thu, 30 Jul 2026 22:39:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785391582;
	cv=none; b=XJUUEQ4xiUhYd/uvgV3YAK+Q4XlRUO57sKTBQL0GDEP/8OeNXbhcIPdmZXBAPny7fUbmLDxHIhY0KF3OdXwx9Fn5HYPgoiBMUUFeiU2hSQT9bFiwadtv7hBxsJUj3wzxvxXm2jYJ+81VdP5GgdpUvcL+xu21Ydnc8tDS20wmfkU1I/rovLsxzenE8BGaTO6S/JZg9vvYUUOpO/Bqoz8wNhj5FvRm75k+15VRxNuEWDfTCogCJsrAZxEwX2UYssu1HOeHdXDiI05Qw5y5HlU4W6XHTvcrf1f90mFHizI2UtkadJViVQ5kfwHmQSrz9zu1XnP0//0Yukm6w0jP07DOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785391582; c=relaxed/relaxed;
	bh=70qAmrGbi2lwMLJ48ZAfSmbWQpEbDt5ppwx5wBXbB6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/hU+rGEahBsDJTWqNbQ/PZD6urt40JuQhZZBZ0JIctrDWdfIUHPk4wQ9R7Ez1bIFveJBNp7uTiQwhYEGx66iewiQg4pr27s6jfYM9HM8aN4RqGtKT0qn0psODUtgBldEiKB0GHbM++b2eme5NGUC6VfZ6mnIRCmC9vABw1nl0gW94IOR9CVpv5sApA/zXG+DEIXAuKZW1eAeYHn6po1d80G+Q5Nw1IUuWV0kiuw2+DXbt3xlzxKffDPgUoLe2leRy3anpygcpYmGgoD62xCQNNxCj8VccLbNnFw2berGacMVny6bmv/Mq9YBaSCOg6tRp0ErjJ8R9wSU3HebKeSuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SxX7HxpU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=bbnpreetsingh@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SxX7HxpU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=bbnpreetsingh@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9dxT42CDz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 16:06:21 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2cace91f112so20622525ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 23:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785391579; x=1785996379; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=70qAmrGbi2lwMLJ48ZAfSmbWQpEbDt5ppwx5wBXbB6E=;
        b=SxX7HxpUW0pRw0NWieiFYQKngNh8oCpjstkGH4H2+FBXb8cO9GnuvrhAmAbOMQmJJU
         uS4S/iQ2qcVa9iWg1/6ULQV+ZVUT4q7DlMp8/Vk/zjoBRkZBxICDCGYQGyi8y8YFpTvz
         L8n3ncN7zlyl84nY4eHOD0i4FhzkU7ND1ATvZW64RWMA5B7mAxKlZ3yDNcM88RhgYQWX
         +IS7JOhpxeagXl0l+7pLuBGotc7eL3S8Ven6KMaHWYD6d6OIm3hwBFHKh3lww+sRi8vD
         eJh4DZEWB/XM33x9hzK4ozU7zeI/2ZZNdOrHfs+xuvMiSvpKGJx09YPp48Pd92LviAxI
         7JGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785391579; x=1785996379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=70qAmrGbi2lwMLJ48ZAfSmbWQpEbDt5ppwx5wBXbB6E=;
        b=H8rh6M9PGNopXRGjI9Slc9B2fRKr+GuwL/QFz6hZ8oVuYPpWlbrHtQ4r9MuWwFxxOc
         E3rJ6wpY6Ch6G2S+4tPUk1Bm6yeZpH4cAM+uW4F2EPTDnoSkq3XAanWhY53VeZoz2XW5
         fgozXnoupNemDGC/8ceuP5DMtA+ctsf2wCTMPUvQbn5FXNJh9p0TqIhEqWrl7tf8CQ4z
         5kOLr1t5L7aGdQY7GkGWID3SiKOHQE7Bnp3JwfBDMX7pmYQwo3wB1bHM2FY6okFIaoli
         RDPbpNr0FyUiY8L9IjBEe8bVpQLsAI+kNcy+nlmviG3AYi84wTt8glwitw7zwOD6AUNP
         CJjg==
X-Forwarded-Encrypted: i=1; AHgh+Rr2arBUIGn7KgNtEFwBaKvpec6PoYcLhxwC6jqYy6lBZLxFax2NK0bUQNJS0S867vIAY+E0xmE1TiLPTGU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwnlwxAgl3G6fTT6muJIJPMxlGTBiwzoVBxNIlQr+8n/8KT7O3n
	upKwegbG+4ktyJIK2eY/PIIh7Q1mnqrWtZxGRfnsMK2Et7rx41Jp40mB
X-Gm-Gg: AR+sD12CDptAEf6Rq0wsmyJituQUZbuWO5MV5ZxHMw5o/QJaNbO2Oxsw1rO1gIAiNwP
	a5NGtX+U7u9BZyhX6QPrAmCk5pgEq3gUfZcI/iRLVpocclnib0NorwcZRMJ7E/frnNJmbOXxdVI
	RDQKaMLAZIn6HdWQAO4W9LXIc7bxRp9zEmp6FW4zDv2h0oct3xCfBcGwUNXNKorOCk4mE2fMdE4
	m9jsFi32SgYXgKqLGRLNTQlyxyyRzFgMPf8j3DYT/myFkmM6H5iGXWi87B3BYWshMoKn5UuZdhr
	1nIsERGxpVHRaf5zolA2R/zrjolR/SVYJJUMQAjlNuUjs5FagHQZU6elhM5pUc/8ktdJlEHRhQA
	0LBIhQDLsuq2fU2bOgS/SMbgHMZP+fk287mb3L+V84sYNbRFTgG/IW7KcCyoq++RqOdeF8+AKdz
	StnyTrMZUGoEIu6q+ZMdlwc/H4nzgmftsUiRUD3vKvEkltGbiChBr81mtt1yxf
X-Received: by 2002:a17:903:3bcf:b0:2ce:ced3:490e with SMTP id d9443c01a7336-2d035e6e9a6mr11975465ad.39.1785391579309;
        Wed, 29 Jul 2026 23:06:19 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a46774sm20780785ad.27.2026.07.29.23.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:06:18 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH 1/2] watchdog: wdrtas: Fix kernel-doc parameter name for wdrtas_reboot()
Date: Thu, 30 Jul 2026 06:06:16 +0000
Message-ID: <20260730060617.7-2-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260730060617.7-1-bbnpreetsingh@gmail.com>
References: <20260730060617.7-1-bbnpreetsingh@gmail.com>
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

scripts/kernel-doc -none reports:

  Warning: drivers/watchdog/wdrtas.c:460 function parameter 'this' not
  described in 'wdrtas_reboot'
  Warning: drivers/watchdog/wdrtas.c:460 Excess function parameter 'nb'
  description in 'wdrtas_reboot'

wdrtas_reboot() names its notifier block argument 'this', but the
kernel-doc comment documents a parameter named 'nb'.

Update the kernel-doc comment to document the 'this' parameter.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 drivers/watchdog/wdrtas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/wdrtas.c b/drivers/watchdog/wdrtas.c
index d4fe0bc822116..6c25171de224e 100644
--- a/drivers/watchdog/wdrtas.c
+++ b/drivers/watchdog/wdrtas.c
@@ -448,7 +448,7 @@ static int wdrtas_temp_close(struct inode *inode, struct file *file)
 
 /**
  * wdrtas_reboot - reboot notifier function
- * @nb: notifier block structure
+ * @this: notifier block structure
  * @code: reboot code
  * @ptr: unused
  *
-- 
2.43.0


