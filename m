Return-Path: <linuxppc-dev+bounces-25893-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE85C5B572
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Aug 2026 13:57:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNHZg3KjDz2yRC;
	Sun, 16 Aug 2026 23:56:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786817610;
	cv=none; b=iUKtMSECFnZ+zraMt9F5SX93QjhUcl/U8tLM0rNoqJIHEd6MfGOzqVLnp3rX6RAGvo6zQUqUR95yLRXFgFgnBCNf5v3Q37EiB1l/owR/DhNhgDlvru9Aw3fjXDGIXBe3NPYG2VcMjHxT/m8zljiZYvDrKFNeo1U+P0G8sDhsMMKMRTnKi78xPXBV8Q5ygW2oNQ4lup3X/qPmXZ6s7+F1g7tQ8m76MKUbp10zoQ4VK+cGyiboxyTYq2/9x1jC2qfpUAyBqPxz1lY8lXbAJtQSgiWrOHsZDFT1ncMCNV4rTuECMam+vofihX54q7bH7mvTqHMmbdTW7uosra6E74bLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786817610; c=relaxed/relaxed;
	bh=hOjD+7itBEHsMfKmr+ynGew/Kjw1CTU/4y0bM+1NDxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iormgl+QG8EOBIpWKd7k1WGyql+KHujuvC2tOZ3HPVCRO5aC3MOtNp5+GnpPGd0gg7bcsLB3a8c6ndAcoe/X7QQDrt1FsxxOq6h9G99BnzFKNHOgWx5P5DScIUfKrPgdJTLKzGPItZ0vGiuboQd8KuyOhH7QyrEel5T9BHYx3MPvMQH9lJcw4fp9BLWlAtiBnQ3XiXocy4SslXo8c53yl/fxPA/n99hUaax418oIiNa0/F9v8+a0Q3fKsH8VN6VidtazGjt/IVLDpNyaQVwJ763F6hpeMozEJCRZoQCs9q53YxdhDg8AaHA6Z34ylwo15wwWJPOrl1q8Lnj0UNcdSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ri2ODPeO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=dragonliu2018@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ri2ODPeO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=dragonliu2018@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hMnK53jbSz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Aug 2026 04:13:29 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2cf452def93so24900925ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786817607; x=1787422407; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hOjD+7itBEHsMfKmr+ynGew/Kjw1CTU/4y0bM+1NDxI=;
        b=ri2ODPeO7a2nQT0y98yPcv6hekJMiUjDCxwHtbl8rwr0kMUPVLiQ7wQIeLy+hV6gHq
         +tWDi0wwyAWl/zy4bqUIu4JeUR5E8y5EXtMkcjxFssoGdYBEi83pCZHnGN9vrgfI3d1s
         D50uG8oZHaMPTZSFkps13i3nOO62YpBxMoV0VcF93GKbvx9w04GBdXttSY7ZeKRdZ1xx
         yBz33vAgrBLkGCljNhUXVxVqk55iRumRxU8ZkrGlojx/zY5CbryJae1XNPuGWwQE3xyC
         H0TXLq0Q2Fmhloke4fpWk1nyghq3UA8N1i9mgwVnjv95FGa/97XxQ9U0Py/wfIHZrVor
         YkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786817607; x=1787422407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hOjD+7itBEHsMfKmr+ynGew/Kjw1CTU/4y0bM+1NDxI=;
        b=mvChGkISSfhRBqfGuWnVXRfwiIsa1b9t6wHMo9OqfC8l3WNxZqCXTCsWufI/8oIRkE
         ahMQXEtM4iV1h6OCpyubbtf6wT1eUVRNpazccJKlmOEK9mQ0khHyXjL6/7ugNd1GcP3G
         Az50dSre+Xg4TcDnSSSb87UWrR2v4qrKt9b7Fp41Px1fdmowKwdzoIOpM+4gaYOxti0X
         nGNIdGb0Lz73Ls70aJ9y9kFG7oUFo/4v4WMSYdV+70WLGtjQgopgKqdvpuOpgseNBoj3
         dxevX33e5KYE0Y+Q0IjKrgkp23tFTEcEXms19s7KeNJRyanoHqgWEzHdylWjyi3ix4W3
         9Sqg==
X-Forwarded-Encrypted: i=1; AHgh+RoupWyEcUFu63KEQe6Ism/d94sWAubmZ9Fm9ZPWQ0LB2AuG2Wj7VeJnO6IWND5Kvs8YMC/36XUS+o6cMUI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzLTe03SrXClddCE13GRRstugEF2mCqHkqm1jdsAvJ7I5E9W5gc
	xxAPVfHm5Dbnh3Nf5mYmekTJ2F6p20ggPPCwLoTwCCemC+2SOsgHtEud
X-Gm-Gg: AR+sD10p/DnuRVfqDSAHlV2z3VoLYdz4we8qLN+Dfmpsa6q/+AjHEj+AzAJzqIJYQE3
	w3G3Hjv6Ll97XprVOSnUG75LGsVm0r88tZJ5rO4LEFEVPOg+4erqBQcd7PKwBmVdQ5z7BEk3+g0
	NAJb/jJ2c8VKJhF5aC7a7lF7UNfYrFXfm+s44S/dzVQj70g2R/Aa8KH/tYW4cFrL9CafcbnaOxU
	FAzRf89jP+oLnvWm1IMJz8I+jwSiEVjixqMZtLqp6riThARS6EPci4WElT1ExtUHFSqrKI+X+P5
	ujFTacOwUzlh+u5ct439QKtEkGJrH5p9Htwmwod04gXV6cFTOq6VNao739sjHfSSW+nxYWC52pq
	7Ded8vnlHl9ZJWQKynfD2ATWpyF8F/6AU370EJME7kyZxxx1GU+3//c7paAoa2XBhq666fvQ+BD
	mxiLpjOdBpI4q0GO1d6/sN5MJgVO/E01FpAC7keOZ5uTvT9A6Dy3q3HqwtAgeD8QWD/xrbHAPtg
	sDP+2jZ8vNVVZSM+QhXiKm/ROE=
X-Received: by 2002:a17:90b:4ac6:b0:38f:1a29:7a82 with SMTP id 98e67ed59e1d1-3933afb387cmr9673131a91.6.1786817607293;
        Sat, 15 Aug 2026 11:13:27 -0700 (PDT)
Received: from localhost.localdomain ([240a:4280:4800:6ace:25e8:2607:e94d:caaf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eb7539d3sm7304254a91.15.2026.08.15.11.13.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 11:13:26 -0700 (PDT)
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
Subject: [PATCH 4/5] i2c: opal: fix device_node refcount leak in i2c_opal_probe/remove()
Date: Sun, 16 Aug 2026 02:12:03 +0800
Message-ID: <20260815181204.2321-5-dragonliu2018@gmail.com>
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

i2c_opal_probe() calls of_node_get() to take an extra reference on the
platform device's of_node when assigning it to the adapter device, but
neither the probe error path nor i2c_opal_remove() drops it.

device_release() does not call of_node_put() and i2c_adapter_dev_release()
only completes a struct, so the extra reference is never released, leaking
the device_node on every probe failure and every adapter removal.

Add the matching of_node_put() to both paths.

In the probe error path, i2c_add_adapter() failure does not run
i2c_del_adapter(), so of_node_put(adapter->dev.of_node) is safe.

In i2c_opal_remove(), i2c_del_adapter() clears adap->dev with memset()
at the end (commit bd4bc3dbded9 ("i2c: Clear i2c_adapter.dev on adapter
removal")), which zeroes adap->dev.of_node before of_node_put() runs.
Cache the pointer before calling i2c_del_adapter(), the same approach
used in i2c-mux (i2c_mux_del_adapters) and mtd (commit 56570bdad5e3
("mtd: core: Fix refcount error in del_mtd_device()")).

Compile-tested with gcc-powerpc-linux-gnu on powernv defconfig; no
hardware available for runtime testing.

Fixes: 470834508f87 ("i2c: Driver to expose PowerNV platform i2c busses")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
---
 drivers/i2c/busses/i2c-opal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-opal.c b/drivers/i2c/busses/i2c-opal.c
index c9b62892397a..43b3d17e933b 100644
--- a/drivers/i2c/busses/i2c-opal.c
+++ b/drivers/i2c/busses/i2c-opal.c
@@ -226,8 +226,10 @@ static int i2c_opal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, adapter);
 	rc = i2c_add_adapter(adapter);
-	if (rc)
+	if (rc) {
 		dev_err(&pdev->dev, "Failed to register the i2c adapter\n");
+		of_node_put(adapter->dev.of_node);
+	}
 
 	return rc;
 }
@@ -235,8 +237,10 @@ static int i2c_opal_probe(struct platform_device *pdev)
 static void i2c_opal_remove(struct platform_device *pdev)
 {
 	struct i2c_adapter *adapter = platform_get_drvdata(pdev);
+	struct device_node *node = adapter->dev.of_node;
 
 	i2c_del_adapter(adapter);
+	of_node_put(node);
 }
 
 static const struct of_device_id i2c_opal_of_match[] = {
-- 
2.55.0


