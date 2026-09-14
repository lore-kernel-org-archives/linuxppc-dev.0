Return-Path: <linuxppc-dev+bounces-27220-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C5CC88E72
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:14:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hk6by1Bvbz2yd7;
	Tue, 15 Sep 2026 00:14:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789395294;
	cv=none; b=T6IN55LcbTp+yhHiUEZ2eNneKOEVeRE46FpYgqVJvV/w3dGqHZbOa9NpZxJO5dWew3CaORshPNUMrlsIYcOSAytejyI2fzBLBl8z3CgHwzbPJhwdv8QtZ1D8I30pncOw8i1kQ51YOvKRFRIBu1AeQViO26aqimYb/q5QTzxC6vUxj6aOJV8Zw+YlJd42Z80dSAgYRGX6MIQxNqa3Kb2xqdC++8XMJUPplbEe5FwOozAUNrqOSx5kadjnFLFbE3BuEX8E6RYlXaLzILcqj2fcVpTNP9MNBw7NR2XU8fBRs3S2I2sY2C5RpWZy4eNEUS5Y0ker1zT+vh5sx2G6t93j/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789395294; c=relaxed/relaxed;
	bh=iowTzUN7eF2XmcFkQ3hjfDXclmIIX6foUfmhSB0uTUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RwgmRlsPeXqCjgd/wd3QBQ3cZ3pzetZA6naPDUxvgdXbd7h/TZK0cyEl5upGSA6i7Hggf8J2S3h/L2MI0nZld4cvh2XpRYrvAtshJUAFxKWjaNddNMNXS9SzII7wvrIVkbPEmrktc2hxix/hQJX4dzYQ1jqBwfQalP8QRCcYVHYXgox2E/VW/St8ZoE7gCGtIY0S9UvKwtsdlKJH//gxwZ+elzxRvYiAcR+LrzTZxm1vPk37rYhOnL35Cw4xA3gk979vCN6mTxuau1WjIabysBap6EgiXayFGA799OJR7TxPVepA91V18cA7VUmS5MYzRROkFUgwfp6QdrDJ73R8NQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QLYY+r4a; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QLYY+r4a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hk6bw2y1Yz2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 00:14:50 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so1753408a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789395287; x=1790000087; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iowTzUN7eF2XmcFkQ3hjfDXclmIIX6foUfmhSB0uTUM=;
        b=QLYY+r4ay6gdixmCxrxCVy+TKFUd/gu68EjkhdZZB9tCS7GogQv3gv20UxXkfyGy1W
         QnyCfhTWUrZGKtcnJLh4i4XCSkbXG+zB2nHPMIiyHxLLNcqkPSkEmcLsYTC6zxk5c3GW
         wgHLCxalpYRdETo4djbeLpVBqUpAiPz/t+1Zi7Ke9s2GbU1Wkv24skqh/xUwYsH/OX5h
         T5cS04HGqrHRR2jaDPUmQbsZPAebExv7k/jUL83xMnunU3ToeW1ayPfsAkmvOSgtlJE/
         5kgVEZKRGUI9HYT7gFnpXRqnWssQosIFrJyqwvsELW4+x1ptCEPWmt0NbmIKMnA2NpWo
         8RgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789395287; x=1790000087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iowTzUN7eF2XmcFkQ3hjfDXclmIIX6foUfmhSB0uTUM=;
        b=pzO8ch+b2Ljm9Weua8BNfvzXGPDxYGKn/gucGB4Vq4fUFg69EcGznKPdtrWhBh+bfX
         Z63u2fng4WSqWuPqkvJHB78j7ZwJz6rBVLd4cZo2dYJ9hcsCUIb5rkcEhtv7lT1KJSiM
         JPxgbQ1Ju3HLG4gusJB4wByAVVOvmaLiwUHYGhgEAnyFsoAe1Rpwd4l+XkI0rHf5VEt8
         xbBz8SXtonVi4c4LMI6e7w0LXgeNaEuj/TkSiYiYGIqxf0xYXBN0tn6bkBxXQZooQmK+
         tu5VN51Ix+KEHoFMhfzyuBEbt2k1hcjylAA45jlGUrWyhw+CLlY9p54FWUOGSblEknSo
         xyTQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXSC7UqC+W11ZDgDqvivteW3/Gy0JNG21s2x0R/qSUzDUHhhFgQ1gNwa19XE5ODsIQt0ZUohTBmwVwawM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kQVi9V8f8wspFI+K+sle78Zt0o5e7LqbHKg6BJhbO5r7OlYp6g
	bm7CAQrtObQpaEbpG+nOgMQz5vp9i02vbmc8+VlDuZWn49n/SzHdSYj5
X-Gm-Gg: AYBFou03GKRLPXYcM9b51Dc6+VTxIC70g7RqSz6vqzPjy/LzeuElKeJgnJ/3SExbQpp
	om+vySwmZT1PwXbaF4ONnFR2E7vvNbSJ7wagYySfLSN1FK3UTLllku/yyiDDobYaopmCGG/Svq7
	9tunnjJQbFPFUJne8OpfeDL3d9qZTgiJsLo1Kf4a7oTeuhELO8w5GJsbTOY2YB7k/HOhlglophx
	WyRV5HZeuEMoHimUlbDgYs4xrxOyuOnh54zNbmiDauMF9P3tWLX9A2uCEv5srzLUx967Zjdu5AB
	PI/mfrEwHrPKpm21//jUzBsTivpG2P5A4dEzasMCyuI80aWbJvHxnvApiRSu81tNtPsvjv73EVi
	XWrW0E9Oa/sfqxw6jHVZjEZ9P/JQHAm4D8oRuNh40O0RfAFOIbXyWQMxyfXcg4G7VMlPqPfE8z2
	WRJGdx9iQg0sosAm40qt+taVlRk2x3qrx5nrvjLwsHgyaBR6s6XtgDXw==
X-Received: by 2002:a17:90b:2809:b0:39d:f2b0:5afd with SMTP id 98e67ed59e1d1-39df2b05b4emr3473390a91.2.1789395287409;
        Mon, 14 Sep 2026 07:14:47 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6549ec0sm5166288a12.15.2026.09.14.07.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:14:46 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@ozlabs.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] macintosh: rack-meter: fix i2s device node reference leak
Date: Mon, 14 Sep 2026 22:14:36 +0800
Message-ID: <20260914141436.1745138-1-lgs201920130244@gmail.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rackmeter_probe() obtains a reference to the i2s-a child node while
iterating over the device tree children. Since the loop exits with
break when the matching node is found, the reference to i2s remains
held by the caller.

The probe error paths correctly release both i2s and np, but the
successful probe path only releases np. This leaks the i2s device node
reference each time the driver is successfully bound.

The i2s node is only needed during probe, including by
rackmeter_setup_i2s(), and is not used after initialization has
completed. Drop its reference before returning successfully from
probe.

This issue was found by manual code inspection.

Fixes: 3e00a5aec3d6 ("[POWERPC] Xserve cpu-meter driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/macintosh/rack-meter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 26cb93191ede..c1c6d97d5013 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -496,6 +496,7 @@ static int rackmeter_probe(struct macio_dev* mdev,
 		goto bail_stop_dma;
 	}
 	of_node_put(np);
+	of_node_put(i2s);
 	return 0;
 
  bail_stop_dma:
-- 
2.43.0


