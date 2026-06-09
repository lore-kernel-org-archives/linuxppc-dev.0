Return-Path: <linuxppc-dev+bounces-22332-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AFFCD8CA4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 13:20:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZTzN0P2zz2ySf;
	Tue, 09 Jun 2026 23:20:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781011199;
	cv=none; b=CxR3PMFd7U2UTxNKS6JRFDaYOsJ8F5Cujb1OMi7kPx2xqsCCt1e+VUXRM/VtilRW2VGzWSidleas5cjiSC/C7jgxJAmK4s4vsRQBblML7zq1oor3sSOBjwFC67G8ItTvz8xsZhuKmjaasctMptsEg3vyzlbn0CU7ZrUfaaVwUa5+tsmx5MvHet4bGM537qFnxtmB59Kn81IcsNW9DEDkjo3wN8J1AozMf12G18kXzx6mM2TKBv3YAaNVfoZ6REWbc7wHJJF26I1aDcU9gbJlDh9MbualQAbCeMKigJutISU6ptZjx3GD+bWDG8eajT3lqQq2IBg2xjNbzbXaQpDaYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781011199; c=relaxed/relaxed;
	bh=fckmtw5a6qdMAglllBfAH38thXkAD945UPCXBAhQnGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Exh973ltHbzyd89D0OIiBQdqqDqXVZzT5gZQx7GYCFsL0POOesWK9sVIs0ZLEqOViYfgwyy0rRfawkkTsjKTlMwZKDXcU4JiwKHEF2QLy9TaPneDHFQv7kCG1/ScITjmzeIfRYlnb5crUvIQDdeXELWyJ4S0LcUl3nfqjz8iRhr4T2YG4dVfXLS208Q/XVLITJ6hiP4+xWwnLldRQiTcENaA/JbtFYKSd5f6yhcfBRaFhb4jCAhTdgAoI0RbACWjDTLdoeZTPiHE5t1tHlPspMfp0Hpcyys9M8KQkB2fX8ie1WuS3sb0oUYPFtbMF+YjJ1mZMt4VZt8lc/dQbTvAHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aBzJZUtd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aBzJZUtd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZTzL4MBCz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 23:19:57 +1000 (AEST)
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-304fb780deaso5464779eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 06:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781011196; x=1781615996; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fckmtw5a6qdMAglllBfAH38thXkAD945UPCXBAhQnGU=;
        b=aBzJZUtdJQd3+FKIarSriMD5Pnin3u682NXTH9x3RX5WE7FFI4qsOo/CkQr2S5z9Hh
         jXpMQXggvAzyYdSX/+OwFQjDUYvMHPjts9jHAqTLMh5xAlDqrc1cEolFfyIO6onPkjBj
         RzDqutkuLrCAPkKEW0TNJYiHob/sZ6UPOa1hhKoF8aI03lAGTFNJyW/VIUgYsfLX8H1j
         JfxA1CcAZEqdHxusK5eIC4iZngmG/Sd/5rwoLnO26yL15SfGGzSNjpP55SU4jvR94GFr
         uC8qx/0JAFHLl6lEZ8OmdOZpx21zYZqcwUFvDEiDom7AlJEJGyhLKPT0+ZlNc5o3PB0c
         GkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011196; x=1781615996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fckmtw5a6qdMAglllBfAH38thXkAD945UPCXBAhQnGU=;
        b=Hf5YXDnIzjMGk/P9XOgjz4IQs3jNSyvfeDFmVEW2lDVZioD+nnSEscq7f8qBVIPi0i
         pZnadSBQOomUNInY2gjyllRGDX9vEI4R9z0t3YEBx1D0c75L7XSsix1rABsH9ETGx6a3
         F+lfJFgusrqbXD2QA2UnmpEbSJkVF966iA9Z3uTLyI5U8mTzG03nEGCBUAY/g1/COMJa
         EWyyngfEmtIWTwJycG4LuzZLOvQGdrSALDr3zcHKVKt1ufzfqenu29nQyxGRASE0M7LE
         xR77p8fegfQzoidBF5UXYundbT1gvTONkOtI3c0A2Pn9SYWsixP7IiPRo05EPAuonJ4s
         0jWQ==
X-Forwarded-Encrypted: i=1; AFNElJ/aE3LFymvuy7Dc9Orfbc6hSLMDDUGV9Qfn1OClr5SJS9h4laLOf5kMVJc4Tl8RSNMuNe65NZx5PZXL1vQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxc4ZWw5nkpjnlHq/d4TkvmurBVXdEnMb+gh6lk6rZi1aXcsF4d
	SQ5gc7TOSlf4inlWIfaHGLxpvQQBgzmH1A09KRPJ3gvanTrb3l8PjBpu
X-Gm-Gg: Acq92OHDU9Aw16KHX3mPQyDHWLgy6sKilDfTPYdAt9wAhIw8hQyfpfOfhzxl2LQRdvh
	6KaKlVNfb0fHa7a8Ma94sjGSBsvq/Vq/XOWEd7Rw0o7wzr8g4ppZppNw9JMowaneKabfA4aM8h5
	gv7VudQVYXIXotDKiRdKpvaDKDXu2yYCmoq9yKx0YnGtBDYTj+0Wu6OfeeC5l/VetwptebOaGqb
	1FLrk9yqHt8iFx4MxenFU3a18Bv23vhoUTBNP/CfUxnxXPanbQJSGgFHylPSamETpHAdHcxgbij
	5ly/q4hkKLcvyl03P2dfLvKpH2NfQoS1yJvgY3cBCYP2BEKiyDeIiRSgo/7du9cUacWRnPAbdKZ
	TW0a4jPCPh9CpelAUCsijMKeCUVRDCsIuic7Eaic75YSrrXQ8ps4R+LbycQtdvR8+wWd4CDdrY7
	Xz9bueRSZs7SlvJBNQTZdG8eYF0wttICuXG05DadgbDfp1hvbVIrNgvpYluXL7
X-Received: by 2002:a05:7300:7fa3:b0:2ed:e12:376d with SMTP id 5a478bee46e88-3077b358a45mr13893772eec.35.1781011195706;
        Tue, 09 Jun 2026 06:19:55 -0700 (PDT)
Received: from localhost.localdomain ([129.41.58.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db55f60sm27162467eec.6.2026.06.09.06.19.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Jun 2026 06:19:55 -0700 (PDT)
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
Subject: [RFC 0/4] mm, swap: Enable THP SWAP for PowerPC Book3S64
Date: Tue,  9 Jun 2026 18:49:30 +0530
Message-ID: <cover.1781000840.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
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

On PowerPC Book3S64, MMU is selected at runtime, so macros like PMD_SHIFT are
effectively runtime variables in the Book3S64 code. THP swap code uses these
macros for e.g. to size some of its array data structures based on PMD_ORDER.
This patch series makes that usage dependent on the runtime variable.

Sayali did some performance runs of this on Book3S64 with Radix and it gives
40-50% performance improvement. We also plan to run it with Hash, will soon
update the results.

Note that this patch series is based out of linux-next (next-20260608).

Ritesh Harjani (IBM) (4):
  include/linux/swap.h: Remove unused leftovers
  mm, swap: make SWAPFILE_CLUSTER runtime
  mm, swap: make SWAP_NR_ORDERS runtime
  powerpc: Kconfig: Enable THP_SWAP on Book3S64

 arch/powerpc/platforms/Kconfig.cputype |   1 +
 include/linux/swap.h                   |  17 +---
 mm/swap.h                              |   5 +-
 mm/swap_table.h                        |   6 +-
 mm/swapfile.c                          | 132 ++++++++++++++++++-------
 5 files changed, 106 insertions(+), 55 deletions(-)

--
2.39.5


