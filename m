Return-Path: <linuxppc-dev+bounces-18666-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAD7F532E7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 06:23:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fg0Ms5j3Jz2ynP;
	Tue, 24 Mar 2026 17:23:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774333385;
	cv=none; b=XNav4FTZvKx9St6sg1oy4JO/Cn64LqIQ/eZDDpFyn2KKefpJr39ZnIGM27udaMp1NPuq660GhrsleJ7ugqZfdwg8MNZw2T66dte2tEonBkOnkts0N2eLcPR8E2ZfEhJit2e0S0W25HZrC7xJlpNUVRj4RdwTAt/Q0x8n88QP0a93+2IEwcfKrVTGpWal7nIZd+J86u40+edkkAqXQmLM8FZfznvfybeh/lRMRa06nGyEG+2Z9d1miFMCrJxYs6iCz31MhhE6o5Cw894k6jSJoLOY5Iyz8hPhoHK4zQazBu8Th+C2YoR5FS6Ik428Bqc8a/k4lYVmY5zwcqSsExx8Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774333385; c=relaxed/relaxed;
	bh=7WrAq85hb5EzAI0QdwS9kx5aUTvTK9+Z0/VmDcCQjL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAHvclTKV7beTeEKIVNqlQhlqfuZ/jpQPmbsG9NL1dDrNjnSsDeXEgJeecnDImWqNezroN3cERe9h46oPT+SuNOJLHi+7VDOiZLww9l9PfDvATyd+rLmccdXWZuc/sI93yWL7h9aAlTE1xeX+oYxyBV4SrMFqaaguLJujMfWUV79zIzKbAcVspOEGIyQSFw6jYceB7+1Ze3TDedDkX3CMyx2LjhGl9NMk/OM3uq9EMwWrBHuQyIzqc3AeZjNjtJHmXZ4yL0XS3iGVPiLLxGuWjv0cHTzbzeB495EVUEY+gbQcsGy5QRYDsJ56KWA2ntHj/CtuwloUC7ARZMNfgNkOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3ClmzK81; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+4a75e1166b7f241dd976+8248+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3ClmzK81;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+4a75e1166b7f241dd976+8248+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fg0Ms0R7vz2yj3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 17:23:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7WrAq85hb5EzAI0QdwS9kx5aUTvTK9+Z0/VmDcCQjL8=; b=3ClmzK815mG5LP/9u3eiWQjQG/
	B51vhls/JePeeU/5jdzpNF+da/Zxj+0wCssyURb2rQXGehRtPa0Z46EzyiQAg/4ndB6yjB7dYJqG0
	NOH4Bkwah311k8+hDW8Nw2MRH77+a5QJqgZ9weeTiZWPCuSKTURTtLnV7pACgkzKgTsmCNe8dQPZ2
	kbIo/t8/fVx1DZQWwywRHFhUIIV6maMwUE39h6jXCKGa71ZVA2NujBQbUEajAUj8sta2VtuyC1hca
	d21VqDCjqEPHBkro9cumv4H2Wq/2KAEWb6etYixOjIeePtKccwc1XBfxhpxbimK4i8P6IDcO29t+8
	9t3r27qA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4v9z-00000000ghi-2n5s;
	Tue, 24 Mar 2026 06:22:40 +0000
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
Subject: [PATCH 01/26] xor: assert that xor_blocks is not from preemptible user context
Date: Tue, 24 Mar 2026 07:21:37 +0100
Message-ID: <20260324062211.3216301-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324062211.3216301-1-hch@lst.de>
References: <20260324062211.3216301-1-hch@lst.de>
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

Most of the optimized xor_blocks versions require FPU/vector registers,
which generally are not supported in interrupt context.

Both callers already are in user context, so enforce this at the highest
level.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 crypto/xor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/xor.c b/crypto/xor.c
index f39621a57bb3..676d7401af43 100644
--- a/crypto/xor.c
+++ b/crypto/xor.c
@@ -28,6 +28,8 @@ xor_blocks(unsigned int src_count, unsigned int bytes, void *dest, void **srcs)
 {
 	unsigned long *p1, *p2, *p3, *p4;
 
+	lockdep_assert_preemption_enabled();
+
 	p1 = (unsigned long *) srcs[0];
 	if (src_count == 1) {
 		active_template->do_2(bytes, dest, p1);
-- 
2.47.3


