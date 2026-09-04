Return-Path: <linuxppc-dev+bounces-26566-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B32C79F80
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 17:16:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hc35x0Fs3z2yrW;
	Sat, 05 Sep 2026 03:16:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::646"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788542180;
	cv=none; b=mO0MpL5nd+cx4+oiX4gns6YzJXTMKKY3CccLUHtRI/nW0M2NlY4Ty0NXeckz2V5MWi/xAS57b/P84DjVDnc7P4uu4wSTh9dtpXHrQwqB5Em1xrkPOI5Ye+whzMutUpglZEU7gWnyUCnMwOsz6xJYwfIbyU2uWzoMzcTxcMrv5m7vhlpWS5LNnI3ssJJAlJuiLpSd0cXnzv0s3uu2HRC61EVdyv3bC/EGluasL43Mxn2TQP1nVBwGoHBvleN+z9mDZrQEzBjAj7ctSlMG6hRB5OrSnKRU5AVL8N6fwAV9C9BY/2TSmnKhTcTvypyg4wVUuGgdGoaYQxNV/AT+PXsIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788542180; c=relaxed/relaxed;
	bh=lHu65GRGtE9tAA3U30k5Ff4J4ZEkOWgVLpTedANrfZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OsIw6zrBxzyRsYZV3aSSi+Kg3/JhVv2IwV8OKxapg0uwm+ipyPzlp10RlBEVmDleqpuHKNde77IJ/Fd9quO9wHrpuq6oQClcjfYT/bOnwwMpF/a+LRI29hg+RR9McIeXSGBqehhmmOmfFKS/g4bQq7LJdWVsqyeJktU4V+PeduSFFgr5FbDIvhXQRHNbuy4s8eMqGFPtPZzv7Ox1PXktmeqBJPHiekA4YGIy1FeQodIOktTUnDpnZZXyNB7E3ZplnBj5lTR/wqN6pVX/bg60EKUaZ6SSPWU2ZaBFobOlIUPzBnAZ0muYgzUSqfOAKVCA+tNrdeo97SJgYYDkH6gEug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=eeNMM+6A; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::646; helo=mail-ej1-x646.google.com; envelope-from=33fyaagkkdj4r8pslq8fsemmejc.amkjglsvnna-bctjgqrq.mxj89q.mpe@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=eeNMM+6A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--tarunsahu.bounces.google.com (client-ip=2a00:1450:4864:20::646; helo=mail-ej1-x646.google.com; envelope-from=33fyaagkkdj4r8pslq8fsemmejc.amkjglsvnna-bctjgqrq.mxj89q.mpe@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x646.google.com (mail-ej1-x646.google.com [IPv6:2a00:1450:4864:20::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc35v1kTRz2y22
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 03:16:18 +1000 (AEST)
Received: by mail-ej1-x646.google.com with SMTP id a640c23a62f3a-c250f2d4b3dso101648966b.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 10:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788542174; x=1789146974; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lHu65GRGtE9tAA3U30k5Ff4J4ZEkOWgVLpTedANrfZQ=;
        b=eeNMM+6Ap5SRmW4DYjO0bJ7pKxWv7TlWHvmzDHuaa7R50uQS4INmO25Y6ZFwZmoj+w
         SfEu7wLuV9ZoKZ8YJtF/lHuKz3DAmWTJ7wwiJvzcR/d8ETe6/M4ROD1ugj8EwlIHC96v
         7BY5NSL1LbNe/Rka+XpLddjIoK+piIPBzfuIYH3/zA0UhHXFPDN752wxuYgcEMuL3Zuh
         hogmgGEH1J2ODY7p2jchRzlaGZGGlUVi6FZ69RrfToKjgRCME65nm+AJoIqKg9fufDrm
         xLsRZUaLETv0ejTal/nR3eoz59wmun3jLhlx8DothVt/AC8LcxPmCUJ538OJqHordQXk
         1V6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788542174; x=1789146974;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lHu65GRGtE9tAA3U30k5Ff4J4ZEkOWgVLpTedANrfZQ=;
        b=H5+JCfS8a2ZJyJ+dEQR6vd10aTyaDJDGk6FAYQcOc6xKteUSV8s7s5/7wvaw1QJWEX
         sbGsv6lL47Os7j+qdUQ+9ADWXMrQ1BDKBSa4cWBDp1UVZssHvJYrs5Ry5mfPAjQKdHkc
         FLf3S3Z0O/0o9GD7FkmuKfpCnMQ3IPZEFE8kbDZ4uzDbrgZicK1XZiR0HfNfAvqA3HO7
         9E7ptiuAhg7sHp7z715yqP3aUKLsiM4F6b13zWrK56tOoGrisG3VgqK5wfhUYlN0oPWo
         szpJ9C1+1dooac+pQvhmac5LRksXPYgfZPMz+n21JpCqez51uMuE9BV4NXnxMHjlGOKk
         aDPg==
X-Gm-Message-State: AFuF++nbsbmz1qVxPY6MUnNZQwVE10FAt3LydsQj9jRGCEIhxhWm2aEB
	EhpG6pEdHFYeOEDsYeDw0VbPqPLoi4uM2xR90nfN6QKxm8oOcegXLY4zDPFYvn2H/KiktOY0OL3
	8qWP3UyvL/CMurZaxpQ==
X-Received: from ejczw3-n1.prod.google.com ([2002:a17:907:e003:10b0:c25:d60:eff0])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c16:b0:c1f:e9d9:64d4 with SMTP id a640c23a62f3a-c260c9cb978mr352987066b.11.1788542173879;
 Fri, 04 Sep 2026 10:16:13 -0700 (PDT)
Date: Fri,  4 Sep 2026 17:16:07 +0000
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
Message-ID: <20260904171610.3342398-2-tarunsahu@google.com>
Subject: [PATCH v4 1/3] ARM: locomo: Fix device reference leak on registration failure
From: Tarun Sahu <tarunsahu@google.com>
To: Russell King <linux@armlinux.org.uk>, Geoff Levand <geoff@infradead.org>, 
	Masakazu Mokuno <mokuno@sm.sony.co.jp>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Paul Mackerras <paulus@ozlabs.org>, helgaas@kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	sourabhjain@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

As per device_register() kernel-doc, calling kfree() directly on
error bypasses reference counting and skips the device release
callback, leaking the reference. Even in case of device_register()
failure, Calling the put_device is advised.

Fix this by calling put_device() on device_registration failure
instead of kfree().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
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
2.55.0.979.g7e5102b832-goog


