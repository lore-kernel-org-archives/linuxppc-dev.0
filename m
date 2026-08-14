Return-Path: <linuxppc-dev+bounces-25877-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080F7C5B572
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 21:01:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hMF5106Ckz2yqL;
	Sat, 15 Aug 2026 07:01:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::648"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786741268;
	cv=none; b=W+cBkFEmW2M2ccLN/FI4yo20B/nrdrJaRComIfg0IEEjjS26TIvLvAe6NUfOy1Ba+CZfzxG78AJ418vDKPDG4QeBmio0s2WUS7GauIo6JiBwuOCXhfBHRs/PIYgsGiZ/xIgX8v+rakd/sxZD4iENbxT06RrBQlcgnjZLuVbxR5nF5VoiACGU4JEQf7DJvA+lw6FPEQ3FgETOm0anRs+iurYoN0VzTRtPAdV+J4WzGsWlnTLvB17DQooxqA7TS72dmERFkuISKImKQSCAPYPxm81x3UIeqTeKHa0pubBn2scgCszQn8uVCShfFylmeLodM89lA/7GafDYzOAN+qMRHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786741268; c=relaxed/relaxed;
	bh=MLg3iB6Pagz28XpVaRBy9ZM+C4ap5o/b/rz1etSQnGM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eoI9zFSexJ19cmtgVZnoPcN36TuWrLHeOui+bk6aMBApeIuQpSPrCKvgfD/XrvnXl+zmqHuFLeXvd9hafAnQYvdr01YkHxFy7HNKCiaycM2zzeViYvdDNaSS/Z3Dk5dDps5GgFwITokeA4YxdpadW0srcc2jkVSBQsMGOfo2qL+wWzeLroZAwVafoPcQurf/huI2nfFUM3rpqUiXfQW1HYO+3Qf0OyF508Vxy/HjJ8GS1CmX2srpROcU2aHeZqtpxZtN9/YNSfV9eHVg5fftZ4ZDMiMj8EH+DyfaEzTuA/3+AaaF0h2T2f4cHV0e1iRO9MucPtSQjc6QgLJm3/S+jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=r4HqSBc2; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::648; helo=mail-ej1-x648.google.com; envelope-from=3doj_agkkdgscjadwbjqdpxxpun.lxvurwdgyyl-mneurbcb.xiujkb.xap@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=r4HqSBc2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--tarunsahu.bounces.google.com (client-ip=2a00:1450:4864:20::648; helo=mail-ej1-x648.google.com; envelope-from=3doj_agkkdgscjadwbjqdpxxpun.lxvurwdgyyl-mneurbcb.xiujkb.xap@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x648.google.com (mail-ej1-x648.google.com [IPv6:2a00:1450:4864:20::648])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hMF4y4k8zz2yS0
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 07:01:06 +1000 (AEST)
Received: by mail-ej1-x648.google.com with SMTP id a640c23a62f3a-c1f74261f67so136613766b.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 14:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786741263; x=1787346063; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MLg3iB6Pagz28XpVaRBy9ZM+C4ap5o/b/rz1etSQnGM=;
        b=r4HqSBc2k877ZeY4jmxVz89D3xWP8B2OYWJMBxYBwG+VbdGs3M0l0zsLIaHN3+2MMF
         KBZdxykINXoxrcR1uM5nayT2oyVEPeI9uM4rcr5TTV4e/ciu3m1qDl1fyjEiNlcBoXz+
         hSLvx4/eUBW0V5k/Po2WR1kcOVv5nIbBOn++PwSrAY2gzFst8Aa76oa2OQ65zx9DicX1
         CiyTK5JVYTMx1zT9ehxONFRip5pdEPHEejwC9OF7jXtOB+V5J6prg9qvGwPDvddG/bz6
         pHjTwCZR9X6mt5nO59bmZ5HBGTMarEFOgsuMQf+4IrI65P8jbVuf5sEK25wCP4CWFrRP
         bYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786741263; x=1787346063;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MLg3iB6Pagz28XpVaRBy9ZM+C4ap5o/b/rz1etSQnGM=;
        b=dz6g0V1DQTYicJFPmY8A8oiTyHhYSiPCcjzEFPR3IEoTtHZA1XYnwax6x4XH/v1FXE
         E89pV8bhAKcE8AuCydy7vnZvtUN6KSzJcqnNYiYAHYHI6hxxTGsHKgXZ7lgWv/6q5ils
         ZvNZmw4QR/+Ywi3D5I1geIu1Ebb7t6I2cM3cH+m3OD5Sz2T6m/eg064eS6p9i0wKvkYM
         WRSpNAhIDZf6YW9gT5meL3gRlOfLh6HYjj/3KAeAdZEmpGOn4GNnz2rW4rMZloSCY3aL
         A4mP9IPhZ2HOAWoIiFV9ytl6egLoSCKeQzBmVOPSNh6FediMZsoBHIQadHvHmC5n/t0B
         JTiA==
X-Forwarded-Encrypted: i=1; AHgh+RrGbIMwzADOvMstM6zDK1Wm0CreXaLPWB4GNFHXq60vcGbAb/xxo/ETn/m1FDW4ZIEbBD0qII1PKI8t+U0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy0Kof9wV6cJIAziBOk6SI4UpX9einb7ILwQ0ib4L7/6Z+NrySy
	5rfCcUdP54RcklU9T5w7r2fFJ0jjgunrKOGJFABwGIGJKDfmUZ2TZzxBLlTJTQ3coP7vQ3KjU/6
	NZ6dsE8Tw4DoUEALutQ==
X-Received: from ejcyh20.prod.google.com ([2002:a17:907:e894:b0:c20:282e:ae3d])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:99c1:b0:c15:a487:3482 with SMTP id a640c23a62f3a-c212a8f7432mr355541166b.21.1786741262708;
 Fri, 14 Aug 2026 14:01:02 -0700 (PDT)
Date: Fri, 14 Aug 2026 21:00:57 +0000
In-Reply-To: <20260814210057.4102768-1-tarunsahu@google.com>
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
Mime-Version: 1.0
References: <20260814210057.4102768-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814210057.4102768-4-tarunsahu@google.com>
Subject: [PATCH v3 3/3] powerpc/ps3: use put_device() on device_register()
 failure in ps3_system_bus_device_register
From: Tarun Sahu <tarunsahu@google.com>
To: helgaas@kernel.org, dmatlack@google.com, 
	Nicholas Piggin <npiggin@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	sourabhjain@linux.ibm.com, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Russell King <linux@armlinux.org.uk>, radheys@amd.com, 
	skhawaja@google.com, djeffery@redhat.com, Geoff Levand <geoff@infradead.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-arm-kernel@lists.infradead.org, souravsgl@google.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

As per the kernel documentation of device_register() function, it is
important to call put_device even if device_register returns an error.

To follow this guidelines and properly release the resources after
device_register() failure, call put_device() instead of kfree()

Also there are in-function-defined struct layout which make struct device
(core) to be child of layout-child's member (layout.dev.core). Also
definition of struct layout is not unique across functions in the driver.
To be able to free struct layout's dynamic allocation via put_device we
need to make sure that the core's release function must call the free
on parent of core and the parent must be at the location 0 of the struct
layout which will inherently free struct layout. This is to not
complicate the code and keep it as it currently implemented. To check
the location of parent at 0 of struct layout, I have added BUILD_BUG_ON.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/platforms/ps3/device-init.c | 83 ++++++++++++++----------
 arch/powerpc/platforms/ps3/system-bus.c  |  2 +
 2 files changed, 52 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platforms/ps3/device-init.c
index 9109c218a060..8d0c77db1764 100644
--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -90,14 +90,12 @@ static int __init ps3_register_lpm_devices(void)
 	if (result) {
 		pr_debug("%s:%d ps3_system_bus_device_register failed\n",
 			__func__, __LINE__);
-		goto fail_register;
+		return result;
 	}
 
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);
 	return 0;
 
-
-fail_register:
 fail_rights:
 fail_read_repo:
 	kfree(dev);
@@ -121,6 +119,12 @@ static int __init ps3_setup_gelic_device(
 		struct ps3_dma_region d_region;
 	} *p;
 
+	/*
+	 * ps3_system_bus_release_device() calls kfree(&p->dev).
+	 * dev must be at offset 0 so kfree() frees outer p.
+	 */
+	BUILD_BUG_ON(offsetof(struct layout, dev) != 0);
+
 	pr_debug(" -> %s:%d\n", __func__, __LINE__);
 
 	BUG_ON(repo->bus_type != PS3_BUS_TYPE_SB);
@@ -164,13 +168,12 @@ static int __init ps3_setup_gelic_device(
 	if (result) {
 		pr_debug("%s:%d ps3_system_bus_device_register failed\n",
 			__func__, __LINE__);
-		goto fail_device_register;
+		return result;
 	}
 
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);
 	return result;
 
-fail_device_register:
 fail_dma_init:
 fail_find_interrupt:
 	kfree(p);
@@ -192,6 +195,12 @@ static int __init ps3_setup_uhc_device(
 	u64 bus_addr;
 	u64 len;
 
+	/*
+	 * ps3_system_bus_release_device() calls kfree(&p->dev).
+	 * dev must be at offset 0 so kfree() frees outer p.
+	 */
+	BUILD_BUG_ON(offsetof(struct layout, dev) != 0);
+
 	pr_debug(" -> %s:%d\n", __func__, __LINE__);
 
 	BUG_ON(repo->bus_type != PS3_BUS_TYPE_SB);
@@ -252,13 +261,12 @@ static int __init ps3_setup_uhc_device(
 	if (result) {
 		pr_debug("%s:%d ps3_system_bus_device_register failed\n",
 			__func__, __LINE__);
-		goto fail_device_register;
+		return result;
 	}
 
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);
 	return result;
 
-fail_device_register:
 fail_mmio_init:
 fail_dma_init:
 fail_find_reg:
@@ -291,6 +299,12 @@ static int __init ps3_setup_vuart_device(enum ps3_match_id match_id,
 		struct ps3_system_bus_device dev;
 	} *p;
 
+	/*
+	 * ps3_system_bus_release_device() calls kfree(&p->dev).
+	 * dev must be at offset 0 so kfree() frees outer p.
+	 */
+	BUILD_BUG_ON(offsetof(struct layout, dev) != 0);
+
 	pr_debug(" -> %s:%d: match_id %u, port %u\n", __func__, __LINE__,
 		match_id, port_number);
 
@@ -308,15 +322,10 @@ static int __init ps3_setup_vuart_device(enum ps3_match_id match_id,
 	if (result) {
 		pr_debug("%s:%d ps3_system_bus_device_register failed\n",
 			__func__, __LINE__);
-		goto fail_device_register;
+		return result;
 	}
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);
 	return 0;
-
-fail_device_register:
-	kfree(p);
-	pr_debug(" <- %s:%d fail\n", __func__, __LINE__);
-	return result;
 }
 
 static int ps3_setup_storage_dev(const struct ps3_repository_device *repo,
@@ -327,6 +336,12 @@ static int ps3_setup_storage_dev(const struct ps3_repository_device *repo,
 	u64 port, blk_size, num_blocks;
 	unsigned int num_regions, i;
 
+	/*
+	 * ps3_system_bus_release_device() calls kfree(&p->sbd).
+	 * sbd must be at offset 0 so kfree() frees outer p.
+	 */
+	BUILD_BUG_ON(offsetof(struct ps3_storage_device, sbd) != 0);
+
 	pr_debug(" -> %s:%u: match_id %u\n", __func__, __LINE__, match_id);
 
 	result = ps3_repository_read_stor_dev_info(repo->bus_index,
@@ -395,13 +410,12 @@ static int ps3_setup_storage_dev(const struct ps3_repository_device *repo,
 	if (result) {
 		pr_debug("%s:%u ps3_system_bus_device_register failed\n",
 			 __func__, __LINE__);
-		goto fail_device_register;
+		return result;
 	}
 
 	pr_debug(" <- %s:%u\n", __func__, __LINE__);
 	return 0;
 
-fail_device_register:
 fail_read_region:
 fail_find_interrupt:
 	kfree(p);
@@ -445,6 +459,12 @@ static int __init ps3_register_sound_devices(void)
 		struct ps3_mmio_region m_region;
 	} *p;
 
+	/*
+	 * ps3_system_bus_release_device() calls kfree(&p->dev).
+	 * dev must be at offset 0 so kfree() frees outer p.
+	 */
+	BUILD_BUG_ON(offsetof(struct layout, dev) != 0);
+
 	pr_debug(" -> %s:%d\n", __func__, __LINE__);
 
 	p = kzalloc_obj(*p);
@@ -461,15 +481,10 @@ static int __init ps3_register_sound_devices(void)
 	if (result) {
 		pr_debug("%s:%d ps3_system_bus_device_register failed\n",
 			__func__, __LINE__);
-		goto fail_device_register;
+		return result;
 	}
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);
 	return 0;
-
-fail_device_register:
-	kfree(p);
-	pr_debug(" <- %s:%d failed\n", __func__, __LINE__);
-	return result;
 }
 
 static int __init ps3_register_graphics_devices(void)
@@ -479,6 +494,12 @@ static int __init ps3_register_graphics_devices(void)
 		struct ps3_system_bus_device dev;
 	} *p;
 
+	/*
+	 * ps3_system_bus_release_device() calls kfree(&p->dev).
+	 * dev must be at offset 0 so kfree() frees outer p.
+	 */
+	BUILD_BUG_ON(offsetof(struct layout, dev) != 0);
+
 	pr_debug(" -> %s:%d\n", __func__, __LINE__);
 
 	p = kzalloc_obj(struct layout);
@@ -495,16 +516,11 @@ static int __init ps3_register_graphics_devices(void)
 	if (result) {
 		pr_debug("%s:%d ps3_system_bus_device_register failed\n",
 			__func__, __LINE__);
-		goto fail_device_register;
+		return result;
 	}
 
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);
 	return 0;
-
-fail_device_register:
-	kfree(p);
-	pr_debug(" <- %s:%d failed\n", __func__, __LINE__);
-	return result;
 }
 
 static int __init ps3_register_ramdisk_device(void)
@@ -514,6 +530,12 @@ static int __init ps3_register_ramdisk_device(void)
 		struct ps3_system_bus_device dev;
 	} *p;
 
+	/*
+	 * ps3_system_bus_release_device() calls kfree(&p->dev).
+	 * dev must be at offset 0 so kfree() frees outer p.
+	 */
+	BUILD_BUG_ON(offsetof(struct layout, dev) != 0);
+
 	pr_debug(" -> %s:%d\n", __func__, __LINE__);
 
 	p = kzalloc_obj(struct layout);
@@ -530,16 +552,11 @@ static int __init ps3_register_ramdisk_device(void)
 	if (result) {
 		pr_debug("%s:%d ps3_system_bus_device_register failed\n",
 			__func__, __LINE__);
-		goto fail_device_register;
+		return result;
 	}
 
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);
 	return 0;
-
-fail_device_register:
-	kfree(p);
-	pr_debug(" <- %s:%d failed\n", __func__, __LINE__);
-	return result;
 }
 
 /**
diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index 0537a678a32f..0918c74d3e19 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -774,6 +774,8 @@ int ps3_system_bus_device_register(struct ps3_system_bus_device *dev)
 	pr_debug("%s:%d add %s\n", __func__, __LINE__, dev_name(&dev->core));
 
 	result = device_register(&dev->core);
+	if (result)
+		put_device(&dev->core);
 	return result;
 }
 
-- 
2.55.0.691.gc56d675ccc-goog


