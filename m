Return-Path: <linuxppc-dev+bounces-21765-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F05CD6E5D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2026 13:57:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gSzDL3kdPz2xld;
	Sun, 31 May 2026 23:57:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.149.242.128
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780235826;
	cv=none; b=PZraD1nFLYg8YiyqtXqtwtrHVS8epCGYIsT5/1Gm257b1gJRxe/wSbCalCjCb0UGg9OwLcMvBEGbElz3nk0YjBDDu0Fy59Bwf58GfiPgbph//D/wQlu8Mi23ntOGcO7EJB5NE/UzXxQqdl9tZk1kCE+6pRNxg9xcmvUZkInfk9HFlXtnashTi//RGgP4HEMn1eSD//bp0ziZM//kxHqH4pAIIlwFRHaVeAMgMXJF94Dlv+uRsOzZnslJ4OjE9fRoPAv1axuntPakQ2RppYa1ZvKG3rbhg2f/vZ4zaPvlKfwnbmqkH8u+oy1nCyBbXII+PVmp3so39cK7f+bxJ+DYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780235826; c=relaxed/relaxed;
	bh=bkGZPnmEBvhp+vL6ky855GObJBvNEfMqOsZeKPfrh+A=;
	h=To:Date:Message-Id:In-Reply-To:Mime-Version:References:
	 Content-Type:Cc:From:Subject; b=HwjSQwQFrApZ+LChWs/ecknFgLT37qWI5UY6dJSqyRDZ9MxAO0hgEdpjR3wNBsrQwMygMbRFNECrXtz4YXq/iqJeK0if7raU0M3h8JDovW2+ehZqcIsLuKiIP31Pgef0uvMLYVhlYqu+XHqSISDFEke4GPxkh5zOjeIe23NNbcDK8CYyrcGOxZ7JUU8xqHTG4p2lGqsFiNRp4hAb4Aciig7Tt2z6vjcW3gzRY/BUPYLo5Cqw54E1WatG9y6hI5Uv+Zybztu3xJT4rNW/v207iaJyTaxz+axX1ciiLScGno/YWzF69fufNnxzWArJYmNPYonIRJl4+/2vU27BFG/rLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=SseuZs/8; dkim-atps=neutral; spf=pass (client-ip=103.149.242.128; helo=lf-1-128.ptr.blmpb.com; envelope-from=yanfei.xu@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=SseuZs/8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=103.149.242.128; helo=lf-1-128.ptr.blmpb.com; envelope-from=yanfei.xu@bytedance.com; receiver=lists.ozlabs.org)
Received: from lf-1-128.ptr.blmpb.com (lf-1-128.ptr.blmpb.com [103.149.242.128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gSzDH4y21z2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2026 23:57:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780235684; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=bkGZPnmEBvhp+vL6ky855GObJBvNEfMqOsZeKPfrh+A=;
 b=SseuZs/8i9bgjoyS2ZTc3Okt7SaapqCGpeDK0B3zKSRzHckhnw4OMLb6/dpEabuX+lm2SO
 mbLzKQ6Eqlg18189wGNpl7B9R0jvEZpogz7TD+97g/AzjJHeNal4uPe2AR2herBADmqCRv
 QQ9Vb3he6KbCmCimo2QGj1KJM73p3D2tuOYGTlVXcinXpQjJYguhdunlXw91+joEE3Fad4
 NlhFHktjMKvsXTN+Gp046rGozolhsWSpmkRjfcjOZhExJjanjzYUSh7nbu7FEhnkGba1zG
 EC18JGB6Po8fQhiDWmeoUOjwsVh40e6za9pJtPbI1BlS1SzN9kr2IKrKPOn5Cg==
To: <harshpb@linux.ibm.com>, <zhaotianrui@loongson.cn>, 
	<maobibo@loongson.cn>, <chenhuacai@kernel.org>, <maddy@linux.ibm.com>, 
	<npiggin@gmail.com>, <sashiko-reviews@lists.linux.dev>, 
	<seanjc@google.com>, <pbonzini@redhat.com>
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7bit
Date: Sun, 31 May 2026 21:53:25 +0800
Message-Id: <20260531135326.2238555-2-yanfei.xu@bytedance.com>
In-Reply-To: <20260531135326.2238555-1-yanfei.xu@bytedance.com>
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
References: <20260531135326.2238555-1-yanfei.xu@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: <kvm@vger.kernel.org>, <stable@vger.kernel.org>, 
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>, 
	<caixiangfeng@bytedance.com>, <fangying.tommy@bytedance.com>, 
	<yanfei.xu@bytedance.com>, <isyanfei.xu@gmail.com>, 
	"Sashiko" <sashiko-bot@kernel.org>
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
Subject: [v2 1/2] KVM: LoongArch: Validate irqchip index in irqfd routing
X-Lms-Return-Path: <lba+26a1c3da2+d6e7b3+lists.ozlabs.org+yanfei.xu@bytedance.com>

Sashiko reported that the irqchip index is not validated for LoongArch.
Add validation and reject out-of-range irqchip indexes to avoid indexing
past the routing table's chip array.

Fixes: 1928254c5ccb ("LoongArch: KVM: Add irqfd support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/kvm/20260525051714.485D51F000E9@smtp.kernel.org/
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
---
 arch/loongarch/kvm/irqfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kvm/irqfd.c b/arch/loongarch/kvm/irqfd.c
index f4f953b22419..40ed1081c4b6 100644
--- a/arch/loongarch/kvm/irqfd.c
+++ b/arch/loongarch/kvm/irqfd.c
@@ -51,7 +51,8 @@ int kvm_set_routing_entry(struct kvm *kvm,
 		e->irqchip.irqchip = ue->u.irqchip.irqchip;
 		e->irqchip.pin = ue->u.irqchip.pin;
 
-		if (e->irqchip.pin >= KVM_IRQCHIP_NUM_PINS)
+		if (e->irqchip.pin >= KVM_IRQCHIP_NUM_PINS ||
+		    e->irqchip.irqchip >= KVM_NR_IRQCHIPS)
 			return -EINVAL;
 
 		return 0;
-- 
2.20.1

