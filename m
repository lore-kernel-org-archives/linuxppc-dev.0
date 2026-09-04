Return-Path: <linuxppc-dev+bounces-26568-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB996C79F80
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 17:16:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hc35y0tLDz2yvM;
	Sat, 05 Sep 2026 03:16:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::546"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788542181;
	cv=none; b=FiXla4RnceO7+zxuHVUkV5Q596QT08D6XLE2fR9x0HLoo8FTZpZcgTSUgN/pUuhGOEMlktqxQ8LBkvv2Xv0iqabxdLycCYq1Hu1137RfNgTdjr2gC62nTS8i3xhYiiEuB89s7+9hWv6nksvE3IIXYd0Rd/2ze7R8dsBZcMqL5xPMTfXZT/YlWaZAXtTFaqSTh6Qqhfc6jnRRmdfmaS5nCgbB7aWn6VnrwTw3XWIRg4IoF2qSfbpbZTLOsUiHuhck18h9V/fEAv8WpGC+gKkuBSXyEIiJkFi/YKVQGu1v0wAHWGmgSHhI+HUjTPpc7el2ydpg05MSoStYWIboZT0xXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788542181; c=relaxed/relaxed;
	bh=NikJEXjNYjtOdRdsXEH0yQrsx5J1yuBuYOZC90aY1Z4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C+d75idgnZ5IIkc3B0QS2x3YfI/K7OWHExa8mjEVMOe3X1Q9omVCUh/FJVFkRUM4AJnp6hUfMbA5OLtfRB0sFZ6uExWx/DZHpm8bf07MBx+lXoUlDn/5YkNmqCwKzs8CIdhu3wyA3YRBlJ8Z/HBVHqe/iuSCk2pcc1kPEO3A6fsJ5bAtESe86RAh77da3jkP+HFdaYlbtvCE2MFyt5TKCUbeGGKENvpxPkODtZBU+cf9aZ6nGsMxXQnyeDm3lpeDXqJDwXM4Y2cYSAop6NVHAvLMJe98Ke+uI1NAcpQQyi3WOjeYEGy9hbib2h1+zIjBvk3kiFxaSeROVWe7qbEIcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LRmEVT9Y; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::546; helo=mail-ed1-x546.google.com; envelope-from=34pyaagkkdkeubsvotbivhpphmf.dpnmjovyqqd-efwmjtut.pambct.psh@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LRmEVT9Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--tarunsahu.bounces.google.com (client-ip=2a00:1450:4864:20::546; helo=mail-ed1-x546.google.com; envelope-from=34pyaagkkdkeubsvotbivhpphmf.dpnmjovyqqd-efwmjtut.pambct.psh@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x546.google.com (mail-ed1-x546.google.com [IPv6:2a00:1450:4864:20::546])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc35w0jnXz2yr2
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 03:16:19 +1000 (AEST)
Received: by mail-ed1-x546.google.com with SMTP id 4fb4d7f45d1cf-6a5d46edd1eso1285316a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 10:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788542177; x=1789146977; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NikJEXjNYjtOdRdsXEH0yQrsx5J1yuBuYOZC90aY1Z4=;
        b=LRmEVT9Y9qLznId8rhc5Cg3LmxD56QSvB5Ob+a2ap8BdGxYtl9TyiBeSLlDrkthxPz
         io+5ohObwpRgjMgXib1D3o4R++oyymVo1OsGsuKS7ve4bGUVP+uRh1GNLIT1Iq06lDRQ
         xgk6Myv42LM0a4+rEBjJljhHdHQkI4ZTKYhrKg28cGBDXSJCrm4CqmMQ5j/7SYvh2nRe
         OuBG9/8SQDOWvg+C5Po1ptw49N3BOhmYY80tKVx5528UPXsfvmhL0msZXOrI0M2Kkgw0
         qrT37FykH6IVWpmzKXw6a4W4KnzdtiPhJDHaLl7luAu4wi3SUBZskjE1pr9+N+3GM2Om
         Ix9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788542177; x=1789146977;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NikJEXjNYjtOdRdsXEH0yQrsx5J1yuBuYOZC90aY1Z4=;
        b=UYi/EBsfo+Nme7/exMhgk+J6DF+fHQcOC5PN8J8MRZ3gxpx85XsG35vVXFkZao9tNz
         TgIYoclCwa6ebuR5PxBJ9n2dsTtu0rhhFYK/oyMW48BPX1reJZu1+IJNqGeMqNbny9jx
         9Eit9rdJH1CqLcAkg7DewAY5/kMSsPhkMgItmyg4A0gI2aPnFQ+l3miqp43ykIlg+zFz
         JHIAU9A2SGN/wcyuwq5n79uNWwG8LwPxYd8eEdGQDBFgg66KTOC0qmr4/uaKXG+i58+6
         mPqF801jUGvkeV+RDymQOrEmuQhKsb3p05pj7Stt6yaXzQWLmC7Ek41cRwr+BBb1lg4S
         PG2w==
X-Gm-Message-State: AFuF++lHyMXmwD7Nd8VRZyi7WoWXglIX3IIxj+QqPoFjTmW9UQXGuG1j
	XlDZuUaEQVm2EurM+/RDgOPPCzvtCkoXszVWdpM34pFR7Kx6A/JIfFELYh8ch8MtjTQI08WlOvF
	Q8QDGGAjq/iSA/moz/g==
X-Received: from edfy24.prod.google.com ([2002:a05:6402:a3d8:b0:6a7:e348:5a70])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:a256:20b0:6a7:ee54:f8a6 with SMTP id 4fb4d7f45d1cf-6a7ee55000fmr1421309a12.42.1788542176533;
 Fri, 04 Sep 2026 10:16:16 -0700 (PDT)
Date: Fri,  4 Sep 2026 17:16:09 +0000
In-Reply-To: <20260904171610.3342398-1-tarunsahu@google.com>
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
References: <20260904171610.3342398-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904171610.3342398-4-tarunsahu@google.com>
Subject: [PATCH v4 3/3] powerpc/ps3: use put_device() on device_register()
 failure in ps3_system_bus_device_register
From: Tarun Sahu <tarunsahu@google.com>
To: Russell King <linux@armlinux.org.uk>, Geoff Levand <geoff@infradead.org>, 
	Masakazu Mokuno <mokuno@sm.sony.co.jp>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Paul Mackerras <paulus@ozlabs.org>, helgaas@kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	sourabhjain@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Tarun Sahu <tarunsahu@google.com>
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

Fixes: d4ad304841a9 ("powerpc/ps3: Fix memory leak in device init")
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Tarun Sahu <tarunsahu@google.com>
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
2.55.0.979.g7e5102b832-goog


