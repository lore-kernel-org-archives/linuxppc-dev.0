Return-Path: <SRS0=yMLg=3F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2989CC33CB3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 16:55:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB4952467C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 16:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0cttr4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4952467C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47z9LC0tt6zDqYn
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jan 2020 03:55:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=i0cttr4V; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47z9GZ3zbgzDqWH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2020 03:52:22 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5DD8B2073A;
 Thu, 16 Jan 2020 16:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579193540;
 bh=ZiZ6TkumCmKhw6ZAr6uKRo1tFs4kdys3f6UhWm76PA0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i0cttr4VSnItIHMZ85QwbkvMTIDoiALQYU2jHlndCgDzYBdj/NLaL8Z3aDVpsI+70
 A49m78/g06U2Hv+KkpZUiNwiHvy+5piPHg9kdSudMWlVjfLwDRDRvq0zaV1nKufaPJ
 49CyKUQb/ayDPYVGl3XQTvB6DCUicrhaD3Sj9bO4=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 099/205] powerpc/security: Fix debugfs data leak
 on 32-bit
Date: Thu, 16 Jan 2020 11:41:14 -0500
Message-Id: <20200116164300.6705-99-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 3b05a1e517e1a8cfda4866ec31d28b2bc4fee4c4 ]

"powerpc_security_features" is "unsigned long", i.e. 32-bit or 64-bit,
depending on the platform (PPC_FSL_BOOK3E or PPC_BOOK3S_64).  Hence
casting its address to "u64 *", and calling debugfs_create_x64() is
wrong, and leaks 32-bit of nearby data to userspace on 32-bit platforms.

While all currently defined SEC_FTR_* security feature flags fit in
32-bit, they all have "ULL" suffixes to make them 64-bit constants.
Hence fix the leak by changing the type of "powerpc_security_features"
(and the parameter types of its accessors) to "u64".  This also allows
to drop the cast.

Fixes: 398af571128fe75f ("powerpc/security: Show powerpc_security_features in debugfs")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20191021142309.28105-1-geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/security_features.h | 8 ++++----
 arch/powerpc/kernel/security.c               | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/security_features.h b/arch/powerpc/include/asm/security_features.h
index ccf44c135389..7c05e95a5c44 100644
--- a/arch/powerpc/include/asm/security_features.h
+++ b/arch/powerpc/include/asm/security_features.h
@@ -9,7 +9,7 @@
 #define _ASM_POWERPC_SECURITY_FEATURES_H
 
 
-extern unsigned long powerpc_security_features;
+extern u64 powerpc_security_features;
 extern bool rfi_flush;
 
 /* These are bit flags */
@@ -24,17 +24,17 @@ void setup_stf_barrier(void);
 void do_stf_barrier_fixups(enum stf_barrier_type types);
 void setup_count_cache_flush(void);
 
-static inline void security_ftr_set(unsigned long feature)
+static inline void security_ftr_set(u64 feature)
 {
 	powerpc_security_features |= feature;
 }
 
-static inline void security_ftr_clear(unsigned long feature)
+static inline void security_ftr_clear(u64 feature)
 {
 	powerpc_security_features &= ~feature;
 }
 
-static inline bool security_ftr_enabled(unsigned long feature)
+static inline bool security_ftr_enabled(u64 feature)
 {
 	return !!(powerpc_security_features & feature);
 }
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index d341b464f23c..1740a66cea84 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -16,7 +16,7 @@
 #include <asm/setup.h>
 
 
-unsigned long powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
+u64 powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
 
 enum count_cache_flush_type {
 	COUNT_CACHE_FLUSH_NONE	= 0x1,
@@ -109,7 +109,7 @@ device_initcall(barrier_nospec_debugfs_init);
 static __init int security_feature_debugfs_init(void)
 {
 	debugfs_create_x64("security_features", 0400, powerpc_debugfs_root,
-			   (u64 *)&powerpc_security_features);
+			   &powerpc_security_features);
 	return 0;
 }
 device_initcall(security_feature_debugfs_init);
-- 
2.20.1

