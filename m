Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD9EC04EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:29:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E0020869
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e11cs6jE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E0020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZGPf4xjhzF3XF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 00:29:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e11cs6jE";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="e11cs6jE"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZG3t147qzF3WG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 00:14:18 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id s4-v6so11034824plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 06:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Uwz2MhBiZj2/RLBte8wwxNWfHSbBq1uBQUZRjpspgrw=;
 b=e11cs6jEoeMmwoBTYdNdNJksH7qI2wwNhzL8dHOfMYBv61ZXmE7ZyV/m0HuwprSE8P
 LFyAsDmOM0lbAcgAwqRMqM/kSCDNmRysuTjQBcOTsE+FYIuV6YatjeYM9khiyj/R3/AY
 QCOLgFdpTNNuFTtQ/BUGeOh8mtqwWkMaj1cDEQfLz/cYm4GL6lZaJ74Hjstyi58GeYBt
 wOKkZeW4oBUFptEPdrDwkxiVepZCC+JvI0CR0+o9yZckDgcyrP91npD4G3d5GNYQsbQN
 Zhnb8I+DxMlfZAf2J/KOOMUmZ9HMuxpolqtPk2C9td0SKgrYsShSDKNx8nkIWCHWN94Z
 0Q0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Uwz2MhBiZj2/RLBte8wwxNWfHSbBq1uBQUZRjpspgrw=;
 b=l4b8mRTOHcZKvN2Di7kiOSG9uL7JbciHbpkuLGBOLMAhssP7Tz6mMq/wn0RakqI3dB
 eLfatmYKXn2K5C2J4dAHt3xlokJ2bu87nXFcJ2+WlcqFhFOHMupOEvANCdNcuRoGbgea
 R8Cu5DER7TrXIOs7UNcGbcXrrwfOqW3P0KEKkV292NO4oJaC0fjMgOTEvR4aGdmLISnM
 6AJUrVZxyonmJ1MeRX3IxxMlF+b1drPGQHwySAdVlv81Dcx02VndWsayy/r686TGnQEr
 ldVQJANE2yuJQrv6Wz7XaET3YzUsqtVz+i/oxJUEHIj6zt99Ux3sbgdVRmWpsCf6tAHX
 C0/g==
X-Gm-Message-State: ABuFfogUr+V2tJOGMyWSzaIQK3MqYilYPsLXZXlrcMBHX8vsiT3zqA/M
 4FHT73vYbdse1zmUBgczFJCEVXRE
X-Google-Smtp-Source: ACcGV62O4GEomn4Rji7i3zI4ZPz6+o/83UivhZoWG06/NphsLTdj3gWE9y8+Ptx4lChGWFwrT5esfA==
X-Received: by 2002:a17:902:34a:: with SMTP id
 68-v6mr21440986pld.39.1539695656502; 
 Tue, 16 Oct 2018 06:14:16 -0700 (PDT)
Received: from roar.local0.net ([60.240.252.156])
 by smtp.gmail.com with ESMTPSA id j62-v6sm16043423pgd.40.2018.10.16.06.14.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Oct 2018 06:14:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 4/5] mm/cow: optimise pte dirty bit handling in fork
Date: Tue, 16 Oct 2018 23:13:42 +1000
Message-Id: <20181016131343.20556-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181016131343.20556-1-npiggin@gmail.com>
References: <20181016131343.20556-1-npiggin@gmail.com>
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, linux-mm <linux-mm@kvack.org>,
 Ley Foon Tan <ley.foon.tan@intel.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

fork clears dirty/accessed bits from new ptes in the child. This logic
has existed since mapped page reclaim was done by scanning ptes when
it may have been quite important. Today with physical based pte
scanning, there is less reason to clear these bits, so this patch
avoids clearing the dirty bit in the child.

Dirty bits are all tested and cleared together, and any dirty bit is
the same as many dirty bits, so from a correctness and writeback
bandwidth point-of-view it does not matter if the child gets a dirty
bit.

Dirty ptes are more costly to unmap because they require flushing
under the page table lock, but it is pretty rare to have a shared
dirty mapping that is copied on fork, so just simplify the code and
avoid this dirty clearing logic.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/memory.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0387ee1e3582..9e314339a0bd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1028,11 +1028,12 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	}
 
 	/*
-	 * If it's a shared mapping, mark it clean in
-	 * the child
+	 * Child inherits dirty and young bits from parent. There is no
+	 * point clearing them because any cleaning or aging has to walk
+	 * all ptes anyway, and it will notice the bits set in the parent.
+	 * Leaving them set avoids stalls and even page faults on CPUs that
+	 * handle these bits in software.
 	 */
-	if (vm_flags & VM_SHARED)
-		pte = pte_mkclean(pte);
 
 	page = vm_normal_page(vma, addr, pte);
 	if (page) {
-- 
2.18.0

