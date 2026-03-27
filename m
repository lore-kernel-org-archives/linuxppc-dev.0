Return-Path: <linuxppc-dev+bounces-18874-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C4E10BA42E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 06:18:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhr7T6MhYz2yrt;
	Fri, 27 Mar 2026 17:18:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774592325;
	cv=none; b=J+lOOW1+amyonYhLEYTNXVOam7HSvUjrVaMC1vSkSxjlFgZB5Ys6oB8DxwDhj1r8/YgziMmPxHqwUoq8H7BC5SmFgYE9NQOIZ8am5MRTqrHkhIhO0zYsFAyWut4VVj6ZE2Kw3ff2AVu0PPt50/wAaQ7TZXLrpeqfOXihAebZDAGWnklWFUaye2v5G2bovpfH5pn2IdCcO2ka+1/FscdVXn+mmRB1jnwNnQldmfj8L33gjcbNjXavL67TIB1QfpEZHsvwFgLAE/2bCDvBzpFU0tMvQWjAWyw+gz38ChPDyarxZpNpfeKfF0cEFpka0brfle1abMfJrKj/QaOI/PqVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774592325; c=relaxed/relaxed;
	bh=omvnt0gtTbnSB/wDielAe87T4OSn5qww3Cus3K4/ids=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZEBnplJSA1PmSVRWZAd38BVmQbsriAhOEjCBWhuCblv72CxTlkQCwdU3k/WrlC+z+lmFfzCSzG8cErX4fQoJhGF9xI+l5SmcYoGWMqT222luAiBcWVCsCmyOsJ13oKlAFPcFa4rMaKf1KM7Y1/etyvZ6Bstp4qyGQQTf1V8xl5Ey8acH8FiaNcC8PRF9zAxSb/hE6oJetih5p4AaecTujwY8wAI6Z0cJdLIk5zN0zVt8+RMT+gKycO1xK3mk6nwfFe+Os1HmiT9cZoUOs6YWtAyfI8dHsx8RmYSFLMQE4YLN9n61JmHPp/UJQlkI73p25jHh+5FH3R2r7CNaWLkCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Wy8zv4y0; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+7b1de7ca9b09bfe890a7+8251+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Wy8zv4y0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+7b1de7ca9b09bfe890a7+8251+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhr7T25bcz2yrm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 17:18:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=omvnt0gtTbnSB/wDielAe87T4OSn5qww3Cus3K4/ids=; b=Wy8zv4y0z20MxoXZazOpXq9N+K
	7xwklbXiO1nKnmP9JHaW1y3ncKCujz7Bq8k8G5YU5nfQDkA7LddynBXrSJ0JfayT6DJFR75g7/ivd
	Dyl0BRo+5PcXTrAVJRHuPZh2GDFD4KM2pN8+x+eIySappBwwKLkcEyMIDu4VtCJsU1o7LVE6O9wBX
	NPRTLVgsV5uJRa3e/LmEORTrrXHWXiEBb9qtXO+ESjqw055RuUvCPpwoDZ47yM/+9lv9eu4aog7Ix
	hwVbuLYtEWEIv1C0ttlvbgeoFjCRRd7bGpY2u9gjdGj6GL0iS/N/IiV+wyQg2fwHSS+2MXMkp7ucY
	hEcFrblQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w60WX-00000006ko2-3wr4;
	Fri, 27 Mar 2026 06:18:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
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
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: [PATCH 04/28] um/xor: cleanup xor.h
Date: Fri, 27 Mar 2026 07:16:36 +0100
Message-ID: <20260327061704.3707577-5-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327061704.3707577-1-hch@lst.de>
References: <20260327061704.3707577-1-hch@lst.de>
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

Since commit c055e3eae0f1 ("crypto: xor - use ktime for template
benchmarking") the benchmarking works just fine even for TT_MODE_INFCPU,
so drop the workarounds.  Note that for CPUs supporting AVX2, which
includes almost everything built in the last 10 years, the AVX2
implementation is forced anyway.

CONFIG_X86_32 is always correctly set for UM in arch/x86/um/Kconfig,
so don't override it either.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Richard Weinberger <richard@nod.at>
---
 arch/um/include/asm/xor.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/um/include/asm/xor.h b/arch/um/include/asm/xor.h
index 647fae200c5d..99e5c7e1f475 100644
--- a/arch/um/include/asm/xor.h
+++ b/arch/um/include/asm/xor.h
@@ -2,23 +2,7 @@
 #ifndef _ASM_UM_XOR_H
 #define _ASM_UM_XOR_H
 
-#ifdef CONFIG_64BIT
-#undef CONFIG_X86_32
-#define TT_CPU_INF_XOR_DEFAULT (AVX_SELECT(&xor_block_sse_pf64))
-#else
-#define CONFIG_X86_32 1
-#define TT_CPU_INF_XOR_DEFAULT (AVX_SELECT(&xor_block_8regs))
-#endif
-
 #include <asm/cpufeature.h>
 #include <../../x86/include/asm/xor.h>
-#include <linux/time-internal.h>
-
-#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
-#undef XOR_SELECT_TEMPLATE
-/* pick an arbitrary one - measuring isn't possible with inf-cpu */
-#define XOR_SELECT_TEMPLATE(x)	\
-	(time_travel_mode == TT_MODE_INFCPU ? TT_CPU_INF_XOR_DEFAULT : x)
-#endif
 
 #endif
-- 
2.47.3


