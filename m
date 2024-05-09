Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310B2C10F1A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 May 2024 12:15:05 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Woc4NMH+;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VZrYg5fncz3d9Y
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 May 2024 22:15:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Woc4NMH+;
	dkim-atps=neutral
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VZrWK3RF8z3cSK
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2024 22:13:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1715256774;
	bh=ifCaKRIH9Ue2yYFoX9qK7HLVBgYgFA4Wkb1kztMM1j0=;
	h=From:To:Subject:Date:From;
	b=Woc4NMH+JqYYOuZ51jT5SokNsn5YZpcGNSiUyjgkRCpt+rlUqDilFPfeOmnZH+7n0
	 7FU2b6NinfHz8g7/Gv6jrd7qD1AvzsKxCIGKiMoeATFdxkrLFw64xt6lrsvyVjxpfC
	 RVzzfVZAuycnExZt0rNwqsphP7MT82JCiuyikcA8H3+AI5ERj2S2HIBHiMHgciTubj
	 TG+9UKhijF2YDfLNKX3dwo4ZaWaNl1ZbEvNOaSKquVkGqAzrjep8ioUvLyGm5hm0Hr
	 YbMJG6Ol5afMlyPfuLC/MZvoBtfVJI+DYnzN9nOOPpozuDWaQUObb9N7wtR0ScjzXn
	 0mtoyf1XCQ6pA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VZrWB0YsYz4wnv;
	Thu,  9 May 2024 22:12:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/3] powerpc: Drop clang workaround for builtin constant checks
Date: Thu,  9 May 2024 22:12:46 +1000
Message-ID: <20240509121248.270878-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The CPU/MMU feature code has build-time checks that the feature value is
a builtin constant.

Back when the code was added clang wasn't able to compile the
checks, so an ifdef was added to avoid the checks for clang builds.
See b5fa0f7f88ed ("powerpc: Fix build failure with clang due to
BUILD_BUG_ON()")

These days clang 13 and later are able to build the checks successfully,
so drop the workaround.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cpu_has_feature.h | 2 --
 arch/powerpc/include/asm/mmu.h             | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cpu_has_feature.h b/arch/powerpc/include/asm/cpu_has_feature.h
index 0efabccd820c..92e24e979954 100644
--- a/arch/powerpc/include/asm/cpu_has_feature.h
+++ b/arch/powerpc/include/asm/cpu_has_feature.h
@@ -24,9 +24,7 @@ static __always_inline bool cpu_has_feature(unsigned long feature)
 {
 	int i;
 
-#ifndef __clang__ /* clang can't cope with this */
 	BUILD_BUG_ON(!__builtin_constant_p(feature));
-#endif
 
 #ifdef CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG
 	if (!static_key_feature_checks_initialized) {
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 24f830cf9bb4..4ab9a630d943 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -246,9 +246,7 @@ static __always_inline bool mmu_has_feature(unsigned long feature)
 {
 	int i;
 
-#ifndef __clang__ /* clang can't cope with this */
 	BUILD_BUG_ON(!__builtin_constant_p(feature));
-#endif
 
 #ifdef CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG
 	if (!static_key_feature_checks_initialized) {
-- 
2.45.0

