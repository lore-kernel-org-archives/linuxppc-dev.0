Return-Path: <linuxppc-dev+bounces-25890-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541C9C5DF70
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Aug 2026 13:56:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNHZD2vFyz2xT6;
	Sun, 16 Aug 2026 23:56:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786817571;
	cv=none; b=cTxlQGx4pUX88avWjckE8dhFIBEDwwz6MYrzW6o1WfcD9+xJdXdVgj+34/vgYv16t3mK540YL9Fno0IGsAWi633OhcJZyIGdDrFx1IyMBUszSK/eAZpNhdmMb+JM0ABdr+UQLu/ttcUogWW1MbkGZUCsWteETKipiJV2FwHEXiutN8Ku2d1sUpc4l05HZPD/UMFYTImAUZqjailpO1lPpF9DZQeBKwgE68oF2Bb66ygzDDECp4S87tJX7O0hCpYUpSxcExZ8lW09p84R3d7rEequJ/z72uKFrQXKqcTduh4BOP7OTCriWBpOmxV8/OeULwiP/YUqUxdl8R9HbuAkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786817571; c=relaxed/relaxed;
	bh=Uq/zXomRaUtmPVU0X/7Fe7/2pJ+viXdEE1hutqkzih4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHH2YW8stFlVtifv1zdB1/WHCVA9oHRdG3rYTl5ODfg0HxxrDRc/2NnhOh3eudFhbX21WRs5K+nVF/EmW6bgQF5GMY9MkB4I5+LHF3Qi29MIPrEH0RW6IB1HypKp/aUilTXxmjIQCIdXcpYp4B4XF7nqOubumwPx5VED7XeYwyXkSo0gjTN0nPRU7xh0ZSNN5DD9H0/VpG8+oEHLFBPualO7gZGyue1yv6hnuBjPUn3thK5ltXO5ThFLdt83O5k+7SfqtIvlpksx+0nR/TVvVVPMJirOZ4+lDf1EnLrkLkRTWPadq22eMQza7mqSS6yJZJ3pe3nw4FLIYdsQL+JT/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o4reCyuk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=dragonliu2018@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o4reCyuk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=dragonliu2018@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hMnJL67GSz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Aug 2026 04:12:50 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2cf452def93so24898425ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 11:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786817568; x=1787422368; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uq/zXomRaUtmPVU0X/7Fe7/2pJ+viXdEE1hutqkzih4=;
        b=o4reCyukND3i8u3ZYuM3dLfsduJmyXiyW7EmNgJvAjs4PYNfcVkv33mY1fFAgmeq6m
         Wk1CDYzsZatRqARYclWQUDSju1h2+d1S58plZ6YwPn00sJq19G3zkbdFLczTeXAJj0Op
         xZwNFUTwmNETPA0M8WZQTjRMRstSptncjLR5DLQbUiyBo3WcFuTiT1/bQsLfMYsrjtOf
         aTUmqqqYO1pviAYPwlFwMXNgAtkYl/fHKeFtgPSStjKrJdvXucNq3tVvlsdsinDMM2Zn
         dfCipYAn+q1k346xEHB+vENrMcuc1f5stbDuzzsHiKzsGaKVgHTYiQLVKyJ1OJ616BE5
         ah9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786817568; x=1787422368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uq/zXomRaUtmPVU0X/7Fe7/2pJ+viXdEE1hutqkzih4=;
        b=RqoB3vNJrGR3slTnFA96SrGGnJ0cYO13URTNIsMwWoZtYnusXAn3eA2OUED0wSOTqj
         0huBaXj9ezU8e27r0WbiUD8nVyktOImDboeKD26ztT/0ncwc+V4A+qRSLBEaIJslWfT8
         EAtSecjatz8JIUxsJKxWlsDlcRokEQOs0rKoAdWIFR/SSPXY0MwtMrbfUvONNj/r9r/f
         PfooT/WQ0IfuNCzHu2x1RblG0KROU2GxHOyNd4921VsqMaE/TlNdXdfBQu4edvvOVVwO
         pdu/9oR6goKBV5Pth7gWcAkwvBNVMVmjquz4d92TYfr5UAc1DIBUwdoGzwLd5EuXloeC
         3MVQ==
X-Forwarded-Encrypted: i=1; AHgh+RrDyEGZGz0fK67vn3zoXBqUoVJ2G3Jv7xxqH0K+zweOhKu/LNIMgXAmyHJPI325f1COt8FHCisJxDTwrsM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzca2fUeC3PDJG6rVmVKA6b9Vs7I+HVd2Qa9EjFXtWT1PcW8Ozg
	S1n5yJZ8sy95T76OVMKkDo/Rah5vdl3oViB5EzKveA9cnmVBzgOTTDu/
X-Gm-Gg: AR+sD10wp3Y2HhmpYqaCYQF1Zy9w7NgLLC28ITDdESTDpA6OTVR6P1JA0vzsT31qpem
	29iNn3BTFh+eXqUNJ2G2l/iPxtQW/Q4VnsRC16MXWUd9IyY6nUZ2VHVO6Y5weETHszfQTP/pbQK
	D+Vk0mnOt8lztH0vmV/gRHG4dqHFLKt8qiBzDzecyg7ceYei1hom7u+vHxQd47BRN/i0ntzmSXu
	d1Tf3t9nUhHa7x1hS4P9nSE+Mhlor3EFXP5EpQzWZ0tnsLmB1xuJ3obszV/1ZGLdlCc5ecybnMn
	9PqJ47RVHHgVoyXNHf4OkH5dvKw6+imMMDEa2f5ezFjhJS16ZOLaVVb7npWloeWypN18dCBwhP1
	2GfHNuCueXyY/kzgw1bcVCPk09sdLhjTaSaQMVSzmiPpHhQn8hNHH2HYurnn3VoT7UPkdfyUWjN
	bqjzbjFljlm/frM0iHNR4BkXT4VUq4Q4S2Vl4x8QsLgi2uXBJZ+3A7VWz4Tyyl9+kBDLywF12cj
	u1h9McitULxhNzwFLPeLBpCS8Q=
X-Received: by 2002:a17:90b:1b43:b0:38e:9ca8:e99 with SMTP id 98e67ed59e1d1-3933af8b5d7mr10385225a91.5.1786817568272;
        Sat, 15 Aug 2026 11:12:48 -0700 (PDT)
Received: from localhost.localdomain ([240a:4280:4800:6ace:25e8:2607:e94d:caaf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eb7539d3sm7304254a91.15.2026.08.15.11.12.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 11:12:46 -0700 (PDT)
From: Liu Zhenlong <dragonliu2018@gmail.com>
To: andi.shyti@kernel.org,
	chris.packham@alliedtelesis.co.nz,
	jochen@scram.de,
	maddy@linux.ibm.com,
	vz@mleia.com,
	piotr.wojtaszczyk@timesys.com
Cc: mpe@ellerman.id.uk,
	npiggin@gmail.com,
	chleroy@kernel.org,
	grant.likely@secretlab.ca,
	neelegup@linux.vnet.ibm.com,
	benh@kernel.crashing.org,
	wsa@kernel.org,
	stigge@antcom.de,
	linux-i2c@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Liu Zhenlong <dragonliu2018@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] i2c: mpc: fix device_node refcount leak in fsl_i2c_probe()/fsl_i2c_remove()
Date: Sun, 16 Aug 2026 02:12:00 +0800
Message-ID: <20260815181204.2321-2-dragonliu2018@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815181204.2321-1-dragonliu2018@gmail.com>
References: <20260815181204.2321-1-dragonliu2018@gmail.com>
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

fsl_i2c_probe() calls of_node_get() to take an extra reference on the
platform device's of_node when assigning it to the adapter device, but
neither the probe error path nor fsl_i2c_remove() drops it.

device_release() does not call of_node_put() and i2c_adapter_dev_release()
only completes a struct, so the extra reference is never released, leaking
the device_node on every probe failure and every adapter removal.

Add the matching of_node_put() to both paths.

In the probe error path, i2c_add_numbered_adapter() failure does not run
i2c_del_adapter(), so of_node_put(i2c->adap.dev.of_node) is safe.

In fsl_i2c_remove(), i2c_del_adapter() clears adap->dev with memset() at
the end (commit bd4bc3dbded9 ("i2c: Clear i2c_adapter.dev on adapter
removal")), which zeroes adap->dev.of_node before of_node_put() runs,
turning it into a no-op.  Cache the pointer before calling
i2c_del_adapter(), the same approach used in i2c-mux
(i2c_mux_del_adapters) and mtd (commit 56570bdad5e3 ("mtd: core: Fix
refcount error in del_mtd_device()")).

Compile-tested with gcc-powerpc-linux-gnu on pmac32 defconfig; no
hardware available for runtime testing.

Fixes: 9fd049927ccb ("of/i2c: Generalize OF support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
---
 drivers/i2c/busses/i2c-mpc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index a21fa45bd64c..8182f7dc3d0f 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -867,8 +867,10 @@ static int fsl_i2c_probe(struct platform_device *op)
 	i2c_set_adapdata(&i2c->adap, i2c);
 
 	result = i2c_add_numbered_adapter(&i2c->adap);
-	if (result)
+	if (result) {
+		of_node_put(i2c->adap.dev.of_node);
 		return result;
+	}
 
 	return 0;
 };
@@ -876,8 +878,10 @@ static int fsl_i2c_probe(struct platform_device *op)
 static void fsl_i2c_remove(struct platform_device *op)
 {
 	struct mpc_i2c *i2c = platform_get_drvdata(op);
+	struct device_node *node = i2c->adap.dev.of_node;
 
 	i2c_del_adapter(&i2c->adap);
+	of_node_put(node);
 };
 
 static int __maybe_unused mpc_i2c_suspend(struct device *dev)
-- 
2.55.0


