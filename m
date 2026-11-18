Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05ED606A320
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DXuqfCbS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTy250Fvfz2xdX;
	Wed, 18 Nov 2026 21:07:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794996428;
	cv=none; b=fnTj/JBumEJ5jcPG8sBlzWmmAJhRlh7Vkx2JACdjtoZvwj2ZfbKuBeKOKokzSEE98dpcAhovd+TXUNFeFCxUzoCWVS+ndgyuDjcVo9BKIuAHH2one7cKPlrqp/B8qDJVLoUwXUP4vezh2cTgIfd66+vtbxtwnPeRzv3zPRJjM7yN3eHCc0qspdFnUmzF/9/AAc+zRU0rhEHopuEjJ5g+ykbKczU6uXL00BW7RlIX4Hv2fTq+BsUiLxEuEDnRC8vzLd4N0bM4cJy4akef/uLcl7VNN8E7ORmCuN7ReL0HCv0w8HlvncdStexsGwJoKZZiv+OK8JYThV/U51qGNaI5tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794996428; c=relaxed/relaxed;
	bh=/kO93nSsjjdF3j4npCojXQ0FzWXWJez2uUSNY9jjjOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CFY8YNSAqibvJeLLG9PCuiHz9LD1g74gZswPe+OFEUlMQagbBSzOeSOsxSGvVmDdyW5DFpefzL33JY/OFSif1OqQ+ss3Br5iKLfX98TsEHrrtWU70K7kQGhFVGhKGmjRejqXyPyKEga6+YMKd4CSRlcGsy/BuQ2Y4qCTsiWQ8wZY3Z8CJJnoikHZ745hdUmYplSTnmwOntfGdREVnZOpmA64T9bJJp0WTP1TVBlTgPQ58VI3KngUtfy2bQHaIOUAIe2A6ZggPTkceJKwb6k2HmgBy2YwbHo9XOOT8z64PXA2+/45tzu19HrY8//Cq2lV+5B3TE9c+nYhJ5W5kdE48g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DXuqfCbS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DXuqfCbS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTy2349j0z2xdV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 21:07:06 +1100 (AEDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-8c47c5b5407so1082201b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 02:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794996423; x=1795601223; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/kO93nSsjjdF3j4npCojXQ0FzWXWJez2uUSNY9jjjOo=;
        b=DXuqfCbSszQVlBLao+vHbWlpHotdzuJrwMggKj4NaC9n6cvjzbu0PO5K50XseUToWQ
         kvER/2Ge9ibnwqsGcMXZHcIzRTTtK/2vKopCza6f1ENt6Oihuqi8eIf+Nwq/7leiuIgj
         iWmBfUJXxg0K9wg40yL2s7HJlcHsOYegmwDARR2CEvOPFmoxPYjMLPZQSXUbvbFfNQyr
         +QoHiURTbFKeGEX2HkyA+PVbN5odOHtQJbdCP+ymvsoc+sRltFNNMxSlkLrZNiEA1uGx
         Ms4BjwCKP/A3XyHYuGe+AuB1KQJqopSD4z0MHDyU/YZHNAiivSClaOnCGVxfpHoyKGSt
         FslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794996423; x=1795601223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/kO93nSsjjdF3j4npCojXQ0FzWXWJez2uUSNY9jjjOo=;
        b=I4typpOxUZHJjG0UchX90QquRC6YbQHkbNl5PrPIoDrRxJlQhv0wbyewO0pLPynFlc
         9Px9dGMXnoBYiR/aDlya+SSa1eT6lo06u6EUhGslBfIxwg5Gexj4kVUhplCyDfZPlhLY
         Xj6sXtePVfp/okj7vsn9GC8XYagPw1Q5omfOan+vBcmnZSSsrBwaFExdfd5lGc/GXMDx
         0dGA3yT8F2s9L0VSMoYujyjkegKqQADlkEysqNYepdDlvCpcff/GmOCUQJrX3iAOFLr2
         khOkHnsVDy8vfmiPKy1cKq5YML4AgirbuaSuTu4ftbAjJj0kzza+Bay+4vk8+QpnjdJA
         6EZg==
X-Forwarded-Encrypted: i=1; AL+hErHuw/M82Uk6n6Eoca5xiHT1ny/NsjmD/oynB/OSWJlI/1DqEFBaSf9lzIBB2Nnk37sauIzscxh7Erfhf1Q=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8keLk9nN816lE8KIauRfRB/AzF9O9R/P+ipav79anfDU7cnzpK
	1OjjZeV98QVt93CHWKKZda4vSaj0Eu7dkZYEGfrrU07ej95VgWNLnGvp
X-Gm-Gg: AZFdTZdq2J0sJo/S4aYG07XlQmeKtwyOvO8re/t+XmtwThtMxWsVoxwkrBy6Do6DmXy
	yBqQEKTGZZCiGjrrrYjifqpLM54l67ZWlJIu2W3MomoCBNa4Z+FNQHwbzC5bsYqdTnZQsm711zk
	jPoT+mUlB484j1Pz5D1NDwA2YJfyWAak5fkIrJIkJaadgsjqRUQZHK/0fYaCFPaO7cre5rtiX4z
	8PnjQtAHg0V1/ucX7pddSJfYb0IDrUfz1FLaDW4TpgfhxO0sB/u39XEtY8khq1WP9wU9r+c0qNM
	3WzWzWmdi6oB/vWDMhTpIkg2VqCYtX9RecEn6bHnAy+o0P9oJRzpDbtvWV+jnTEmHVxx7wHUSX+
	43eATiS8+v5nZhYoXlR8yxVGmi3XRBcWfaToXFw8Y+/bzECsyNUOcBmx4fxVlBKCIrjn/ipmzDX
	TSYmBl+2BEkiNHC3wu85snUgtPfLgt2YWJQzvhZFvzTvvMSphJ4+uaJagfngyllctilYwYteYS0
	d4P2P4wEGQlCfm0PrsCIHs/n0GzWpHuNa/0rKEdCKxkGD3qslK6mVggjoPkD0EqJB90aRN+7SW1
	JWJ9AHM3KCP9dIB1h1gSbyvfsGyEXSXM1G6FGhJi+mGSRvrmi52o1SPKhw0/VNIeJcesc+i3b7w
	XRtKPNPMWhgQWcb93JKWEoV90f0JW2ib0YaDgEO9/HkJg
X-Received: by 2002:a17:902:dad2:b0:2ed:520:2641 with SMTP id d9443c01a7336-2efd9bcde77mr39901635ad.31.1794996423492;
        Wed, 18 Nov 2026 02:07:03 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff6215025sm10634145ad.46.2026.11.18.02.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:07:03 -0800 (PST)
From: phucduc.bui@gmail.com
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	jonathan.downing@nautel.com,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 0/2] ASoC: fsl: lpc3xxx-i2s: Fix error handling and DMA configuration
Date: Wed, 18 Nov 2026 17:06:29 +0700
Message-ID: <20261118100631.26658-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: bui duc phuc <phucduc.bui@gmail.com>

Hi all,

This series simplifies error handling and fixes incorrect 
DMA depth macro usage.

Compile-tested only.

Best regards,
Phuc

bui duc phuc (2):
  ASoC: fsl: lpc3xxx-i2s: Simplify error handling
  ASoC: fsl: lpc3xxx-i2s: Fix DMA depth configuration

 sound/soc/fsl/lpc3xxx-i2s.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.43.0


