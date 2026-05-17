Return-Path: <linuxppc-dev+bounces-21003-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6A2CD37AC
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 May 2026 06:38:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJB8Q65clz2xVK;
	Sun, 17 May 2026 16:38:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778999894;
	cv=none; b=GfO3badx/3x3ZkWTjjDLBo46HvHMOS11hD6GJM/YDlLq8Rbxyw4J7f6TqAOiK5RT0YKY6gH2QPU8VnbqfiNwh2Z2vqBLhLGdAuwzWqEVGz5LlDHYMgZP5EObZmK4VCMPVo6LOki1POTeBDBQKoadNsDW36lampbe8oTOJvon3Zifg7dkoiQ5ewK2mwkv5eZ4VWXRfMy30VRDB5L74Pea/jdDOr/rKSCCsQmoO5z8iGWuhcW/NgcmIh5h4JsFynVQJel0QkZwblmY3NmUe+XxO4iEieYsF0jOGthos7+AiwxYsP0eywlP49mhaI1X4luNd29NwPDgUn6PNORnOvhJ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778999894; c=relaxed/relaxed;
	bh=+ZFzf44Sk919984SFOAGa+1CUGlhHfu7QzgvuomImAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HGvQ1cqxm3T2mbnLwPOwzTlE5otj9xDqgZdhT6Veo97veotipz75DLDoOK36IVDZCZJT6HJ0IJHcVlN7dcL/eeAhm/9HoNvXdrgGrjQJwQyVdsXpXrZE37tFTGPstW/oNJnPqtlgkfNqOhGIq7WGQF7WB/Dz0jY68v5PbUJeEv5bSGGbeHWqIv+T3zPtmVsIMV9kzjAnN1bmwlsR5fXOVl14VlVxGbumUoFy8iFZuJ3NpHn8IWfnsYtPbMPzwH3F3h5hJeMMsfXpBx1uNgzia9DqHQmhfuR4O/yA/GW7vp0uQDfghZVYuzsl7YPXxNogA/eS1zu+nuSlx+/SAsfvgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Imbu2gpD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Imbu2gpD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJB8P657fz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2026 16:38:13 +1000 (AEST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-c827313dac0so942325a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 23:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778999891; x=1779604691; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZFzf44Sk919984SFOAGa+1CUGlhHfu7QzgvuomImAE=;
        b=Imbu2gpD2XzCeSj4ZHjFc3Ez//psoMxYPlwhFvNL4HpHZDV+FEER5M6xLS09gS5lKO
         cYqs7Hx6wkQF9jjPj3gK6lZozKfa4LMcAxuP88d4DbopqKeLg46VQrYH0Kpb88sWBNEh
         1hwdqRLQjTM3tLoaBEfpwbyLl5XduP+NnLKVglPxZ9daa4xSo3w8qLEz5bQw0wc+OnNt
         DTqFRbXb7mrMcZJZmXhFQBv5VI9wIv24k1XHupiHrr3BnlX85nLugw5uwab4fcSI+nId
         vlc88m/BreZOh1+C+86glSKud2uVrqbBNL6qrozespWqM4HJp9L41T3mZ175AMJaGps8
         1Yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999891; x=1779604691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZFzf44Sk919984SFOAGa+1CUGlhHfu7QzgvuomImAE=;
        b=I5btlDGX2Mz2mHdTA+mJakGbZ1uU6GJLDVyyibYcQSx5sOu1m2etCa/uBUsb/BMqEj
         yxLenR7cVto+kdBo9lAJOkizHUUaQrugsmZpgiW4xVFEbKt33+7qD9fHyUgra6mR1aJf
         yeNelN6UtZjsa4blVQ/jFxKBqJoQJgog9x5l/g7Cirh6p/vxiTgMHWDPBeCcBxlJJUfx
         m8dy1x4Wh4FMFmO3f2D6a+M1nam8/wkQ6ayJ7fJ5kaVnNYlkjPMbSjSVBBfDC16gh3z5
         W0L5qb7mTd321LJRnz5e3cDSmdBrp1Q4YgIkQNLs6h1xylwneOErbetjbQfwm5/tR7o/
         a9lA==
X-Gm-Message-State: AOJu0YzkJZWMcm8iOqjFeqWsoa2XQgEJ3+PDnkOcKqxd2p6S3FTAvoeL
	1OzY9JXJlzEzeynvF92EtoGvkeOYBBsVMkfw8sQBcJXWsjYTl8HVgeZqw/TKbA==
X-Gm-Gg: Acq92OHXzpgfj2LFHa7NHP0Qt0k9rR6wOv8lpJIvyRht1JxRQ+D1X5RjZsTaI2wfkLb
	vGysm1BNpz7g4Qiq49lvm7h+4aKjRAwvhYieuWCwEiCvFoEqQIpJJKS6zG2ky5E+7gLxQhNpfVi
	edTGcTQe2BKBuoSUTzdDFVWL6wiVMFHE07IzTLE63pz0p2YE0CaeidW8sbFzAbuP8tgoS3q7xdw
	w0Da1zONx8phQqb7us/crybC6jb4Tl0gTAlxLDyIuYmjAMmnbEqdntf1JZ305UZ0m0dQk9i7t3T
	+RnVOi6E5qLZq1GiPOokp72uZ4K5+vQ4VIoXpiEdNazl8dPYtZeGmASMfCZThSOZMadAcYXytjJ
	PqtxssU6CgAOXGU0/mRJSHIpRuaD801kCdjLC6mYq9wK4fIcCrhDDQk+L6P4ixZ3CUAjXmVSfF3
	GVYasXGxYi3pSDPeSmcnhpvwyNwaZVBaVYQAv4Xbk7JX9dP/EjHbHwwEYjGGrJ0BbVIwS6YdMKv
	C65AuVJLnKktTXaRm6jbKpsZCfKeqfyyFU=
X-Received: by 2002:a17:902:7d95:b0:24b:1585:6350 with SMTP id d9443c01a7336-2bd7e8bd1b1mr70639835ad.11.1778999891193;
        Sat, 16 May 2026 23:38:11 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c0600c3sm108534975ad.29.2026.05.16.23.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:38:10 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] powerpc/44x: Set GPIO chip parent
Date: Sat, 16 May 2026 23:37:54 -0700
Message-ID: <20260517063754.21819-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

The PPC4xx GPIO driver stopped assigning an explicit parent
to the gpio_chip when it moved away from of_mm_gpiochip_add_data().

Restore that association from the platform device so OF GPIO lookup
can match phandles to the registered gpiochip.

Tested on: Cisco MX60W. No more probe deferral.

Assisted-by: Codex:GPT-5.5
Fixes: 1044dbaf2a77 ("powerpc/44x: Change GPIO driver to a proper platform driver")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/powerpc/platforms/44x/gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/44x/gpio.c b/arch/powerpc/platforms/44x/gpio.c
index aea0d913b59d..4413a94cf7a6 100644
--- a/arch/powerpc/platforms/44x/gpio.c
+++ b/arch/powerpc/platforms/44x/gpio.c
@@ -169,6 +169,7 @@ static int ppc4xx_gpio_probe(struct platform_device *ofdev)
 
 	gc = &chip->gc;
 
+	gc->parent = dev;
 	gc->base = -1;
 	gc->ngpio = 32;
 	gc->direction_input = ppc4xx_gpio_dir_in;
-- 
2.54.0


