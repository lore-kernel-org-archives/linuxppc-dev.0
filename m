Return-Path: <linuxppc-dev+bounces-18014-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B54AFD0640
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 07:05:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW1wr158Hz3cH7;
	Wed, 11 Mar 2026 18:05:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773212732;
	cv=none; b=YoPH1iNbWeq40EcyDt11zrfMc9+w/U3nyto0c6E7nNjKSO6BlgOqin9rL6ERuTTnClVugTRwvW4zdJBbjlpSiFYrFew244Ip0qAlRzk9Di7QVvzBn0djRvipGmFmgfhNxEVHhEyJTtKrkwFlre4sh6YooJx51v3cztLRhb6VRjKXQpWIjQmQCulb7l3ifRH8LqlPf4QQ4x1vyOfYnLulY6FpUQi/ZB30dKAswcudLVgE1DsOWeis2nwtBm9chisK+FwH7iyQtIgWeWOfyjNCD0w1jin6+lnJHOeDdR0cx/GAjFbhlT5UGAAUNawKPW3+dZP/tshgb/GfDrLL8nRM6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773212732; c=relaxed/relaxed;
	bh=WGxZOFGJjbC4KZLgbzmM1eG4Dgszv7Etxq5IbgQGdlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/5Y5S1VoKhqp7mB/68N9Z9ORfEX1t88bhutMPJBE/k1v2ZHlu26EwW/lnDrnreM/l2aYxtjzJTS54iNEaGTX9mdRZGl8z7QNSUtgM86QmKX1eKnq/+0QujbAN1/t0N4PSJA+wVGb54JbtAucYZ19EMqdqEXJrvi7l+NYwIRfM8HshAiyVeptOc67J+Yr+xEjN6YDK4qnt5Jh0IQ8+7FEobtSIM531Y7YkEdfClWd3rAHCQCsfBXjaC2W8OLvTbe5iRtfpZBX8EugykiTuxnlwR/NM6iMhf6/Cqeaj/X58nRiWU+9a0q0LT0gy1r/ubGONxzKhDL6CyDFES0cGE10w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=D4k58v58; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=D4k58v58;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+bcc67bb7b2d0717eac20+8235+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW1wq4jwDz3cH4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 18:05:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WGxZOFGJjbC4KZLgbzmM1eG4Dgszv7Etxq5IbgQGdlc=; b=D4k58v58vrgrfQ7Qik0j8hncUS
	QDsoJ7UW0grGKEM72bCaImi+9rKpClKCgXEdyS3ehhLv173t7BD6xOMz0EuquuGo5TkqtibtKhQT5
	metuwVJt3OeE3oINB8U99sXZ2lgbFmPVF9DuvkFKK+1HV1QdayBobVjX329D1qDFHJzKCk5iWzCE0
	x93nqDDScdurz3v8PRl2V6FiSmp70VjFIGld+61oaVDno8LFej+TH44bbp9qx9S1PJOy8E4br/Ztj
	ekOie1fwZHnUMPF7LXeiInRGO3KY6apG6z0be0jGbTjX8179D8mNqvEUlYTaYJdsDIpsuObXOteHk
	03QJEvNA==;
Received: from [212.243.42.10] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Dd1-0000000AyGU-2w5z;
	Wed, 11 Mar 2026 07:05:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
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
Subject: [PATCH 03/27] um/xor: cleanup xor.h
Date: Wed, 11 Mar 2026 08:03:35 +0100
Message-ID: <20260311070416.972667-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311070416.972667-1-hch@lst.de>
References: <20260311070416.972667-1-hch@lst.de>
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


