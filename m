Return-Path: <linuxppc-dev+bounces-23995-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D96C44506
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 06:14:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxM4S1sr9z30DH;
	Fri, 10 Jul 2026 16:14:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783664088;
	cv=none; b=lx2r/3zgtCXNq84Pmalk6pM0bglvMdZwbLubGmRL7YXIVvSN9EViIkvx3/P0ts7Bs5DHqi8TyHWgJOXol87Tz9B9iJRqpU6Nc7Q36KyEkOXzg+va8qNuyHueg8iM7kMXEdSbq3nrZWzxTK3mEnnyMCpu23GpvoMQaajhHdKgsQ3k+bCu5KELfc82I7dfReUIEtPi31IvIt0z1NWFb0OZLIei4eFS8wzIlPtfIhFkKdpQq3gg3mmrzf5Ox3MAMMNnmSn5aa8nv4iNjCvcy0hFKNLm6nL3qjhrXOz0gvMzkgdsbXdWN1RHaCoOnB3ZJM2gRB0jlqqIkB3mVKaa3+x1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783664088; c=relaxed/relaxed;
	bh=KeykUqcfS6kSddaqoR26cUAfULRKNnrxqKDAbIPyu7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hk/IF5ZfXoJk6IG1w+7IrVYCkJfUB1Cc1kRUZ35+a7IQQuslqQ9UPUTlCHNNJSezGSHjH9VKSxfrCXv1dRoVvWdDDhNH7Ci5y5mdyC2kQ//7mnK68ElBRCUR7N5I2hNRmWttyxxT7dr+9jzAyF5icfdFpipBUSLB4JdnKOW6Gqkr5jo2DyDnzvrgFgX/ieL+BvbvY32m/naA5xLLTKfy/P+bb6p3rHMfNbFtmD5berNJnpOsVX71f8XzWrJedIpSkThKlMlPoimIu/KPT9nJFao9h+XW5xoBMEyWJM2DhwOCf/shI5ZUfTyd0aNt2VphmO0NqtVTuZUwnYBhiATGJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rfqSOWFB; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=gdnbHJ8A; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rfqSOWFB;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=gdnbHJ8A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxM4R3Cdgz30CX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 16:14:47 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783664079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KeykUqcfS6kSddaqoR26cUAfULRKNnrxqKDAbIPyu7s=;
	b=rfqSOWFBe6ZBGrww84NxwVEEFFYktr4d9mPlzoROjIvD1qBZz82aQQAVHGCx0vf/73Ig6n
	Flelik/aO36kCfL+q+WDU2u6tUR1km9iNe4gKlNC8TG27c7XS+u88+yA0GuLi55OC7U/Em
	iWfeLR2Oe5fKIApvv+7aLbcv5TynBRUCEJQ/ctb+dcIfU9emRqRc77knyHDqbeHp/IDj0Q
	8sBpZ1bP636AXYLxIz8MTzLCZwVHfMmxEV/oOuugUPe1VZtcoT1tMBZqY3Z+E017KEZvYt
	nF3gaNUU9jnBbgInAVZLA+VY2z5efvvfTioSq31qBbQUWnBv5DO8yCls/+YaMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783664079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KeykUqcfS6kSddaqoR26cUAfULRKNnrxqKDAbIPyu7s=;
	b=gdnbHJ8AqQGFpQjvt1SqWSLIOP6qJ26Fo6dxYb1VcrWV87AwAdv8e42eywek+qY+GCnU/f
	9nUOFwFXsaJGOdBA==
Date: Fri, 10 Jul 2026 08:14:27 +0200
Subject: [PATCH 1/2] powerpc/vdso: Add support for vDSO installation
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260710-powerpc-vdso-install-v1-1-3015af1aa354@linutronix.de>
References: <20260710-powerpc-vdso-install-v1-0-3015af1aa354@linutronix.de>
In-Reply-To: <20260710-powerpc-vdso-install-v1-0-3015af1aa354@linutronix.de>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783664073; l=823;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=zIO7ClxdVaWBcm23hUcNtdZ9oCwPASP5zGs0nWIrlZM=;
 b=BA5VTuCjLOLSlet43qfCm5Q5yZ49P7svxBvqg+OdtDZZKjP67wTzEbbqes8uqF2T1UJOFQdy0
 tlYK3XnTK9ODM2G1dzwimcAt8s1oE2i7SfyFp4iougDqSlvIZGjHD4Q
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

From: Thomas Weißschuh <linux@weissschuh.net>

'make vdso_install' can install the unstripped vDSO files,
so that they can be shipped to the target system for debugging purposes.

Add the necessary variables so this also works on PowerPC.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/powerpc/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a58b1029592c..78112e032c50 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -391,6 +391,9 @@ vdso_prepare: prepare0
 		$(build)=arch/powerpc/kernel/vdso include/generated/vdso64-offsets.h)
 endif
 
+vdso-install-$(CONFIG_VDSO32)	+= arch/powerpc/kernel/vdso/vdso32.so.dbg
+vdso-install-$(CONFIG_PPC64)	+= arch/powerpc/kernel/vdso/vdso64.so.dbg
+
 archprepare: checkbin
 
 archheaders:

-- 
2.55.0


