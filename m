Return-Path: <linuxppc-dev+bounces-22447-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5718DCD98C5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 03:09:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbSLL6KXBz2xll;
	Thu, 11 Jun 2026 13:09:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781147386;
	cv=none; b=JPiUjpqffcbRy+l7yPN8Hji5sDF3jTLxl8PE96y7jnyqMa1jANetZd43FQtPVTQpmQ/aoOa47rj7VwTCNJPF+1STlrtRVS///rkA69oY8jbKQKxKKdnBuM7fSQG+8LE6IQzyJqbyO7AsvbnngnSvIdCS9iOM6zabtKsC7LUGm7AscebPWU/oqSxgPX2mpbj4zn2Kp2zDYvFCkcWjO4E5OWuqjI1EeQPu/GkEF0vkkqjuiHqH4f5Xw85YrbmgjB54o2hHvab67DoL138/nC5T557DRNodi58Yy2HaZZt098DKUqM14EtyX2sqxbKp5/5g7rvrWmwEg8HFuy2m21BPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781147386; c=relaxed/relaxed;
	bh=WT95mZHoPykr2tWUu0TCr6QJxaYWH5/rFPVhZTId5OQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VpRxd5Qf3Fz3v33wKTxN+8ob5BSwsIRaBcpQGdJMclYIoz/JisQ9h6j2ssRzoKMK4Z0JyL34ugdKJ31/IsqpbfrVCPYD1cQjv0n6TYy+d0mbuMPUdSwxRoCqKdupNHJqS9KxmFgTu3gbM22F/DIG30+TrX+9FIDGUJ5TN9w4PkJQOT9xGLbZCh4YGw8Qk3Gc9mw6RbY9bhj9Hygh8rIJb21VfZmp/JL3bC5HHPx1K2aEpKhNbHqqAU4jtLdJqTrSgTNlW0DQhBHAKF0Rk/ESJ5iRKUcn0ftjLf53ow7y8fgPPGdxe8syiLfV8hkvPZC6thi/aQ95ZuHWg6aH2TrY3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JuKICs9g; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JuKICs9g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbSLK5gPNz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 13:09:45 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-c85a297d2d2so4451376a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 20:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781147383; x=1781752183; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WT95mZHoPykr2tWUu0TCr6QJxaYWH5/rFPVhZTId5OQ=;
        b=JuKICs9gjTEDBqADdgs49qb0elDpvjiBa+XCkQL0LEwoZRTX3N5fYbYjiqIr97Dv7n
         DHH+nD4ZbNwH5QZxT0bpRlPlspeXUiUBA96kheopH2dtre53RuZGqaScf3iWQLmPPYIJ
         BC+Ngmr5SWrjvUW3bM87yOwb+ALTZ9WNhlnmZiHEvIxrPhm2vSRt7BTbMXWyKKIDh3qd
         PGAdPdoEAhaEkIXMgnFIHreQzhENg3SyGusLMKlFNUCwWy9WxTNABJzO5VXS/ITe+G2S
         viC+/v4yGlezuaMsXCRnT6LUMZs53xpkvAGPLktwfslKXnBadDmBKWsS8BvQrAm5IZD9
         WqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781147383; x=1781752183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WT95mZHoPykr2tWUu0TCr6QJxaYWH5/rFPVhZTId5OQ=;
        b=Pp8vpIyfpZTg3fxMzYLtQ64/V4ToXaNR/zlw3t8Ey0ASdArqCvmc5cCtFCvrsBoqxG
         1BnNQYIuBhWEwPAc7cTk5hs3Tnm0cqP+Zgvf4NNpMNRrAY8ozdWcZzsgGEwjAMObgK5U
         Jkp46uVgIAW167F80ZqomNXjxoi6Q6IPgKOpjOpJ8RsDa1+4v0BEhYod6MrxPM9yNdjI
         L9xUiL1K4MwtRXSHDM2bZu3sA0n1bf/kkcxSbMV4+C0tIf/O6DIA1nKdBerIJtmFsOg2
         YiABivEaJz5VumVFqfS7dYygCCFO2ygsHPXw3p0RJKQsSI8bM0pj70CfbscCtybTYtG+
         1l0g==
X-Forwarded-Encrypted: i=1; AFNElJ9jPc6lAejC3l3/njL/YVlP8EqwJ/3b++YFlwvmee/tK024Qxl5Oa36NhpAl59Fw/Vc2/cNoAOfnEaKVxM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzCbXd5Y/YVTscUSuLov07xEw5OonQ5wUExsklPW3YkoNfyfz1W
	lGhBx4t0WB/iHD18AP1aGdAcYizPIaS7tn3hgjHodos/M4w7dJ0a1iWf
X-Gm-Gg: Acq92OGDVC6MMhSsOztoIba5z0wfDqQpVOYPPos8qdGD/WBptsd2IrmDJvtLZghBW24
	zEM63/Du07MUdKReuwpyqFGaEPHxjSee8wsZqwsRB3RLFHF2anvelofnv0fmcUx1psniGm2M/F0
	lY4pQp02owtZLKMlGEm3ITFbR09DX99/Jymf/0D+aOGygca74wOL4qon/mqbCta2YjTPTxkYFPS
	fOSs5gq18++jgx6CRdCBSOpmfc9K77kpSm61cbWeSRjttwn2+bKEnDfui5YuHal2K00eFZeOcBp
	fjdHvbZMdQdnnoP9T06OBQFELDFAVfTt3kbV7EMJy4+5ZcVNtYXircOACoXTXs/3W0QzDSLn2Hw
	KWgEzCHCY9hEBcCbGCpX9uWYLE9/YNHCSEzyCah/Ju68mI+KWT6A4FGmgTxlc00/dMtT63SDz9G
	JiHDjhQoFWVpSassbV5si8OMBV7UxYr4VAoKAr9qU=
X-Received: by 2002:a05:6a00:12cb:b0:841:d7f6:7297 with SMTP id d2e1a72fcca58-84336e0cc4amr784300b3a.40.1781147383427;
        Wed, 10 Jun 2026 20:09:43 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bb6ccasm289180b3a.16.2026.06.10.20.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:09:42 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	David Hildenbrand <david@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Sayali Patil <sayalip@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v2] include/linux/swap.h: Remove unused leftovers
Date: Thu, 11 Jun 2026 08:39:32 +0530
Message-Id: <68591daf0d679e5a0072d63751f187d14613e2b0.1781146877.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
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

This removed unused leftovers, most of them are forward structure
declarations. Also removes SWAP_BATCH macro which isn't used any
where in the code.

Found these during manual code review.

Reviewed-by: Barry Song <baohua@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
RFC -> v2:
- separated from the rest of the series (enable thp swap on PowerPC Book3s64)
- RB from Barry
[RFC]: https://lore.kernel.org/linuxppc-dev/cover.1781000840.git.ritesh.list@gmail.com/

 include/linux/swap.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 8f0f68e245ba..46c25523d7b8 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -16,10 +16,6 @@
 #include <uapi/linux/mempolicy.h>
 #include <asm/page.h>

-struct notifier_block;
-
-struct bio;
-
 #define SWAP_FLAG_PREFER	0x8000	/* set if swap priority specified */
 #define SWAP_FLAG_PRIO_MASK	0x7fff
 #define SWAP_FLAG_DISCARD	0x10000 /* enable discard for swap */
@@ -29,7 +25,6 @@ struct bio;
 #define SWAP_FLAGS_VALID	(SWAP_FLAG_PRIO_MASK | SWAP_FLAG_PREFER | \
 				 SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE | \
 				 SWAP_FLAG_DISCARD_PAGES)
-#define SWAP_BATCH 64

 static inline int current_is_kswapd(void)
 {
@@ -175,7 +170,6 @@ static inline void mm_account_reclaimed_pages(unsigned long pages)

 struct address_space;
 struct sysinfo;
-struct writeback_control;
 struct zone;

 /*
@@ -442,7 +436,6 @@ extern sector_t swapdev_block(int, pgoff_t);
 extern int __swap_count(swp_entry_t entry);
 extern bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry);
 extern int swp_swapcount(swp_entry_t entry);
-struct backing_dev_info;
 extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
 sector_t swap_folio_sector(struct folio *folio);

--
2.39.5


