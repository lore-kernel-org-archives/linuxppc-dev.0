Return-Path: <linuxppc-dev+bounces-24736-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAB8C531CB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:13:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5Wkp47Vxz2ynW;
	Thu, 23 Jul 2026 23:12:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784812370;
	cv=none; b=QGq1TJ+C0syj2CzkTtnDmfNzib12nM/DCjjFWlIOBCQxiX2rNpRG0llq7zHZPaMmJyAO+qn4WTYr6tP6a5Ebgre+N7Eod24H/nwrmqEhIsv7Ct9twTSnkbQIW7sJZBxVr6jVl2Ltxu+/PwmbKolJ56/ZKMTgopVI9O6xCUQrmgdh29foQSS/dg4Pwww/jGpl2+HfRToXXA8jhVJCG31ZWX9+4UTnrVcJKuKVXU8W4Og7BDrRafdvORLFwmVvO1vgowbOXN6WaNIe2oLJ/4gDUn0Fmpe810gQB5skFDUNown9Cd3md9sc1MVHZEaznPv3AVPkk7Ssnyf41LvAworhkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784812370; c=relaxed/relaxed;
	bh=j4KV6sQuWKd8eS0AoGbKfckVEhtCT+5lyhSl3SyfXiA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5d9QqeAFX3W5XxP9tpS09j2utpm6fDugNV+avlFeaV7nOlJhvF0HaT+EMC3wV+9KqyEqNxO5uqmJqYao30joffOm/qyGw3yPh6cnVak0FNor481y2hDbYHFKTVUJScloyLXdh07b7zNIyMlgRnZkDJybex3idLFt4MnskTKIpL2zDE5G264xm/zRLvmRP94wNiSsQ3hvZ3r1c6Rli2dPNOm9QCBACveiybq2mnL6DCYD11ZT5LTPrM+wjh6TUxmyQKZizf8SK9mj/sQpu01VNcl7vlT4aR5hwTKvcxKwTZZLw7V9AY82OGp5sftw9saucE8ZDsz/hPazpqyG2mHAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=urWVc2P0; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=urWVc2P0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5Wkj6bRJz2yVZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 23:12:43 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=j4KV6sQuWKd8eS0AoGbKfckVEhtCT+5lyhSl3SyfXiA=;
	b=urWVc2P0ENx4blIXgZ5M+OtVOKt+sYZN9XXmSTw7XVqALzzXo3TdRX3PE3VyxIOZg4VByloEe
	b5mediW2Oh8/2F/+uq6eOWGBNEW5vePZYXQabopjTR9MCFdRxcV0zfyBmUqk4FKqGTQWuwkCBw2
	vOlOwKMDaDkSBYHJGl9FVOM=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4h5WWh261Gz1prKd;
	Thu, 23 Jul 2026 21:03:12 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id B9D8640538;
	Thu, 23 Jul 2026 21:12:37 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Jul
 2026 21:12:35 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<akpm@linux-foundation.org>, <baoquan.he@linux.dev>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <thuth@redhat.com>,
	<ruanjinjie@huawei.com>, <vladimir.murzin@arm.com>, <mark.rutland@arm.com>,
	<ardb@kernel.org>, <james.morse@arm.com>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <robh@kernel.org>, <kees@kernel.org>,
	<coxu@redhat.com>, <sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
	<adityag@linux.ibm.com>, <hbathini@linux.ibm.com>, <makb@juniper.net>,
	<piliu@redhat.com>, <graf@amazon.com>, <liaoyuanhong@vivo.com>,
	<jbouron@amazon.com>, <bauerman@linux.ibm.com>, <bgwin@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <kexec@lists.infradead.org>
Subject: [PATCH 1/8] powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()
Date: Thu, 23 Jul 2026 21:12:35 +0800
Message-ID: <20260723131242.1537633-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723131242.1537633-1-ruanjinjie@huawei.com>
References: <20260723131242.1537633-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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


