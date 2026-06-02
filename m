Return-Path: <linuxppc-dev+bounces-21838-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D61C5DF71
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 05:02:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTzGB3Yg9z3btq;
	Tue, 02 Jun 2026 15:02:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780376530;
	cv=none; b=nkEKhuebbXo3LyljYiJk4R3FkhBhAjpbuTNLiTMGjPJhHbV0F6I34yGPDjtJne4HZKUDEZk1x+Ha/TpIAPLbq/SiDeqM+zUa8VhV4PgBgxCmneRWu7h8mV8YrB9c4uo+tl0hZdP+w2U+qfnRVG7iTAzuC4v0KcMOwO8P0C9o14h8J+n5q1YwkFNvOqA6sBBriaK0nRdipQxY2bLjdseYl9gNuq2akAbP8Rr0PSp/4JgvNUmIu0/rQodX7lT1yd5D159yOcWhZ16kQPUgTfcdvMr2QGgbfhTt/ujP9i5LPsxSwsewntZhZOejHWoO9fAVjQYAl5mRYDDFE3gnY+x6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780376530; c=relaxed/relaxed;
	bh=7Rc5e+pcCQNLSk7M/61K5VybU7Xya1+dcR9m3vlqSb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2lX/VL3EeNyG8FZpLR0tijCwWadFCBl6znepbmbdmgO2fndPpHcPGCCkfMVIJrAKuYrOcyA5Hmkcm6KaRwRU0z/uE8bTXPUqEKvzyTgTHzU6TkJc0sM8fQUbmDZy+DF63KVZmBT2eyEEwn/9a0xhmND/bvEBOpDO214PUiYyLWz2ibFuTaL+vW30CMCIlzSHD4XEmqbj1LICsTbjXh5aqE0cibq2u1WwGvyyKvKeWiyGyRGGcUY/Ch8+jJJm5E+xDbUPgNc/s/M+XZ25Aa3r5LO85FLOzbw6CMHsAu1gDgX5py3fHpXfAGAozvQfwBID/Qw2AN8u3fKs0nRS/rl1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eRATI/iG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eRATI/iG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTzG96Gk6z2ytJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 15:02:09 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-36c68964315so1504548a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 22:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780376528; x=1780981328; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Rc5e+pcCQNLSk7M/61K5VybU7Xya1+dcR9m3vlqSb4=;
        b=eRATI/iGtnj6P7Od2gVx0I6E2j9IQQnwvFYzhOotppiqW87SEslHzvd1y/E+DmECTb
         GTEiFH4fqKeYEmAtjn95LFW3W8qg/ZD7olxAxvcKjdxhU/0+yMOwbT5GlWfanbw2whXW
         ynmjda92dP3nHWXVzcAh9F+g3ZwcaB83dgwR0nbW+bDcczFdaNgWv9XTN3d+1qeGUHGU
         pPkQgn5/zUMa//AqGdL6k5ozZ5Ch8DwbWokP+ibT0S7jb0dRMQYRX0KGR5F9rfnVXOF2
         oaEg1DduXAeXJQRAfLmFnH7yA7C97/HL+IhWfnMT8e8W767bRku85BW1Xo2Zaq+JZh4n
         EF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780376528; x=1780981328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Rc5e+pcCQNLSk7M/61K5VybU7Xya1+dcR9m3vlqSb4=;
        b=Y2UM42EkA210FV+M0ITl/tyfFbi5kNzeMvalLlSedQa2d9Asxm1xgIxGesTVNW8Ist
         txZlVPBEyp89OEy7xq7kaXfxaQNziBOO4Wdruc/p154Se6k9A7SscoXjIKlkxcUUCcO5
         9tx16wpBGVM3ZzeLdFD17WHUBnlixqY7jxNfz+fPF/Nc1SqpRXdBnjkLDrvWx9Bx1VSI
         LkLZW5T+UBioWOgY+PxGEFa7EGSulDYItE6oMXgyYUOF4rDinCsOpBhPoJaITL52vbNd
         ESWXG5kd1cwk6ocvQ3m7BTg/N9/PK+OyWBPcIgNKEt/HuoXiq/JH94FwjF+BpiaQYbO5
         HCog==
X-Forwarded-Encrypted: i=1; AFNElJ8WZcs30xlPDCdT2idfOC+on7BipDcU1FQLkrlGE8iOZ96DxmAR1Szp2w87dHtsPopC2YevtjWZHDDsVO8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwxtYgpehTjJa+QlgX6BDZRGQDDUnY6/qWtdD0naTkP2XfFaLzc
	QxSbPo6kHq/5Gi7U/pDFv2/CAsqfMHaOKqwBjPqTY8ra/f+uMCFz15bB
X-Gm-Gg: Acq92OEgQ//kQ7WBOA0C+c+c2cYcpXk7bkGdEJcSJ69BcT1cVXPCpdY6B9idZTznUt/
	mybFyEdZPSn7wxkhU+cvQlQIUoSMwt2q/MKs6+ONcoVk3V5+la3iybPsdfNVEfaFcnVmYANJYKQ
	vmnnKT+QzcHRDfjH7Pqm3yi4SSSRZ9Tk/40vtDXOBzJjW+VgNJXnzXNuq5TGP2qHOjVPrxtHJgv
	xDvMSYse5MT6yxVSlz6Fpi4fSgyPXGXB1X0yQ4kZHd3El+E/cz8exjjhLCfa02RERcXs+vk1c1W
	g4BSwKlWuWNMLNBbwm3u8cznfoSKu1r++DxLxzVzvs4Gj+BuxYD271AMe708T+uvh2vvKtkC/qc
	yN9sknCyF8E2z2J1uW82gYfVFMe8llKmxVlNTqDV8lcuC+0RNTJAp57p5i/+8Naha8cLvYfTbnI
	4jtn65tD8hkCfsQkZJ2k5XkQJv4O9IPHIyWrPXTXrX27284GmgpUBcZJ+tlNKwMOh75aKN/mF/l
	jIpdBCHY5+nEbmJLgUoA4pV3QrujBj2sVJpySBTAhJofQ==
X-Received: by 2002:a17:90b:540c:b0:36d:c159:8f11 with SMTP id 98e67ed59e1d1-36dc159997amr5795090a91.26.1780376527983;
        Mon, 01 Jun 2026 22:02:07 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8589d055c7sm8958467a12.9.2026.06.01.22.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 22:02:06 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 7/7] gpio: ppc44x: add MODULE info
Date: Mon,  1 Jun 2026 22:01:31 -0700
Message-ID: <20260602050131.856789-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602050131.856789-1-rosenp@gmail.com>
References: <20260602050131.856789-1-rosenp@gmail.com>
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

Fixes:

ERROR: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-ppc44x.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpio/gpio-ppc44x.o

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpio/gpio-ppc44x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpio-ppc44x.c b/drivers/gpio/gpio-ppc44x.c
index cc7796e0cfbd..425ccbc234c8 100644
--- a/drivers/gpio/gpio-ppc44x.c
+++ b/drivers/gpio/gpio-ppc44x.c
@@ -211,4 +211,7 @@ static struct platform_driver ppc44x_gpio_driver = {
 	},
 };
 
+MODULE_DESCRIPTION("PPC44x gpio driver");
+MODULE_LICENSE("GPL");
+
 module_platform_driver(ppc44x_gpio_driver);
-- 
2.54.0


