Return-Path: <linuxppc-dev+bounces-18670-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AEEF532D4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 06:23:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fg0Nd5JFVz2ypw;
	Tue, 24 Mar 2026 17:23:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774333425;
	cv=none; b=h1UHzJLvtiLdyVp9DFNfkbpuyiNHwe5s2m4HWLeZg6mNb7ZQma2fFEBn+7z0nkVV5uA8OtCtqYn8eV2O67bSyxFIuXQg7tF1MrTs4YdrCgGHZYlceY2luFVtXZP33I5WxDNqfNbohi7nNTUJEXI/FH7OmNWACaP8bvB0HZWgEIizKe/AfnhnRnoEkPCI8tusD3eIdlPtxEV6S7DHPhasbrSOlYpv0TjbJBsWQag/90zmf7Bp7Yw/QbrbpfHzaKVwYCvM9hY0GJIOJP/nfSTHWmcN5lrw24zN0Syq3VZ+bU+QdG3paImruR/JQaHVOuarp7SKlJv3iwZpcxxbCfvVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774333425; c=relaxed/relaxed;
	bh=LA3t7gmFmV1NbfkwPmVDb+x/QYZiy0EYRNWRMnVHb4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLU1O862BuF5UddZq7490DffDWYbSRGjS59ZrWqm3nltt/7j1GTQXYjfb6ykPR443BdynAZO78mvPLfCdApMmAi9BkbZTLCApJ7Ln4Y/43tmsQKQXo3Xdjxw3xUq+5l9+3uJQejfqZsx/8RtSopol+SBpqKG8pzqDLRpjeNRe4f1SIhGvy8WUGTkpfUSo49T1+EkwNaHbjvR8HP5eDLAgtRl7mDYJv+7p5fw1uAsXxOcjPj6I5+Gg2moMvNrQolwaCoQDlumMcEjbKEBZIPSW3Ex3z92lL5PB2TmS1YHplOC1Aq8S7DQM6wNEKiZ6rglIOp+67JJJvxKSMQq8Gnipw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZJZVPuEp; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+4a75e1166b7f241dd976+8248+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZJZVPuEp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+4a75e1166b7f241dd976+8248+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fg0Nd1H99z2ypk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 17:23:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=LA3t7gmFmV1NbfkwPmVDb+x/QYZiy0EYRNWRMnVHb4k=; b=ZJZVPuEpXwDUj0dF4Wfxor4O24
	pSbzpzg7mzFhKEjNbbFKGzln8bXXiN7T9LnKk8Sx4L0ErYVaQip7mLThaN0lGAiFDOT7kFNYPO8Xp
	7raami0hqPkvVQv2zj+80vd3xPK+mHN92XQ3kO6LWR7t4YR3BMgo99vI9mZRWJ1vdL5uZQjIdbY4s
	Qeo664vHepjuSWVI4SOiOyaGEZ/4vTnHFG5U0cpAgrrUE1E/gM531YaxJBrVO2rqEwsWlkZ8pVQOK
	ks4kdZF5sWaTvMY9PJ7Tz1v+iZEnnwBpSWtZtTIdqj4/I8mWOhW6ILCe5uUi0mxC0swd/IrK0Vm1y
	ya2dWK/g==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vAm-00000000h6S-3Yjt;
	Tue, 24 Mar 2026 06:23:29 +0000
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
Subject: [PATCH 05/26] xor: small cleanups
Date: Tue, 24 Mar 2026 07:21:41 +0100
Message-ID: <20260324062211.3216301-6-hch@lst.de>
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

Update the to of file comment to be correct and non-redundant, and drop
the unused BH_TRACE define.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/raid/xor/xor-core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/raid/xor/xor-core.c b/lib/raid/xor/xor-core.c
index 676d7401af43..edb4e498da60 100644
--- a/lib/raid/xor/xor-core.c
+++ b/lib/raid/xor/xor-core.c
@@ -1,14 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * xor.c : Multiple Devices driver for Linux
- *
  * Copyright (C) 1996, 1997, 1998, 1999, 2000,
  * Ingo Molnar, Matti Aarnio, Jakub Jelinek, Richard Henderson.
  *
- * Dispatch optimized RAID-5 checksumming functions.
+ * Dispatch optimized XOR parity functions.
  */
 
-#define BH_TRACE 0
 #include <linux/module.h>
 #include <linux/gfp.h>
 #include <linux/raid/xor.h>
-- 
2.47.3


