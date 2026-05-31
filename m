Return-Path: <linuxppc-dev+bounces-21764-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F13CD6E5D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2026 13:56:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gSzCL3VQ2z2xld;
	Sun, 31 May 2026 23:56:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.149.242.128
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780235774;
	cv=none; b=PJ0dyZVQpNyEI5Nla3wUgIGkRvZLNVArbYHpJUTYQ+W4FghlLS0eonrp0ib/AJUsSOn+e71jV7LEBBdf5CXa64qH/qT15bFotnBtDQ3McIved0QB/Ix5WZJ6PlUMJ5iHOu3xWWRCKcoa0wk1VvQ+xUBTDf/SrNLuuZYp1vkio5mLmhAKj8sL+SYcXlYZCaUMWV++MgiwaFIKzA3WSi0ngJ/3VAISfbu7DpoDBKdYeuohEZhcA9DS3X5yoxa81mseBL9UUEjPZZGVWIFHxtwgjWnGClZpXwhsWL1wxkDEqigUUcT/wu0FV0D+1s9/3XKZa3rlWEL1krsLcjI8SnLo6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780235774; c=relaxed/relaxed;
	bh=iQj5TnujvPDGBG8oYjt78Ys5Do8XcI+QaD2jG2aisX0=;
	h=Subject:Mime-Version:Date:Message-Id:Content-Type:To:Cc:From; b=Sk7b+BHgkHzC8kdDvjjIDmTbFpww8kDaNez/sTp8vazRKeENQb+FOeWTXtYof4EoVedlSdws50hbePPsJiwNd9n/QQprOTZAOcWN89L9OXZsxM7MoU2focLE7DyzXeQ6WoYleZrFMRJcAEFSRsI7bADtDwViAaEGTeXvX4ralg8ZYGZCUKRvUGPDrcT2UV9gCXPlGvHtGeVVI3Gx+6iMk3heXt+QuYar92M/jzfQTrmb8M3khmuPmjtV6SzIPW0xS2+I9EDe4Grdbf5ZmInLOdU8jZPINzdrWtIQ05ie3n6gVYahGJcJkj5rEKz7l+Xp8SuopKLH97bEO2QYZL59nA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=ALj5KvTN; dkim-atps=neutral; spf=pass (client-ip=103.149.242.128; helo=lf-1-128.ptr.blmpb.com; envelope-from=yanfei.xu@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=ALj5KvTN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=103.149.242.128; helo=lf-1-128.ptr.blmpb.com; envelope-from=yanfei.xu@bytedance.com; receiver=lists.ozlabs.org)
Received: from lf-1-128.ptr.blmpb.com (lf-1-128.ptr.blmpb.com [103.149.242.128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gSzCG6wTLz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2026 23:56:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780235626; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=iQj5TnujvPDGBG8oYjt78Ys5Do8XcI+QaD2jG2aisX0=;
 b=ALj5KvTNr1sjr2+hfosteAP5Oq/rMhhEPrnDAohSVRG9zbkL4BTKP2x4MWQpBTQ4gP1PKT
 aou0cy/p2Ep7P6KTDtQ4pjpo1Al2cR7eUsABi3kK4IDBO1wnuvQ6do/UVexRBUQbEiAJfp
 +YWSbofaJ95tKYweVt3LbFvfvb4JuMgvZ/t2LqSMNIi6RSNTDkZ88yleClpd+r9ZT2JDmr
 4PK2KMy9ieeDEey3R2ilmE2JZVWJLuIVxYT/vSNqNPjXXRblSSgDHeZcrMgDAMz3j+iZw2
 f6dyAGahyQmaiT/Bsa0trW33f0FapTTVKMbPIIvyj58FxG7yoKF6mN5G8Q2USA==
Subject: [v2 0/2] KVM: Validate irqchip index in routing entries
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
X-Lms-Return-Path: <lba+26a1c3d68+a300e1+lists.ozlabs.org+yanfei.xu@bytedance.com>
Date: Sun, 31 May 2026 21:53:24 +0800
Message-Id: <20260531135326.2238555-1-yanfei.xu@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <harshpb@linux.ibm.com>, <zhaotianrui@loongson.cn>, 
	<maobibo@loongson.cn>, <chenhuacai@kernel.org>, <maddy@linux.ibm.com>, 
	<npiggin@gmail.com>, <sashiko-reviews@lists.linux.dev>, 
	<seanjc@google.com>, <pbonzini@redhat.com>
Cc: <kvm@vger.kernel.org>, <stable@vger.kernel.org>, 
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>, 
	<caixiangfeng@bytedance.com>, <fangying.tommy@bytedance.com>, 
	<yanfei.xu@bytedance.com>, <isyanfei.xu@gmail.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7bit
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>

Validate irqchip indexes for LoongArch and PowerPC irq routing entries
to reject out-of-range values before indexing the irqchip array.

v1->v2:
- Split the patch into two by architecture (Sean)
- Pick up Reviewed-by

Yanfei Xu (2):
  KVM: LoongArch: Validate irqchip index in irqfd routing
  KVM: PPC: Validate irqchip index in MPIC routing

 arch/loongarch/kvm/irqfd.c | 3 ++-
 arch/powerpc/kvm/mpic.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.20.1

