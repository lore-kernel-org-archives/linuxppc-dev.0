Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55754606A31F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 21:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJNcnSxf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jBG4s3zx5z2xdb;
	Sat, 24 Oct 2026 08:15:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792790109;
	cv=none; b=mn83rTK2vCe2hxkkSLSdAmS8IYyJPUTWq2coYLO2uu7sfG8NhbyzDH66G73DC5vmYWxNB24ZZSGYm7AYRMfOn0RKJHxrawLD0gVd3i/S+AxUE0O0VQKFzKNKSByWsLKJrlzHTmkW5ms7NXyqtBxXZegA+OpUmH3HPh34RCDJR45otWNRgkg5qgV9/25qS6n8Gm4dS7YnCY2t9WShUUYy4UFculTii8E53EI81FIF59tx7ilci2JXLFtgyWdr5ZameNlaL9LFgFuNjqmaHNCQxRmzJ1zQKfl3nPVxlOi4qeiBrtO0cJ/+6OR3WTMXdR3Z9NzmedtSqV7fdOGCtKxZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792790109; c=relaxed/relaxed;
	bh=4RRKenf4WMdsMoazXVn5Fv1nREnywQlVZbcXmB+WYTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSl+1dfAXIXu9Zr9jlBOhGmDtSqhL2puQ9gEPAt7RaP77F7KeDxhkQWkbi9ZQFWEZOUSQBQaUPVPHeEF0ocTO0pm1XF4YI8qRdskfB2HqoQJxyBNI3oD6p9kHhmGoeA2gczLwGXmjQ84us+XmwEbAiLCJ9kC/aHsVJ3GUJ/3GuAxmRacteKm2CQ03MSuK5NOOMhbWo+YHcFlmLfj0d8TM8xLusurvE6GadJOIhvn60L5fhP4SjE+IGGHu0YqyAWdpRxYA5kMO3vkjJDZJulYr8gsJETwkV/dWnzGQeHEYkKdmLzoA5D8uqiwTQYlFGU/TeqQemHZDkTapbk0QA8jSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJNcnSxf; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJNcnSxf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jBG4r5N9Xz2xdX
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 08:15:08 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7A65540F7F;
	Fri, 23 Oct 2026 21:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C45E1F01825;
	Fri, 23 Oct 2026 21:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792790106;
	bh=4RRKenf4WMdsMoazXVn5Fv1nREnywQlVZbcXmB+WYTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WJNcnSxfpbyU3D717qRFVvJDOAEXGegP3j4BB6QIPJhFZU3URyjDgqX1B69krN7VC
	 xTGkKefJjeEBjJ/k1P9LUx5TMEuAiJt2nKVgLGDD1BKOJyekdNuJ8b7g1KHUx4Dm9Q
	 1vupbgplhZnYv3yhRKoMlwdYihHXCleNmqhVLONAOZrnSxKyXNNUsCa9Gm1K/jVd6s
	 MIPRWfiwWuvNeNgVTqptqn4SO+n5tShA1/ciGLtYzlfmvttVPycNNP88FjqGuv2Ysb
	 hcPV1hHjBUySogAdlKpcQ/Wt2iO3QYhvEBE7EyYz7dhvcTAHXAtkDvmNcK2QWDjBDu
	 8DLk3DI0kAHDg==
From: Sasha Levin <sashal@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] powerpc/irq: Fix build with CONFIG_PROC_FS=n
Date: Fri, 23 Oct 2026 17:15:03 -0400
Message-ID: <20261023211503.3764302-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2331292e-1a40-44ef-8776-9155e8e41f03@linux.ibm.com>
References: <2331292e-1a40-44ef-8776-9155e8e41f03@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit fbb22ceaaf8f ("powerpc/irq: Make irqstats array based") made
arch_show_interrupts() call irq_proc_emit_counts(). That function lives
in kernel/irq/proc.c, which is only built with CONFIG_PROC_FS, so
kernels without procfs no longer link:

  powerpc64-linux-ld: arch/powerpc/kernel/irq.o: in function `arch_show_interrupts':
  arch/powerpc/kernel/irq.c:134:(.text+0x4b8c): undefined reference to `irq_proc_emit_counts'

arch_show_interrupts() is only called from irq_seq_show(), which is in
kernel/irq/proc.c as well, so build it only with CONFIG_PROC_FS, as x86
already does.

Fixes: fbb22ceaaf8f ("powerpc/irq: Make irqstats array based")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609271531.8kf2NTjK-lkp@intel.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

fbb22ceaaf8f came in with bb2235894a8a ("Merge tag 'powerpc-7.4-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux"), so
mainline is affected now. Build-tested with the ppc64 randconfig from the
report, a ppc32 tinyconfig with LD_DEAD_CODE_DATA_ELIMINATION disabled
(it hides the error otherwise) and ppc64_defconfig.

 arch/powerpc/kernel/irq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index bce546931a13b..55bcf0326f5a9 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -122,6 +122,7 @@ void inc_irq_stat_and_enable(enum irq_stat_counts which)
 	set_bit(which, irq_stat_count_show);
 }
 
+#ifdef CONFIG_PROC_FS
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	const struct irq_stat_info *info = irq_stat_info;
@@ -155,6 +156,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 #endif
 	return 0;
 }
+#endif /* CONFIG_PROC_FS */
 
 static int __init irq_init_stats(void)
 {
-- 
2.53.0


