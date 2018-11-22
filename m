Return-Path: <SRS0=R24o=OB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C77C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 14:16:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C810206B2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 14:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mMTNnWp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C810206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4311hg4hMqzDqPk
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 01:16:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="mMTNnWp3";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=wout2-smtp.messagingengine.com (client-ip=64.147.123.25;
 helo=wout2-smtp.messagingengine.com; envelope-from=ruscur@russell.cc;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="mMTNnWp3"; dkim-atps=neutral
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4311QY5Pc0zDqP1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 01:04:21 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 35993A3B;
 Thu, 22 Nov 2018 09:04:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 22 Nov 2018 09:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=+owCQ/BgGKcmfDfjWjzum1ZzRQ3m2sjfxrqTBYasJMg=; b=mMTNnWp3
 Bwx9ouhe+EpM8J+UtooXXSEgkUyUi9TcVySsfwV5k+kLWtCALS4XHekWd5r+bC2V
 MrLWsdsd24fkoA0DIryobwBXtv2XFJAxgiQhOXI0zdLAiN5UlhRv/l+Y6odRfFM+
 86W7ZS5FX+EHpqxl1v9+Y/sUGYfd0IwHDM2Jt3NTv9UPQGMZsxZEoUDPibb9qD/w
 I8JRJQtJjback7wmKMtDlCGY3+Tu+5AHJBLrHMAgV+d1qESTPl2Ml7617EniFctV
 JZcqmFgNsdHyia6ukYCnUJ0QpJY/xadiMH/zw6Q5FYHmWhUer8N/6Sonj3hw4cMY
 J4fYOLWuPj0riQ==
X-ME-Sender: <xms:Yrf2W4xtwIpKAsVMHqHj7mRzYjputSFjw-zZewqfT13vnNfTBxdGxw>
X-ME-Proxy: <xmx:Yrf2W_w2XE94jc3gyS_-5JXQL_qMJa4OlLARs6ce2jWrNZGWlBPOKQ>
 <xmx:Yrf2W71kdb5qEMV9YuZG5QcCWhxF3rOKbRRqkS6e9fRNT17BX0bJBw>
 <xmx:Yrf2W2cympX76VNBHitAiXTYGJ9EBy5wFnPgpiHv9r3zkRZkVTuOlg>
 <xmx:Yrf2WwWRn0dL3pMhUGLM3d_rhsihSur82pSeqhoHugrS1ngT3RKbTg>
 <xmx:Yrf2W-9RDGk4Ujguvlvb8qGKBNXA4BMFx3n_kv3lQc86neWPGzOcag>
 <xmx:Yrf2W-St0g89C46JznitADUf4imyvr38USa9yLipW3ftUilF6N-4Rg>
Received: from crackle.ozlabs.ibm.com.com (124-171-154-44.dyn.iinet.net.au
 [124.171.154.44])
 by mail.messagingengine.com (Postfix) with ESMTPA id A4A73102E8;
 Thu, 22 Nov 2018 09:04:15 -0500 (EST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] powerpc/mm/radix: Use KUEP API for Radix MMU
Date: Fri, 23 Nov 2018 01:04:15 +1100
Message-Id: <20181122140416.3447-4-ruscur@russell.cc>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122140416.3447-1-ruscur@russell.cc>
References: <20181122140416.3447-1-ruscur@russell.cc>
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
Cc: kernel-hardening@lists.openwall.com, Russell Currey <ruscur@russell.cc>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Execution protection already exists on radix, this just refactors
the radix init to provide the KUEP setup function instead.

Thus, the only functional change is that it can now be disabled.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/mm/pgtable-radix.c        | 9 ++++++---
 arch/powerpc/platforms/Kconfig.cputype | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 931156069a81..f08a459b4255 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -535,8 +535,13 @@ static void radix_init_amor(void)
 	mtspr(SPRN_AMOR, (3ul << 62));
 }
 
-static void radix_init_iamr(void)
+void setup_kuep(bool disabled)
 {
+	if (disabled)
+		return;
+
+	pr_warn("Activating Kernel Userspace Execution Prevention\n");
+
 	/*
 	 * Radix always uses key0 of the IAMR to determine if an access is
 	 * allowed. We set bit 0 (IBM bit 1) of key0, to prevent instruction
@@ -605,7 +610,6 @@ void __init radix__early_init_mmu(void)
 
 	memblock_set_current_limit(MEMBLOCK_ALLOC_ANYWHERE);
 
-	radix_init_iamr();
 	radix_init_pgtable();
 	/* Switch to the guard PID before turning on MMU */
 	radix__switch_mmu_context(NULL, &init_mm);
@@ -627,7 +631,6 @@ void radix__early_init_mmu_secondary(void)
 		      __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
 		radix_init_amor();
 	}
-	radix_init_iamr();
 
 	radix__switch_mmu_context(NULL, &init_mm);
 	if (cpu_has_feature(CPU_FTR_HVMODE))
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index a20669a9ec13..e6831d0ec159 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -334,6 +334,7 @@ config PPC_RADIX_MMU
 	bool "Radix MMU Support"
 	depends on PPC_BOOK3S_64
 	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
+	select PPC_HAVE_KUEP
 	default y
 	help
 	  Enable support for the Power ISA 3.0 Radix style MMU. Currently this
-- 
2.19.1

