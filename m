Return-Path: <linuxppc-dev+bounces-25891-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7949DC5B572
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Aug 2026 13:56:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNHZP6m7Qz2xtt;
	Sun, 16 Aug 2026 23:56:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786817585;
	cv=none; b=Geo0Ec1hvQbzhPS1bIwYQMcShz3B6mEfhnX4ehyimfcGP256YCY8U+YOaMAp2FRu2LGo8xa0u8OEkJlgfT8iK3VJdzfOr+ir4Qw809OCyrCs1XoODsx1t9OPaAg0/+x5+PO4lYNpuu1LTxp5aThd1gb8s7fmfHF5pD35VXtuUFsxFTTOJB8s4oghrWDFU9OGgqJ2GQRMP9yFevtKoLJRj4yZ5iIpvauutHxZUeEJsj54MKcN4EftgP1JpnvCAzLKJQiO1ss4z1W8Dz7UwF9sDHcGlJjxGTDs8lnit0d9ydGMHgAvBnzDFO22duisyhhp02zCTUJhl35cc+tX8TUxbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786817585; c=relaxed/relaxed;
	bh=i7/QgzN5wyVgDaVsVdjpFdimGVN0rJBMi0oSVa7MqkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQ4QPE2p2brH4jLv4v0bqNHSrf+l+Y63KP/qkqvHNYNTun+ibjtdikU/RZu6VkL12/2Me+kSiFyCd2lPbbl/DWEEN9XqaVWTbbNa4VD2s0CWUNRMKVakwdO7DFnPBSSow4f95gmI1qggyqsdRWQ/2ZhG9SjNH03wv3k+NXgzmFpadD5DDx8X6KqbIYkbSaK7LH+P0bmo+KnBShynSAvPV/INS2UulFGB1QJsq11+CEHXByplw3zdC8yo5Dd7y3PFNSJGXibHRvJ/Vdc5QUpOxwrGNIf793coqIegwj/VNnZIUc9Wz0iSry6AmyE3Bnx7ozUD90ydiYE/8GZ2oCtBsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZvL5daH9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=dragonliu2018@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZvL5daH9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=dragonliu2018@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hMnJc2HGDz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Aug 2026 04:13:04 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-381b831d535so3224640a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 11:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786817582; x=1787422382; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i7/QgzN5wyVgDaVsVdjpFdimGVN0rJBMi0oSVa7MqkE=;
        b=ZvL5daH9Ki0yWj1qeuHZYI+MHDbeMtWY+0ASf2wiULKjBmIJQykKo0u0m6OJ/O/muH
         mXFxqcgJJ7lSuxySQl5kuEZ+53dZsWpR1AHk/z2G18bbn4Un0rR1h2EScbe1xGf3XMdZ
         jQWCfY5aFmz5/zrVZpNidhNkrPXv89fV3QCgOY1hlGh5D3/X9zVGZbnJhHRXzi4MpDKn
         FVrbKdsOHEgzBkw2xkFHyR7gwHHVN5wqBl8DJtfvibNHqUkIhdwlCAhZ9yGIdHz+zxak
         DBiCx6Grv+sQ3wfikhrywrk9eaVDuIopWWkDivi5c8CXASSGbE7M4wbIl1BYcezV1xCE
         phcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786817582; x=1787422382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i7/QgzN5wyVgDaVsVdjpFdimGVN0rJBMi0oSVa7MqkE=;
        b=MhBjIky3/K46ZEgKGLXTX6rZq3z0V+V4k9o7ULEvLOwgxx7r/eoVOvy4TILTchz0NA
         khFdQlWspyvRbgmv8yfpHTBCe2Yui0dwgBEdZ2+vveOzHm0UgfjmFCf5Pxw8BRMs8kWf
         MN3l86tUFHdR9hmVPXV/EFCiZ/y2AyiwBere9YAWL16Yu3R3Vo/aF7CprxTNxtcV+l0M
         cOtvx4a9Zp2FztiFETxiByX8D9KTOUjZK79L6HTZg3cr3aUHdFT+D881Tm40BGeUF7Jd
         OavLBlIUjlAAraxQFLEtYkaKUN7/0jXQQr/A6dRJKF1/B1QiD6d4JktYTAuUlAOs6yEy
         yjQQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq6Zf6kHSl5j44GRsHN9YhCoV8B+Y9wBfaSM1tUWE2CBQix653WQHg5pheNLNDc3apDYvi0pq+725grsEs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzyiG/EY0AOgPXhXZT9tu5eAEZfAE+3/lrYY8IghGhTci+2LlHC
	lDe3tTWfHFSVq7fwhEPCjRC0paVJyPJe44uuC9CRv2DL2fgn7C9xvPBn
X-Gm-Gg: AR+sD10d/C00hxiDUWSAt1ytv6+kXbAsa5oWfw5RQThTzLsBaprEu/RhKQG3X9JKfKN
	tjrm50oJ0jhcg/H23c2XSH+zG6CVNK6zINrkgHQeJu718G/FiF1CvF60ueK2BtZlI9gBJ7nhC3Y
	GSH9j7ESjYcNa/ZXBZAdWrHT0yh6oMTnwElmJAGyinhmgyVs0uyc1aNdsZwPUJJ5NdqnUwX1ATJ
	MRXOf42ZLD0Sp/apSynowSEP2mtxWzRS4z9DucjdUQPmjU9R6gw7PIQVO45mNTd8fbLJmxEIQpZ
	0qvQNapI9FlMsBjZjSLwgujONdo99GzHffoKxSLAv8hCd7ERbO2vjl0hr3/SCPGlXlQk2h4ePP0
	a1FsXHHYHgVZsFvayZiNv8xFpJch5tPUv1Xl+5Vx+bznYWpkXsYoGbIh6yNMyUqt3Tw5lKVgZLF
	ya4ZE0Dzw5Gt5FP9O++CdUVH7Fd0YphgPzJ0GxbjJr7YKIsy2I9ZJe/9lC/5PasgoMbiUn/Vey/
	peFlGHe78CLpLw0d5ptR9xRZR4=
X-Received: by 2002:a17:90b:2747:b0:38e:2f21:3bb5 with SMTP id 98e67ed59e1d1-3933baa0da9mr17205808a91.21.1786817581938;
        Sat, 15 Aug 2026 11:13:01 -0700 (PDT)
Received: from localhost.localdomain ([240a:4280:4800:6ace:25e8:2607:e94d:caaf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eb7539d3sm7304254a91.15.2026.08.15.11.12.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 11:13:01 -0700 (PDT)
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
Subject: [PATCH 2/5] i2c: cpm: fix device_node refcount leak in cpm_i2c_probe()/cpm_i2c_remove()
Date: Sun, 16 Aug 2026 02:12:01 +0800
Message-ID: <20260815181204.2321-3-dragonliu2018@gmail.com>
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

cpm_i2c_probe() calls of_node_get() to take an extra reference on the
platform device's of_node when assigning it to the adapter device, but
neither the probe error paths nor cpm_i2c_remove() drops it.

device_release() does not call of_node_put() and i2c_adapter_dev_release()
only completes a struct, so the extra reference is never released, leaking
the device_node on every probe failure and every adapter removal.

Add the matching of_node_put() to the probe error cleanup (out_free, which
covers both the cpm_i2c_setup() and i2c_add_numbered_adapter() failure
paths, neither of which runs i2c_del_adapter()) and to cpm_i2c_remove().

In cpm_i2c_remove(), i2c_del_adapter() clears adap->dev with memset() at
the end (commit bd4bc3dbded9 ("i2c: Clear i2c_adapter.dev on adapter
removal")), which zeroes adap->dev.of_node before of_node_put() runs.
Cache the pointer before calling i2c_del_adapter(), the same approach
used in i2c-mux (i2c_mux_del_adapters) and mtd (commit 56570bdad5e3
("mtd: core: Fix refcount error in del_mtd_device()")).

Compile-tested with gcc-powerpc-linux-gnu on tqm8xx defconfig; no
hardware available for runtime testing.

Fixes: 9fd049927ccb ("of/i2c: Generalize OF support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
---
 drivers/i2c/busses/i2c-cpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 2cb6a233d313..08e33db32f14 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -671,6 +671,7 @@ static int cpm_i2c_probe(struct platform_device *ofdev)
 out_shut:
 	cpm_i2c_shutdown(cpm);
 out_free:
+	of_node_put(cpm->adap.dev.of_node);
 	kfree(cpm);
 
 	return result;
@@ -679,9 +680,11 @@ static int cpm_i2c_probe(struct platform_device *ofdev)
 static void cpm_i2c_remove(struct platform_device *ofdev)
 {
 	struct cpm_i2c *cpm = platform_get_drvdata(ofdev);
+	struct device_node *node = cpm->adap.dev.of_node;
 
 	i2c_del_adapter(&cpm->adap);
 
+	of_node_put(node);
 	cpm_i2c_shutdown(cpm);
 
 	kfree(cpm);
-- 
2.55.0


