Return-Path: <linuxppc-dev+bounces-25894-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381A6C5DF70
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Aug 2026 13:57:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNHZp59dLz2yS6;
	Sun, 16 Aug 2026 23:57:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786817621;
	cv=none; b=jK9P67FBrFm+R5QtEdgwq7JHgNH7a4cxL48klpm8R+Patsn5tCCG3CuVaqNsA4SMn/S0inrzIHpMM+S2Dh1OeOEFLhbVxKPGwY3MGI1nKgxN4kcGnUOS83NmQHAl3qFfijwS9+8IIOmEg1WbWAH3aN88sFPDTH0anH8mVCQGWfW1GL7mCsy9oXvmdxgF8GfuQMXs+255YsIh/Xmv2pUTeSm2tZW2Ek0nAKAmvcEJ4EGAy8Jj/AttMpaTRxExuU0NrfGV5tsrKETPKhZ2DmxwEOqSUiWqsclLj1ooKM8yVoooKLWEnxs0C3KMLl8sqWnCscFwn+XGESkmroCIM0391w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786817621; c=relaxed/relaxed;
	bh=V91oZrI/zJYRrYjWs8UIHznDrCj9rfvAd4MAMUD9J1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arwmwWRsc62OVGISTjsLmB73SUHxAxZ/hBO+KMsiywxWSZvDtxZVT5Zmv157cz9l3wqmmQcbFwNBCouZrNZ6oA/EEhTtHko5Zt+9nxNxcSr9REal1wZacZ8/DeRRDHQn35GT7pCd6VkSsHX9c1Go4AyuzuxmnaTEEKUeupVHzQ3gPwQdzXOVL871vbVARx0sbt6rBLoRYJk+xHho9tTMjksJdXhWPoGHIdaky4Px7YJ6cLzdbe6yjzoqnouUF8NfvufsfGY71PBt0iMF73XyWskss0n+hkhMOxHazEEQeQHyhFZFs9cmdzV4BaHlCB+Z3Fo9N5Ivd2AXgslcfNN6Cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RTKXwa0Z; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=dragonliu2018@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RTKXwa0Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=dragonliu2018@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hMnKJ4klDz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Aug 2026 04:13:40 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-38e58034d05so1765411a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 11:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786817618; x=1787422418; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V91oZrI/zJYRrYjWs8UIHznDrCj9rfvAd4MAMUD9J1o=;
        b=RTKXwa0ZWIHMpwoBL7cZoFgL4SAZ4OrrphdROfpUT3p5jw3G5Umfxd6E9eQs6v4pOG
         qhQyTUnUZlr6NESjKEaoF8Gw5OnGX7UxZ75mCiZLBySZK6s9tjlx5Cns0eJTDz5uerrw
         8hMfGObUozaJ+dE07sn+73ULVNb5dKZuk/zRCE6An1pm9Y2oUs4/NC8OOdcuhFWo5xMu
         GWptzbDbB6/IIOquUX5A2lLlTKdxYLU2Bb2QSGQjCqnx/TkCMp1M0vcfPtrkbfWlQZ2d
         3pWyKB3HPqJP6F3hqrNJgqJltFYCxbB9Tjtslf7vxtA+ssfAUkX5sokcsKTgIRBcdbPK
         zIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786817618; x=1787422418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V91oZrI/zJYRrYjWs8UIHznDrCj9rfvAd4MAMUD9J1o=;
        b=NlC+6BpPKWQKN4Sm/iGNnLBQVw0w+oesp+yNYsqDScPFQUx9aLFICNm6AXUcVVQwqo
         0XoCeQG8gKCYRGHPOBfppKnYIF/6NLONYTMTQJ31mJIFoH4dUMHVmm2scj7u4UGKwosj
         8ZuioKwIqHX4xQnwm19DX35R2AeLS4aIrcvTqjgZ7FR4K+J6gt3MwflLKGzpgEd2qipC
         KhS8a4z2PO+lirhikytXWGif17jlCKWz4TPr0Yg0HVqsVgLk9HAgphUNULDXxSL3aa25
         996ahEOo5d/hwrI4FBEl4ha9KfJtxgz7T0p1B4MlChL4Z05RBdniLHUl6hb2AjzxzAIr
         qGOg==
X-Forwarded-Encrypted: i=1; AHgh+RpOcKSy54IUVWtGI3KPbqosMXe+QPHYkbhvv0+5i5hPxSm8dQKL14cOj6teNX7cPjQGig0M25gNZ4naPjY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwFgTep75TmQu5xS9ylYyxknUUvKtdY0GubugLEr4XOqNqjQ5Au
	x3OfPoKkra03oktLdRTu1jfr3d8naC8km+KAFcZy5ChnuMpteq1Lm4Mw
X-Gm-Gg: AR+sD11jRXpeK5AYlzvO2+8f+W4tUItS4Rrv1Lbg257kZBN637NoR+ufbJDmQeJqEEC
	WFDEDC4eeBCn8Il7MZ8UcGEfDiZC9pX32+SyCNVZcutRRXc11bdqEzORO3D3ZckTcC+b7Zd3KMg
	Uo/39+kU5Ohkrtftx0GPU8tOHLDvaeaMpdJwuCOBzYCToZw452lFzAQ/42HeqpY6zsqyuwsA7XR
	p05KBZ38569bsD9zKTSgGkJyPD+f+lhen6v/7JXO5eZ3e+PeuMifh9zVgEGbZSGao5dFsZE8yZ9
	yVinEW2xq/pwkkH1zdiwa3UDG45UljOiTbOvRxa2LvfOVWmMv3a9Aj9Qn3968kvrAXkpMuoA0gB
	c1x/XHeGrNzWZSG+VCk+ranMM+mEqrvK+yp5mq8PZMTEVecV4AKYq384Jzd4ONef3A6rnaY3PW6
	GNqQ44KufR3MnbrEg2u+99AS4mHAlcQK35vCiy7aQS5h4ESYPYehLtiwhvMelB6tS9JrQTrYiDD
	GA278fBr8C0/EMDYS+//ZEYhhM=
X-Received: by 2002:a17:90b:1b05:b0:380:873:49cb with SMTP id 98e67ed59e1d1-3933baa0d6amr14788639a91.21.1786817618461;
        Sat, 15 Aug 2026 11:13:38 -0700 (PDT)
Received: from localhost.localdomain ([240a:4280:4800:6ace:25e8:2607:e94d:caaf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eb7539d3sm7304254a91.15.2026.08.15.11.13.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 11:13:36 -0700 (PDT)
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
Subject: [PATCH 5/5] i2c: pnx: fix device_node refcount leak in i2c_pnx_probe()/i2c_pnx_remove()
Date: Sun, 16 Aug 2026 02:12:04 +0800
Message-ID: <20260815181204.2321-6-dragonliu2018@gmail.com>
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

i2c_pnx_probe() calls of_node_get() to take an extra reference on the
platform device's of_node when assigning it to the adapter device, but
none of the probe error paths nor i2c_pnx_remove() drops it.

device_release() does not call of_node_put() and i2c_adapter_dev_release()
only completes a struct, so the extra reference is never released, leaking
the device_node on every probe failure and every adapter removal.

Add the matching of_node_put() to all probe error paths (the three early
return paths before clk_prepare_enable(), and the out_clock label which
covers the wait_reset(), platform_get_irq(), devm_request_irq() and
i2c_add_numbered_adapter() failure paths; dev is devm_kzalloc'ed so
adapter.dev.of_node is NULL and of_node_put() is a no-op when CONFIG_OF
is not set) and to i2c_pnx_remove().

In i2c_pnx_remove(), i2c_del_adapter() clears adap->dev with memset()
at the end (commit bd4bc3dbded9 ("i2c: Clear i2c_adapter.dev on adapter
removal")), which zeroes adap->dev.of_node before of_node_put() runs.
Cache the pointer before calling i2c_del_adapter(), the same approach
used in i2c-mux (i2c_mux_del_adapters) and mtd (commit 56570bdad5e3
("mtd: core: Fix refcount error in del_mtd_device()")).

Compile-tested with gcc on arm64 defconfig using COMPILE_TEST; no
hardware available for runtime testing.

Fixes: b41a216dafe4 ("i2c: Add device tree support to i2c-pnx.c")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
---
 drivers/i2c/busses/i2c-pnx.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 8daa0008bd05..0b6c144d9a21 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -644,20 +644,26 @@ static int i2c_pnx_probe(struct platform_device *pdev)
 	}
 #endif
 	alg_data->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(alg_data->clk))
+	if (IS_ERR(alg_data->clk)) {
+		of_node_put(alg_data->adapter.dev.of_node);
 		return PTR_ERR(alg_data->clk);
+	}
 
 	snprintf(alg_data->adapter.name, sizeof(alg_data->adapter.name),
 		 "%s", pdev->name);
 
 	/* Register I/O resource */
 	alg_data->ioaddr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(alg_data->ioaddr))
+	if (IS_ERR(alg_data->ioaddr)) {
+		of_node_put(alg_data->adapter.dev.of_node);
 		return PTR_ERR(alg_data->ioaddr);
+	}
 
 	ret = clk_prepare_enable(alg_data->clk);
-	if (ret)
+	if (ret) {
+		of_node_put(alg_data->adapter.dev.of_node);
 		return ret;
+	}
 
 	freq = clk_get_rate(alg_data->clk);
 
@@ -707,14 +713,17 @@ static int i2c_pnx_probe(struct platform_device *pdev)
 
 out_clock:
 	clk_disable_unprepare(alg_data->clk);
+	of_node_put(alg_data->adapter.dev.of_node);
 	return ret;
 }
 
 static void i2c_pnx_remove(struct platform_device *pdev)
 {
 	struct i2c_pnx_algo_data *alg_data = platform_get_drvdata(pdev);
+	struct device_node *node = alg_data->adapter.dev.of_node;
 
 	i2c_del_adapter(&alg_data->adapter);
+	of_node_put(node);
 	clk_disable_unprepare(alg_data->clk);
 }
 
-- 
2.55.0


