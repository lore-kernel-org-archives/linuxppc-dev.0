Return-Path: <linuxppc-dev+bounces-18142-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7FE106ACDD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 19:18:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWy6V285Yz3cbX;
	Fri, 13 Mar 2026 06:17:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773343026;
	cv=none; b=EGUBsH+lwwBW6O7al6QGZdlNlXoZ22CBgSlJUvdXMBU1Dgl5xuoKFPM3XXiky7PEOnNfFSRA9/hIIYfVNIMqFPt7bJ7ymyWiTD/EkTkTNBr9khs8xLuRH30Xpm4MuY0JjCSeD2Avc9y2FzzDrpeINW3u1pU31Cszb9WmRW4+8HDbWZal0rbzXPFco0jJtpCmY8azDiFURjugvUl2A91i82u8EUw6VZjVNEXfCXoLgVSJmewoNVaQVGDrP0Xpj+tBwqel7amUduDuhxBiasBai7KlEdl7Xvwg5tMOcKRSyclqpD7Wb9Vgg0/MaP3F0d6xDltlRDZsYe7cQT+sX/3Arg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773343026; c=relaxed/relaxed;
	bh=5K7eKfDaNC8F0R4YEvVj595iph2zwfv8FNQbISthhlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ok0Yy/IllPkDnL4ILR5IFR0iEA0zWghesYsTwxzx5M19jmood2AAgvN2It1khRKRinOiG6adkstGTmix7kfPj7XjggpLzR46nRwaK83yKo+ANaZNAH0FLbf6SB6eLQWV+b8eJiXRSbPPDD3ExoURxbSdoyrZuPAMFASfq3PYIpKh99WPSmZ9j5/rTyglh8491MDkrXoMZG0B5HR76QtrPrn2OCJO4sSzeo6q71Z1a5TME6EabhCXnCRX6dlQninMQelCVD6iIVPENxd04v7kyTXts/18f+NjGkP5byNib4L/X/o6HE9kpSaLNh3rteTrxY2o5EBjGXRlNh4arxsKXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IKQZlP72; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IKQZlP72;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWy6T3dFQz3cYK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 06:17:05 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 047DD43251;
	Thu, 12 Mar 2026 19:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB91C2BCB3;
	Thu, 12 Mar 2026 19:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773343023;
	bh=LrLBS64c+lmBUJM2XbvLHLJnGjK9/zMfbb5TL2UTCws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IKQZlP72+6csLhk1/TtPL203kF8CKJ4yHgCb4eCuGDZU+ZL2nxheJGMXStid0kFAN
	 2OVVFpqO4OVMSByMzLStjg9y8ifXYjL6/QCXvUuLLFaeCMwb48LvyIXQCF7u8u3qeP
	 uwIxhlyGYbb0gS/nuNZz4OJ7lkW3NGWTMj4VZMvkqDMPIbYoIZWbRDEOUopY1WPX+7
	 qLm3s7SrxVb53C8Gxh9pGNSNcvt2v0Fbh8ym+0CkV6ERlSAFGMEF499lWL9vTnk1ZQ
	 I0/I4AC3auqJmbgPHCWmk6ZrjLB7Rl6c93zBisW5xiBxR+vlvIXopknlA3JpzzSbkv
	 HFt2tFa2A4wpg==
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
Subject: [PATCH 12/20] tools/testing/vma: test that legacy flag helpers work correctly
Date: Thu, 12 Mar 2026 19:16:10 +0000
Message-ID: <63f3217453d4797a7ad4705d438a4f8dcbaf1062.1773342102.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773342102.git.ljs@kernel.org>
References: <cover.1773342102.git.ljs@kernel.org>
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


