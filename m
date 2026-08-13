Return-Path: <linuxppc-dev+bounces-25820-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCBEC5CFDB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 09:54:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLLLG6GcVz2ygn;
	Thu, 13 Aug 2026 19:54:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::347"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786614870;
	cv=none; b=budo6gp+3Qdj4xmjfQCOkSVDtkenmOSx5x/taHpilMGhGvkRs54yK5Kq44THBVtH8Y8feYt/lBFvPbcL8ioHf9WSteg11g57MkDUQjVJQSfCeOtqtBCOMvEzaHjn4sd0KvO/RGw1wSTCgUPMp988cSD4lxM8EFmApunB9Py04by3iZffjNW7BRrLA+6/XSbSR/axMzkzbi03lNnkXsR6XUaPb7yH3OMTrnjIKKJtryNt3UX3Q9lf+UbDXu3G44B5t5fU9TNspN3WJZEVJrJymEuO8q6GvMcpOGuuWFJmLOoj2G8HYzDSoWFpJzKRlVaZOBH/mD8+21kr+sgGSupD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786614870; c=relaxed/relaxed;
	bh=w9wwW7mRQHxWYHcAeYLej02klFAo7h8n1OW6fMkc7LU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WIAe1HzFQoo8SESWTqCrNy6gqSo4aLLH36J1FRU7BRi/IlQBhr3VKB8rw7OHWf55RTrtUVnXCsGYUC07UruJYeWPeUGA+ZVeG31NqJFtt2kordiits+6VqzeY3MOM78+tk2jhEFY92afbCWGuJJeYOx6gZ3u9v0t2wu548WzKf15aKhPxbJmyOftA7vZSi8mLHmbIEfkLp3ki81xG6oG+oMp2WWU0ctXl0wQO/GzyTi7/06zRgzfQ97V65uX+86DFx6vc6DlF12gdiy+uOCtGruYaTh+697OQSOEKOSYx/HIOPwDNkA/RmAP/0esXOg1einUuXGLBTfypHK4/fiBeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pt7/dWdi; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::347; helo=mail-wm1-x347.google.com; envelope-from=3uzr9agkkdmo9q7a38qxaw44w1u.s421y3ad55s-tub1y898.4f1qr8.47w@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pt7/dWdi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--tarunsahu.bounces.google.com (client-ip=2a00:1450:4864:20::347; helo=mail-wm1-x347.google.com; envelope-from=3uzr9agkkdmo9q7a38qxaw44w1u.s421y3ad55s-tub1y898.4f1qr8.47w@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x347.google.com (mail-wm1-x347.google.com [IPv6:2a00:1450:4864:20::347])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLLLF19Blz2yVd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 19:54:28 +1000 (AEST)
Received: by mail-wm1-x347.google.com with SMTP id 5b1f17b1804b1-49564d4b849so8483955e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 02:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786614866; x=1787219666; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w9wwW7mRQHxWYHcAeYLej02klFAo7h8n1OW6fMkc7LU=;
        b=pt7/dWdiuH6V1rfWsQS9tK9nqXVwKPL42WybcvZJAxRdrRZedDs60X9pmExh6kmXse
         gLUiS2qa1pruOkPIAhYyfDCSW1ZAcLxbFiLclIOorvl2ePuHAG39L3UWOnXR7Shyqvx3
         PUx0CDY8GibhvaFf6Vwxm/IulA/W0iDCUo6cm2CRNGSQtjc8ZeguVispSV4kSsBLAmWH
         YeugnByTRzijZWDLEnghP3Hjd3Fa5GcR3nuxj7OIUwrQH2y1Vsq0J3qxsHd0sPgeyVkQ
         ldNDzIgVrjmXSrDM2pZtlE7C1qIv/QxjZgmXpqMmIMN+FECfD5/WewQnDi7rDwzvEVK1
         ecow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786614866; x=1787219666;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w9wwW7mRQHxWYHcAeYLej02klFAo7h8n1OW6fMkc7LU=;
        b=sojNwE5UTFHqqC7SA8lh1OJdOmVeRuL/u4wGmUlAYw+IxZ1nBUikW6cngWTCmwRXP2
         Va92Jdmranixs4ll4uLKKH5LfJ5J2a/Be244eDYqUInvphzh6C9WBVzMbdBA0GS+UFzu
         VFHqMAfh1Olr92g5sM49kLEGpjgVdPEobeSLxYDlnw72fi2ENLgCUbr1Z1f09a/9JQvh
         zSPqE0Ow1U1qMv+omUvs8hKdA94VkFz0DORRuPYtLL2xu9aiSw/q6U4zAjzRVep2mpXs
         wELaqbmgD8lwyeQcsw/Dr5Cv3C4CzSnxMxk9RdpmdHvOlkH8uv3alzHiPEH5ddBl2NB8
         rGTg==
X-Forwarded-Encrypted: i=1; AHgh+RpE1gFbWg9ltEAoaWum+MHamELU4Xb3ulgdL3N6zHhmCb51cbApCFB+0xlQ8icWUX1jsGGaTnZyofjOKAU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YziUQ7WIL/y8Ea1h1DYNCv09zMKzBkfMmcQjKIt7Se2R8Ca3U88
	+gWWAEoaRPH7G3hhkK7hzLJRLmqb0f1quS5OrIshGXUko34c3DCDWYOs/MYbsdYqTd2TkD8Ltjv
	Co2jMZzqIEPKObubnIw==
X-Received: from wmbf23.prod.google.com ([2002:a05:600c:5957:b0:495:5899:6e45])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:b99:b0:499:7a5e:4c3f with SMTP id 5b1f17b1804b1-4998215a94fmr44349825e9.1.1786614865465;
 Thu, 13 Aug 2026 02:54:25 -0700 (PDT)
Date: Thu, 13 Aug 2026 09:54:19 +0000
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
Message-ID: <20260813095421.1700945-2-tarunsahu@google.com>
Subject: [PATCH v2 1/3] ARM: locomo: use put_device() on device_register() failure
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

When device_register() fails, calling kfree(dev) directly bypasses the
device_release() callback (locomo_dev_release) and leaks internal driver
core structures allocated during device initialization.

Fix this by replacing direct kfree(dev) with put_device(&dev->dev) when
device_register() returns an error, ensuring proper refcount decrement
and cleanup via locomo_dev_release().

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 arch/arm/common/locomo.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 55e360452828..0f6689d343b0 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -223,10 +223,8 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
 	int ret;
 
 	dev = kzalloc_obj(struct locomo_dev);
-	if (!dev) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!dev)
+		return -ENOMEM;
 
 	/*
 	 * If the parent device has a DMA mask associated with it,
@@ -255,10 +253,11 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
 
 	ret = device_register(&dev->dev);
 	if (ret) {
- out:
-		kfree(dev);
+		put_device(&dev->dev);
+		return ret;
 	}
-	return ret;
+
+	return 0;
 }
 
 #ifdef CONFIG_PM
-- 
2.55.0.699.gb54405d56f-goog


