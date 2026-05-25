Return-Path: <linuxppc-dev+bounces-21468-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2887CD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 10:45:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPCGX0dcDz2xbN;
	Mon, 25 May 2026 20:45:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.149.242.128
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779693608;
	cv=none; b=DfYlbtcIRqdIxLnw2FGMYV0GxMoXFO7RzfvuC6rmnszbWqWHUt7iV8OSWeHjbOHteOreSA+k2Q1ez48Gt7GVDJAaVY5h99z0KOlrqxp2W/wE022vGSoHKBP/ZOZhFM8X0Y2J7f2tZxg9FtYfRTChcFl4hZcuRA6qH4k4CMcpwQUYB6v+kWiQWzHTZU0mMcZw5sD4MF/XVjgURjosSKgQnfcAIdZd6XFHsHhRp6rWewNv1QiaqBfYvh/iEI9rSIRUKYribYkAiLSIKApW2xOkPnYA2Tt1wEfFBi8aHzJA8foK4QBoJoybcKN4II3Cuwpw68vsgNm6YGwRihdMwhPjuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779693608; c=relaxed/relaxed;
	bh=FSPlzs2arfc5IQb4eW/8WkmdON8YANDuE11YBYOEbL8=;
	h=Message-Id:Cc:Content-Type:Subject:Mime-Version:From:Date:To; b=Ek6w6v7eAEvvKQgulEIZ0fuTS2jSo665Fm6YHGmpuiSm+y7Dl1XapjJAjY8yItKu/6wdcVg3Sr+Hs6Py+kqD6P0ZJjzhVsKwfIO8qdkvU415GFNkm8d8snUt+Pj1aEQFb7oq1JcuSgD6msSXKDZXv/TrMYkmoSnl9A1t2H/vrcGVEixks9dia3Satwtk51zDs+K0v4IFtnrBPc66YCSGHASDvtdO8H8FlChEc5P3ZdByE3tvwChSgFWmpP8AphRCzrLfN9r4majZvqqmItwEq2UjmMKBtxxyJ0GVAikhS191/VV2JUeser6U8hi8vC/xenyx4vkYs5275TYVgRyRXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=n8KD4sOS; dkim-atps=neutral; spf=pass (client-ip=103.149.242.128; helo=lf-1-128.ptr.blmpb.com; envelope-from=yanfei.xu@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=n8KD4sOS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=103.149.242.128; helo=lf-1-128.ptr.blmpb.com; envelope-from=yanfei.xu@bytedance.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 929 seconds by postgrey-1.37 at boromir; Mon, 25 May 2026 17:20:05 AEST
Received: from lf-1-128.ptr.blmpb.com (lf-1-128.ptr.blmpb.com [103.149.242.128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gP6j12WnBz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 17:20:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779692535; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=FSPlzs2arfc5IQb4eW/8WkmdON8YANDuE11YBYOEbL8=;
 b=n8KD4sOSLz78RhwV62EDGGMUc8UtaywsjsAopjIbOMsrDioHdfebXQzG4eMWm5X1OfNVbi
 xqhSA4KL8Kt3OGmJVWVm7EqTAmmtXMRPNRx3NeY4vgPas14jlUsF6wUpIkplDNiwoWNG9r
 CpXHnKOWAD6jLY1NYqasdwQMjclfamR3tUCQ8OrnAbcuSOR9gWvuhZNtnniucOHp7sU0eo
 x2afAQ6huL+oBF6zq8lKPh+mKvINo9pYQa/mRwrDfQ4xA7auJPZaX3XoIpJwXrb7KFX179
 lL0Qy+4Dj7TSmINrtt6BOCQbvoMiqXzYy9MM04W7WwOl2G+AKAzF1Or7gtJikQ==
Message-Id: <20260525070154.495455-1-yanfei.xu@bytedance.com>
Content-Transfer-Encoding: 7bit
Cc: <kvm@vger.kernel.org>, <loongarch@lists.linux.dev>, 
	<linuxppc-dev@lists.ozlabs.org>, <caixiangfeng@bytedance.com>, 
	<fangying.tommy@bytedance.com>, <yanfei.xu@bytedance.com>, 
	<isyanfei.xu@gmail.com>, "Sashiko" <sashiko-bot@kernel.org>
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH] KVM: Validate irqchip index for LoongArch and PowerPC
X-Lms-Return-Path: <lba+26a13f3f5+b1c5c7+lists.ozlabs.org+yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
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
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
Date: Mon, 25 May 2026 15:01:54 +0800
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
To: <zhaotianrui@loongson.cn>, <maobibo@loongson.cn>, 
	<chenhuacai@kernel.org>, <maddy@linux.ibm.com>, <npiggin@gmail.com>, 
	<sashiko-reviews@lists.linux.dev>, <seanjc@google.com>, 
	<pbonzini@redhat.com>

Sashiko reported that irqchip index is not validated for LoongArch and
PowerPC. Add validation and reject out-of-range irqchip indexes to avoid
indexing past the routing table's chip array.

Fixes: de9ba2f36368 ("KVM: PPC: Support irq routing and irqfd for in-kernel MPIC")
Fixes: 1928254c5ccb ("LoongArch: KVM: Add irqfd support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/kvm/20260525051714.485D51F000E9@smtp.kernel.org/
Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
---
 arch/loongarch/kvm/irqfd.c | 3 ++-
 arch/powerpc/kvm/mpic.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

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
diff --git a/arch/powerpc/kvm/mpic.c b/arch/powerpc/kvm/mpic.c
index 3070f36d9fb8..fb5f9e65e02e 100644
--- a/arch/powerpc/kvm/mpic.c
+++ b/arch/powerpc/kvm/mpic.c
@@ -1833,7 +1833,8 @@ int kvm_set_routing_entry(struct kvm *kvm,
 		e->set = mpic_set_irq;
 		e->irqchip.irqchip = ue->u.irqchip.irqchip;
 		e->irqchip.pin = ue->u.irqchip.pin;
-		if (e->irqchip.pin >= KVM_IRQCHIP_NUM_PINS)
+		if (e->irqchip.pin >= KVM_IRQCHIP_NUM_PINS ||
+		    e->irqchip.irqchip >= KVM_NR_IRQCHIPS)
 			goto out;
 		break;
 	case KVM_IRQ_ROUTING_MSI:
-- 
2.20.1

