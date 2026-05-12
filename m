Return-Path: <linuxppc-dev+bounces-20729-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83656CD4F24
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 05:24:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF4kq6ctmz2yL8;
	Tue, 12 May 2026 15:23:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778563427;
	cv=none; b=PDnNota0ED7HF3iM1MOeCmPO7V2hhS0DUt5gNuGXJ9GzablGNE10W/gG5YHif+jvaPKG46B8wdsdHxgnPupWe5AV+OhjTaGAwsKmbAtZHSHR0Z/BWjg59o7gmJ0ow+dOf9BHe8f6hs06EwNZlJxPRxRRHF5mmY/hQ+iNO3NTmpnutkToYLHkMyoucBxBC0q469XZCJ2zs8M0IT1QEeH5faTBQsFTYpIZZnivrQMdOi+2Z7H2QhxZt6XvSmkuZCOOD/ZNcgB8GJxofFzC+A16N9Vae4a9ZZlaVu4RsB3Bno4yZMBCR4ySibmqJ/Gyd4eDeB9FexQqv4ZMXlJQRTrx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778563427; c=relaxed/relaxed;
	bh=FrucDfI55A4jcSSVoNviao79x+Ghh2EC2PzCAQQDOKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGYCYcrKeRcrIoLMzhsz1vod85MO+zpHYIylb5CpEMDNYCg/5JU3oka16tq3YfOmxrw4toZuApqFovOv7+8wWTEVo/pGlbxTE6pz1EVmujU/Sy4KCDiPvLl7bFWijMv8b7oZ61FaUEM6H2/gNvlIwEBgFp9vCpxTv8l4nNKFW2zMgUduQs1etfgc7aPSfskqoAsGxpt8Ah8kIWoWDXCRqNWnOy0mN/kaUj+eQ4SAJYlIE9sa+NZIHfmIMjkbbSOE62GizqCx7ZJI+uI13M3cxwAvePH2PSjdenZcCjgiDd5F0il1rFSyt7PBhCUBEKQ2fSKA3Hg6fZ1mU0eRtud07Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EvnVvM7H; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EvnVvM7H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF4kq2Qgzz2yKw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 15:23:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FrucDfI55A4jcSSVoNviao79x+Ghh2EC2PzCAQQDOKY=; b=EvnVvM7HI7+ZWoAyBPThinXwFT
	YeEI327ffDblk2OowWcpf476lKHasaU/T3CtG5dw8KYky6YIgH3Mh5eJr6tT9HvNFCV/+lXgifZKo
	jmiKWrHh7NE7L3vgKqRHM+k1+hZMel8Qecc69oX6VNcEyhOtJQqDp9p9C5Ls0OxTuo++leBRHp9+Q
	8GUJ850mH7GEE5fHRefLAKtIAdIWrQ4w5qcVW3Mdg/LlUHJri1EFGfrHMwsTwiDYv9GxsOweM6koG
	Ll/jNoPFD1eTtgTnqbumw4XNrw8w9f1cdzBB/t9eUqwXLncyUHM27G1ntDoMETi/6uLYlm7lrdpoo
	L06hVz5A==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMfae-0000000Fayj-35wW;
	Tue, 12 May 2026 05:23:33 +0000
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
Subject: [PATCH 05/19] raid6: remove unused defines in pq.h
Date: Tue, 12 May 2026 07:20:45 +0200
Message-ID: <20260512052230.2947683-6-hch@lst.de>
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
2.53.0


