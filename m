Return-Path: <linuxppc-dev+bounces-20724-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DCDCD4851
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 05:23:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF4kd2c4vz2yKw;
	Tue, 12 May 2026 15:23:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778563417;
	cv=none; b=hnBGbAAAgPD4Lc/Fs8pPiYQg7yvZBmXCmOLbG60aR5r7O/yz6k+TlhipL6Nv2qBhLrHpC6xOQYh3P48+PMzTcz4mTrbV0Qagp0v/sdjk8/7yQiI8KL+iR+4gAmU0z00sFBbxMeJ33V4OJvNU3qd8PPpsH3BP/+7GzEelH5+3aQ+y7sDnu60db4q2+yUqL60kAyrdbPr4zb6wGEVPp9csw+aARbOY4VuVHPVd9gdD+vLDva5pBGwVML4rtxAHYUIriJkpbn5wDGeKFMsRlLoF1Uqfc3nYSKy1/wPsAlMXrqET+h9R2yvvbYESJhzMxsi+Ent9P7LOKuYBtilv9M/eZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778563417; c=relaxed/relaxed;
	bh=lk9xgGRX6KmTgHi8yeCmJiNwyDWaauERdGqaOWPOxNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DH7m+W3mcoa7aBlCq2sNkUgD9jcVkQOEuQ8NBnDqGPT6xFuHAdHoIGs9JuMMvXI2mLU6itp9ELXfVUMXsNGLrvMTaOa3Yh1EoD1kRMAUY3W0lDQfbsa6TFVmeXeRZgnkVNK/MiT77aJ6Y0QAM7Kq5mOLY4kcR93ufSJmWSDlicB7rLnT13tRR33CALeSyZhRUhU9GIkUW6OzQbwxoboJzmj3nnySTb5NnDEClqZJMQZYg5T+D2aLp/qL/qIO3EdoOn+phPJhujKMoPOY/qV83vjPIWlj8ODddGM1/KqIkyMNszptCQCgdgxhV9vDJn113JuDdPfRr3ulC3bFqZjRiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=l9QL8FjZ; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=l9QL8FjZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF4kX73bMz2yGf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 15:23:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lk9xgGRX6KmTgHi8yeCmJiNwyDWaauERdGqaOWPOxNE=; b=l9QL8FjZ7+E5EBMHVT0/gRU+vG
	eamJddBD4ZK2GrbpvQkqMeld+GJF1U8zc0XZKnsp3cbar4kkaiZ6prkVXfW5QHNmKwOko9E0CAaCG
	K6nseoa3cjAeTPtKZ1mDOZz3Dzv+qSAlvUcrAyqlkJ2cBKvc5q8k6SA3W89evJiahuLj7tRPCblYk
	67mWrhIWdo6GJvmWsCiVx9KGhqz2Lx4zA1NFzvV0+RkG0BQpZnrKCUUHTUgRJldV6EUY+DHzEmOhX
	kjYI6hqQsKxKtPUx90JTmkimbSZePBIxTp2pD0+LosuqW4BQq12FxpZ35qupJ1ptq5qWURy7fZluC
	n3JlY+qA==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMfZz-0000000FaPv-0bKv;
	Tue, 12 May 2026 05:22:51 +0000
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
Subject: [PATCH 01/19] btrfs: require at least 4 devices for RAID 6
Date: Tue, 12 May 2026 07:20:41 +0200
Message-ID: <20260512052230.2947683-2-hch@lst.de>
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

While the RAID6 algorithm could in theory support 3 devices by just
copying the data disk to the two parity disks, this version is not only
useless because it is a suboptimal version of 3-way mirroring, but also
broken with various crashes and incorrect parity generation in various
architecture-optimized implementations.  Disallow it similar to mdraid
which requires at least 4 devices for RAID 6.

Fixes: 53b381b3abeb ("Btrfs: RAID5 and RAID6")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a88e68f90564..0b54b97bdad8 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -159,7 +159,7 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 		.sub_stripes	= 1,
 		.dev_stripes	= 1,
 		.devs_max	= 0,
-		.devs_min	= 3,
+		.devs_min	= 4,
 		.tolerated_failures = 2,
 		.devs_increment	= 1,
 		.ncopies	= 1,
-- 
2.53.0


