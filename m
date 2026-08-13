Return-Path: <linuxppc-dev+bounces-25822-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22106C5CFDB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 09:54:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLLLK0dFcz302l;
	Thu, 13 Aug 2026 19:54:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::645"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786614873;
	cv=none; b=Y7085rHrQf+r1dw4rCg2014r551yHyUEyn/Ybe1HEzOwv7zmdtikTFRRtdbvYZ0krZ0lv+KeJELsvjb42JcXftNnjtfis4O4AvKBpzPLsxFz6D9Eb0og/bwlsiQCD1teChKxe01TYOejqNfEb2AtbStOoMc4kslr05Bwomp2WXV4s2RU2HwptqmNPT/Cpy9fF4spvovzJWInFzT7kGslqc04TeF/2iNqn2udWNdY/RldkBOxLRdBX/8vnfw8UulODqAfrv9SNJ3o1v1sGe0AMlOB571kW77oCJotBqYIrg5BsPvDg45A3Ug8vP674wFoSvHGgw2dzoXNiF1xIKFp0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786614873; c=relaxed/relaxed;
	bh=fT6jyW0ebkoIBHvxF4dzhS8i8Cr8YB5wD7+pzVH5V5U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VoNGzpNBbuZqB8ljs809/0/RpPb91f0RO0wVnttetpu8893/yk5Sj8PngNaSaFogAPuRp2VQXQOgx/uh+ZRFBYMSbLzO05MYiDZjzEg5BuOrZd7JCdyMZdkSlydORhR5gxsrpayaNyEdIx1wxbVCLNQ19/UpF07Qd6XDMl7nyYg+bZCuauQmm0bDMOcd7b0EhwZEnH9TJx2Hm5ov5Tg3gm2w6ik+2IqSs2pmyhG7a8rMKGqaDVnTXxQQQlfJxdMolaWX31MEyJLt9iISkFUHNKWHJEivkqYdJCTOYBGRl0LEopQ+X44PbTzsyKd2gmx7hbhaxaFbp68FFBrXF5nMhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NFe097dN; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::645; helo=mail-ej1-x645.google.com; envelope-from=3u5r9agkkdmwbs9c5aszcy66y3w.u64305cf77u-vwd30aba.6h3sta.69y@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NFe097dN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--tarunsahu.bounces.google.com (client-ip=2a00:1450:4864:20::645; helo=mail-ej1-x645.google.com; envelope-from=3u5r9agkkdmwbs9c5aszcy66y3w.u64305cf77u-vwd30aba.6h3sta.69y@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x645.google.com (mail-ej1-x645.google.com [IPv6:2a00:1450:4864:20::645])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLLLH4pzBz2yqd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 19:54:31 +1000 (AEST)
Received: by mail-ej1-x645.google.com with SMTP id a640c23a62f3a-c15deb3377eso118852166b.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 02:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786614868; x=1787219668; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fT6jyW0ebkoIBHvxF4dzhS8i8Cr8YB5wD7+pzVH5V5U=;
        b=NFe097dNvy8SP83cowlE+zQdoLxx7upRcyZOgyvq3/RIZun8mUHIjRp1tYcmJ8Mebp
         HvjYMS/Gj26TFYFC7CgbHWyCRZTTd9KhtS8twso21WGEktRBD1aWu3h5WYxgm3NpTMeD
         axPhMcv2uXosTOvyN2yEH+SsFfGKGOE7P2KWwCu1IQ07g8fnv5d5NDnH8HHksVbz3uYz
         Vg6TvwDY1QBVA69BwClDWq9R5lpD/hRoKvNJD+QyD2NSHnt1Tq8cGkwnKQ6tIIqPYlj/
         edd7KvCMoBnpdEEpbrl8yp6XTTPVxNFmaIVw1Wm4neTV8VhrCAaV3G0ofnu0b5ELvSMX
         2gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786614868; x=1787219668;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fT6jyW0ebkoIBHvxF4dzhS8i8Cr8YB5wD7+pzVH5V5U=;
        b=tBSoE1RP/xPcZMoLm/6Xxufe12G2lu3dwVuf70JTQ5BF6+aRVvqwgaR4HjVweg3iQv
         Eg5UFyAiHgSXnGqhWrSqaJPFBd4Jxe9xtCPvZ4lkjqOvNB1f/ZO4rO/msirk21QOz+BJ
         OkZn89fvd4fKnMr5w0Qc+wXV7BoSlCviOICMrnqTWdktfPoSAEIIGYneuNwazefKtP6D
         XGVfJfUVPYzBkGVF06TtJdKjo/1gKtAdTWrdxDrQ5npxUAci4Ymb1JUdFHjL/xjKDBdu
         sXSmlTUxylGmvA1A04QnbKgf/CGLkvIcb9pW0czBnTo+WnCudJeXkodExmgrTg5rXqWa
         zK2Q==
X-Forwarded-Encrypted: i=1; AHgh+RqjYx4xLRO9RG1u+H/EWFIRDa9ZPOexrQ5ylUCehTyr2AIQR35ScJ0+O0+HGIEsW8c/thDz9h4dvcFuN74=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxKsnddA8R1Jbnme6LJkJwPuxRvgzyxH/AjuwfHZbnDfQs2t8BU
	IUetKceDepsvvXoDOhjNV9nAztgnnkSJxEkz0Uu62omk2/z+N3d2PKulvNIizmt5VYXa6qxKm50
	KpjyaJFDoJq/yEwnNWg==
X-Received: from ejbdx22.prod.google.com ([2002:a17:906:a856:b0:c21:1508:2a])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:a689:b0:c20:31d1:a899 with SMTP id a640c23a62f3a-c2108f37134mr206587566b.4.1786614867700;
 Thu, 13 Aug 2026 02:54:27 -0700 (PDT)
Date: Thu, 13 Aug 2026 09:54:21 +0000
In-Reply-To: <20260813095421.1700945-1-tarunsahu@google.com>
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
References: <20260813095421.1700945-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.699.gb54405d56f-goog
Message-ID: <20260813095421.1700945-4-tarunsahu@google.com>
Subject: [PATCH v2 3/3] powerpc/ps3: use put_device() on device_register()
 failure in ps3_system_bus_device_register
From: Tarun Sahu <tarunsahu@google.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Russell King <linux@armlinux.org.uk>, Geoff Levand <geoff@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, djeffery@redhat.com, 
	Nicholas Piggin <npiggin@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, dmatlack@google.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, souravsgl@google.com, skhawaja@google.com, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

When device_register() fails, calling put_device() ensures that the
device reference count drops to 0, which invokes the release callback
ps3_system_bus_release_device() to cleanly free the device and its
associated driver core resources.

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
2.55.0.699.gb54405d56f-goog


