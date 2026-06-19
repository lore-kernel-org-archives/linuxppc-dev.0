Return-Path: <linuxppc-dev+bounces-22779-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547B0CD98E6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 04:41:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghQ0M5Xpgz3bpP;
	Fri, 19 Jun 2026 14:41:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781844083;
	cv=none; b=YYiC/77ehSD2TR5Eq8wRVMIuciWQu6MoL5RWLunk867/j84kUFyfrh0umZe9+SOeMy3FL1MHeUdf5+8j9NICmojpQ7+ULHK5Utj9EMfD2maaalw30znfvK3sSbkA1QXt+3gLrvpK+HtYOCCIPNS6JQvvaTGrDHAIVvSStauzrafbihgsDShznSWsxBvoQ+gvQa5HsrIbmOevZyHxZ5QwnIZyrJAzFwpk9psmgggrFPhZtC7sAqgYEx5yJu4pcdoKcYXLekBbNYZI/5A+WIR7xhHy/C5P/8VTFF6oK70mYGI7/mdSb1KbYIAb51Kv11aXdmVqbu36dNWncgf4QJcrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781844083; c=relaxed/relaxed;
	bh=LHipDb4hQnOkueiysmnxTLayb0+ss/N1hnMyC7dj3wA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y3Te2d/WdHQd05YzjkYFNyTmilofE8+44WCVdayIs42ASiJIRc0Hltrl314w5v/IITHxQ7N897sI8I9EaZMP0LGRYM5AGFtIn8TQQ4DOSKUqbbfNef2oNv28oAumHdmYk0cY2tEDKk6A/AOjUF+XIFooV/nBtcsy0KlG0LUmF8UklSmwD3fC42ho/5dwb5khYOKdtSgW0BXFG/q8CaGarwiP+AOjMqMGY/FMnLlfTZwrTZJrjn44pivseteZ55uNCulzJ47+CxB+WUe13iGkhIndGiRZgfaQZOMn2265sP3apvxwxmsp+0QxKtH3CWf88IuHwgE9WL0lic/RmK0m3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SaZrlXgt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SaZrlXgt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghQ0L55BFz2ySW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 14:41:21 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2bf125989f2so11149455ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 21:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781844079; x=1782448879; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LHipDb4hQnOkueiysmnxTLayb0+ss/N1hnMyC7dj3wA=;
        b=SaZrlXgtsQWGbKsJC049Cp0j1segmwncToFCzcgDV/R0mmQ4iwcVLmynCGlfhTNZOb
         5K0OfEyfxUh0kkHx3NjkQLF5br9s+Ly78hqEE4OalQ7Hs4kmAPUwtPGBfd5VglwfQrCy
         MxbJqp/eALlujAyIyTMBLzvU/43ca4+ZI4L9x4MjTUideCJGRA0jBgSBFwqa5iLdlCS7
         uZbwZDcoWDDRu6QZzgsBErk1SW8MC6zjUiLhD8e7g8maKxaGlfYdRq8CuKVq1njCM9Rg
         kzveRXA3CtgkO9g27TTcKr0REahqkfBFt+ONc/TWjvokBwYGlfS6afaIGCFvF/A/R35N
         hCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781844079; x=1782448879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHipDb4hQnOkueiysmnxTLayb0+ss/N1hnMyC7dj3wA=;
        b=AUN7H1qvP02JqDsKYlieBcnkcTKi9BKoDGU3bMY2O5o5FDlios8AaasFvhy0qpFHOh
         k+SRLlSnd6Nh8WtYQMRcCkHlwgRdSbtTPwItCRbbLe9RAtVBsxVOc/R5jvc412a3PxZq
         w3MMu2sGn1adbTmOKcOF2bMpyZnVothJ+8rwZelOyHxpgch0tHE4kGfmcROunkYpb8Xr
         bh6YOCvuGgUReToM18Yf9iH3BdCxb1ZOx2Ao29354SHm5Xob6J+9hzT48QgWAR3GGEi9
         Eyq/9QkQNaIYM/swZ/IUDs9+jDNG3ZHqJYLcjMZifv3R0QaP0ap4Fh8bkCIRdphyXaLq
         n0lQ==
X-Forwarded-Encrypted: i=1; AFNElJ/PI6lhQyGFdl2Nib/8C1uE5pVJMlbunasAWSq2Lw9Rv3+b7Cbtu7htO/b6K4Wy2zgBhJahydID3rxVu8k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywqy5qGHUlCOT4MyRaNQx3Znyl5+kEV1s1+KWrvZKxUyPipTxGv
	PUC+PugW/eyvGSFHGRg/cKqs6yM7329pqXpdAWTq9/FE687JELuZoMu6
X-Gm-Gg: AfdE7ck/EHMvMlvfQovxMcyTqvmq/562vp1ts7UUtOWbQTnP/3uU8LtVDNy+noJHjPK
	R9O5V83G/TWydll6qztUYEw5lWESvuL8GxHyuQgJ2KvW7Y0+Iv2DGpEPQRSlfMiWGkC8+/wK1XV
	q+sSuVAO51m0hYiLKHuOqZti663sn7U+YhLIalOmkrXqJPGAz1CWWENTaqZ5fDiEmVPZn1OHCpK
	vkgSxeN6koPHDK1g3CJWk7QKjS9KxE3NqOXc6KQ0MGdUwiH8RlIbWKpTzwLA86caWJ9DH8TidPI
	/iyqZVTLCZ2vLPPX6mMuKjNNUtXJt+ldhixeaFps7x1hy6TF94HG23p0+D4K8gFcGwWY+uFEMr+
	P45IC8b6yu3Q7KMnUcQJ3qyroYvuFtR66TjJJqDaJdBay+l5gATtqULSOUL0tzTjt/hE/qn7OLX
	QemUVODZK6JSQitUEsOygHMQ==
X-Received: by 2002:a17:902:e54b:b0:2c1:a19:8396 with SMTP id d9443c01a7336-2c718f61d05mr23229975ad.31.1781844079424;
        Thu, 18 Jun 2026 21:41:19 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7208e5760sm8293735ad.36.2026.06.18.21.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 21:41:18 -0700 (PDT)
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
Subject: [PATCH v4 0/3] mm, swap: Enable THP SWAP for PowerPC Book3S64
Date: Fri, 19 Jun 2026 10:10:56 +0530
Message-Id: <cover.1781843449.git.ritesh.list@gmail.com>
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

On PowerPC Book3S64, MMU is selected at runtime, so macros like PMD_SHIFT
are effectively runtime variables in the Book3S64 code. THP swap code uses
these macros for e.g. to size some of its array data structures based on
PMD_ORDER. This patch series makes that usage dependent on the runtime
variable and provides an upper-bound architecture override for cases (e.g.
SWAP_NR_ORDERS), where the runtime conversion is not considered beneficial.

This series increases bandwidth throughput with zram backend for swapout by
around 40-50% with Radix and 100-130% with Hash (Tested by Sayali)

Note that this patch series is based out of linux-next (next-20260608).

v3->v4:
======
1. Revert SWAPFILE_CLUSTER definition - since we already adjusted all the users
   of SWAPFILE_CLUSTER and made those users use this value at runtime (Kairui Song)

v2 -> v3:
=========
1. Fixed sparse warning for swap_table_use_page reported by lkp in patch-1

RFC -> v2:
==========
1. Send the unused leftovers change in swap.h separately [1]
2. Changed RFC Patch-3 design from runtime SWAP_NR_ORDERS to arch override
   (ARCH_MAX_PMD_ORDER) - suggested by Youngjun
3. Dropped RFC tag

[1]: https://lore.kernel.org/linux-mm/68591daf0d679e5a0072d63751f187d14613e2b0.1781146877.git.ritesh.list@gmail.com/
[RFC]: https://lore.kernel.org/linux-mm/cover.1781000840.git.ritesh.list@gmail.com/
[v2]: https://lore.kernel.org/linuxppc-dev/cover.1781170904.git.ritesh.list@gmail.com/


Ritesh Harjani (IBM) (3):
  mm, swap: make SWAPFILE_CLUSTER runtime
  mm, swap: allow archs to override SWAP_NR_ORDERS via ARCH_MAX_PMD_ORDER
  powerpc: Kconfig: Enable THP_SWAP on Book3S64

 arch/powerpc/include/asm/book3s/64/pgtable.h |  7 +++++++
 arch/powerpc/platforms/Kconfig.cputype       |  1 +
 include/linux/swap.h                         | 12 +++++++++++-
 mm/swap_table.h                              |  6 ++----
 mm/swapfile.c                                | 17 ++++++++++++-----
 5 files changed, 33 insertions(+), 10 deletions(-)

--
2.39.5


