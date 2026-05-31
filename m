Return-Path: <linuxppc-dev+bounces-21766-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A4FCD6E52
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2026 13:57:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gSzDf3ttxz2xld;
	Sun, 31 May 2026 23:57:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.149.242.129
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780235842;
	cv=none; b=LMDXzqqtO0vbPCO+OCjC/PfA/1O4TrLePsQPkRIStVzeQ6TX4w1U6mcIp5fQr7ziCRuEGj3qVR36UUwuLSTsnPPnh4okngScpSXIq0bLD8F0xCcyGTbNmLhTJPOstkODsocuCxaeWLr0Tq1U6wZeOmeWsvWJCjwHmtajHHe6jhrgHvvfBRr054x82/UIcWa0pyw55JgDDey+fkknHiCzDWPnCkEK0sXZUsbWz0g3WuKtYS4FsMGQ20zw2dzWooxA+4pWhWwo55x+aGf5TfBCHJ7T35M0Wubz7c1lPO+AtQ4GyRYog8Zlob3xtXOZXfvJgL+k5/kD6p5raTN5txSPeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780235842; c=relaxed/relaxed;
	bh=nR73VRGDGmpbNBrOPjjPEurTnZdfsMAaZGX1i2lVKd4=;
	h=Cc:From:References:Content-Type:To:Message-Id:In-Reply-To:Date:
	 Mime-Version:Subject; b=RME2Wq9b4+aPbxKbP4hMd8r5oizNAzM49xy8cpy6kDhioX4Gzkh8mhZhcxf5jih9AhQpQdVD+ywpOSno/b73S4GFBRPoqIU8m/W5Dts4t7BwirYFJ6plTIbBzFey+UmIcqjVf483QHbeJ5Irc7fpbAOb9eXfvH35zmhFwWO5SS+zMFB6LFjZ1xjka28y+96WcISwOwO/mfoqobfdQQ2gIfXWcVmz6PZp4owrVxmetxfUxqRhfnjaRm01FSIrMuxvWzxhB8TEW2pDeFRm2D0SSeOG8NddWFtOXOKKnyoi3tw+2Fi5rd1Ho35o01FtAjRSRDXSN1jkrZbtOQMod4qTcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=UHMAEVaV; dkim-atps=neutral; spf=pass (client-ip=103.149.242.129; helo=lf-1-129.ptr.blmpb.com; envelope-from=yanfei.xu@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=UHMAEVaV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=103.149.242.129; helo=lf-1-129.ptr.blmpb.com; envelope-from=yanfei.xu@bytedance.com; receiver=lists.ozlabs.org)
Received: from lf-1-129.ptr.blmpb.com (lf-1-129.ptr.blmpb.com [103.149.242.129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gSzDb5WjQz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2026 23:57:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780235700; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=nR73VRGDGmpbNBrOPjjPEurTnZdfsMAaZGX1i2lVKd4=;
 b=UHMAEVaVLrQBupsrPYf3W/atYCIVvdKAhmdzYCY7VONnhyG9w/k1gWCemC0TUDOXJ0BOeF
 ietFcXIVWz54sNvwviM0UVjfqm3YuDGJA2ZAyodvKBsYx3DsvTm3lgSXxjH2DsPiliEBcX
 cJj7spX7ALhVpIzIeFVDMA4ouv+m3fkluJDwjGIzyGU9DPoT5PSHwFOAMIsURT4t4eNPM9
 Qwwb+GsCEIHPfnX1m9dD5ExjOnQ0huO8/go5RGWknvr4lrszjRmVNYxretNc5z1CbL1nCW
 h5B9zDdON2v9cm/L84XGTHTgUCF+dJ/o0CplgfsKMmBFfxoQjMXw8rx3/SapWA==
Cc: <kvm@vger.kernel.org>, <stable@vger.kernel.org>, 
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>, 
	<caixiangfeng@bytedance.com>, <fangying.tommy@bytedance.com>, 
	<yanfei.xu@bytedance.com>, <isyanfei.xu@gmail.com>, 
	"Sashiko" <sashiko-bot@kernel.org>
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
References: <20260531135326.2238555-1-yanfei.xu@bytedance.com>
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
X-Lms-Return-Path: <lba+26a1c3db2+992da2+lists.ozlabs.org+yanfei.xu@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <harshpb@linux.ibm.com>, <zhaotianrui@loongson.cn>, 
	<maobibo@loongson.cn>, <chenhuacai@kernel.org>, <maddy@linux.ibm.com>, 
	<npiggin@gmail.com>, <sashiko-reviews@lists.linux.dev>, 
	<seanjc@google.com>, <pbonzini@redhat.com>
Message-Id: <20260531135326.2238555-3-yanfei.xu@bytedance.com>
In-Reply-To: <20260531135326.2238555-1-yanfei.xu@bytedance.com>
Date: Sun, 31 May 2026 21:53:26 +0800
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
Content-Transfer-Encoding: 7bit
Subject: [v2 2/2] KVM: PPC: Validate irqchip index in MPIC routing

Sashiko reported that the irqchip index is not validated for PowerPC.
Add validation and reject out-of-range irqchip indexes to avoid indexing
past the routing table's chip array.

Fixes: de9ba2f36368 ("KVM: PPC: Support irq routing and irqfd for in-kernel MPIC")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/kvm/20260525051714.485D51F000E9@smtp.kernel.org/
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
---
 arch/powerpc/kvm/mpic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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

