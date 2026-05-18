Return-Path: <linuxppc-dev+bounces-21048-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29214CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 05:21:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJmPt6MDvz3cKT;
	Mon, 18 May 2026 15:21:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779081714;
	cv=none; b=YRfJi313u9C8nBwb6BB2SHjF0tkv0HmaMoIqT3HQNnUwgUks41mJOtfPRD8PxrxfUAIfPVEeBeXZKj30WMaztq8ZU7/MVlNkvgmL06NjdwleaRibMbyixS79MYjlh5D6Z4OxTxg/C6RYhrxuwISLgZv9XVYZnBV65AccYx+oVQeZUVHaP2XEmbjxdPrPCD4/MVzSU1H0ktXB5ObLL81ZPyKlNrr8iAhull9Vu5hPjPiD5XvuTmR6Nxt55iCglqBrQwKmn27gDYUiiOIcQ82TCg3fN8U6cDHgvlco0rcS4CQSt9FZk19ntaBZSBe37g6i1mhOoK1bVuF+6RgUWXbXhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779081714; c=relaxed/relaxed;
	bh=f75V728WWXgJ9k+dp8OnmQyD6j07xSpDflFB4j9UARE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8CdN9oYZE+MKmVXcaxjHGu1CMUJftrQnLI6NQ8Hq6Dc8zTw+n2687rSHY5gJMj4QftRWa3bGDdywAqRMcIv2yom6rHl8bmxIH87VptTNqrpPFLVDS52rScWIxyT5VXdsXP2iUpLcHJ1fZD6lx7Rz2ybinxYLVGgMtlIcp/ZHww96jqFI1MNcdxw1pmq+P2zBczhpZ7YwoTYXU9FTRqqN4Ju28h39f9R4ywRTzuxAhWMwUHsp+3WpZS1simxpp9rqKOoMLja0oiAvYCmcjUoBy2jDNFFKtdikoPBN8Eht/qzjKZsobAJ5Icewj6RfkNNLbwScliGAix44nhLwz2uDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=J6mAY3oj; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+a5a5d3dd39d7e5270008+8303+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=J6mAY3oj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+a5a5d3dd39d7e5270008+8303+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJmPt1Hz6z3cG8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 15:21:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=f75V728WWXgJ9k+dp8OnmQyD6j07xSpDflFB4j9UARE=; b=J6mAY3ojeDIZaoG74JPNESpw7T
	09j3b2IfYGu988cG9glzV3wdJdYudBQ4y2TqYq3b6VrJqCJ7LofW0hb8FyGNuKuhmCbm9QYB9Ggy+
	Vkp/G8uP8SdYvK5yDILVYq4hF3hWLJf2FbrxNznGegAvCNpSDMjZ+iVH3dxDEkl7Kwj5yWORpjTab
	S4flMhBU467nI42SOM66H7qYU2D0sMQYC8IuVj3r4kSTyy/FwvjQ2Lnvenl1M+uF7LbpblAVUyo73
	oNIFHH+U/0mlJ9nnNUWyrZqHEOysFnPzxSRceTbhthIUQLTZbtNEfAEEwH2HFR6X+pyzY7LmSK0cR
	8Kr6a9BQ==;
Received: from [2001:4bb8:2d1:6fdb:d67d:128c:34ba:85b8] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOqQ3-0000000EHd5-0y9I;
	Mon, 18 May 2026 05:21:35 +0000
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
Subject: [PATCH 13/18] raid6: update top of file comments
Date: Mon, 18 May 2026 07:17:56 +0200
Message-ID: <20260518051804.462141-14-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518051804.462141-1-hch@lst.de>
References: <20260518051804.462141-1-hch@lst.de>
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
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Ard Biesheuvel <ardb@kernel.org> # kunit only on arm64
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
index 43e3309b5306..a600d5853672 100644
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
2.53.0


