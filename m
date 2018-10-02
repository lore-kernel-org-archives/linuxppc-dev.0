Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FF6C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 15:06:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA13206B2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 15:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8+/tg1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA13206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PjCp3XwMzF3Hw
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 01:06:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h8+/tg1X";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="h8+/tg1X"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PhMp3NJqzF3G3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 00:28:22 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id az3-v6so1713768plb.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=r9/vwWgGVzm4QO5Ojfe2DEknPX3Y8EVK1WlC7C/OH8I=;
 b=h8+/tg1XXVgAniLown/crQHgsGA/UxZvztg6fMSofLWbo6a0zLuvVN7WQtbVpoLocx
 Tv2r4iovwvK/rHSxUhuv6n3kafHSxPxaJAbV+1np05XSayyXNIUwiWYP8xjzbxYpmzIq
 Othxkfp04wl8TIjhoHHZQ0ZbgH+Uw8iYUcAsul32ONZOB1OqSrRT5/GvmqtKFEeyOCJt
 eRGiZWkfD4VLLCntn/NRwHDg5NatHfr9uWmDtWnYUV8cSK2RIpYtJ5zq4t17OrbQToBw
 QCR/6IedabcB3qPiafddNCyCC2squi6pVO371G7rFpF5JbczEf7FL+u50wUHJ+D63rUm
 YNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=r9/vwWgGVzm4QO5Ojfe2DEknPX3Y8EVK1WlC7C/OH8I=;
 b=ggA/0/bOqEG8gIrwAkVb4/ddseuPq6KNJIMCmtvJvXzNkWoA17eBz2GibC2FAkleG4
 bd1AzCxxncX1noUHohDyC4VLjLGHwutzdeoWIdY7Gmg0Wv4V+7H7dAaxIMjPZLDC6/nF
 irolyZWibJyKgqTMfAh6kwRowD3hE0WjBIGlOSawe4gzmUcCYz3S7YOP5n+Ur6Hkmq7m
 6gKdINQvOv40kCCbalOVfD+uDZsf9XAJjYmujkOdRtGBXV5LFeP/uMw+wU3A3EpB7dKk
 1eT/g3jc/ZEDgZlPKLCjl1rfzVFsmIZUGmnh5PkpSYAQ9HqNdgf5raZt0OiYPvplIh2z
 5FUw==
X-Gm-Message-State: ABuFfogXJDdwlyWQk+wLEKChnspRwjTxEuvIzq83vK1kFDuPI1dzvohb
 NyTS/drEn9wTI5wlhd4Y6XPl66jl
X-Google-Smtp-Source: ACcGV62hHUo+O3iZkGuBO0tcmMN6w8D2u0b9/TiATW544g0HHlWrSqHSk4TqPXhmQbSHBv/9Mq0rJA==
X-Received: by 2002:a17:902:d88b:: with SMTP id
 b11-v6mr923518plz.136.1538490500701; 
 Tue, 02 Oct 2018 07:28:20 -0700 (PDT)
Received: from roar.local0.net (59-102-83-213.tpgi.com.au. [59.102.83.213])
 by smtp.gmail.com with ESMTPSA id p3-v6sm21862621pfo.130.2018.10.02.07.28.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Oct 2018 07:28:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 7/9] powerpc/64s/hash: Fix false positive preempt warnings
Date: Wed,  3 Oct 2018 00:27:57 +1000
Message-Id: <20181002142759.6244-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181002142759.6244-1-npiggin@gmail.com>
References: <20181002142759.6244-1-npiggin@gmail.com>
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fixes: 5e46e29e6a97 ("powerpc/64s/hash: convert SLB miss handlers to C")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slb.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index b5a33da875b5..c273d0baf4fc 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -558,21 +558,21 @@ static void slb_cache_update(unsigned long esid_data)
 	/*
 	 * Now update slb cache entries
 	 */
-	slb_cache_index = get_paca()->slb_cache_ptr;
+	slb_cache_index = local_paca->slb_cache_ptr;
 	if (slb_cache_index < SLB_CACHE_ENTRIES) {
 		/*
 		 * We have space in slb cache for optimized switch_slb().
 		 * Top 36 bits from esid_data as per ISA
 		 */
-		get_paca()->slb_cache[slb_cache_index++] = esid_data >> 28;
-		get_paca()->slb_cache_ptr++;
+		local_paca->slb_cache[slb_cache_index++] = esid_data >> 28;
+		local_paca->slb_cache_ptr++;
 	} else {
 		/*
 		 * Our cache is full and the current cache content strictly
 		 * doesn't indicate the active SLB conents. Bump the ptr
 		 * so that switch_slb() will ignore the cache.
 		 */
-		get_paca()->slb_cache_ptr = SLB_CACHE_ENTRIES + 1;
+		local_paca->slb_cache_ptr = SLB_CACHE_ENTRIES + 1;
 	}
 }
 
@@ -596,24 +596,24 @@ static enum slb_index alloc_slb_index(bool kernel)
 	 * POWER7/8/9 have 32 SLB entries, this could be expanded if a
 	 * future CPU has more.
 	 */
-	if (get_paca()->slb_used_bitmap != U32_MAX) {
-		index = ffz(get_paca()->slb_used_bitmap);
-		get_paca()->slb_used_bitmap |= 1U << index;
+	if (local_paca->slb_used_bitmap != U32_MAX) {
+		index = ffz(local_paca->slb_used_bitmap);
+		local_paca->slb_used_bitmap |= 1U << index;
 		if (kernel)
-			get_paca()->slb_kern_bitmap |= 1U << index;
+			local_paca->slb_kern_bitmap |= 1U << index;
 	} else {
 		/* round-robin replacement of slb starting at SLB_NUM_BOLTED. */
-		index = get_paca()->stab_rr;
+		index = local_paca->stab_rr;
 		if (index < (mmu_slb_size - 1))
 			index++;
 		else
 			index = SLB_NUM_BOLTED;
-		get_paca()->stab_rr = index;
+		local_paca->stab_rr = index;
 		if (index < 32) {
 			if (kernel)
-				get_paca()->slb_kern_bitmap |= 1U << index;
+				local_paca->slb_kern_bitmap |= 1U << index;
 			else
-				get_paca()->slb_kern_bitmap &= ~(1U << index);
+				local_paca->slb_kern_bitmap &= ~(1U << index);
 		}
 	}
 	BUG_ON(index < SLB_NUM_BOLTED);
-- 
2.18.0

