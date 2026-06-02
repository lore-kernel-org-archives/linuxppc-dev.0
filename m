Return-Path: <linuxppc-dev+bounces-21834-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAF9CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 05:02:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTzG22HJFz3bs0;
	Tue, 02 Jun 2026 15:02:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780376522;
	cv=none; b=lbv5HbuEbsW6WCPeTLF9YkTLnIy9lrG0m7DqbA6LBbXVzg4uJEts5xq5kw3K+0VJAPKzO++vPAzFDoi5AkZHMzgODjy8dGos8q0Yvdi2wDPx64cVPwLx1wIhXCz3FyFwDvhm6QpWNQBIwHOy17251Ut6sHrwem2GcNxFSsbZGlN6+gZSvG1LqgXnS1ZP2ZuR94BAJGlLqVLWe2cIQBeMbPsQwe4X2N+7IIMwWmkgikQ0kOAcGCzYHkoBJOS6LFu/Myqeu69CcRBlAdVFOYGfaOmp5zO4q8SgNvNRCUCfpOBPB/A3Nb7v3KeuL8ObuiA3tmOT3GkKBefi3uqiwz0D5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780376522; c=relaxed/relaxed;
	bh=JqpZtb3L5AZBzchvpjx7HvUJPGkad1t8dle6FYbZAXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwxUKDFuay1pGabsEzIRSXjCWAJTYy6daNMS67y7z8w/F65+wj95BF4lJqOaP11XID6lJ9Cvm4mX+jdzr1e8GugH+nh33hjCv7/iouJaCcasZJzE/dpfBo7RdEUw9RYmserfrRjnxc9ICWcyD9x1AskByMDQYzGcOGgnVFD4tYXA6uo3Jkb9eF2XSNyCzFyLnAn7acykaIWmVxeie3we93tFOQyVVVCYB0CHQGKuR8DS+33nR2k1/MJr1nMpzaborh2FuBcC8/L/jEGP5x22PArwhS8fSY1cVhcshp3jZocJzDCpUmy0vf0dkd30Gan1hKS6SjOytA3aJuoV3ImaWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IlreeKFk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IlreeKFk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTzG14NWrz2xy3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 15:02:01 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-36bba9a1089so2279595a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 22:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780376520; x=1780981320; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqpZtb3L5AZBzchvpjx7HvUJPGkad1t8dle6FYbZAXY=;
        b=IlreeKFkhL14ylUKhc53K2w9xPLuA2rDLRcee2q3tOmr4xy7TPSgbKW2zdqMIo4IqN
         /DgKz/m9Ud9gTmd4miYRuQ7J2NpYEAw3WitBiW3/quBi33urufWrViUakWpyM75coPJ8
         hQAYuUUNaP0pQBWndsgguhar1tg+d7RrdGw5GGSPd4L31PHEMNFhV3660q3px1+gn6ga
         jqtXp11HJWA8GppZuev3SJ02VpVhWvMCzI2s4BNhqlkv2OazY3i3dM1ZOQcCbc43Txpd
         Y1OTAHk/ToSKfbBHTuYwM59CbJuLcaT3N59I16d31ASAHRzUdPzBd5C7y9suUdM82ffX
         FHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780376520; x=1780981320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JqpZtb3L5AZBzchvpjx7HvUJPGkad1t8dle6FYbZAXY=;
        b=XJ7bDSUvLuCxjj24mvKPhs+Qn8ZPUrhwUjWNY2fkSONMynJ6HeqmqTziAsqGk9BJY3
         sUjHo/hNSi4/uGU9/6eqC0Gy7t0mw0hFRNONJydrf0lQkNoNAT0aK61F+ofOMoigrHL1
         nMk2/JXFDCtFlVnKhQhJgtQWf5F+2hhgt/Sf10eFvXnfjnNjpgvw2TGnvWZwnega/VuS
         stqmTIrczWPX3Rw82+DZTJW8T1XZ48tarhdT+iqQ1+P8Yrvy+138tuJso1C5bxgEo62f
         EPuSgMa9wl0PdK4p3irjAgwT/Jn192mc1U1dhWsxAiuzojUjIk6skT0J2Et0Gxsg6T1q
         Ojlw==
X-Forwarded-Encrypted: i=1; AFNElJ9jbLi5L6rw2jQvdcChGDfCvNXyTK9quHYUi7PYkD5VZwQQYY5K2JZgtNwzN27kSCrG+seP5CpPc7KAkZc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzvotYpwpfB2z/7n+XxluxYDZZgQZ0URu7N85TTzAaOEpEn6L0B
	MjJiXWuPNGbd4HoKnEihZ8Qd+ImJSeGmFdS38rz02IdsetO7/rkihlwp
X-Gm-Gg: Acq92OHeAe4eLroyMyR1FHSA/K6qak4CjJ4pAo5lPCcYxYw4fJqqEJa/DkCnSWmM/sp
	wCoL9PRZuze5D7orewkgjSlRE+zQac6jHCvxIkzZg2i1cumDIPCsfPdeYxE6xeUEOdeMbfqg/Ol
	vcf4S9U53zDsGCkZQeQLp8T78aKvgnOVEmyAV9MepA0jLuRjpZ8rT61eXwCgvmcnPwLDW63HvCi
	JYT9eu/EqMqhr4Roa4u7g87AVsnD5diVjKk5TMnK1fEKS+En4RAs/DhYGQn1stVqd+4pbACzxyy
	XFev6odCtaFT0pV/cJT9zpDz24lJA11uplPlfW/hZXgBlX6nj74k7q5n83/3aLYgfk1BXOGgDoV
	lZ02onbu/g5xQ22vtmTiOpxgMhw75X4b3Io2FlqnWsF5fl3A5uwmnX6T2Py9xFAyOb3zMkPl85B
	KUVXD7Ey87nsru11YtQ0rqPoVkOfV0eFYlurIV6wWmMVmUUtfp0q5Dukwmln1cIsaFnwhVTajpZ
	C1vdb6sUJjibbls7R06HzD3uqX72wgWIrNiqghkzJVl1g==
X-Received: by 2002:a17:90b:354c:b0:369:7f25:cec0 with SMTP id 98e67ed59e1d1-36c2eba615emr9027043a91.0.1780376519593;
        Mon, 01 Jun 2026 22:01:59 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8589d055c7sm8958467a12.9.2026.06.01.22.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 22:01:57 -0700 (PDT)
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
Subject: [PATCH 3/7] gpio: ppc44x: Set GPIO chip firmware node
Date: Mon,  1 Jun 2026 22:01:27 -0700
Message-ID: <20260602050131.856789-4-rosenp@gmail.com>
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

The PPC4xx GPIO driver stopped assigning an explicit firmware node
to the gpio_chip when it moved away from of_mm_gpiochip_add_data().

Restore that association from the platform device so OF GPIO lookup
can match phandles to the registered gpiochip.

Tested on: Cisco MX60W. No more probe deferral.

Assisted-by: Codex:GPT-5.5
Fixes: 1044dbaf2a77 ("powerpc/44x: Change GPIO driver to a proper platform driver")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpio/gpio-ppc44x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-ppc44x.c b/drivers/gpio/gpio-ppc44x.c
index 0d2244272e32..07b699cc4dd9 100644
--- a/drivers/gpio/gpio-ppc44x.c
+++ b/drivers/gpio/gpio-ppc44x.c
@@ -169,6 +169,8 @@ static int ppc4xx_gpio_probe(struct platform_device *ofdev)
 
 	gc = &chip->gc;
 
+	gc->parent = dev;
+	gc->fwnode = dev_fwnode(dev);
 	gc->base = -1;
 	gc->ngpio = 32;
 	gc->direction_input = ppc4xx_gpio_dir_in;
-- 
2.54.0


