Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F229AC433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Dec 2021 08:25:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JF4tP4Bnwz3fjP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Dec 2021 19:25:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FByLsNpx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.dev (client-ip=94.23.1.103; helo=out0.migadu.com;
 envelope-from=liu.yun@linux.dev; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=FByLsNpx; dkim-atps=neutral
X-Greylist: delayed 410 seconds by postgrey-1.36 at boromir;
 Thu, 16 Dec 2021 12:31:33 AEDT
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JDvj16nK8z2xXV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Dec 2021 12:31:33 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1639617869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=r5Y8V8LmGPaOqgsHLTKQ4Y9e5AwcnOowe8vIcmyYg4k=;
 b=FByLsNpxmqamZ2wS9rhzDY7Pb6t82REWY9EwagkZaeWxCgzuAYwACEfp0a8QfpGCZkxMMe
 +6g/hbCKnm40ROYlpcWJ8V1qvwTtXnXeowj4fEYTQ027ur7QDsAcMZyIMQBR1bBQfb5F0S
 5gaR6q/yFY5zIz+xH3bR5JCn2FFwBsY=
From: Jackie Liu <liu.yun@linux.dev>
To: mpe@ellerman.id.au
Subject: [PATCH] powerpc/iommu: fix modpost section mismatch error in
 allocate_dart()
Date: Thu, 16 Dec 2021 09:24:15 +0800
Message-Id: <20211216012415.1095737-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Mailman-Approved-At: Thu, 16 Dec 2021 19:09:28 +1100
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
Cc: aik@ozlabs.ru, liu.yun@linux.dev, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Jackie Liu <liuyun01@kylinos.cn>

allocate_dart is used in dart_init, and dart_init is in the __init
section, we should also put the allocate_dart function in the __init
section.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 arch/powerpc/sysdev/dart_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 1d33b7a5ea83..be6b99b1b352 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -226,7 +226,7 @@ static void dart_free(struct iommu_table *tbl, long index, long npages)
 	dart_cache_sync(orig_dp, orig_npages);
 }
 
-static void allocate_dart(void)
+static void __init allocate_dart(void)
 {
 	unsigned long tmp;
 
-- 
2.25.1

