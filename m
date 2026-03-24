Return-Path: <linuxppc-dev+bounces-18705-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F33BF532D4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 06:44:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fg0rW6Mgwz3fKH;
	Tue, 24 Mar 2026 17:44:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774334667;
	cv=none; b=EAp995n/5iMrMCoc+syX3Ir4laS+peCSyJXyxrXbzEeH7zKJ+I2f7vQSoOf0FSx0pQLedAJjKI0DTtwsl4b0AhAOBzWR1OTUjtduuBXsEeq5R7SapdJk2jh51Ih9MrRbXlGHGrEagF/jtKyL7uHBJR5YXNEWju9Zg/n8axje+2m/jxBJpG6obuHlqR7pZWVdbA+H+pVVZea8ahevHG48tua5nbUo4nfZTLbPVJcDNyRc11OpI5TYiG8kRtN5DsM8mtFaak6iULxkbKfnIzNByqait9jkGtw/MH1J0eiF3fuJjUmo6iEvx/i6P3H4M6wIIqluqLIGT6KNsznoC56pYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774334667; c=relaxed/relaxed;
	bh=dHnmPdMyRE0J+BnZ4DYHnLY9lmWhvxHv4FOPtQNRSM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPl4VilO4dg13MIT++G+v7SrntQGSK2RYz0/GbxPaA7y4JgP0Ms3Vpd1lmZZJK65U7OnKiQkuJUqxvrUylW038HY2v9t8tQ8kHJbC4EOtOjR23T5DKH859A7U4tWC1nZD00rNXTuKKkATt/flHMr3AEDIYGludGchhmzQWssUaw7Gajx6w4VNMDCW1UG8o3gYTXf1Uu+KW4GNiw40PA9XFP+JReJ9gNwBy5Byyaqj9zRlhV6lho7sXdzEMipGdAQ0kui1dR0iMmpweGdHfkI18SrJ+7l/mL6LoihccVrVkMydiMogKA0Ed/nXbJOdj7VthyzQQWwAACpf4YeGgq3kw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yz/zzOWX; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+4a75e1166b7f241dd976+8248+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yz/zzOWX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+4a75e1166b7f241dd976+8248+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fg0rW1T6bz3fJL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 17:44:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dHnmPdMyRE0J+BnZ4DYHnLY9lmWhvxHv4FOPtQNRSM8=; b=yz/zzOWXy/ZdpkoYrAZ8g3NYS4
	FEVCC5dbOQwpFlenWAnGHkhi4W4F5TY5LjNs5D8JoShw9fpcg0d/CMV+1QEXpG3L53ZvEj3e6MC3/
	VJQZESNrsrfmQz1XxkJXgTAzhauExzWtPc2PP0aFPwrfhzK1+zSWXfnn8Wt9zrpeSE2fgJRN9l1rC
	w42UK1kUyN51JyFNEdLW6WfP0RtHUbLjYvlRZ+T4R0XE7mN00qWWOjG6Yb1d8xep1XavSJQcN1eUi
	Q63y4entpaNY3+OSetRx5XsXsH4/YPpGl/t+3I/+swrrgNXy/JlpbTSOOITpOBybRQcCT3jmyFMQA
	Xzs4j//Q==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vUq-00000000nsT-2H25;
	Tue, 24 Mar 2026 06:44:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: [PATCH 12/17] raid6: update top of file comments
Date: Tue, 24 Mar 2026 07:40:47 +0100
Message-ID: <20260324064115.3217136-13-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324064115.3217136-1-hch@lst.de>
References: <20260324064115.3217136-1-hch@lst.de>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Drop the pointless mention of the file name, and use standard formatting
for the top of file comments.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/raid/raid6/algos.c      |  8 +-------
 lib/raid/raid6/arm/neon.c   |  2 +-
 lib/raid/raid6/mktables.c   | 12 +++---------
 lib/raid/raid6/recov.c      | 14 ++++----------
 lib/raid/raid6/riscv/rvv.h  |  2 --
 lib/raid/raid6/x86/avx2.c   | 13 ++++---------
 lib/raid/raid6/x86/avx512.c | 18 ++++++------------
 lib/raid/raid6/x86/mmx.c    | 10 ++--------
 lib/raid/raid6/x86/sse1.c   | 18 ++++++------------
 lib/raid/raid6/x86/sse2.c   |  9 +--------
 10 files changed, 28 insertions(+), 78 deletions(-)

diff --git a/lib/raid/raid6/algos.c b/lib/raid/raid6/algos.c
index 201443f6cac2..5fdf6d362f58 100644
--- a/lib/raid/raid6/algos.c
+++ b/lib/raid/raid6/algos.c
@@ -1,12 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- linux-c -*- ------------------------------------------------------- *
- *
- *   Copyright 2002 H. Peter Anvin - All Rights Reserved
- *
- * ----------------------------------------------------------------------- */
-
 /*
- * raid6/algos.c
+ * Copyright 2002 H. Peter Anvin - All Rights Reserved
  *
  * Algorithm list and algorithm selection for RAID-6
  */
diff --git a/lib/raid/raid6/arm/neon.c b/lib/raid/raid6/arm/neon.c
index 341c61af675e..af90869aaffc 100644
--- a/lib/raid/raid6/arm/neon.c
+++ b/lib/raid/raid6/arm/neon.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/lib/raid6/neon.c - RAID6 syndrome calculation using ARM NEON intrinsics
+ * RAID6 syndrome calculation using ARM NEON intrinsics
  *
  * Copyright (C) 2013 Linaro Ltd <ard.biesheuvel@linaro.org>
  */
diff --git a/lib/raid/raid6/mktables.c b/lib/raid/raid6/mktables.c
index 97a17493bbd8..b6327b562fdb 100644
--- a/lib/raid/raid6/mktables.c
+++ b/lib/raid/raid6/mktables.c
@@ -1,15 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- linux-c -*- ------------------------------------------------------- *
- *
- *   Copyright 2002-2007 H. Peter Anvin - All Rights Reserved
- *
- * ----------------------------------------------------------------------- */
-
 /*
- * mktables.c
+ * Copyright 2002-2007 H. Peter Anvin - All Rights Reserved
  *
- * Make RAID-6 tables.  This is a host user space program to be run at
- * compile time.
+ * Make RAID-6 tables.  This is a host user space program to be run at compile
+ * time.
  */
 
 #include <stdio.h>
diff --git a/lib/raid/raid6/recov.c b/lib/raid/raid6/recov.c
index 76eb2aef3667..3fa53bc3fde4 100644
--- a/lib/raid/raid6/recov.c
+++ b/lib/raid/raid6/recov.c
@@ -1,16 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- linux-c -*- ------------------------------------------------------- *
- *
- *   Copyright 2002 H. Peter Anvin - All Rights Reserved
- *
- * ----------------------------------------------------------------------- */
-
 /*
- * raid6/recov.c
+ * Copyright 2002 H. Peter Anvin - All Rights Reserved
  *
- * RAID-6 data recovery in dual failure mode.  In single failure mode,
- * use the RAID-5 algorithm (or, in the case of Q failure, just reconstruct
- * the syndrome.)
+ * RAID-6 data recovery in dual failure mode.  In single failure mode, use the
+ * RAID-5 algorithm (or, in the case of Q failure, just reconstruct the
+ * syndrome.)
  */
 
 #include <linux/mm.h>
diff --git a/lib/raid/raid6/riscv/rvv.h b/lib/raid/raid6/riscv/rvv.h
index 3a7c2468b1ea..df0e3637cae8 100644
--- a/lib/raid/raid6/riscv/rvv.h
+++ b/lib/raid/raid6/riscv/rvv.h
@@ -2,8 +2,6 @@
 /*
  * Copyright 2024 Institute of Software, CAS.
  *
- * raid6/rvv.h
- *
  * Definitions for RISC-V RAID-6 code
  */
 
diff --git a/lib/raid/raid6/x86/avx2.c b/lib/raid/raid6/x86/avx2.c
index 7efd94e6a87a..7d829c669ea7 100644
--- a/lib/raid/raid6/x86/avx2.c
+++ b/lib/raid/raid6/x86/avx2.c
@@ -1,16 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- linux-c -*- ------------------------------------------------------- *
- *
- *   Copyright (C) 2012 Intel Corporation
- *   Author: Yuanhan Liu <yuanhan.liu@linux.intel.com>
+/*
+ * Copyright (C) 2012 Intel Corporation
+ * Author: Yuanhan Liu <yuanhan.liu@linux.intel.com>
  *
- *   Based on sse2.c: Copyright 2002 H. Peter Anvin - All Rights Reserved
+ * Based on sse2.c: Copyright 2002 H. Peter Anvin - All Rights Reserved
  *
- * ----------------------------------------------------------------------- */
-
-/*
  * AVX2 implementation of RAID-6 syndrome functions
- *
  */
 
 #include <asm/cpufeature.h>
diff --git a/lib/raid/raid6/x86/avx512.c b/lib/raid/raid6/x86/avx512.c
index 0772e798b742..e671eb5bde63 100644
--- a/lib/raid/raid6/x86/avx512.c
+++ b/lib/raid/raid6/x86/avx512.c
@@ -1,20 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- linux-c -*- --------------------------------------------------------
- *
- *   Copyright (C) 2016 Intel Corporation
+/*
+ * Copyright (C) 2016 Intel Corporation
  *
- *   Author: Gayatri Kammela <gayatri.kammela@intel.com>
- *   Author: Megha Dey <megha.dey@linux.intel.com>
+ * Author: Gayatri Kammela <gayatri.kammela@intel.com>
+ * Author: Megha Dey <megha.dey@linux.intel.com>
  *
- *   Based on avx2.c: Copyright 2012 Yuanhan Liu All Rights Reserved
- *   Based on sse2.c: Copyright 2002 H. Peter Anvin - All Rights Reserved
+ * Based on avx2.c: Copyright 2012 Yuanhan Liu All Rights Reserved
+ * Based on sse2.c: Copyright 2002 H. Peter Anvin - All Rights Reserved
  *
- * -----------------------------------------------------------------------
- */
-
-/*
  * AVX512 implementation of RAID-6 syndrome functions
- *
  */
 
 #include <asm/cpufeature.h>
diff --git a/lib/raid/raid6/x86/mmx.c b/lib/raid/raid6/x86/mmx.c
index 3228c335965a..afa82536142d 100644
--- a/lib/raid/raid6/x86/mmx.c
+++ b/lib/raid/raid6/x86/mmx.c
@@ -1,14 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- linux-c -*- ------------------------------------------------------- *
- *
- *   Copyright 2002 H. Peter Anvin - All Rights Reserved
- *
- * ----------------------------------------------------------------------- */
-
 /*
- * raid6/mmx.c
+ * Copyright 2002 H. Peter Anvin - All Rights Reserved
  *
- * MMX implementation of RAID-6 syndrome functions
+ * MMX implementation of RAID-6 syndrome functions.
  */
 
 #include <asm/cpufeature.h>
diff --git a/lib/raid/raid6/x86/sse1.c b/lib/raid/raid6/x86/sse1.c
index 6ebdcf824e00..f4b260df522a 100644
--- a/lib/raid/raid6/x86/sse1.c
+++ b/lib/raid/raid6/x86/sse1.c
@@ -1,19 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- linux-c -*- ------------------------------------------------------- *
- *
- *   Copyright 2002 H. Peter Anvin - All Rights Reserved
- *
- * ----------------------------------------------------------------------- */
-
 /*
- * raid6/sse1.c
+ * Copyright 2002 H. Peter Anvin - All Rights Reserved
  *
- * SSE-1/MMXEXT implementation of RAID-6 syndrome functions
+ * SSE-1/MMXEXT implementation of RAID-6 syndrome functions.
  *
- * This is really an MMX implementation, but it requires SSE-1 or
- * AMD MMXEXT for prefetch support and a few other features.  The
- * support for nontemporal memory accesses is enough to make this
- * worthwhile as a separate implementation.
+ * This is really an MMX implementation, but it requires SSE-1 or AMD MMXEXT for
+ * prefetch support and a few other features.  The support for nontemporal
+ * memory accesses is enough to make this worthwhile as a separate
+ * implementation.
  */
 
 #include <asm/cpufeature.h>
diff --git a/lib/raid/raid6/x86/sse2.c b/lib/raid/raid6/x86/sse2.c
index 7049c8512f35..43b09ce58270 100644
--- a/lib/raid/raid6/x86/sse2.c
+++ b/lib/raid/raid6/x86/sse2.c
@@ -1,15 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- linux-c -*- ------------------------------------------------------- *
- *
- *   Copyright 2002 H. Peter Anvin - All Rights Reserved
- *
- * ----------------------------------------------------------------------- */
-
 /*
- * raid6/sse2.c
+ * Copyright 2002 H. Peter Anvin - All Rights Reserved
  *
  * SSE-2 implementation of RAID-6 syndrome functions
- *
  */
 
 #include <asm/cpufeature.h>
-- 
2.47.3


