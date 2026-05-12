Return-Path: <linuxppc-dev+bounces-20732-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A719CD4F24
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 05:24:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF4ll0Ffcz2yLB;
	Tue, 12 May 2026 15:24:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778563475;
	cv=none; b=FNhfJmotyKlRlpW6RgwHj/1+59Gp+ueil3/nHrlpzQp8K2L4kBH7LIeIPqQ1t5fwpooR0Bcy8c15hc78kHb/cfTLHRnjO2VzA7nwEj6n3Zbxvl9nlVdC4av5H5LzZaKnOWiHF56XX0N/hzl98KOJqdf6LtkiyVDiBintE3qedu7DhhKMqx6ny1FHsjLSop4pZcnKkHK9O4hTHfsLd+KhbqsXhHi/cZ443xW3Cu22a+T1Qmevb435vLvm5Jr4cb9Q3aN/ZN+YNrw+dRNGe39B4m0kVszKgyDRa9ymFi2p21KAr336SwDRMu9OqWhXgptoBALJxP1TSg+jz35Ub2dBOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778563475; c=relaxed/relaxed;
	bh=FIkZNeGgSVXhgVzo7Yqwh5gdAVZfUzYoIKIAcxn+4Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0A2vO51JsFZjxrvno1Uk+nzH2DNRggIUxTOF32kdaGB2lggAixG5BvonTkst+Vm7IhTpyH7HVn9k7NybkDR5mx63vzb4bGbze7ugvd08lKRE58Mya3ul8VqZY1PcjyQyPbabCnpJzsH5V5CbnulEKaA7FTRCgx9akZO/HSMReL+4T18sn/UlgIKvGNDfd0KgtTHPT2saCjql1qVGclyVuHsbN1/sYZLEESNhpRLjmzE2C0rlwnfg5ZMg5zVF1yVnEJVhsl19Wzfa16erGGn92g1jyS0v/BorqY8TtNGkSak4v3s05oDpViXvLUvKIOS/WcSMQmoNNHDrs/drsAdjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=C7LN66UW; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=C7LN66UW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF4lj4yppz2ySD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 15:24:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FIkZNeGgSVXhgVzo7Yqwh5gdAVZfUzYoIKIAcxn+4Eo=; b=C7LN66UWZbxj/GHx//n4N3aszN
	704qm8fYJvM+ck4YjXPy7tVzYQzfJNJGgq9NJfYcemFeUdXsFAQqE1NFOgwWO0c7U/tDlSjCvSavH
	7QoNd/kWYyvwXXUv+Y1lEMMhwnUfos9TINnFoxqnAwhpLoTQ041wpNrKBuqhPgylUQdPJSu20x5PV
	AASFcOSIt2SNRDNLBNLRal03HUOcUbiOtWuKvDP9l3p18egg0A17KyVofn04NRwSxxVoQJtlCmj9X
	hZbi/EOFB0NoQroe0kJ9cIa9I7/LMsNNsZ8/knIOikll6otZkLiRu47VfvscDa6cDQBIT7nHSp4ZR
	lZb+Td7w==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMfbO-0000000FblM-2vTU;
	Tue, 12 May 2026 05:24:20 +0000
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
Subject: [PATCH 09/19] raid6: hide internals
Date: Tue, 12 May 2026 07:20:49 +0200
Message-ID: <20260512052230.2947683-10-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512052230.2947683-1-hch@lst.de>
References: <20260512052230.2947683-1-hch@lst.de>
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

Split out two new headers from the public pq.h:

 - lib/raid/raid6/algos.h contains the algorithm lists private to
   lib/raid/raid6
 - include/linux/raid/pq_tables.h contains the tables also used by
   async_tx providers.

The public include/linux/pq.h is now limited to the public interface for
the consumers of the RAID6 PQ API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 crypto/async_tx/async_pq.c                    |  1 +
 crypto/async_tx/async_raid6_recov.c           |  1 +
 drivers/dma/bcm-sba-raid.c                    |  1 +
 include/linux/raid/pq.h                       | 96 ++-----------------
 include/linux/raid/pq_tables.h                | 19 ++++
 lib/raid/raid6/Makefile                       |  2 +
 lib/raid/raid6/algos.c                        |  3 +-
 lib/raid/raid6/algos.h                        | 82 ++++++++++++++++
 lib/raid/raid6/arm/neon.c                     |  2 +-
 lib/raid/raid6/arm/recov_neon.c               |  2 +
 lib/raid/raid6/int.uc                         |  2 +-
 lib/raid/raid6/loongarch/loongarch_simd.c     |  2 +-
 .../raid6/loongarch/recov_loongarch_simd.c    |  2 +
 lib/raid/raid6/mktables.c                     |  2 +-
 lib/raid/raid6/powerpc/altivec.uc             |  2 +-
 lib/raid/raid6/powerpc/vpermxor.uc            |  2 +-
 lib/raid/raid6/recov.c                        |  2 +
 lib/raid/raid6/riscv/recov_rvv.c              |  2 +
 lib/raid/raid6/riscv/rvv.h                    |  2 +-
 lib/raid/raid6/s390/recov_s390xc.c            |  2 +
 lib/raid/raid6/s390/s390vx.uc                 |  2 +-
 lib/raid/raid6/tests/raid6_kunit.c            |  2 +-
 lib/raid/raid6/x86/avx2.c                     |  3 +-
 lib/raid/raid6/x86/avx512.c                   |  3 +-
 lib/raid/raid6/x86/mmx.c                      |  3 +-
 lib/raid/raid6/x86/recov_avx2.c               |  2 +
 lib/raid/raid6/x86/recov_avx512.c             |  2 +
 lib/raid/raid6/x86/recov_ssse3.c              |  2 +
 lib/raid/raid6/x86/sse1.c                     |  3 +-
 lib/raid/raid6/x86/sse2.c                     |  3 +-
 30 files changed, 151 insertions(+), 103 deletions(-)
 create mode 100644 include/linux/raid/pq_tables.h
 create mode 100644 lib/raid/raid6/algos.h

diff --git a/crypto/async_tx/async_pq.c b/crypto/async_tx/async_pq.c
index f3574f80d1df..27f99349e310 100644
--- a/crypto/async_tx/async_pq.c
+++ b/crypto/async_tx/async_pq.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
 #include <linux/raid/pq.h>
+#include <linux/raid/pq_tables.h>
 #include <linux/async_tx.h>
 #include <linux/gfp.h>
 
diff --git a/crypto/async_tx/async_raid6_recov.c b/crypto/async_tx/async_raid6_recov.c
index 305ea1421a3e..e53870d84bc5 100644
--- a/crypto/async_tx/async_raid6_recov.c
+++ b/crypto/async_tx/async_raid6_recov.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
 #include <linux/raid/pq.h>
+#include <linux/raid/pq_tables.h>
 #include <linux/async_tx.h>
 #include <linux/dmaengine.h>
 
diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index ed037fa883f6..0de03611252e 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -40,6 +40,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/raid/pq.h>
+#include <linux/raid/pq_tables.h>
 
 #include "dmaengine.h"
 
diff --git a/include/linux/raid/pq.h b/include/linux/raid/pq.h
index 662c2669f63f..760dd41a10b0 100644
--- a/include/linux/raid/pq.h
+++ b/include/linux/raid/pq.h
@@ -1,15 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- linux-c -*- ------------------------------------------------------- *
- *
- *   Copyright 2003 H. Peter Anvin - All Rights Reserved
+/*
+ * Copyright 2003 H. Peter Anvin - All Rights Reserved
  *
- * ----------------------------------------------------------------------- */
-
-#ifndef LINUX_RAID_RAID6_H
-#define LINUX_RAID_RAID6_H
+ * Public interface to the RAID6 P/Q calculation and recovery library.
+ */
+#ifndef LINUX_RAID_PQ_H
+#define LINUX_RAID_PQ_H
 
-#include <linux/blkdev.h>
-#include <linux/mm.h>
+#include <linux/types.h>
 
 /*
  * While the RAID6 algorithm could in theory support 3 devices by just copying
@@ -30,82 +28,4 @@ void raid6_recov_2data(int disks, size_t bytes, int faila, int failb,
 void raid6_recov_datap(int disks, size_t bytes, int faila,
 		void **ptrs);
 
-/* Routine choices */
-struct raid6_calls {
-	void (*gen_syndrome)(int, size_t, void **);
-	void (*xor_syndrome)(int, int, int, size_t, void **);
-	int  (*valid)(void);	/* Returns 1 if this routine set is usable */
-	const char *name;	/* Name of this routine set */
-	int priority;		/* Relative priority ranking if non-zero */
-};
-
-/* Various routine sets */
-extern const struct raid6_calls raid6_intx1;
-extern const struct raid6_calls raid6_intx2;
-extern const struct raid6_calls raid6_intx4;
-extern const struct raid6_calls raid6_intx8;
-extern const struct raid6_calls raid6_mmxx1;
-extern const struct raid6_calls raid6_mmxx2;
-extern const struct raid6_calls raid6_sse1x1;
-extern const struct raid6_calls raid6_sse1x2;
-extern const struct raid6_calls raid6_sse2x1;
-extern const struct raid6_calls raid6_sse2x2;
-extern const struct raid6_calls raid6_sse2x4;
-extern const struct raid6_calls raid6_altivec1;
-extern const struct raid6_calls raid6_altivec2;
-extern const struct raid6_calls raid6_altivec4;
-extern const struct raid6_calls raid6_altivec8;
-extern const struct raid6_calls raid6_avx2x1;
-extern const struct raid6_calls raid6_avx2x2;
-extern const struct raid6_calls raid6_avx2x4;
-extern const struct raid6_calls raid6_avx512x1;
-extern const struct raid6_calls raid6_avx512x2;
-extern const struct raid6_calls raid6_avx512x4;
-extern const struct raid6_calls raid6_s390vx8;
-extern const struct raid6_calls raid6_vpermxor1;
-extern const struct raid6_calls raid6_vpermxor2;
-extern const struct raid6_calls raid6_vpermxor4;
-extern const struct raid6_calls raid6_vpermxor8;
-extern const struct raid6_calls raid6_lsx;
-extern const struct raid6_calls raid6_lasx;
-extern const struct raid6_calls raid6_rvvx1;
-extern const struct raid6_calls raid6_rvvx2;
-extern const struct raid6_calls raid6_rvvx4;
-extern const struct raid6_calls raid6_rvvx8;
-
-struct raid6_recov_calls {
-	void (*data2)(int, size_t, int, int, void **);
-	void (*datap)(int, size_t, int, void **);
-	int  (*valid)(void);
-	const char *name;
-	int priority;
-};
-
-extern const struct raid6_recov_calls raid6_recov_intx1;
-extern const struct raid6_recov_calls raid6_recov_ssse3;
-extern const struct raid6_recov_calls raid6_recov_avx2;
-extern const struct raid6_recov_calls raid6_recov_avx512;
-extern const struct raid6_recov_calls raid6_recov_s390xc;
-extern const struct raid6_recov_calls raid6_recov_neon;
-extern const struct raid6_recov_calls raid6_recov_lsx;
-extern const struct raid6_recov_calls raid6_recov_lasx;
-extern const struct raid6_recov_calls raid6_recov_rvv;
-
-extern const struct raid6_calls raid6_neonx1;
-extern const struct raid6_calls raid6_neonx2;
-extern const struct raid6_calls raid6_neonx4;
-extern const struct raid6_calls raid6_neonx8;
-
-/* Algorithm list */
-extern const struct raid6_calls * const raid6_algos[];
-extern const struct raid6_recov_calls *const raid6_recov_algos[];
-
-/* Galois field tables */
-extern const u8 raid6_gfmul[256][256] __attribute__((aligned(256)));
-extern const u8 raid6_vgfmul[256][32] __attribute__((aligned(256)));
-extern const u8 raid6_gfexp[256]      __attribute__((aligned(256)));
-extern const u8 raid6_gflog[256]      __attribute__((aligned(256)));
-extern const u8 raid6_gfinv[256]      __attribute__((aligned(256)));
-extern const u8 raid6_gfexi[256]      __attribute__((aligned(256)));
-
-#endif /* LINUX_RAID_RAID6_H */
+#endif /* LINUX_RAID_PQ_H */
diff --git a/include/linux/raid/pq_tables.h b/include/linux/raid/pq_tables.h
new file mode 100644
index 000000000000..7b1ebe675677
--- /dev/null
+++ b/include/linux/raid/pq_tables.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright 2003 H. Peter Anvin - All Rights Reserved
+ *
+ * Galois field tables for the Linux RAID6 P/Q parity algorithm.
+ */
+#ifndef _LINUX_RAID_PQ_TABLES_H
+#define _LINUX_RAID_PQ_TABLES_H
+
+#include <linux/types.h>
+
+extern const u8 raid6_gfmul[256][256] __attribute__((aligned(256)));
+extern const u8 raid6_vgfmul[256][32] __attribute__((aligned(256)));
+extern const u8 raid6_gfexp[256]      __attribute__((aligned(256)));
+extern const u8 raid6_gflog[256]      __attribute__((aligned(256)));
+extern const u8 raid6_gfinv[256]      __attribute__((aligned(256)));
+extern const u8 raid6_gfexi[256]      __attribute__((aligned(256)));
+
+#endif /* _LINUX_RAID_PQ_TABLES_H */
diff --git a/lib/raid/raid6/Makefile b/lib/raid/raid6/Makefile
index 886a1771e78d..f64f6d32f28b 100644
--- a/lib/raid/raid6/Makefile
+++ b/lib/raid/raid6/Makefile
@@ -2,6 +2,8 @@
 
 hostprogs			+= mktables
 
+ccflags-y			+= -I $(src)
+
 obj-$(CONFIG_RAID6_PQ)		+= raid6_pq.o tests/
 
 raid6_pq-y			+= algos.o tables.o
diff --git a/lib/raid/raid6/algos.c b/lib/raid/raid6/algos.c
index 683b97cb94ad..af31a1feb6e7 100644
--- a/lib/raid/raid6/algos.c
+++ b/lib/raid/raid6/algos.c
@@ -11,10 +11,11 @@
  * Algorithm list and algorithm selection for RAID-6
  */
 
-#include <linux/raid/pq.h>
 #include <linux/module.h>
 #include <linux/gfp.h>
+#include <linux/raid/pq.h>
 #include <kunit/visibility.h>
+#include "algos.h"
 
 static const struct raid6_recov_calls *raid6_recov_algo;
 
diff --git a/lib/raid/raid6/algos.h b/lib/raid/raid6/algos.h
new file mode 100644
index 000000000000..e5f1098d2179
--- /dev/null
+++ b/lib/raid/raid6/algos.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright 2003 H. Peter Anvin - All Rights Reserved
+ */
+#ifndef _PQ_IMPL_H
+#define _PQ_IMPL_H
+
+#include <linux/raid/pq_tables.h>
+
+/* Routine choices */
+struct raid6_calls {
+	const char *name;
+	void (*gen_syndrome)(int disks, size_t bytes, void **ptrs);
+	void (*xor_syndrome)(int disks, int start, int stop, size_t bytes,
+			void **ptrs);
+	int  (*valid)(void);	/* Returns 1 if this routine set is usable */
+	int priority;		/* Relative priority ranking if non-zero */
+};
+
+/* Various routine sets */
+extern const struct raid6_calls raid6_intx1;
+extern const struct raid6_calls raid6_intx2;
+extern const struct raid6_calls raid6_intx4;
+extern const struct raid6_calls raid6_intx8;
+extern const struct raid6_calls raid6_mmxx1;
+extern const struct raid6_calls raid6_mmxx2;
+extern const struct raid6_calls raid6_sse1x1;
+extern const struct raid6_calls raid6_sse1x2;
+extern const struct raid6_calls raid6_sse2x1;
+extern const struct raid6_calls raid6_sse2x2;
+extern const struct raid6_calls raid6_sse2x4;
+extern const struct raid6_calls raid6_altivec1;
+extern const struct raid6_calls raid6_altivec2;
+extern const struct raid6_calls raid6_altivec4;
+extern const struct raid6_calls raid6_altivec8;
+extern const struct raid6_calls raid6_avx2x1;
+extern const struct raid6_calls raid6_avx2x2;
+extern const struct raid6_calls raid6_avx2x4;
+extern const struct raid6_calls raid6_avx512x1;
+extern const struct raid6_calls raid6_avx512x2;
+extern const struct raid6_calls raid6_avx512x4;
+extern const struct raid6_calls raid6_s390vx8;
+extern const struct raid6_calls raid6_vpermxor1;
+extern const struct raid6_calls raid6_vpermxor2;
+extern const struct raid6_calls raid6_vpermxor4;
+extern const struct raid6_calls raid6_vpermxor8;
+extern const struct raid6_calls raid6_lsx;
+extern const struct raid6_calls raid6_lasx;
+extern const struct raid6_calls raid6_rvvx1;
+extern const struct raid6_calls raid6_rvvx2;
+extern const struct raid6_calls raid6_rvvx4;
+extern const struct raid6_calls raid6_rvvx8;
+
+struct raid6_recov_calls {
+	const char *name;
+	void (*data2)(int disks, size_t bytes, int faila, int failb,
+			void **ptrs);
+	void (*datap)(int disks, size_t bytes, int faila, void **ptrs);
+	int  (*valid)(void);
+	int priority;
+};
+
+extern const struct raid6_recov_calls raid6_recov_intx1;
+extern const struct raid6_recov_calls raid6_recov_ssse3;
+extern const struct raid6_recov_calls raid6_recov_avx2;
+extern const struct raid6_recov_calls raid6_recov_avx512;
+extern const struct raid6_recov_calls raid6_recov_s390xc;
+extern const struct raid6_recov_calls raid6_recov_neon;
+extern const struct raid6_recov_calls raid6_recov_lsx;
+extern const struct raid6_recov_calls raid6_recov_lasx;
+extern const struct raid6_recov_calls raid6_recov_rvv;
+
+extern const struct raid6_calls raid6_neonx1;
+extern const struct raid6_calls raid6_neonx2;
+extern const struct raid6_calls raid6_neonx4;
+extern const struct raid6_calls raid6_neonx8;
+
+/* Algorithm list */
+extern const struct raid6_calls * const raid6_algos[];
+extern const struct raid6_recov_calls *const raid6_recov_algos[];
+
+#endif /* _PQ_IMPL_H */
diff --git a/lib/raid/raid6/arm/neon.c b/lib/raid/raid6/arm/neon.c
index c21da59ab48f..bd4ec4c86ee8 100644
--- a/lib/raid/raid6/arm/neon.c
+++ b/lib/raid/raid6/arm/neon.c
@@ -5,8 +5,8 @@
  * Copyright (C) 2013 Linaro Ltd <ard.biesheuvel@linaro.org>
  */
 
-#include <linux/raid/pq.h>
 #include <asm/simd.h>
+#include "algos.h"
 
 /*
  * There are 2 reasons these wrappers are kept in a separate compilation unit
diff --git a/lib/raid/raid6/arm/recov_neon.c b/lib/raid/raid6/arm/recov_neon.c
index 4eb0efb44750..e1d1d19fc9a8 100644
--- a/lib/raid/raid6/arm/recov_neon.c
+++ b/lib/raid/raid6/arm/recov_neon.c
@@ -4,8 +4,10 @@
  * Copyright (C) 2017 Linaro Ltd. <ard.biesheuvel@linaro.org>
  */
 
+#include <linux/mm.h>
 #include <linux/raid/pq.h>
 #include <asm/simd.h>
+#include "algos.h"
 #include "arm/neon.h"
 
 static int raid6_has_neon(void)
diff --git a/lib/raid/raid6/int.uc b/lib/raid/raid6/int.uc
index 4f5f2869e21e..e63bd5a9c2ed 100644
--- a/lib/raid/raid6/int.uc
+++ b/lib/raid/raid6/int.uc
@@ -18,7 +18,7 @@
  * This file is postprocessed using unroll.awk
  */
 
-#include <linux/raid/pq.h>
+#include "algos.h"
 
 /*
  * This is the C data type to use
diff --git a/lib/raid/raid6/loongarch/loongarch_simd.c b/lib/raid/raid6/loongarch/loongarch_simd.c
index 1b4cd1512d05..f77d11ce676e 100644
--- a/lib/raid/raid6/loongarch/loongarch_simd.c
+++ b/lib/raid/raid6/loongarch/loongarch_simd.c
@@ -9,9 +9,9 @@
  * Copyright 2002-2004 H. Peter Anvin
  */
 
-#include <linux/raid/pq.h>
 #include <asm/cpu-features.h>
 #include <asm/fpu.h>
+#include "algos.h"
 
 /*
  * The vector algorithms are currently priority 0, which means the generic
diff --git a/lib/raid/raid6/loongarch/recov_loongarch_simd.c b/lib/raid/raid6/loongarch/recov_loongarch_simd.c
index 7d4d349322b3..0bbdc8b5c2e7 100644
--- a/lib/raid/raid6/loongarch/recov_loongarch_simd.c
+++ b/lib/raid/raid6/loongarch/recov_loongarch_simd.c
@@ -10,9 +10,11 @@
  * Author: Jim Kukunas <james.t.kukunas@linux.intel.com>
  */
 
+#include <linux/mm.h>
 #include <linux/raid/pq.h>
 #include <asm/cpu-features.h>
 #include <asm/fpu.h>
+#include "algos.h"
 
 /*
  * Unlike with the syndrome calculation algorithms, there's no boot-time
diff --git a/lib/raid/raid6/mktables.c b/lib/raid/raid6/mktables.c
index 3de1dbf6846c..97a17493bbd8 100644
--- a/lib/raid/raid6/mktables.c
+++ b/lib/raid/raid6/mktables.c
@@ -57,7 +57,7 @@ int main(int argc, char *argv[])
 	uint8_t exptbl[256], invtbl[256];
 
 	printf("#include <linux/export.h>\n");
-	printf("#include <linux/raid/pq.h>\n");
+	printf("#include \"algos.h\"\n");
 
 	/* Compute multiplication table */
 	printf("\nconst u8  __attribute__((aligned(256)))\n"
diff --git a/lib/raid/raid6/powerpc/altivec.uc b/lib/raid/raid6/powerpc/altivec.uc
index 084ead768ddb..eb4a448cc88e 100644
--- a/lib/raid/raid6/powerpc/altivec.uc
+++ b/lib/raid/raid6/powerpc/altivec.uc
@@ -22,7 +22,7 @@
  * bracked this with preempt_disable/enable or in a lock)
  */
 
-#include <linux/raid/pq.h>
+#include "algos.h"
 
 #include <altivec.h>
 #include <asm/cputable.h>
diff --git a/lib/raid/raid6/powerpc/vpermxor.uc b/lib/raid/raid6/powerpc/vpermxor.uc
index bb2c3a316ae8..ec61f30bec11 100644
--- a/lib/raid/raid6/powerpc/vpermxor.uc
+++ b/lib/raid/raid6/powerpc/vpermxor.uc
@@ -20,11 +20,11 @@
  * This instruction was introduced in POWER8 - ISA v2.07.
  */
 
-#include <linux/raid/pq.h>
 #include <altivec.h>
 #include <asm/ppc-opcode.h>
 #include <asm/cputable.h>
 #include <asm/switch_to.h>
+#include "algos.h"
 
 typedef vector unsigned char unative_t;
 #define NSIZE sizeof(unative_t)
diff --git a/lib/raid/raid6/recov.c b/lib/raid/raid6/recov.c
index cc7e4dc1eaa6..735ab4013771 100644
--- a/lib/raid/raid6/recov.c
+++ b/lib/raid/raid6/recov.c
@@ -13,7 +13,9 @@
  * the syndrome.)
  */
 
+#include <linux/mm.h>
 #include <linux/raid/pq.h>
+#include "algos.h"
 
 /* Recover two failed data blocks. */
 static void raid6_2data_recov_intx1(int disks, size_t bytes, int faila,
diff --git a/lib/raid/raid6/riscv/recov_rvv.c b/lib/raid/raid6/riscv/recov_rvv.c
index 3ff39826e33f..02120d245e22 100644
--- a/lib/raid/raid6/riscv/recov_rvv.c
+++ b/lib/raid/raid6/riscv/recov_rvv.c
@@ -4,7 +4,9 @@
  * Author: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
  */
 
+#include <linux/mm.h>
 #include <linux/raid/pq.h>
+#include "algos.h"
 #include "rvv.h"
 
 static void __raid6_2data_recov_rvv(int bytes, u8 *p, u8 *q, u8 *dp,
diff --git a/lib/raid/raid6/riscv/rvv.h b/lib/raid/raid6/riscv/rvv.h
index 0d430a4c5f08..c293130d798b 100644
--- a/lib/raid/raid6/riscv/rvv.h
+++ b/lib/raid/raid6/riscv/rvv.h
@@ -7,8 +7,8 @@
  * Definitions for RISC-V RAID-6 code
  */
 
-#include <linux/raid/pq.h>
 #include <asm/vector.h>
+#include "algos.h"
 
 static int rvv_has_vector(void)
 {
diff --git a/lib/raid/raid6/s390/recov_s390xc.c b/lib/raid/raid6/s390/recov_s390xc.c
index 2bc4c85174de..e7b3409f21e2 100644
--- a/lib/raid/raid6/s390/recov_s390xc.c
+++ b/lib/raid/raid6/s390/recov_s390xc.c
@@ -6,7 +6,9 @@
  * Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
  */
 
+#include <linux/mm.h>
 #include <linux/raid/pq.h>
+#include "algos.h"
 
 static inline void xor_block(u8 *p1, u8 *p2)
 {
diff --git a/lib/raid/raid6/s390/s390vx.uc b/lib/raid/raid6/s390/s390vx.uc
index 97c5d5d9dcf9..aba3515eacac 100644
--- a/lib/raid/raid6/s390/s390vx.uc
+++ b/lib/raid/raid6/s390/s390vx.uc
@@ -12,8 +12,8 @@
  */
 
 #include <linux/cpufeature.h>
-#include <linux/raid/pq.h>
 #include <asm/fpu.h>
+#include "algos.h"
 
 #define NSIZE 16
 
diff --git a/lib/raid/raid6/tests/raid6_kunit.c b/lib/raid/raid6/tests/raid6_kunit.c
index ab4fda17395b..9b71f22fa19a 100644
--- a/lib/raid/raid6/tests/raid6_kunit.c
+++ b/lib/raid/raid6/tests/raid6_kunit.c
@@ -7,7 +7,7 @@
 
 #include <kunit/test.h>
 #include <linux/prandom.h>
-#include <linux/raid/pq.h>
+#include "../algos.h"
 
 MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 
diff --git a/lib/raid/raid6/x86/avx2.c b/lib/raid/raid6/x86/avx2.c
index aab8b624c635..0bf831799082 100644
--- a/lib/raid/raid6/x86/avx2.c
+++ b/lib/raid/raid6/x86/avx2.c
@@ -13,8 +13,9 @@
  *
  */
 
-#include <linux/raid/pq.h>
+#include <asm/cpufeature.h>
 #include <asm/fpu/api.h>
+#include "algos.h"
 
 static const struct raid6_avx2_constants {
 	u64 x1d[4];
diff --git a/lib/raid/raid6/x86/avx512.c b/lib/raid/raid6/x86/avx512.c
index 47636b16632f..98ed42fb0a46 100644
--- a/lib/raid/raid6/x86/avx512.c
+++ b/lib/raid/raid6/x86/avx512.c
@@ -17,8 +17,9 @@
  *
  */
 
-#include <linux/raid/pq.h>
+#include <asm/cpufeature.h>
 #include <asm/fpu/api.h>
+#include "algos.h"
 
 static const struct raid6_avx512_constants {
 	u64 x1d[8];
diff --git a/lib/raid/raid6/x86/mmx.c b/lib/raid/raid6/x86/mmx.c
index 22b9fdaa705f..052d9f010bfe 100644
--- a/lib/raid/raid6/x86/mmx.c
+++ b/lib/raid/raid6/x86/mmx.c
@@ -11,8 +11,9 @@
  * MMX implementation of RAID-6 syndrome functions
  */
 
-#include <linux/raid/pq.h>
+#include <asm/cpufeature.h>
 #include <asm/fpu/api.h>
+#include "algos.h"
 
 /* Shared with raid6/sse1.c */
 const struct raid6_mmx_constants {
diff --git a/lib/raid/raid6/x86/recov_avx2.c b/lib/raid/raid6/x86/recov_avx2.c
index bef82a38d8eb..06c6e05763bc 100644
--- a/lib/raid/raid6/x86/recov_avx2.c
+++ b/lib/raid/raid6/x86/recov_avx2.c
@@ -4,8 +4,10 @@
  * Author: Jim Kukunas <james.t.kukunas@linux.intel.com>
  */
 
+#include <linux/mm.h>
 #include <linux/raid/pq.h>
 #include <asm/fpu/api.h>
+#include "algos.h"
 
 static int raid6_has_avx2(void)
 {
diff --git a/lib/raid/raid6/x86/recov_avx512.c b/lib/raid/raid6/x86/recov_avx512.c
index 06c70e771eaa..850bb962b514 100644
--- a/lib/raid/raid6/x86/recov_avx512.c
+++ b/lib/raid/raid6/x86/recov_avx512.c
@@ -6,8 +6,10 @@
  * Author: Megha Dey <megha.dey@linux.intel.com>
  */
 
+#include <linux/mm.h>
 #include <linux/raid/pq.h>
 #include <asm/fpu/api.h>
+#include "algos.h"
 
 static int raid6_has_avx512(void)
 {
diff --git a/lib/raid/raid6/x86/recov_ssse3.c b/lib/raid/raid6/x86/recov_ssse3.c
index 5ca7d56f23d8..95589c33003a 100644
--- a/lib/raid/raid6/x86/recov_ssse3.c
+++ b/lib/raid/raid6/x86/recov_ssse3.c
@@ -3,8 +3,10 @@
  * Copyright (C) 2012 Intel Corporation
  */
 
+#include <linux/mm.h>
 #include <linux/raid/pq.h>
 #include <asm/fpu/api.h>
+#include "algos.h"
 
 static int raid6_has_ssse3(void)
 {
diff --git a/lib/raid/raid6/x86/sse1.c b/lib/raid/raid6/x86/sse1.c
index fad214a430d8..7004255a0bb1 100644
--- a/lib/raid/raid6/x86/sse1.c
+++ b/lib/raid/raid6/x86/sse1.c
@@ -16,8 +16,9 @@
  * worthwhile as a separate implementation.
  */
 
-#include <linux/raid/pq.h>
+#include <asm/cpufeature.h>
 #include <asm/fpu/api.h>
+#include "algos.h"
 
 /* Defined in raid6/mmx.c */
 extern const struct raid6_mmx_constants {
diff --git a/lib/raid/raid6/x86/sse2.c b/lib/raid/raid6/x86/sse2.c
index 1b28e858a1d4..f30be4ee14d0 100644
--- a/lib/raid/raid6/x86/sse2.c
+++ b/lib/raid/raid6/x86/sse2.c
@@ -12,8 +12,9 @@
  *
  */
 
-#include <linux/raid/pq.h>
+#include <asm/cpufeature.h>
 #include <asm/fpu/api.h>
+#include "algos.h"
 
 static const struct raid6_sse_constants {
 	u64 x1d[2];
-- 
2.53.0


