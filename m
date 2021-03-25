Return-Path: <SRS0=KFk7=IX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F93C433C1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Mar 2021 11:27:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1023461A56
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Mar 2021 11:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1023461A56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F5jWW4Tz5z3bpY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Mar 2021 22:27:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ny8VuovB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Ny8VuovB; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F5jW56MgXz2xfT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Mar 2021 22:27:13 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B851861A5E;
 Thu, 25 Mar 2021 11:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616671631;
 bh=MvspNmx/BQ2U6lxFhhm7YQJAvRh6QOInlWJfeIGGQP8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ny8VuovBr3ANoFfcLtGd9aDdytRpWvwlCxbG6F9R/cSHlrMD58Px10sY2HbjIdpp4
 1Hyik/szoRMoXTjmRZ+iCHxc95uWtGrQoM5q+UZx4XTJs+i5sD1Bjsw2R4lsqMZHKf
 JdudvtZx5GJFim8PzPznTy8eICcRv3d5ssLIFBJ7JOST2L+LsA5NFF8Q2RAqb/0Z32
 FNiMLvmWx5A/FXZK5Ri3UAVBP4HqzwtW3BKVO3ueeTJfkPeOBKCeZFRPKtcpt4rhGS
 FdGw67QhP2x7yqI0hhsrAZ/99LVpL5tZIcJyXKPuZHjFZClPbHhx4W3E+SZh7qghVc
 LMGqkNcxcJ5oA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 15/24] powerpc: Force inlining of
 cpu_has_feature() to avoid build failure
Date: Thu, 25 Mar 2021 07:26:41 -0400
Message-Id: <20210325112651.1927828-15-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325112651.1927828-1-sashal@kernel.org>
References: <20210325112651.1927828-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit eed5fae00593ab9d261a0c1ffc1bdb786a87a55a ]

The code relies on constant folding of cpu_has_feature() based
on possible and always true values as defined per
CPU_FTRS_ALWAYS and CPU_FTRS_POSSIBLE.

Build failure is encountered with for instance
book3e_all_defconfig on kisskb in the AMDGPU driver which uses
cpu_has_feature(CPU_FTR_VSX_COMP) to decide whether calling
kernel_enable_vsx() or not.

The failure is due to cpu_has_feature() not being inlined with
that configuration with gcc 4.9.

In the same way as commit acdad8fb4a15 ("powerpc: Force inlining of
mmu_has_feature to fix build failure"), for inlining of
cpu_has_feature().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/b231dfa040ce4cc37f702f5c3a595fdeabfe0462.1615378209.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/cpu_has_feature.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cpu_has_feature.h b/arch/powerpc/include/asm/cpu_has_feature.h
index 7897d16e0990..727d4b321937 100644
--- a/arch/powerpc/include/asm/cpu_has_feature.h
+++ b/arch/powerpc/include/asm/cpu_has_feature.h
@@ -7,7 +7,7 @@
 #include <linux/bug.h>
 #include <asm/cputable.h>
 
-static inline bool early_cpu_has_feature(unsigned long feature)
+static __always_inline bool early_cpu_has_feature(unsigned long feature)
 {
 	return !!((CPU_FTRS_ALWAYS & feature) ||
 		  (CPU_FTRS_POSSIBLE & cur_cpu_spec->cpu_features & feature));
@@ -46,7 +46,7 @@ static __always_inline bool cpu_has_feature(unsigned long feature)
 	return static_branch_likely(&cpu_feature_keys[i]);
 }
 #else
-static inline bool cpu_has_feature(unsigned long feature)
+static __always_inline bool cpu_has_feature(unsigned long feature)
 {
 	return early_cpu_has_feature(feature);
 }
-- 
2.30.1

