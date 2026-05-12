Return-Path: <linuxppc-dev+bounces-20742-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF69CD4851
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 05:26:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF4nk4q32z30RT;
	Tue, 12 May 2026 15:26:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778563578;
	cv=none; b=HZow8kI+JpZemORMnwGXKTWcIW0mtASVtbchVdnKkTJEq5roLZaefklVG3P11m3D9vKfEDOXXSxbptTxACjOKmQahcgRSgGbFOEvETJil+g2v9Ol0XM2zNh0260yXqXuI2IeyYqTRE6HynWRaHDp0dHfROaff+nU9zpk7S/tomlstuAKLZ0j5jUMWUgGIkr329h1H38MZU6Ns6clr11HHcUS0QZCrPGlqagkicx7GLZV5LWcOG8YLs8K9SJkZucDM6Zf8JAJtvbUm8doyU46/mTbycP81lpFp4hiD3UE5pma9egWLzix38wP9hEkb5PtvED90OkYYh38jEdpUF584A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778563578; c=relaxed/relaxed;
	bh=eieqJh591jkivWgUpSd0uAjJTAcruVOirF8ZRJ69/fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVAOM1yMSwhJe7xvaWC+nsAmmWTGm+oSigemtf0RgwggUkKZaKMO4RHFMmWtiaVSysN0Dxkmp/BrajxbHBkbEDOqur/IHqwElazCB8SmsPe1J/3Gkc5RLzyvivyeUTHtGXKMwxxBnEPhlv9E5d2nslhi1rULADmFimsDfCm057YM071vAA7pgFqQoTiOBe9JL5U5sY+2nza6eB3lmcXkgF099urFhHU/zJNp4xCdd9sL6ggu0o/XgUbMLcT22XDCcLjc22Xd2KkfYPigpgkKokynHCL7RGrtyQqhLvFMER7u7y+J7HLZ1vI1So8WMK5FR9EbRChyMWM64BHSjYr/gA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KxRdAHBu; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KxRdAHBu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF4nk11XLz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 15:26:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eieqJh591jkivWgUpSd0uAjJTAcruVOirF8ZRJ69/fk=; b=KxRdAHBuwBWUa5VuUvv4S8bpkO
	q+PO3gq3K+krpIfb/evZRbcYyKQqTgJobbpkHxU3qYYQnwc6eMEzGqZcv9MIbQW9tkAmNuifIJ/uJ
	tao4426qjA/2FAMk6pjqB7/ZoVvcOl7LG61PX3QB2Wl45oPjmMveu6HHYGeCFJpqPEHeQLMIVx4qN
	xKVcH5O1USlSW2iuwX1KvsK9hJBzC8Udx2kZR7xocK7ce/un02XfktJ6gdWtpJq69+KEhNxq/XZF1
	mjHwSWHRTzPVctMBKxM1mHZ0WceMb16p0UZrNyyjkA3UKM2c2k09prKBid0iSGC4Q2bauboixhEK5
	z0ITnD/Q==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMfd7-0000000FdFG-1HIB;
	Tue, 12 May 2026 05:26:05 +0000
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
Subject: [PATCH 18/19] raid6_kunit: randomize parameters and increase limits
Date: Tue, 12 May 2026 07:20:58 +0200
Message-ID: <20260512052230.2947683-19-hch@lst.de>
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

The current test has double-quadratic behavior in the selection for
the updated ("XORed") disks, and in the selection of updated pointers,
which makes scaling it to more tests difficult.  At the same time it
only ever tests with the maximum number of disks, which leaves a
coverage hole for smaller ones.

Fix this by randomizing the total number, failed disks and regions
to update, and increasing the upper number of tests disks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/raid/raid6/tests/raid6_kunit.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/raid/raid6/tests/raid6_kunit.c b/lib/raid/raid6/tests/raid6_kunit.c
index 775a0051f9a4..d6ac777dcaee 100644
--- a/lib/raid/raid6/tests/raid6_kunit.c
+++ b/lib/raid/raid6/tests/raid6_kunit.c
@@ -8,6 +8,7 @@
 #include <kunit/test.h>
 #include <linux/prandom.h>
 #include <linux/vmalloc.h>
+#include <linux/raid/pq.h>
 #include "../algos.h"
 
 MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
@@ -43,6 +44,12 @@ static unsigned int random_length(unsigned int max_length)
 	return round_up((rand32() % max_length) + 1, 512);
 }
 
+static unsigned int random_nr_buffers(void)
+{
+	return (rand32() % (RAID6_KUNIT_MAX_BUFFERS - (RAID6_MIN_DISKS - 1))) +
+			RAID6_MIN_DISKS;
+}
+
 static void makedata(int start, int stop)
 {
 	int i;
@@ -169,9 +176,7 @@ static void test_rmw(struct kunit *test, unsigned int nr_buffers,
 static void raid6_test_one(struct kunit *test)
 {
 	const struct test_args *ta = test->param_value;
-	/* including P/Q we need at least three buffers */
-	unsigned int nr_buffers =
-		(rand32() % (RAID6_KUNIT_MAX_BUFFERS - 2)) + 3;
+	unsigned int nr_buffers = random_nr_buffers();
 	unsigned int len = random_length(RAID6_KUNIT_MAX_BYTES);
 
 	/* Nuke syndromes */
-- 
2.53.0


