Return-Path: <linuxppc-dev+bounces-20660-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544E7CD37B2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 May 2026 21:48:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDGhL5Wx6z2xnK;
	Mon, 11 May 2026 07:48:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778433265;
	cv=none; b=AXNfuUQq2wTMk6nhdGjnvEJ/z0eY3BzhdOVv1ZYn5S3KTzxrgcAs2KpQrm6EPa5mH4P+APM5Iy+tVQMLobKg9bmcL0jhA4KR8ffGiBG53YBX9ZK88jX8bopK/ffZ+TxKpcPLam+w7L5fakJwpoOgWxHnehCY5ZYtrwKAJJBjmGmFQhwDin/ETQvh1ejERS19omRukRsitXOBw1NO9rlg7tXpli5aW50m9NZ/SGrmniRtv82pAWb+YUCxt68stGtrXgcGimcUrbvoJpsvbt1tKG77nWwAh5hKrpS89950FlU1ITOwqTjRqXZdjuWzhgPPV4XoycwOFGZTV2gmEulHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778433265; c=relaxed/relaxed;
	bh=iuaa/iv38+EpjRtmaMrOBvX+X90TeEo1RpmrNxck1uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnRcl2+fqCoTObys0CuoCLeG+8uhEBA5liPJkXif9rDeMDVpZbf3d+tkzMj/ccxDK8xvFIVOHYaGydUU9dlfc8p2A2fxP5KFdBMspo4WMQ58sHraj3/GdJM3NRB6SSTIfA0x/ndNWottEH4+ntyUCHlxm320I0KXvG3pxKnuB01SQkUdxeACBhyGgtwrqeT+WWW6PgYPlls5cJk9IafmIIKrZ9THATXT9KNFwOe631uWBrd4jtQODZh28QQviHBe49Q6jkS2CAIvkPkMcsIWuHml6DNwG8EsmxIyTaVd7OA6Nn6MWvI4nCcL0aeEvbtP9TPrS8k5d9kj+AhB8JUUNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QTl21Ofm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QTl21Ofm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gD8bj2pnYz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 03:14:25 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-c80170db7d6so1228738a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2026 10:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778433263; x=1779038063; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuaa/iv38+EpjRtmaMrOBvX+X90TeEo1RpmrNxck1uE=;
        b=QTl21OfmRbQld5GVThzza+NTCbLcIQymZtV4c8GSt2HGkxRGC48aFDc626Lf2EcoUW
         AFOB/Nq0gywuVqSacdgJrcaBPXN6VKcR1laQSCVM+Fyos9meUnkuc+Gv/JbDGsIfn3AE
         JSI7wxtrun7lmUughTo3wKyQYKqYuNDcDK8N0Xehy1d8No/iI+1ekSOsoECPViVZawrm
         kF/RWz9XcWbXXVvGvQvrgxCXbFzgeS1KNtoyvZxMTT2WGEDQCFPPRX3IYDbwbY48fO3z
         dGoe5NaWHOg7AC53oBciQklZZBRz7KM//k1CJlDtgnSzL/Iw9DfY0Lm2B4pCjF/DOPzl
         0hKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778433263; x=1779038063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iuaa/iv38+EpjRtmaMrOBvX+X90TeEo1RpmrNxck1uE=;
        b=EHM1IRWezVe7HNisUPC3kdNQ51CuIlX4Q4LHDbOqn6r/eS63uyvKk3Tk2iZHqC645f
         rmz0wJR5OqrqEZIGMx4ROvtkc5WbUU5IJZPZbM8sHiVMWdZLgRdJJE5ylLgsT1FhUeN6
         8CYaunvenj2dq0GSPmxnIVt/2lJgnPlCf/2ImQKS2npG5m2otJs34UBmCjw+kjsecBzX
         4airHuGu5aWLjDFj5ZeYo/A2QissIJo8yJkHccvNtPQcsPd/Zw2oXMVMrXh2AfLXkUsV
         2uuatuHsLrGRcs7mEltEy6QW4qxWYyr7GH/pAwGWZXPgDX9EOc9GhE7ojYA7dLC+2P3z
         OacQ==
X-Gm-Message-State: AOJu0Yzyl30bD7/mkfOmNM60vr1zHpMR7kTJ1lPFQMjO0Dj0883a0m7q
	a7orVaFPPi+729eoH2uMvc3rHZLBEg4v/RXr00QRDFCf9zX7SE5rbvka
X-Gm-Gg: Acq92OHrWVEu+CD+zUkvjw1Fx9NlGY2e/CBEJw2lA2mQLlWclfW5ZBUYeN94SXFyLOd
	WX1ovxcjx08accMcCOULADtbyt5r/hyoZKa8mPOyy1RZwUGYr5cqTKtRL3AfbR+8QJs3a8abQGf
	mwjadpvmfKphGqA3S7sa6yoe18bC+rs0BxklDTpJIBwv+w3DApq2Ajuhf0x6ysCubkBa4E0SV1J
	XfBnzrYzSFCgyZVaJCuUdyUZhP6b7SLxGcTTIPIFKpzadv/k8dgN+Ca2u/nlL9wsRhrNUjLIFUG
	chTGjbkOjVCB97mB0VoP0ZbQrpGpYhCaZbmTSSPh1yDSwsVu/c7GAsKH+v739rSYu+l///orq3d
	Rnn+0I3yN5M2IuI79G7BX2TB2USWrRKLQqOpi37FWoLdxRYMDuSvN+fPk4ssMUCkcOw03g0gHRS
	z23B9EWXMRVI+g/XT3L16qei62d4VN
X-Received: by 2002:a05:6a21:328e:b0:398:a76e:4ad4 with SMTP id adf61e73a8af0-3aa5a915f0emr23841929637.21.1778433263409;
        Sun, 10 May 2026 10:14:23 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563f381sm21799778b3a.6.2026.05.10.10.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 10:14:23 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	robh@kernel.org,
	saravanak@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH 2/2] of/fdt: make early_init_dt_scan_chosen() return void
Date: Mon, 11 May 2026 02:13:53 +0900
Message-ID: <20260510171353.1406018-3-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260510171353.1406018-1-ekffu200098@gmail.com>
References: <20260510171353.1406018-1-ekffu200098@gmail.com>
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

Since commit 064e32dc5b03 ("of: fdt: Honor CONFIG_CMDLINE* even
without /chosen node, take 2"), early_init_dt_scan_chosen() always
returns 0, so the return value checks at its callers have become
dead code.

Drop the return value, change the function to return void, and
update its declaration and callers accordingly. No functional
change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
dt-test result

[    0.684136] ### dt-test ### start of unittest - you will see error messages
[    0.685849] ### dt-test ### EXPECT \ : Duplicate name in testcase-data, renamed to "duplicate-name#1"
[    0.685870] Duplicate name in testcase-data, renamed to "duplicate-name#1"
[    0.689496] ### dt-test ### EXPECT / : Duplicate name in testcase-data, renamed to "duplicate-name#1"

...

[    1.693384] ### dt-test ### EXPECT / : OF: resolver: overlay phandle fixup failed: -22
[    1.693386] ### dt-test ### EXPECT / : OF: resolver: node label 'this_label_does_not_exist' not found in live devicetree symbols table
[    1.694968] ### dt-test ### end of unittest - 405 passed, 0 failed
---
 drivers/of/fdt.c       | 10 ++--------
 include/linux/of_fdt.h |  2 +-
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index ba65e36e183c..1b2cf5b29926 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1087,7 +1087,7 @@ int __init early_init_dt_scan_memory(void)
 	return found_memory;
 }
 
-int __init early_init_dt_scan_chosen(char *cmdline)
+void __init early_init_dt_scan_chosen(char *cmdline)
 {
 	int l, node;
 	const char *p;
@@ -1144,8 +1144,6 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 #endif /* CONFIG_CMDLINE */
 
 	pr_debug("Command line is: %s\n", (char *)cmdline);
-
-	return 0;
 }
 
 #ifndef MIN_MEMBLOCK_ADDR
@@ -1226,12 +1224,8 @@ bool __init early_init_dt_verify(void *dt_virt, phys_addr_t dt_phys)
 
 void __init early_init_dt_scan_nodes(void)
 {
-	int rc;
-
 	/* Retrieve various information from the /chosen node */
-	rc = early_init_dt_scan_chosen(boot_command_line);
-	if (rc)
-		pr_warn("No chosen node found, continuing without\n");
+	early_init_dt_scan_chosen(boot_command_line);
 
 	/* Setup memory, calling early_init_dt_add_memory_arch */
 	early_init_dt_scan_memory();
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 51dadbaa3d63..09e9d45f432b 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -68,7 +68,7 @@ extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
 extern unsigned long of_get_flat_dt_root(void);
 extern uint32_t of_get_flat_dt_phandle(unsigned long node);
 
-extern int early_init_dt_scan_chosen(char *cmdline);
+extern void early_init_dt_scan_chosen(char *cmdline);
 extern int early_init_dt_scan_memory(void);
 extern void early_init_dt_check_for_usable_mem_range(void);
 extern int early_init_dt_scan_chosen_stdout(void);
-- 
2.43.0


