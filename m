Return-Path: <linuxppc-dev+bounces-18697-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6068AF532E5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 06:42:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fg0pG0jnhz3f4L;
	Tue, 24 Mar 2026 17:42:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774334550;
	cv=none; b=bYVQoQy6+X2LNKSg6JcEue2tA7wN+XypMfQ/4X0UcSemsGKHRvPYWLbLTXw/WPglvooUigVesOqBa8MvwPYxJRcWRBT9b9PYx1YxdBrSbp0DCo4KHnTX1chXAWlE0Z4YBE5LcCerDbzlmXtzcxyXR9I/Qx3IDfVr3u089BtAnUwOiDPu+RpuE2/aQDMASBVm0hg7kepLH4SeMIrEafvHkgCFlq2bsJQhsmbA6XAuFCp0SFBbn1WAt4/+3zi2jjd+2ASVsb3Ien4QXyb+pQp+CjqfKZkixx6bpZaaGo3zuoK43lPDRVmGvUU3Dc/6he3RyZBPZx+WfF9g/gCSk/9JVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774334550; c=relaxed/relaxed;
	bh=BgRvLJC5xERY6XssOQotPnJq5Jwvijj2Vg9vEpnJo9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXtbXZWMdzJRBMU8EXm1EupOvDUGvHFoyST6pkoNuwbUwTStleNqbPLp8voCZvlHaL5JWqsVFDphwRrc2dSLlhLvOZd201freg2PMdfrjHPUleEHRwbrkNhNcXRz+t7IkNTbiuAnB3n4Sthq/bkgFIHevE5xVnuxKzwE6RqR4kxky7HHkm8F7JkQh0uKsPRSrNTunS3zs4XlWbQ5koVllzOn1gkDNQZIWgMdRlJ0UUDAtAR10/gGpv1mlWY3iKV+AkwvgGSg2Wf5onzlmRNgEaH7+RLiIBXWXR/g22JIrLoW1ogFHgL1SuRchuYYtZcEUgIQkpmREyobQdparTLlgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KzbrTBd4; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+4a75e1166b7f241dd976+8248+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KzbrTBd4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+4a75e1166b7f241dd976+8248+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fg0pF3zNQz3f1s
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 17:42:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BgRvLJC5xERY6XssOQotPnJq5Jwvijj2Vg9vEpnJo9M=; b=KzbrTBd45XjmU8GadN4Z9MlRls
	tMwjvaVj8sApJYQWkL7clog04fA0OxZIm8p3UePwR2fjUPMU4VLgO2aeJweyI0/8rUvvCCJ0upw5p
	XrcA8hFmfuQM+YsJTy0kXr5HLxxCAU8V/5n2+yzNqKW9SVeYGrNrhyYDKzlFgcmad6aZJW8JqJ3BK
	zY1JLq0lC7PawovnLbveaiGOZ5Qna2no2MFmmN3hbEfkW8o1wEyuScq3X5wnoXdml56EN9U9XNrPb
	gybaZORUREM7c8nWGJbMrcvIAj6tdgpcka1T67mTzRvWND96U40obZaWgjxKlFRkKjP/E0kQSuRCA
	43p6v9cQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vT0-00000000mK9-2ob6;
	Tue, 24 Mar 2026 06:42:19 +0000
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
Subject: [PATCH 04/17] raid6: remove unused defines in pq.h
Date: Tue, 24 Mar 2026 07:40:39 +0100
Message-ID: <20260324064115.3217136-5-hch@lst.de>
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

These are not used anywhere in the kernel.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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
2.47.3


