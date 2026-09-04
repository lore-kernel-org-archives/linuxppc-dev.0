Return-Path: <linuxppc-dev+bounces-26591-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB12C624DB
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 06:10:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcNH41Tpgz2yv4;
	Sat, 05 Sep 2026 16:10:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c30"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788525954;
	cv=none; b=c3A0g0HGHjYGx9KnD81Uex2GWPT0J8190mtongMd+0ypA0LeLiyU1O7viIVMKBX4AL5Lr+PSWZyQsletzRN88K6CS8USOBmr1VAwU3rKw25Jew8dqygpQtvNkfZsXJpofQwIyfmfpK7WXGXBAjDDxAlbdbNejfvvxiapsWsDRIuEwUCz6ovlm0MnkfLqbLqI5r8W9oWCGAhHO7B8ZymUoUC7/rK3ZeEly2pg+gxqDKTgjHiEm7lVEcIqEi6n4lRWThoOLyDxoxBIQkVQSQNq/xVUqH+zBIKCV/u96vZbrh7Rp5xxKohCA3jQkeyZqyC0f3Rno4R17X5CFHV1gIzSDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788525954; c=relaxed/relaxed;
	bh=yCmaPe0iP6tKAqZOH5fpzpvMEa+c8TRt94OkvkEgA6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NsyUhpQga/+sZDi5T7+SyKWV4cqSFRhvAenE/kl1i8a2EU7umAr6uVmYxR2ySk1eSPExBAylnH1fyPJDinENMFL/cMvk6oUP6VMjRpwUxTaV381EeRBGsKYRTQk6eO9aqZ7e2I3/PykpUB7XbcWtt/2WaifsGmsu/Gs62tPJfqiYZZ1hb4OZxIqwMzgQTdNoWOCo9/pTRBShNETMJRRcMdwJjd8js87Ru9KkMXIvu+odzganskSNqYXXwj4JYH4+cRd7Wud2dfU5c29JAM1fqnEaRv0ZM6bbJxUEGlTPUA2WOblXQngwn44SzW3E/yRYfFWQ0hPpziXJYxHOh8U9ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M/P0DoIW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M/P0DoIW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbx5r3ZWsz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 22:45:51 +1000 (AEST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-6b145a9623fso425825eaf.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 05:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788525949; x=1789130749; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yCmaPe0iP6tKAqZOH5fpzpvMEa+c8TRt94OkvkEgA6g=;
        b=M/P0DoIWb05ekoGUPJpaEOPp/Csh2MvAb7i26rOgv50p2mYl0k1pvAkuRPWjeCTIO/
         ajfz+44/2nS0MiqzD0wsXZIcAiUBk5Tnl2ei1eX4JaBW9oyBgKdPmQVcFUVxM1X2M5QG
         S+PsqYTlMyDzRTZDcsQLd4CiPIYSC+Qclw0W9OPMy4jvi1AW3/CQpcJMlYjzDAdYp7YY
         NPkgLZRo/nHWREad+DXvDKI0JC3FmuieBwgvb6LStaQfo0PsAcYPMXb2zBlzdApV65+C
         lMfKN5vYdwOgCyf86OCmmnEOChR1usj+aWHHeKddzVdG02f927tXAJJnJLNT3hsoR4+1
         zfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525949; x=1789130749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yCmaPe0iP6tKAqZOH5fpzpvMEa+c8TRt94OkvkEgA6g=;
        b=IwCmB/8zxccKQLtVYFJZpIxwIYl7kRhvaIAitOJ0H/WWecw/Rp4aVzcVlg8OzsFLT0
         Wtju03kq1P0yyBdRO463tpId7DL52QxbYa8aWaIYy1OhALvbMQCw696wazBwcSriJmJB
         0aLACgm5bUHPOpdRdOseXJpCv0fj1KAumizqSAoKkudezmf5uipwbVoA3B+g8fadatG0
         AQzVgYt7d6TfSlABoSV9yC/fNLwuWLiOeHxGJKMxts7hHvtwdRzBXI4P/YSTQxURrk3s
         WC/9Xn8c3OtEdgRtC/Zk5cpSh2Vgfkt40gbm2MLTewASZoON7C/OT0I5CEFe1nRevMLs
         yoXw==
X-Forwarded-Encrypted: i=1; AKwUvBwFxYuKezmmFniwODXmPK6cGlOy2GI0a/b4Ygn6eCzxicpH15NsPpmOgoUYbusZsYqYMqRA612QeXdjByA=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nI+uzKamkGvxrNRfQMXJqR8LsdIFP67vKe2qTaYfrwciXJe1yf
	J3rnTZMf2vFs66cKNnRpsIOPFcf+6Qf6h3SCNU40OdfLLwJdsYYBJ1OL
X-Gm-Gg: AYBFou06dN+itBZWWvjhWTwwtFiwLEpSZ9d1Sj8lTCr8HUMtFiwDyBJ+oCL/2Dw3G1a
	IIxR2LM4U1P+0Ik98fgUIASF68D1yY9///6GTzXx0PXnuZl9OoGhRf/TtJVlZdQ8QoNCW1FiSKv
	4IuZ6Xdd9kIMScJ5sSonGOqvDdOYIvNXr4ekTD7XdIkLqEhU0Di09i4l1zL1iibR3OQRUhsU9f6
	ueomCUMUzTbMMU1FhXh3qWQAB6rbPRIYsLNoXelL6mT2Ww1Iduq5tAZQCZN1bX9Pv72CDLRhetJ
	iz595FMXNoO39T2teseBIYL2IzScBZVhOiNNAj8qJ0u0O45KEcb0XjdRxIM8zYYQmCsNFgn9bmg
	mmB82W7Yuc0Yra3oDDGU96MWVJdbiEzRcYxHoMlPyyFb2NvQGAhRbai+4R7eE5KMMe30yUlu05U
	Ygl71RmZMLiZ2n8E6QBLuXzo+XxBpoOhS+1LvSIxlYlPeWXsh/Bf0cFsFDqXGxCSAj4sENWaJ/Y
	kQ2dkoRNVeuZEE=
X-Received: by 2002:a05:6820:f00b:b0:6b1:24ce:6264 with SMTP id 006d021491bc7-6b6fe3af760mr4231568eaf.30.1788525948980;
        Fri, 04 Sep 2026 05:45:48 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243f780csm6477419c88.13.2026.09.04.05.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:45:48 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] macintosh: fix typos in comments
Date: Fri,  4 Sep 2026 18:15:35 +0530
Message-ID: <20260904124540.7652-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904124540.7652-1-hemanth.selam@gmail.com>
References: <20260904124540.7652-1-hemanth.selam@gmail.com>
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

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/macintosh/adbhid.c               | 4 ++--
 drivers/macintosh/macio_asic.c           | 2 +-
 drivers/macintosh/via-pmu.c              | 6 +++---
 drivers/macintosh/windfarm_lm75_sensor.c | 2 +-
 drivers/macintosh/windfarm_pm81.c        | 2 +-
 drivers/macintosh/windfarm_pm91.c        | 2 +-
 drivers/soc/fsl/qbman/qman_portal.c      | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
index 6155da58091b..68d1df6bc92d 100644
--- a/drivers/macintosh/adbhid.c
+++ b/drivers/macintosh/adbhid.c
@@ -32,7 +32,7 @@
  *
  * Improve Kensington support.
  * Split mouse/kbd
- * Move to syfs
+ * Move to sysfs
  */
 
 #include <linux/module.h>
@@ -604,7 +604,7 @@ adbhid_buttons_input(unsigned char *data, int nb, int autopoll)
 
 			case 0x7f:
 			case 0xff:
-				/* keypad overlay toogle */
+				/* keypad overlay toggle */
 				break;
 
 			default:
diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index ee3caa3d87d1..926bd074352b 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -749,7 +749,7 @@ static void macio_pci_remove(struct pci_dev* pdev)
 
 /*
  * MacIO is matched against any Apple ID, it's probe() function
- * will then decide wether it applies or not
+ * will then decide whether it applies or not
  */
 static const struct pci_device_id pci_ids[] = { {
 	.vendor		= PCI_VENDOR_ID_APPLE,
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 8c652c15018c..736936152b0b 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -482,7 +482,7 @@ static int __init via_pmu_start(void)
 	/* Make sure PMU settle down before continuing. This is _very_ important
 	 * since the IDE probe may shut interrupts down for quite a bit of time. If
 	 * a PMU communication is pending while this happens, the PMU may timeout
-	 * Not that on Core99 machines, the PMU keeps sending us environement
+	 * Not that on Core99 machines, the PMU keeps sending us environment
 	 * messages, we should find a way to either fix IDE or make it call
 	 * pmu_suspend() before masking interrupts. This can also happens while
 	 * scolling with some fbdevs.
@@ -1286,7 +1286,7 @@ pmu_wait_complete(struct adb_request *req)
 
 /* This function loops until the PMU is idle and prevents it from
  * anwsering to ADB interrupts. pmu_request can still be called.
- * This is done to avoid spurrious shutdowns when we know we'll have
+ * This is done to avoid spurious shutdowns when we know we'll have
  * interrupts switched off for a long time
  */
 void
@@ -1549,7 +1549,7 @@ pmu_sr_intr(void)
 			/* 
 			 * For PMU sleep and freq change requests, we lock the
 			 * PMU until it's explicitly unlocked. This avoids any
-			 * spurrious event polling getting in
+			 * spurious event polling getting in
 			 */
 			current_req = req->next;
 			req->reply_len += data_index;
diff --git a/drivers/macintosh/windfarm_lm75_sensor.c b/drivers/macintosh/windfarm_lm75_sensor.c
index 128e9944429a..085b8c640e3a 100644
--- a/drivers/macintosh/windfarm_lm75_sensor.c
+++ b/drivers/macintosh/windfarm_lm75_sensor.c
@@ -108,7 +108,7 @@ static int wf_lm75_probe(struct i2c_client *client)
 		return -ENXIO;
 	}
 
-	/* Usual rant about sensor names not beeing very consistent in
+	/* Usual rant about sensor names not being very consistent in
 	 * the device-tree, oh well ...
 	 * Add more entries below as you deal with more setups
 	 */
diff --git a/drivers/macintosh/windfarm_pm81.c b/drivers/macintosh/windfarm_pm81.c
index 2a4a3746f6a0..308ed55688b2 100644
--- a/drivers/macintosh/windfarm_pm81.c
+++ b/drivers/macintosh/windfarm_pm81.c
@@ -734,7 +734,7 @@ static void wf_smu_remove(struct platform_device *ddev)
 
 	/* Release all sensors */
 	/* One more crappy race: I don't think we have any guarantee here
-	 * that the attribute callback won't race with the sensor beeing
+	 * that the attribute callback won't race with the sensor being
 	 * disposed of, and I'm not 100% certain what best way to deal
 	 * with that except by adding locks all over... I'll do that
 	 * eventually but heh, who ever rmmod this module anyway ?
diff --git a/drivers/macintosh/windfarm_pm91.c b/drivers/macintosh/windfarm_pm91.c
index 14089d57e5f7..d2e72d1aa6bc 100644
--- a/drivers/macintosh/windfarm_pm91.c
+++ b/drivers/macintosh/windfarm_pm91.c
@@ -656,7 +656,7 @@ static void wf_smu_remove(struct platform_device *ddev)
 
 	/* Release all sensors */
 	/* One more crappy race: I don't think we have any guarantee here
-	 * that the attribute callback won't race with the sensor beeing
+	 * that the attribute callback won't race with the sensor being
 	 * disposed of, and I'm not 100% certain what best way to deal
 	 * with that except by adding locks all over... I'll do that
 	 * eventually but heh, who ever rmmod this module anyway ?
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index 456ef5d5c199..e44de59ec522 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -33,7 +33,7 @@
 struct qman_portal *qman_dma_portal;
 EXPORT_SYMBOL(qman_dma_portal);
 
-/* Enable portal interupts (as opposed to polling mode) */
+/* Enable portal interrupts (as opposed to polling mode) */
 #define CONFIG_FSL_DPA_PIRQ_SLOW  1
 #define CONFIG_FSL_DPA_PIRQ_FAST  1
 
-- 
2.48.1


