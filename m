Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61140C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Jan 2022 03:54:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jm0nv2dK1z3bN9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Jan 2022 14:54:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=jiapeng.chong@linux.alibaba.com; receiver=<UNKNOWN>)
X-Greylist: delayed 309 seconds by postgrey-1.36 at boromir;
 Sat, 29 Jan 2022 14:54:16 AEDT
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jm0nN0dTtz2yMx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jan 2022 14:54:13 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0V35EraQ_1643428129; 
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0V35EraQ_1643428129) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 29 Jan 2022 11:48:54 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: mpe@ellerman.id.au
Subject: [PATCH] powerpc/fadump: Use swap() instead of open coding it
Date: Sat, 29 Jan 2022 11:48:47 +0800
Message-Id: <20220129034847.76902-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Abaci Robot <abaci@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Clean the following coccicheck warning:

./arch/powerpc/kernel/fadump.c:1291:34-35: WARNING opportunity for
swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/powerpc/kernel/fadump.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index d0ad86b67e66..de08dd078081 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1271,7 +1271,6 @@ static void fadump_release_reserved_area(u64 start, u64 end)
 static void sort_and_merge_mem_ranges(struct fadump_mrange_info *mrange_info)
 {
 	struct fadump_memory_range *mem_ranges;
-	struct fadump_memory_range tmp_range;
 	u64 base, size;
 	int i, j, idx;
 
@@ -1286,11 +1285,8 @@ static void sort_and_merge_mem_ranges(struct fadump_mrange_info *mrange_info)
 			if (mem_ranges[idx].base > mem_ranges[j].base)
 				idx = j;
 		}
-		if (idx != i) {
-			tmp_range = mem_ranges[idx];
-			mem_ranges[idx] = mem_ranges[i];
-			mem_ranges[i] = tmp_range;
-		}
+		if (idx != i)
+			swap(mem_ranges[idx], mem_ranges[i]);
 	}
 
 	/* Merge adjacent reserved ranges */
-- 
2.20.1.7.g153144c

