Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62914C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 12:18:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EBA620652
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 12:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBA620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gNQV1C1MzDqrC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 23:18:26 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gNJv6SZyzDqkK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 23:13:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43gNJv0HK7z9sCh; Thu, 17 Jan 2019 23:13:35 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43gNJt5qnfz9sD4; Thu, 17 Jan 2019 23:13:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4] powerpc/64s: Add slb_full_bitmap rather than hard-coding
 U32_MAX
Date: Thu, 17 Jan 2019 23:13:26 +1100
Message-Id: <20190117121328.13395-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117121328.13395-1-mpe@ellerman.id.au>
References: <20190117121328.13395-1-mpe@ellerman.id.au>
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The recent rewrite of the SLB code into C included the assumption that
all CPUs we run on have at least 32 SLB entries. This is currently
true but a bit fragile as the SLB size is actually defined by the
device tree and so could theoretically change at any time.

The assumption is encoded in the fact that we use U32_MAX as the value
for a full SLB bitmap. Instead, calculate what the full bitmap would
be based on the SLB size we're given and store it. This still requires
the SLB size to be a power of 2.

Fixes: 126b11b294d1 ("powerpc/64s/hash: Add SLB allocation status bitmaps")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/slb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index bc3914d54e26..61450a9cf30d 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -506,9 +506,16 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 	asm volatile("isync" : : : "memory");
 }
 
+static u32 slb_full_bitmap;
+
 void slb_set_size(u16 size)
 {
 	mmu_slb_size = size;
+
+	if (size >= 32)
+		slb_full_bitmap = U32_MAX;
+	else
+		slb_full_bitmap = (1ul << size) - 1;
 }
 
 void slb_initialize(void)
@@ -611,7 +618,7 @@ static enum slb_index alloc_slb_index(bool kernel)
 	 * POWER7/8/9 have 32 SLB entries, this could be expanded if a
 	 * future CPU has more.
 	 */
-	if (local_paca->slb_used_bitmap != U32_MAX) {
+	if (local_paca->slb_used_bitmap != slb_full_bitmap) {
 		index = ffz(local_paca->slb_used_bitmap);
 		local_paca->slb_used_bitmap |= 1U << index;
 		if (kernel)
-- 
2.20.1

