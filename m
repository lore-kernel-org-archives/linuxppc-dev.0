Return-Path: <linuxppc-dev+bounces-24957-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFE1C54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 01:29:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8vrd5v4gz2yjg;
	Wed, 29 Jul 2026 11:29:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785288577;
	cv=none; b=DRQHlTz5Ts9gqh38a5QxwrsQIUgBSHFCDkMWU45zWPX037OT/J1inXlRPkU+pWIBkb2ty/TNjpY3ilQYcFzE9rwggEvRsBIkAfwBOXibxj34uPZ3xMbo/1MSs3SN4AYK88a66hQyDvVMuCKNNCjeR+kyXN2Ok8AxA+xeR3z073ijAHXyU+NXy5KiIWNTtMe8jyLZ6wFJfsWTYkAV8IJdTB7QSHLvnrMjE7WE3A+akru/xWVAu1dLa5ciOwOyBQZQxAUkKXPyaw1X2BgKRPItu3X2eYkBkeEtiqrjkrHwuRlxRIFcCmwusJZQ1tb0d/M3160U9Ow5QGJ3zeowfX3O1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785288577; c=relaxed/relaxed;
	bh=j4KV6sQuWKd8eS0AoGbKfckVEhtCT+5lyhSl3SyfXiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlF/7m3JKKjUOY7fTUiGM8+40zP8PWMIvWknnBzl2FPVid1ddCrSgxLwu14l0yJeSbB9yTCx8sqAzfx0sf1tlg9kL4L9+1iusWVk0d4DSwCs/44aE1W+Pn2bKmPrGaAhnoI3lXv0SW0RSa0qbU9DOWuh1WhNFoCtCqj/PtFkJ/++s7ZZn0jnbQ4fWp5SJAxznvvIYrMEcPCelOLMS0ssMm8PZOsCchTULkmPSd5prXrfvodIHKuI5V3o0Gpd3qSxteCh/gtgkLqr2/7Hjf/2e8HfJy2MkH/2OZAmuF2GKI3h8mKby5NTGCfmWgyK3IJvTEYhf3wevx/TN1HPvol2ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=urWVc2P0; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=urWVc2P0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8vrb6JqBz2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 11:29:35 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=j4KV6sQuWKd8eS0AoGbKfckVEhtCT+5lyhSl3SyfXiA=;
	b=urWVc2P0ENx4blIXgZ5M+OtVOKt+sYZN9XXmSTw7XVqALzzXo3TdRX3PE3VyxIOZg4VByloEe
	b5mediW2Oh8/2F/+uq6eOWGBNEW5vePZYXQabopjTR9MCFdRxcV0zfyBmUqk4FKqGTQWuwkCBw2
	vOlOwKMDaDkSBYHJGl9FVOM=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4h8vdG4RDtzcb0T;
	Wed, 29 Jul 2026 09:19:46 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 96D494057D;
	Wed, 29 Jul 2026 09:29:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Jul
 2026 09:29:26 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <sourabhjain@linux.ibm.com>, <rppt@kernel.org>,
	<baoquan.he@linux.dev>, <hbathini@linux.ibm.com>, <adityag@linux.ibm.com>,
	<ritesh.list@gmail.com>, <bauerman@linux.ibm.com>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2 1/3] powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()
Date: Wed, 29 Jul 2026 09:29:46 +0800
Message-ID: <20260729012948.2797865-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729012948.2797865-1-ruanjinjie@huawei.com>
References: <20260729012948.2797865-1-ruanjinjie@huawei.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)

In get_crash_memory_ranges(), if crash_exclude_mem_range() failed
after realloc_mem_ranges() has successfully allocated the cmem
memory, it just returns an error but leaves cmem pointing to
the allocated memory, nor is it freed in the caller
update_crash_elfcorehdr(), which cause a memory leak, goto out
to free the cmem.

Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Fixes: 849599b702ef ("powerpc/crash: add crash memory hotplug support")
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/kexec/crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index 60a917a6beaa..775895f31037 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -502,7 +502,7 @@ static void update_crash_elfcorehdr(struct kimage *image, struct memory_notify *
 	ret = get_crash_memory_ranges(&cmem);
 	if (ret) {
 		pr_err("Failed to get crash mem range\n");
-		return;
+		goto out;
 	}
 
 	/*
-- 
2.34.1


