Return-Path: <linuxppc-dev+bounces-18380-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F3B103E197
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 15:52:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbYGF6Mptz30VM;
	Thu, 19 Mar 2026 02:51:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773849077;
	cv=none; b=GG5ZaR+eBGj/XWI6sbOxJpvyyASzRd1xl8OBMaHongb/Ll6/4crkcAWz5RJ8BhXsGonuuqB3R0HH+BDX4SJTSLmhSAnFfNSPWluuMKob6altKsC+1bqrRCc8m2RyQFBwNO5jgW3zflI2euP1HIgARDCV+H/8SVRxPeMdzkqHCE/wALQ9O6bpm3oNZJl4M8iWce7+0PexxzOPnU3l4cAAvtPnu5AXc09CnPCgueuru+bu+b0DBYKfJVnrubqI+9kuQRjQufp3dsFJOEeKAGN+QYTBi4Kqp8TD2v2Tr65+PxMOLlHKPMPmMedQQwnfN02TRUU7ytIk9fBeQhtcMASJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773849077; c=relaxed/relaxed;
	bh=5K7eKfDaNC8F0R4YEvVj595iph2zwfv8FNQbISthhlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6uDfnTuAEqDqPRnpbCgBZtUloLCbwV8t3KQgenWorESobJUxCp7S0fxULdU+RYGqnDactOJlJMT4J5YBmiSoMMHB0TSgzeoUiMPXVQA4HLf+Qb3hp6E8T3esfoPr/0eHOKwX52dk2Au1IUSmlH90UAMIrTCYy6SdZ9KYK+BE4RNaGFda+jhMECRbMue8LWoh65pwCsuyjRspiZjR8VxVMAYw5PyJovqY4Ovp8ehbyFOALibPZz6oYe4y0PS7LZUy8PX1Qlae9PEnRFhP0rIidnApo7RoRxLqIHhVmYr+8Yo29OPy/PlTDn51uvh/hn5mFh4WmEGAN1tiZ9X4B5Rqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PAMV/FRG; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PAMV/FRG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbYGF0NPqz2yng
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 02:51:17 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EE69760132;
	Wed, 18 Mar 2026 15:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F1CC2BCB3;
	Wed, 18 Mar 2026 15:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773849074;
	bh=LrLBS64c+lmBUJM2XbvLHLJnGjK9/zMfbb5TL2UTCws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PAMV/FRG9PjgQCw7QyBV6vAY5/1tkgmucdPKe6bNfQcaayUFlcPcWUrRM5+pumUew
	 8tkdQO0XR039wEdB/Z+kBm+nVhTMS+y+FEWY9areaHD6j2ywMX1H//6cVHsmdp6ujF
	 M8CROXi20fKoT1AdSl0ZdsL1KeupVrZxCUxOLYtB6/K8aGzLF9/ZuGPeCnm1biPoS7
	 zf9JSM2o7s+qHRM/dDXx7XJX5zWvE/ctttO/iWCDZFKpArYUsCJ2Cods/BYOCBUPcY
	 ldo+q78sUAKXxMqnxurIx0JfoKd2+Sc8PBn+lOt6KAxcWcmrMIXNNY1urbuV+cISbL
	 5HToCgJWlqsdQ==
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Brian Cain <bcain@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
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
	"H . Peter Anvin" <hpa@zytor.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v3 12/23] tools/testing/vma: test that legacy flag helpers work correctly
Date: Wed, 18 Mar 2026 15:50:23 +0000
Message-ID: <4bbead202fcd419239913a61de769b209aa298fd.1773846935.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773846935.git.ljs@kernel.org>
References: <cover.1773846935.git.ljs@kernel.org>
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

Update the existing compare_legacy_flags() predicate function to assert
that legacy_to_vma_flags() and vma_flags_to_legacy() behave as expected.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 tools/testing/vma/tests/vma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
index 98e465fb1bf2..1fae25170ff7 100644
--- a/tools/testing/vma/tests/vma.c
+++ b/tools/testing/vma/tests/vma.c
@@ -5,6 +5,7 @@ static bool compare_legacy_flags(vm_flags_t legacy_flags, vma_flags_t flags)
 	const unsigned long legacy_val = legacy_flags;
 	/* The lower word should contain the precise same value. */
 	const unsigned long flags_lower = flags.__vma_flags[0];
+	vma_flags_t converted_flags;
 #if NUM_VMA_FLAG_BITS > BITS_PER_LONG
 	int i;
 
@@ -17,6 +18,11 @@ static bool compare_legacy_flags(vm_flags_t legacy_flags, vma_flags_t flags)
 
 	static_assert(sizeof(legacy_flags) == sizeof(unsigned long));
 
+	/* Assert that legacy flag helpers work correctly. */
+	converted_flags = legacy_to_vma_flags(legacy_flags);
+	ASSERT_FLAGS_SAME_MASK(&converted_flags, flags);
+	ASSERT_EQ(vma_flags_to_legacy(flags), legacy_flags);
+
 	return legacy_val == flags_lower;
 }
 
-- 
2.53.0


