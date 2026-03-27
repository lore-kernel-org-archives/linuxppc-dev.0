Return-Path: <linuxppc-dev+bounces-18872-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF9410BA42E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 06:18:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhr6p2j2Cz2ypY;
	Fri, 27 Mar 2026 17:18:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774592290;
	cv=none; b=ndw15L64HnrA9KDjHeJICfiu4JgOj78we7ISJ+BoRRMu1gEP0nOSnx/4MZwDu3eTSK44MEi3Yv9tTXb5j70GvpLVUwSguzPUd3mIhL0RjhYnMy7APdoFC+otTmIfbNxm/0kW2ClFqEzRMpWuhXDHvHSxoCoqo3ccP/dyJtv8SpWVOZucuYphM3MFaX4EhLwxyXPP2wmnwsR06tpczBDnEQLHzB+x3RA9ffJLor3R1QiIoD0psFSR11rUH9KzCJ/WdXgk4k//R6+ueqPD2C0ahOlfrbIqQoEXx6JB4Iy5lsuo0AgM6j5V6NU/vWxZw0rvU7tesuf5gH6x/ecv7epyjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774592290; c=relaxed/relaxed;
	bh=5Q4WO2fmqU3XVJCOHArp4PLeLItyndyIBgJVZQfhExI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6Gp/gM547AHxBi1zivkPlErIGIlrvPQ84w4Z5SOvBKMdJI32DxySMYPhkyHem0Wghhf9IZZeE6rDCyah+3ViOV1xQojob0MvrY954+2fE4coY14zBWRVijCN4bbF458JucdxUdN7GJCRB7B6q/2sSsIeULhwaSa5gB+9QE8BwnhXrXs23+U6WxmMcD08uMnKdr1CWTTbzRG6UE0XgaCyO3C8fBLC/sOUl1hjffQnhqQBvJ8NtBk0zvGwQWsePyX1awhRHRBn8vVIvaGcIhlJhURAscQiaWb1zfGO0znD+yxQKhTQzHxAz94wcLLolQQQBUrzCXOGSD9OF72s1RXPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OMyjUHqe; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+7b1de7ca9b09bfe890a7+8251+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OMyjUHqe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+7b1de7ca9b09bfe890a7+8251+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhr6n5NYmz2xR4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 17:18:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5Q4WO2fmqU3XVJCOHArp4PLeLItyndyIBgJVZQfhExI=; b=OMyjUHqeAjPy2hburxYVx43Lfw
	EbE7hXkI0M7l6tR1cILCcLFm5qoR7owg2spB08uni1M204SFhOOI55wXQxdbRClRuhmGQMwty9VgL
	CS73XAkw8b1l5/57pIk+CELpK2HaQ2/w2kXKBx97uOfWuh1obNmGdfq0AFDjjgORkHnoAeYtZPnvr
	idYSVHMIlfsLc1Kmqxt0rxNh9T2UiDM4sEhGsTnVsI7wgPsGN7PAVzbyLlueJv7qX2H50SZdg/kyA
	dH9lukCeHXqVt+1/zppxByvBfnONhCaM6xg1t8E4MOr56gIdz/ZhXOc6jIzsXUDDYmtCnEGaBcgv4
	Uw7hDFDA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w60Vx-00000006kcV-01lD;
	Fri, 27 Mar 2026 06:17:49 +0000
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
Subject: [PATCH 02/28] arm/xor: remove in_interrupt() handling
Date: Fri, 27 Mar 2026 07:16:34 +0100
Message-ID: <20260327061704.3707577-3-hch@lst.de>
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

xor_blocks can't be called from interrupt context, so remove the
handling for that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/xor.h | 41 +++++++++++---------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/arch/arm/include/asm/xor.h b/arch/arm/include/asm/xor.h
index 934b549905f5..bca2a6514746 100644
--- a/arch/arm/include/asm/xor.h
+++ b/arch/arm/include/asm/xor.h
@@ -4,7 +4,6 @@
  *
  *  Copyright (C) 2001 Russell King
  */
-#include <linux/hardirq.h>
 #include <asm-generic/xor.h>
 #include <asm/hwcap.h>
 #include <asm/neon.h>
@@ -156,13 +155,9 @@ static void
 xor_neon_2(unsigned long bytes, unsigned long * __restrict p1,
 	   const unsigned long * __restrict p2)
 {
-	if (in_interrupt()) {
-		xor_arm4regs_2(bytes, p1, p2);
-	} else {
-		kernel_neon_begin();
-		xor_block_neon_inner.do_2(bytes, p1, p2);
-		kernel_neon_end();
-	}
+	kernel_neon_begin();
+	xor_block_neon_inner.do_2(bytes, p1, p2);
+	kernel_neon_end();
 }
 
 static void
@@ -170,13 +165,9 @@ xor_neon_3(unsigned long bytes, unsigned long * __restrict p1,
 	   const unsigned long * __restrict p2,
 	   const unsigned long * __restrict p3)
 {
-	if (in_interrupt()) {
-		xor_arm4regs_3(bytes, p1, p2, p3);
-	} else {
-		kernel_neon_begin();
-		xor_block_neon_inner.do_3(bytes, p1, p2, p3);
-		kernel_neon_end();
-	}
+	kernel_neon_begin();
+	xor_block_neon_inner.do_3(bytes, p1, p2, p3);
+	kernel_neon_end();
 }
 
 static void
@@ -185,13 +176,9 @@ xor_neon_4(unsigned long bytes, unsigned long * __restrict p1,
 	   const unsigned long * __restrict p3,
 	   const unsigned long * __restrict p4)
 {
-	if (in_interrupt()) {
-		xor_arm4regs_4(bytes, p1, p2, p3, p4);
-	} else {
-		kernel_neon_begin();
-		xor_block_neon_inner.do_4(bytes, p1, p2, p3, p4);
-		kernel_neon_end();
-	}
+	kernel_neon_begin();
+	xor_block_neon_inner.do_4(bytes, p1, p2, p3, p4);
+	kernel_neon_end();
 }
 
 static void
@@ -201,13 +188,9 @@ xor_neon_5(unsigned long bytes, unsigned long * __restrict p1,
 	   const unsigned long * __restrict p4,
 	   const unsigned long * __restrict p5)
 {
-	if (in_interrupt()) {
-		xor_arm4regs_5(bytes, p1, p2, p3, p4, p5);
-	} else {
-		kernel_neon_begin();
-		xor_block_neon_inner.do_5(bytes, p1, p2, p3, p4, p5);
-		kernel_neon_end();
-	}
+	kernel_neon_begin();
+	xor_block_neon_inner.do_5(bytes, p1, p2, p3, p4, p5);
+	kernel_neon_end();
 }
 
 static struct xor_block_template xor_block_neon = {
-- 
2.47.3


