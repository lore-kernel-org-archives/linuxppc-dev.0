Return-Path: <linuxppc-dev+bounces-21043-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BEBCD4F50
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 05:20:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJmNG50qKz3c5N;
	Mon, 18 May 2026 15:20:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779081630;
	cv=none; b=gsn81zK6T1xnx/MFkDOp2HkA0OXjkKMG+aFuTk8pTW95JJqLv9l5GaeNEFEgOwx06gNczw9JC4FitGv+wABu/MQJKF8JeC4Hj63uE0T33KQ9su3YwxgJ44Sts3mxi6OVtUB393fjz49eMhDCamLX8dW43UDMENoTKLQdAgU9duXvGpcWx7HPCK/op7IRBfjB6JIEROF5IfhW3z9g6MIJltr+A0pe16q9P7Vx5Z6AEkz4YelzS2h5ZtaMoUQADrFCZ0TdRWkBXtGf9wG48prSl1XehhfRoEjegrP1+C9gFHiMtVdGH3ViPKvYbzsCxAbnlBMTKDYkTsSm1bL1Lcv2ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779081630; c=relaxed/relaxed;
	bh=phfgrGTmhjQjM3TY6ZoI4XSopq/ltnl5TBViggGEnP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+w9Bd0KsuwU4SUcZy7hOzW9PbM9w21kgPWBZEGmGKFX2I7ZkjXNBrFFPyjjp1MrXw5ejiYM8pOVuiOwhVzFYC2Xi8LJ70JIUp+lZaWO52t2L4TXxnoSZSwBlSscXKivpxPM6dXNVMMiBMkWzYrQ+TOHEgTc+7lurG6rN1iU+WQsliNkPGlm7bCa8WbC5/q1Lknmrtjy2FB6EU6dnxMNPhOM3vJ2odnpHIUXzCnY3GHPSyiySfaRGrlZW/dB2asU26/LUnL1KTJkQqZ+o3OPSP8cdJ8yHV1VI84k8/j2yYaSFCpdir/a+valkgjM4mTshv4NvPzj4OZ7fvp2spR1kQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SDdM5XD3; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+a5a5d3dd39d7e5270008+8303+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SDdM5XD3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+a5a5d3dd39d7e5270008+8303+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJmNG0N7Pz3c5J
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 15:20:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=phfgrGTmhjQjM3TY6ZoI4XSopq/ltnl5TBViggGEnP4=; b=SDdM5XD3KGXf2ji8wBwXA3e2wN
	1jeQIc7NadTQHAMNNjok/lc1LrzZ7IYBrjFmF0bzDlvzt4akoIdxQyLb2xj27v8PlFArY0Ap18e8i
	ipyQ++Xch5ZrWzVb6zTppJPkKMa1lEBywu4AdouT4TY8kFPJFxAcUF5A9HhIrEC4woOWgrK7MZ931
	XfPCR7Y8QGCjQLAowTFAbwHwqlA5f5P7nT/ua7gYXlmBgSWtPsdDwamRBjS+gWgzw+ORqGjEIfe+i
	sImhGGJpkr4HI8EWyooLaexcJs6GqRLOoFoiU8zFQMjr6KXxf8RbvMYi9gdCzsmzBDfSxwZgmH8D9
	yiAEC51Q==;
Received: from [2001:4bb8:2d1:6fdb:d67d:128c:34ba:85b8] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOqOn-0000000EGcX-1AkH;
	Mon, 18 May 2026 05:20:17 +0000
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
Subject: [PATCH 08/18] raid6: warn when using less than four devices
Date: Mon, 18 May 2026 07:17:51 +0200
Message-ID: <20260518051804.462141-9-hch@lst.de>
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

Quoting H. Peter Anvin who came up with the RAID6 P/Q algorithm, and
who wrote the initial implementation, then still part of the md driver:

  The RAID-6 code has *never* supported only 3 units, and if it ever
  worked for *any* of the implementations it was purely by accident.
  Speaking as the original author I should know; this was deliberate as
  in some cases the degenerate case (3) would have required extra trays
  in the code to no user benefit.

While md never allowed less than 4 devices, btrfs does.  This new
warning will trigger for such file systems, but given how it already
causes havoc that is a good thing.  If btrfs wants to fix third, it
should switch to transparently use three-way mirroring underneath,
which will work as P and Q are copies of the single data device by
the definition of the Linux RAID 6 P/Q algorithm.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Ard Biesheuvel <ardb@kernel.org> # kunit only on arm64
---
 include/linux/raid/pq.h | 2 ++
 lib/raid/raid6/algos.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/raid/pq.h b/include/linux/raid/pq.h
index 425a227591c0..87e3cb55bf07 100644
--- a/include/linux/raid/pq.h
+++ b/include/linux/raid/pq.h
@@ -11,6 +11,8 @@
 #include <linux/blkdev.h>
 #include <linux/mm.h>
 
+#define RAID6_MIN_DISKS		4
+
 void raid6_gen_syndrome(int disks, size_t bytes, void **ptrs);
 void raid6_xor_syndrome(int disks, int start, int stop, size_t bytes,
 		void **ptrs);
diff --git a/lib/raid/raid6/algos.c b/lib/raid/raid6/algos.c
index b0ba31f6d48e..63d1945ba63c 100644
--- a/lib/raid/raid6/algos.c
+++ b/lib/raid/raid6/algos.c
@@ -42,6 +42,7 @@ void raid6_gen_syndrome(int disks, size_t bytes, void **ptrs)
 {
 	WARN_ON_ONCE(!in_task() || irqs_disabled() || softirq_count());
 	WARN_ON_ONCE(bytes & 511);
+	WARN_ON_ONCE(disks < RAID6_MIN_DISKS);
 
 	raid6_call.gen_syndrome(disks, bytes, ptrs);
 }
@@ -77,6 +78,7 @@ void raid6_xor_syndrome(int disks, int start, int stop, size_t bytes,
 {
 	WARN_ON_ONCE(!in_task() || irqs_disabled() || softirq_count());
 	WARN_ON_ONCE(bytes & 511);
+	WARN_ON_ONCE(disks < RAID6_MIN_DISKS);
 	WARN_ON_ONCE(stop < start);
 
 	raid6_call.xor_syndrome(disks, start, stop, bytes, ptrs);
-- 
2.53.0


