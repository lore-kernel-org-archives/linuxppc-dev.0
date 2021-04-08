Return-Path: <SRS0=7qm+=JF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE34BC433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Apr 2021 01:11:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07CCB6120E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Apr 2021 01:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CCB6120E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FG39Z3b3Hz3bwg
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Apr 2021 11:10:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.32; helo=szxga06-in.huawei.com;
 envelope-from=yukuai3@huawei.com; receiver=<UNKNOWN>)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FG39931ypz2yxB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Apr 2021 11:10:34 +1000 (AEST)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FG36x3lTrzkjBY;
 Thu,  8 Apr 2021 09:08:41 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 09:09:45 +0800
From: Yu Kuai <yukuai3@huawei.com>
To: <mpe@ellerman.id.au>
Subject: [PATCH 2/2] powerpc: make 'boot_text_mapped' static
Date: Thu, 8 Apr 2021 09:18:01 +0800
Message-ID: <20210408011801.557004-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210408011801.557004-1-yukuai3@huawei.com>
References: <20210408011801.557004-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: yukuai3@huawei.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The sparse tool complains as follow:

arch/powerpc/kernel/btext.c:48:5: warning:
 symbol 'boot_text_mapped' was not declared. Should it be static?

This symbol is not used outside of btext.c, so this commit make
it static.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 arch/powerpc/kernel/btext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
index 359d0f4ca532..8df9230be6fa 100644
--- a/arch/powerpc/kernel/btext.c
+++ b/arch/powerpc/kernel/btext.c
@@ -45,7 +45,7 @@ unsigned long disp_BAT[2] __initdata = {0, 0};
 
 static unsigned char vga_font[cmapsz];
 
-int boot_text_mapped __force_data = 0;
+static int boot_text_mapped __force_data;
 
 extern void rmci_on(void);
 extern void rmci_off(void);
-- 
2.25.4

