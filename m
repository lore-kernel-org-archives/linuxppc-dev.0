Return-Path: <linuxppc-dev+bounces-21039-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938A5CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 05:19:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJmM82PZ5z3byZ;
	Mon, 18 May 2026 15:19:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779081572;
	cv=none; b=BC4kCY/WR0K968E0Yit5Pm0XP8YJyBPPJdqTDxXOKo6qAR5fy3nvmvflGA+sIpFz2/Jj5cuUcC8LSjWdHeYEWXNncbxMJ9pgXKBNunpsZe5KSK4KamgPYr2pJI87E5dHk5/q1Nr9La5TiOBW5jNsTMhmmS/5mi2kADxKGLM26+qigNZNq7+48ReR6F42QuR+MTk/r4ucAlFWSlLyZWykHUlYuPR8uaCd7Z6OJZ+K9rkZ0ycZoCzawTmAcffd9+/IBpiicXZ2ccKqMFSHAzgfXNTKHzHZuxJAaARNkZynka+NkENqRwAt2YlKlFQOiGqxHP4swJclStZH17/PWXSjVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779081572; c=relaxed/relaxed;
	bh=oPj6YyuMGUNCf0Hmw0XpTtspEAmY9x+9oDziy5puBG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arS65UpnctGFJj+k7ZLqQEMgOmVRQR73StRdR6E6s4SlUJz4jhAAOpUdE4M9p3NXa5o5m+w6yWyLtLmO1ScqW2vGWB74UglibS7BEFguROLug0JWvIy8aW2JfH9epbbzOImlldVnPgCbEDUN3ixA3kv1t1no4T8bK23Dn7Hs05rQZQlnagcGwgDo1b9QvyMvxjxseVMfAnZkvBvjpHSLD+//F6nVZoY4Ibx1BZdcsjzFQgf1ksmFrwRREccNO2m6mzPsW6RnxMcD2GtJkplrA/YZb3pPSjlB8vhHSIcap2go/lTpqrwl3A0EzZ0fdf3IdW9ge7sPPTbmG+99JH98Ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=q5Mrno9G; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+a5a5d3dd39d7e5270008+8303+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=q5Mrno9G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+a5a5d3dd39d7e5270008+8303+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJmM74xCnz3byT
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 15:19:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oPj6YyuMGUNCf0Hmw0XpTtspEAmY9x+9oDziy5puBG0=; b=q5Mrno9GvpbxW2XcuAy9csfwpU
	BX/cQ/l1gJ/VERaG55tOXAfdJNsbJJWHZMHEG81mmghQH2MbZVKUTxlbpte25jIr82r/sU/QhDSnR
	R5ygQGlxX06p+RwtkXWJdUbQtvtBdyUrOUh8hBII98iyaopudQ1XGVzU0jnD9O0jBXYPd5EYySpv7
	wVggmxbIGygyKBvYjyfhd0tD8cuu6UZuEdaXHHG8SqbcltnR4m6IOg3jEvc2zCy4VpQ/EFjNzFc6e
	pmlt7b/Q5qbWKGQYBShvRbxbGjwrZAa/iPXdjmYafFcFKVRSeN5UAKt0ME16EpcRNujjpvS2oe5z9
	88JUSAFg==;
Received: from [2001:4bb8:2d1:6fdb:d67d:128c:34ba:85b8] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOqNp-0000000EFtC-0bCw;
	Mon, 18 May 2026 05:19:17 +0000
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
Subject: [PATCH 04/18] raid6: remove unused defines in pq.h
Date: Mon, 18 May 2026 07:17:47 +0200
Message-ID: <20260518051804.462141-5-hch@lst.de>
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

These are not used anywhere in the kernel.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Ard Biesheuvel <ardb@kernel.org> # kunit only on arm64
---
 include/linux/raid/pq.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/raid/pq.h b/include/linux/raid/pq.h
index d26788fada58..5e7e743b83f5 100644
--- a/include/linux/raid/pq.h
+++ b/include/linux/raid/pq.h
@@ -90,12 +90,6 @@ extern const struct raid6_calls raid6_neonx8;
 extern const struct raid6_calls * const raid6_algos[];
 extern const struct raid6_recov_calls *const raid6_recov_algos[];
 
-/* Return values from chk_syndrome */
-#define RAID6_OK	0
-#define RAID6_P_BAD	1
-#define RAID6_Q_BAD	2
-#define RAID6_PQ_BAD	3
-
 /* Galois field tables */
 extern const u8 raid6_gfmul[256][256] __attribute__((aligned(256)));
 extern const u8 raid6_vgfmul[256][32] __attribute__((aligned(256)));
-- 
2.53.0


