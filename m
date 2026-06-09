Return-Path: <linuxppc-dev+bounces-22333-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45BECD8C92
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 13:20:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZTzT3Xr8z3br2;
	Tue, 09 Jun 2026 23:20:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1235"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781011205;
	cv=none; b=F1kpb1Q115f7t5kRfV6xq3Sh9gQiChjfNaJREWbX58zu7VGxUMJdX2oNbNT5U3/b16C1MVj6nj88GiLBljeYAVeoj7RUA6MsS2CRBj0UFh2YW/amCovDmh6oBoxbpTdOgqhPlAHm5W6DcRAVMJAYWUN/TEjdSHvks50Gu9E3VBUZF1NZ1q+Th4x45o8bjw5banhKSfZ9Ex/rt1ZEGRbrZl5e0jHY4Y01cdVPvejBo35MOZX4iE22yjgyNBbAJVowmIhmYQkxm9L1iK7rHBK6tnq6dQPzw+3BVQ+y76dhmLgdm9i07AJTCS20XmwU1vHkfzVuwuP6KXs7Qd51idiC2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781011205; c=relaxed/relaxed;
	bh=hvy4DWne9ysaGXsdY1H8ASxix4oKBI9EnEfYdxECItc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdnM1OmO4/4wG/w02rzhd+TJZtnVGKlGDFl3KSUHfYgg6UQzc64NzH9t723MX2psKzofPhOZidHokalICVy51CVvFSxo6P5S3FtKx4DqiEpPZ4V/UUuRf/koT1WowKmNbdYuMbpzTxjjYh+bkH21plRiENDrx7jTjfwhTC6q+N2uMi/ZjhzG33Vyf1xpnczE4l+AR6tyIaCFrCqc88XLlbF1BBZvS4eAtHSJePhFAWB4P602ptuQQR0/ioVPOuZiPjIoMQTLdQ64yM4Yj49BWAhJsCEWxQbZ1v5KZF/mA2Ul2D9yoKSvVlg2aQ8DSg/iXfBl9dutCd27bk0StJhcFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cjO+dYzX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cjO+dYzX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com [IPv6:2607:f8b0:4864:20::1235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZTzS5592z2xll
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 23:20:04 +1000 (AEST)
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-137dd523634so8609819c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 06:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781011202; x=1781616002; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvy4DWne9ysaGXsdY1H8ASxix4oKBI9EnEfYdxECItc=;
        b=cjO+dYzXtRddlwhQniWncQH5gvf1dHhI7eeXIlu4CSZqkjLtAykpV3WvrPdtNZqBQx
         sn9VfFn3PNbCZEY4W1EDb177rvgk+npK4hX/+GzI8+V0NQT9HugXreE0MJgB8EPPokzb
         zJtF6p93JCEqf/Yd6VHgdi35+6VsDrCjPpaNQkw4KnKaJbHeVjF4m7ULT4bdgk95mWCe
         5rYl1YfNsJG7j0MVYPESl+aY3Hst5kEO0BEbsOaPzvq9AzA+p48fDUIzq4LNR2YXuQiR
         vH+0Uw00W+un/GtdEfn+1mB0Eq6XwiP5pSZCRVyFSQs7vCQNKAXRfvAydmePlzKAFi84
         t4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011202; x=1781616002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hvy4DWne9ysaGXsdY1H8ASxix4oKBI9EnEfYdxECItc=;
        b=QTxSXVQwjTL3JyfvrsXTcIii2kzdekkx7PcBd/PPVbJ0fT3dwxhl3isZQ7PgpMO4bL
         MkT5S1xqzZAkLoZxKa0mg5T9xgFybORF39hrdfmoM4P1LUI7G3HoZ3dHmulTdXsBKeFY
         +ShCLnD9oexOHxjwTM9oJmaEj9qzrs+soe97cTkYNFD+oypBfsD8hgTfKKuHIN4PfL3h
         LSN59ZUtZIJmuINXEX6GZ2IjtlW3R1N8NNLagYc7PTbD9a4Rdvr2VZcIkBECnJKqaZuc
         3bVGpY3aDB1xGE1lMx8DGzm8EF0pDncPMFd53cvZV93YZY7Y9CVM5OEeSLhfTAiDEPAt
         eyPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/eECnAz5OpaWBuQw2JLy6D/NmBIsfER/R1FnuEpT1WSN91srEaDEUCgRBUlDscWVtH2D62/Ghu+zPTDTs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwebGwJfHH+yPt0H+SQDd7+qQ+rtUVKSWIb1e9AbvZfDS3yWSf1
	LB/yn5BfS84yj9YboGtA5l8FttFjAGmBI1mCNchIZ8y7CUFYj/GcWAzl
X-Gm-Gg: Acq92OHyZ80FPyNTl3rr7n2aipDK26dCV1aOJ9g+CDoBm3jNHuvSNYwwrDDEUzJT4WK
	cjJQ/e3v5YHu4SsDoDR5LVtNHrVxhRX1YoVk5LaFCcUkAMuK3pZ38KRjwQ59jEVbwAOve6or+az
	ORaupEo+w7G5e7u/HcRY+AZcmXm667KRy3kGASTGAZlw+TxxceTbYDSCsiJgwYKwP8mF4VY7fOi
	1mGrTYK8hsFC2Gl5AtWTEVaVw09oq3ooRdHMnePh4gcZtbYLl5qM2gylgEeomv+MicepU67RBAY
	1/lQeysHSBskmeBhfv5/6oYDvTJEQQq4JSfB9utjNYTY2RCqIy/JyjzMmbJvN9dKsVp8RC6bjvm
	YBI0m8IViEOvCGTzsQXu2J09Og11GMVcQ6BqASMMSzp1Q3mKxRtq5zva82ZCXVofuXFYAAjuTfd
	HEMG6g0qGPmVOVkbus77Et7HTk3inf6db0oIGzBf2Th9D0EtENWsu/yjhEw/96UNEIZwFMUxM=
X-Received: by 2002:a05:7300:320c:b0:304:e7c9:b528 with SMTP id 5a478bee46e88-3077b2f4881mr10893136eec.30.1781011202153;
        Tue, 09 Jun 2026 06:20:02 -0700 (PDT)
Received: from localhost.localdomain ([129.41.58.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db55f60sm27162467eec.6.2026.06.09.06.19.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Jun 2026 06:20:00 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-mm@kvack.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [RFC 1/4] include/linux/swap.h: Remove unused leftovers
Date: Tue,  9 Jun 2026 18:49:31 +0530
Message-ID: <68591daf0d679e5a0072d63751f187d14613e2b0.1781000840.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1781000840.git.ritesh.list@gmail.com>
References: <cover.1781000840.git.ritesh.list@gmail.com>
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

This removed unused leftovers most of them are forward structure
declarations. Also removes SWAP_BATCH macro which isn't used any
where in the code.

Found these during manual code review.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
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


