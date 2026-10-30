Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2BB606A323
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=F6K1PpZl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGbVq0Yvlz30Tp;
	Sat, 31 Oct 2026 09:34:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793399650;
	cv=none; b=OX2xsH2awomgYzJgp28U9uGOltZn50L7Y3ewQTUxSIOC55uaxSPjxoUIVvWgFexWss5Co8Ir11MPXUcc7v1wkcfoIkl6afhLugXpVhmtBcNReFsEGCko0eldNHMjNxZa6JtCFXu7hXKixUgu1iZLT3glDdMKYblQZpxj5rFjxr9d3EhIvKcFvD/zPJE9B6pZU4Y5B8g2mwV/pA69cOorh5zzU6JXhx4rO8ScEIvhVZwuRu32tlwiPARhmd9LevMzf3fbT0l47PsGJzsxxlUgdzSnWw/vnpuY00Ec6jZqezDEfUzbVcqz7NNeoJ1TkCKh/VwoVK4sOcpUPHIWBLGz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793399650; c=relaxed/relaxed;
	bh=lY0pxtvUJ1KUjGauum4/uEvThtLNCFkzMFjgO1TNNk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=au7VQ1ZxF8nIkmCsJcwCZaC4Q1xI2Y9TDuCOsqyWFDjPXduAfjMfOEnEwGKFhS4YMQNUOX4aEZoe7qMKrZFrMAFYgiGQhJVqjTAHzkj4ql9sotrk0WiiBo+P5uijJ5wNuJym4AzHTV5FY0ztzurO2WJLI3zY7qdSfR/diCInM6SS+cqoU7mRGbhMi6KE8uYKK2r2S1o4EQVkJRgs8PtySxwLj+TKPR21Xw9jvrhMS2PCgOpABa3ZntHQTT9naN2OluU1oaL83mjveMDvh8okaqlLX4rf8f1gmzSGFJsAR1KmQLSGXY1QxE4Z1k7AkBDrWgPQc2HuIyeFcIrwnMdWLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=0x0f.com; dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=F6K1PpZl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122d; helo=mail-dl1-x122d.google.com; envelope-from=daniel@0x0f.com; receiver=lists.ozlabs.org) smtp.mailfrom=0x0f.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=F6K1PpZl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=0x0f.com (client-ip=2607:f8b0:4864:20::122d; helo=mail-dl1-x122d.google.com; envelope-from=daniel@0x0f.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com [IPv6:2607:f8b0:4864:20::122d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGbVm0722z2yZf
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 09:34:06 +1100 (AEDT)
Received: by mail-dl1-x122d.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so834999c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 15:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1793399642; x=1794004442; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lY0pxtvUJ1KUjGauum4/uEvThtLNCFkzMFjgO1TNNk8=;
        b=F6K1PpZl7xolm8EQ0g7+pG0R4mYBTir/D4esIaalWPt892HdCUzOiZrt1FGA6Eobr/
         ULY5dxkLjhQ8QwJAlq1mUWwoOXfSezf41+kzQjQK6w1R0WLlpyPoSzPm03dI42gsSDqC
         8266lrFeocFV5GcIybvIAEEgQMBGFs2PDwTO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399642; x=1794004442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lY0pxtvUJ1KUjGauum4/uEvThtLNCFkzMFjgO1TNNk8=;
        b=Uaf53UhON3igyKJjYB1L03Gq4GGFHCLJ5xBHdA6ph1G1cKzVsPnF7pOQEKBpm/wYK5
         ODCT3umdQ/ONq1wPVmoeMJLgdJ6V6J2CJDQRqcQWESH91L/1iSb45sH8Upl5ET+VmPGR
         Y9ySY/JG+JjzxOufNv4DlcathRgF1ORLGR9rrdy3RHVAol6MBa/lR5oOBIB2b4aGMZnm
         d6FU9GjqbYBCPGsObYe3AbV82cFX9Vkv0JxAnq7r4ZaghkIEtleG43UqMWr3N9920USl
         dg3Qrqat9imhTLIFZmtXE/e0U5stIm0cBpgWEzBp/f/sz2S7dW2ZyZqcZUr6cL6weenk
         /mQA==
X-Gm-Message-State: AFq9FYICPD/mKuNm6gRq30uXYeJwgb0ShSG8NvijLY7noMeQ83bRhTNi
	G4gW5jozoA8Fi1ePaugBnDOZexcHKP4fvR6OJqtWcxUjyWmSXQ9siNueiHDbuhYpzqU=
X-Gm-Gg: AYBFou1OjGXcJ4VCoLxWHOe8epayUA56XXxFAyV/SNAx3pvQox8Uqw3prKIOaEu1LOp
	PIxGOpuK5uGlO6fAM5U0ImiqYyq3tTEa/eAwAhH7v6S5iXWsMBNzfGhCKvwuZgdYHYp0r26nsyG
	G9fk1xeVzh3/9RToFQ/HE3izbpiGi4eKs+3xTyrm6k1jAfYCD4D7e7IqGJp1sOwy04tnFxmIaLo
	ZsUBCPgEIx4SztjRnM1UYLdVBcAF8Vm5wovoiXeHSWciTbN60VjkbK9rPxlrNgjxBNDtYKJqYv2
	LWGQXqWMF6B6DNMCVVk7Qh/OZQg2C9CaxV3UKC/l74tZMfAkfgrevHItgDfNxNvtO1GxGVSzS7J
	Nx066pIP5eLmdIB5NLVqnIehPKlZZl+rUPjSamb+joblg4WuyqAX6ZsbkdYTOe0zlu4R16qsSLE
	HBF07eKE3E+EDucgGtDiAqt3r24Z3FAU8EaIRLWzCaqyh3oqS8a8PyjcV4L0/FUwXi64LJjvzOO
	JRPI8PkS0RukC6Ji5W+rK/RWBocj3mSahrO5xdUEDOx06CfZPtYBywB+PGeiP/i3r/gxc2PPMTD
	JnsoPHIjeuLuB6ZUqpy5WHmXk4HL38+UGK4t+pEvbNdCD5hF1eMyOfARnZTJX8F4NVzTKcPY/vE
	pgeZACEhbn6+1CHIa
X-Received: by 2002:a05:701b:2816:b0:182:94d7:f76a with SMTP id a92af1059eb24-1ac6088a34bmr4779354c88.43.1793399642429;
        Fri, 30 Oct 2026 15:34:02 -0700 (PDT)
Received: from shiro (p1795186-ipxg00e01sizuokaden.shizuoka.ocn.ne.jp. [153.207.151.186])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1ac192c2e9dsm12324147c88.9.2026.10.30.15.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:34:01 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: andi.shyti@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] i2c-powermac: Silence modalias failure message on G5 powermacs
Date: Sat, 31 Oct 2026 07:33:18 +0900
Message-ID: <20261030223318.1140883-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.55.0
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
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,URI_HEX,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

G5 powermacs, and maybe others, have i2c nodes that have no compatible
and cause i2c_powermac_get_type() to print a warning like:

i2c i2c-3: i2c-powermac: modalias failure on /u3@0,f8000000/i2c@f8001000/cereal@1c0

The point of i2c_powermac_get_type() seems to be to override the modalias
that comes from the compatible so that normal i2c device drivers do not
bind to devices that are managed by other mac specific drivers (like the fan
control ones).

Since a device with no compatible shouldn't bind to any normal device the
warning doesn't need to be printed.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/i2c/busses/i2c-powermac.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index f99a2cc721a8..b37cf5b4ab10 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -299,6 +299,18 @@ static bool i2c_powermac_get_type(struct i2c_adapter *adap,
 		}
 	}
 
+	/*
+	 * Some Apple device trees have i2c nodes with no compatible that can be
+	 * ignored. Without this the cereal node on G5 macs prints the modalias
+	 * warning below on every boot.
+	 */
+	if (!of_property_present(node, "compatible")) {
+		dev_dbg(&adap->dev,
+			"i2c-powermac: no compatible property on %pOF, skipping\n",
+			node);
+		return false;
+	}
+
 	dev_err(&adap->dev, "i2c-powermac: modalias failure on %pOF\n", node);
 	return false;
 }
-- 
2.55.0


